# Information obtained from http://en.wikipedia.org/wiki/Provinces_and_territories_of_Canada
# created by Juergen Helmers <juergen.helmers@gmail.com>

class AddIsraeliGeoData < ActiveRecord::Migration
  
  @country = "Israel"
  
  @states = Hash.new
  @states['Jerusalem District'] = ['Jerusalem']   
  @states['Northern District'] = ['Nazareth', 'Safed', 'Kinneret', 'Yizre\'el', 'Akko', 'Golan']
  @states['Haifa District'] = ['Haifa', 'Hadera']
  @states['Central District'] = ['Ramla', 'Sharon', 'Petah Tikva', 'Rehovot']
  @states['Tel Aviv District'] = ['Tel Aviv']
  @states['Southern District'] = ['Beersheba', 'Ashkelon']
  @states['Judea and Samaria Area'] = ['Modi\'in Illit']
                                 
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