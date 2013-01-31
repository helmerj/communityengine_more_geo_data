# Information obtained from http://en.wikipedia.org/wiki/Provinces_of_Kenya
# created by Juergen Helmers <juergen.helmers@gmail.com>

class AddKenyanGeoData < ActiveRecord::Migration
  
  @country = "Kenya"
  @states = Hash.new

  @states['Central'] = ['Gatanga','Gatundu','Kamwangi','Githunguri','Kikuyu','Kandara','Kiambu','Limuru','Chaka','Mweiga','Kigumo','Engineer','Kerugoya','Kianyaga','Wanguru','Baricho','Lari','Maragua','Kiria-ini','Karatina','Kaiyaba','Mirangini','Mukurweini','Murang\'a','Kenol','Ol Kalou','Nyahururu','Njambini','Ol Jororok','Nyeri','Othaya','Ruiru','Wamagana','Gatuanyaga','Thika']
  @states['Coast'] = ['Bura','Kizurini','Kilifi','Dongo Kundu','Kinango','Kwale','Kizingitini','Lamu','Malindi','Mombasa','Msambweni','Wundanyi','Minijila','Hola','Taveta']
  @states['Eastern'] = ['Maikona','Embu','Garba Tula','Maua','Meru','Nkubu','Isiolo','Kangundo','Makueni','Kitui','Kyuso','Korr','Machakos','Wote','Marsabit','Siakago','Gatimbi','Chuka','Moyale','Mutomo','Mwingi','Marimanti','Urru','Kithimani']
  @states['Nairobi'] = ['Makadara','Kamukunji','Starehe','Langata','Dagoretti','Westlands','Kasarani','Embakasi']
  @states['North Eastern'] = ['Bura','Garissa','Masalani','El Wak','Mandera','Takaba','Wajir','Bute','Habaswein','Griftu']
  @states['Nyanza'] = ['Bondo','Nyansiongo','Ogembo','Homa Bay','Kisii','Kisumu town','Holo','Kehancha','Kegonga','Keroka','Migori','Nyamira','Awasi','Kosele','Madiany','Rongo','Siaya','Sindo']
  @states['Rift Valley'] = ['Kabarnet','Kabartonjo','Sosiot','Bomet','Litein','Sigor','Chemolingot','Kajiado','Ngong','Chepkorio','Iten','Kericho','Kipkelion','Eldama Ravine','Mogogosiek','Keringet','Endebess','Sweetwaters','Nanyuki','Mukogodo','Rumuruti','Loitokitok','Lorugum','Tot','Kapsowar','Marigat','Mogotio','Molo','Naivasha','Nakuru','Bahati','Kapsabet','Nandi Hills','Kabiyet','Kobujoi','Narok','Ololulunga','Njoro','Alale','Nyahururu','Sighor','Rongai','Mararal','Wamba','Baragoi','Sotik','Maraba','Murkhan','Kilgoris','Maili Saba','Kitale','Lodwar','Lokori','Lokitaung','Lokichar','Kakuma','Eldoret','Naiberi','Outspan','Kapenguria']
  @states['Western'] = ['Bumula','Chwele','Webuye','Mukuyuni','Bungoma','Sirisia','Budalangi','Busia','Butere','Kima','Hamisi','Malava','Kakamega','Khwisero','Kimilili','Lumakanda','Matete','Matungu','Kapsokwony','Mumias','Sabatia','Funyala','Siaya','Amagoro','Amukura','Mbale']

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