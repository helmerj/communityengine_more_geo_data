# Information obtained from http://en.wikipedia.org/wiki/Provinces_and_territories_of_Canada
# created by Juergen Helmers <juergen.helmers@gmail.com>

class AddCanadianGeoData < ActiveRecord::Migration
  
  @country = "Canada"
  
  @states = Hash.new
  @states['Ontario'] = ['Toronto']        
  @states['Quebec'] = ['Quebec City', 'Montreal']
  @states['Nova Scotia'] = ['Halifax']
  @states['New Brunswick'] = ['Fredericton', 'Saint John']
  @states['Manitoba'] = ['Winnipeg']
  @states['British Columbia'] = ['Victoria', 'Vancouver']
  @states['Prince Edward Island'] = ['Charlottetown']
  @states['Saskatchewan'] = ['Regina', 'Saskatoon']
  @states['Alberta'] = ['Edmonton', 'Calgary']
  @states['Newfoundland and Labrador'] = ['St. John\'s']
  
    
                                 
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
