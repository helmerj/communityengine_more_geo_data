# Information obtained from http://en.wikipedia.org/wiki/hungary
# created by Juergen Helmers <juergen.helmers@gmail.com>

class AddHungarianGeoData < ActiveRecord::Migration
  
  @country = "Hungary"
  @states = Hash.new
    
  @states['Western Transdanubia'] = ['Zala','Vas','Győr-Moson-Sopron']
  @states['Southern Transdanubia'] = ['Somogy','Tolna','Baranya']
  @states['Central Transdanubia'] = ['Fejér','Komárom-Esztergom','Veszprém']
  @states['Central Hungary'] = ['Budapest', 'Pest']
  @states['Northern Hungary'] = ['Miskolc','Eger','Salgótarján','Ózd','Kazincbarcika','Mezőkövesd','Sárospatak','Sátoraljaújhely','Tiszaújváros','Tokaj','Gyöngyös','Hatvan','Balassagyarmat']
  @states['Northern Great Plain'] = ['Hajdú-Bihar','Jász-Nagykun-Szolnok','Szabolcs-Szatmár-Bereg']
  @states['Southern Great Plain'] = ['Bács-Kiskun','Békés','Csongrád']
  
                                 
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
