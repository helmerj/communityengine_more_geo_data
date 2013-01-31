# Information obtained from http://en.wikipedia.org/wiki/Regions_of_Morocco
# created by Juergen Helmers <juergen.helmers@gmail.com>

class AddMorroccanGeoData < ActiveRecord::Migration
  
  @country = "Morrocco"
  @states = Hash.new

  @states['Chaouia-Ouardigha'] = ['Ben Slimane Province','Khouribga Province','Settat Province']
  @states['Doukkala-Abda'] = ['El Jadida Province','Safi Province']
  @states['Fès-Boulemane'] = ['Prefecture of Fès-Dar-Dbibegh','Moulay Yacoub Province','Sefrou Province','Boulemane Province']
  @states['Gharb-Chrarda-Béni Hssen'] = ['Kénitra Province','Sidi Kacem Province']
  @states['Grand Casablanca'] = ['Nouaceur Province','Médiouna Province']
  @states['Guelmim-Es Semara'] = ['Assa-Zag Province','Es Smara Province','Guelmim Province','Tan-Tan Province','Tata Province']
  @states['Laâyoune-Boujdour-Sakia El Hamra'] = ['Boujdour Province','Laâyoune Province']
  @states['Marrakech-Tensift-El Haouz'] = ['Prefecture of Marrakesh-Medina','Prefecture of Marrakesh-Menara','Prefecture of Sidi Youssef Ben Ali','Al Haouz Province','Chichaoua Province','El Kelâat Es-Sraghna Province','Essaouira Province']
  @states['Meknès-Tafilalet'] = ['Prefecture of Meknès','El Hajeb Province','Errachidia Province','Ifrane Province','Khénifra Province','Midelt Province']
  @states['Oriental'] = ['Berkane Province','Figuig Province','Jerada Province','Nador Province','Prefecture of Oujda-Angad','Taourirt Province']
  @states['Oued Ed-Dahab-Lagouira'] = ['Prefecture of Aousserd','Oued Eddahab Province']
  @states['Rabat-Salé-Zemmour-Zaer'] = ['Prefecture of Rabat','Prefecture of Salé','Prefecture of Skhirat-Témara','Khemisset Province']
  @states['Souss-Massa-Drâa'] = ['Prefecture of Agadir-Ida-Ou Tanane','Préfecture of Inezgane-Aït Melloul','Chtouka Aït Baha Province','Ouarzazate Province','Taroudant Province','Sidi Ifni Province','Tinghir Province (since 2009)','Tiznit Province','Zagora Province']
  @states['Tadla-Azilal'] = ['Azilal Province','Béni-Mellal Province','Fquih Ben Salah Province']
  @states['Tangier-Tétouan'] = ['Prefecture of Fahs-Anjra','Prefecture of Tangier-Assilah','Prefecture of Tétouan','Chefchaouen Province','Larache Province']
  @states['Taza-Al Hoceima-Taounate'] = ['Al Hoceïma Province','Taounate Province','Taza Province','Guercif Province']

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