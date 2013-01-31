# Information obtained from http://en.wikipedia.org/wiki/States_and_territories_of_India
# created by Juergen Helmers <juergen.helmers@gmail.com>

class AddIndianGeoData < ActiveRecord::Migration
  
  @country = "India"
  @states = Hash.new

  @states['Andhra Pradesh'] = ['Hyderabad','Vishakhapatnam','Vijayawada','Warangal','Rajahmundry','Guntur','Tirupathi','Kurnool','Nellore','Kakinada','Karimnagar','Khammam','Eluru','Ongole','Anantapur','Kadapa','Nizamabad','Vizianagaram','Srikakulam','Nalgonda','Adilabad']
  @states['Arunachal Pradesh'] = ['Tirap District','Changlang District','Lohit District','Anjaw District','Lower Dibang Valley','Upper Dibang Valley','East Siang','West Siang','Upper Siang','Lower Subansiri','Upper Subansiri','Kurung Kumey','Papum Pare','East Kameng','West Kameng','Tawang District','Longding District']
  @states['Assam'] = ['Odalguri','Karimganj','Cachar','Kamrup','Kamrup Metro','Karbi Anglong','Kokrajhar','Golaghat','Goalpara','Chirang','Dibrugarh','Dima Hasao','Tinsukia','Darrang','Dhubri','Dhemaji','Nagaon','Nalbari','Bongaigaon','Barpeta','Baksa','Morigaon','Jorhat','Lakhimpur','Sivasagar','Sonitpur','Hailakandi']
  @states['Bihar'] = ['Patna','Gaya','Bhagalpur','Muzaffarpur','Biharsarif','Darbhanga','Purnia','Arrah','Munger','Chhapra','Katihar','Danapur','Sasaram','Dehri']
  @states['Chhattisgarh'] = ['Raipur','Bhilai Durg or Greater Raipur','Bilaspur','Raigarh','Korba','Ambikapur','Rajnandgaon','Jagdalpur','Chirmiri','Dhamtari']
  @states['Goa'] = ['Panaji','Bicholim','Mapusa','Ponda','Tiswadi (Panaji)','Bardez (Mapusa)','Pernem','Bicholim','Sattari (Valpoi)','Margao','Mormugao (Vasco da Gama)','Quepem','Mormugao','Salcete (Margao)','Quepem','Canacona (Chaudi)','Sanguem','Dharbandora']
  @states['Gujarat'] = ['Ahmedabad','Amreli','Anand','Palanpur','Bharuch','Bhavnagar','Dahod','Ahwa','Gandhinagar','Jamnagar','Junagadh','Bhuj','Kheda','Mehsana','Rajpipla','Navsari','Patan','Godhra','Porbandar','Rajkot','Himmatnagar','Surendranagar','Surat','Vyara','Vadodara','Valsad']
  @states['Haryana'] = ['Ambala District','Kaithal District','Kurukshetra District','Panchkula District','Yamuna Nagar District','Faridabad District','Palwal District','Gurgaon District','Mahendragarh District','Mewat District','Rewari District','Hisar Division','Bhiwani District','Fatehabad District','Jind District','Hisar District','Sirsa District','Jhajjar District','Karnal District','Panipat District','Rohtak District','Sonipat District']
  @states['Himachal Pradesh'] = ['Bilaspur','Chamba','Hamirpur','Kangra','Kinnaur','Kullu','Lahaul','Spiti','Mandi','Shimla','Sirmaur','Solan','Una']
  @states['Jammu and Kashmir'] = ['Srinagar','Jammu','Anantnag','Udhampur','Baramulla','Kathua','Sopore','Rajouri','Poonch','Leh','Bandipore']
  @states['Jharkhand'] = ['Jamshedpur','Dhanbad','Ranchi','Bokaro Steel City','deoghar','Phusro','Hazaribagh','Giridih','Ramgarh','Daltonganj']
  @states['Karnataka'] = ['Bagalkote','Bangalore Rural','Bangalore Urban','Belgaum','Bellary','Bidar','Bijapur','Chamarajanagar','Chikkaballapur','Chikkamagaluru','Chitradurga','Dakshina Kannada','Davanagere','Dharwad','Gadag','Gulbarga','Hassan','Haveri','Kodagu','Kolar','Koppal','Mandya','Mysore','Raichur','Ramanagara','Shimoga','Tumkur','Udupi','Uttara Kannada','Yadgir']
  @states['Kerala'] = ['Alappuzha','Ernakulam','Idukki','Kannur','Kasaragod','Kollam','Kottayam','Kozhikode','Malappuram','Palakkad','Pathanamthitta','Thiruvananthapuram','Thrissur','Wayanad']
  @states['Madhya Pradesh'] = ['Bhopal','Raisen','Rajgarh','Sehore','Vidisha','Bhind','Morena','Sheopur','Ashoknagar','Datia','Guna','Gwalior','Shivpuri','Alirajpur','Barwani','Burhanpur','Dhar','Indore','Jhabua','Khandwa','Khargone','Balaghat','Chindwara','Jabalpur','Katni','Mandla','Narsinghpur','Seoni','Betul','Harda','Hoshangabad','Rewa','Satna','Sidhi','Singrauli','Chhatarpur','Damoh','Panna','Sagar','Tikamgarh','Anuppur','Dindori','Shadol','Umaria','Dewas','Mandsaur','Neemuch','Ratlam','Shajapur','Ujjain']
  @states['Maharashtra'] = ['Mumbai','Mumbai Suburban (Mumbai Upanagar)','Thane','Raigad','Ratnagiri','and Sindhudurg','Pune','Satara','Sangli','Solapur','Kolhapur','Nashik','Dhule','Jalgaon','Ahmednagar','Nandurbar','Aurangabad','Jalna','Latur/Lattalur','Nanded','Osmanabad','Parbhani','Hingoli','Beed','Amravati','Akola','Washim','Buldhana','Yavatmal','Nagpur','Chandrapur','Wardha','Bhandara','Gondia','Gadchiroli']
  @states['Manipur'] = ['Bishnupur','Churachandpur','Chandel','Imphal East','Imphal West','Senapati','Tamenglong','Thoubal','Ukhrul']
  @states['Meghalaya'] = ['West Jaintia Hills (Jowai)','East Jaintia Hills (Khliehriat)','East Khasi Hills (Shillong)','West Khasi Hills (Nongstoin)','South West Khasi Hills (Mawkyrwat)','Ri-Bhoi (Nongpoh)','North Garo Hills (Resubelpara)','East Garo Hills (Williamnagar)','South Garo Hills (Baghmara)','West Garo Hills (Tura)','South West Garo Hills (Ampati)']
  @states['Mizoram'] = ['Aizawl','Champhai','Kolasib','Lawngtlai','Lunglei','Mamit','Saiha','Serchhip']
  @states['Nagaland'] = ['Dimapur District','Kiphire District','Kohima District','Longleng District','Mokokchung District','Mon District','Peren District','Phek District','Tuensang District','Wokha District','Zunheboto District']
  @states['Orissa'] = ['Angul','Boudh','Bhadrak','Bolangir','Bargarh','Balasore','Cuttack (Kataka)','Debagarh','Dhenkanal','Ganjam','Gajapati','Jharsuguda','Jajpur','Jagatsinghpur','Khordha','Keonjhar','Kalahandi','Kandhamal','Koraput','Kendrapara','Malkangiri','Mayurbhanj','Nabarangpur','Nuapada','Nayagarh','Puri','Rayagada','Sambalpur','Subarnapur','Sundargarh']
  @states['Punjabv'] = ['Amritsar','Barnala','Bathinda','Faridkot','Fatehgarh Sahib (Sirhind-Fategarh)','Fazilka','Firozpur','Gurdaspur','Hoshiarpur','Jalandhar','Kapurthala','Ludhiana','Mansa','Moga','Muktsar','Patialav','Pathankot','Rupnagar','Ajitgarh (Mohali)','Sangrur','Shahid Bhagat Singh Nagar (Nawanshahr)','Tarn Taran']
  @states['Rajasthan'] = ['Ajmer','Alwar','Banswara','Baran','Barmer','Bharatpur','Bhilwara','Bikaner','Bundi','Chittorgarh','Churu','Dausa','Dholpur','Dungarpur','Hanumangarh','Jaipur','Jaisalmer','Jalore','Jhalawar','Jhunjhunu','Jodhpur','Karauli','Kota','Nagaur','Pali','Pratapgarh','Rajsamand','Sawai Madhopur','Sikar','Sirohi','Sri Ganganagar','Tonk','Udaipur']
  @states['Sikkim'] = ['East Sikkim','West Sikkim','North Sikkim','South Sikkim']
  @states['Tamil Nadu'] = ['Ariyalur','Chennai','Coimbatore','Cuddalore','Dharmapuri','Dindigul','Erode','Kanchipuram','Nagercoil','Karur','Krishnagiri','Madurai','Nagapattinam','Namakkal','Udagamandalam','Perambalur','Pudukkottai','Ramanathapuram','Salem','Sivaganga','Thanjavur','Theni','Thoothukudi','Tiruchirappalli','Tirunelveli','Tirupur','Tiruvallur','Tiruvannamalai','Tiruvarur','Vellore','Viluppuram','Virudhunagar']
  @states['Tripura'] = ['Ambassa','Kailasahar','Udaipur','Agartala']
  @states['Uttar Pradesh'] = ['Agra','Allahabad','Aligarh','Akbarpur','Auraiya','Azamgarh','Barabanki','Badaun','Bahraich','Bijnor','Ballia','Sambhal','Banda','Balrampur','Bareilly','Basti','Bulandshahr','Chandauli','Chitrakoot','Deoria','Etah','Etawah','Firozabad','Fatehgarh','Fatehpur','Faizabad','NOIDA','Gonda','Ghazipur','Gorakhpur','Ghaziabad','Hamirpur','Hardoi','Hathras','Jhansi','Amroha','Jaunpur','Akbarpur','Kannauj','Kanpur','Kasganj','Manjhanpur','Padarauna','Lalitpur','Kheri','Lucknow','Mau','Meerut','Maharajganj','Mahoba','Mirzapur','Moradabad','Mainpuri','Mathura','Muzaffarnagar','Pilibhit','Pratapgarh','Rampur','Rae Bareli','Saharanpur','Sitapur','Shahjahanpur','Shamli','Navgarh','Robertsganj','Gyanpur','Sultanpur','Shravasti','Unnao','Varanasi']
  @states['Uttarakhand'] = ['Almora','Bageshwar','Chamoli Gopeshwar','Champawat','Dehradun','Haridwar','Nainital','Pauri','Pithoragarh','Rudraprayag','New Tehri','Rudrapur','Uttarkashi']
  @states['West Bengal'] = ['North 24 Parganas','South 24 Parganas','Bardhaman','Murshidabad','West Midnapore','Hooghly','Nadia','East Midnapore','Howrah','Kolkata','Maldah','Jalpaiguri','Bankura','Birbhum','North Dinajpur','Purulia','Cooch Behar','Darjeeling','South Dinajpur']
  @states['Andaman and Nicobar Islands'] = ['North and Middle Andaman','South Andaman','Nicobar']
  @states['Chandigarh'] = ['']
  @states['Dadra and Nagar Haveli'] = ['Dadra','Nagar Haveli']
  @states['Daman and Diu'] = ['Diu','Daman']
  @states['Lakshadweep'] = ['']
  @states['National Capital Territory of Delhi'] = ['Central Delhi','North Delhi','South Delhi','East Delhi','North East Delhi','South West Delhi','New Delhi','North West Delhi','West Delhi']
  @states['Puducherry'] = ['']

  def self.up
    country = Country.find_or_create_by_name(@country)
    country_id = country.id 
    
    @states.each { | key, value |
      State.new(:name => key).save
      state = State.find_by_name(key)
      value.each do |metro_area|
        MetroArea.new(:name => metro_area, :state_id => state.id, :country_id => country_id).save
      end
    }   
  end

  def self.down
    country = Country.find_by_name(@country).destroy
    @states.each { | key, value |
      State.find_by_name(key).destroy
      value.each do |metro_area|
        MetroArea.find_by_name(metro_area).destroy
      end
    }
  end
end