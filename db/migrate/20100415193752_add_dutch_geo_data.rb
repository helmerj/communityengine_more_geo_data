
# Information obtained from http://en.wikipedia.org/wiki/Netherlands#Administrative_divisions
# created by Juergen Helmers <juergen dot helmers at gmail dot com>

class AddDutchGeoData < ActiveRecord::Migration
  
  @country = "Netherlands"
  @states = Hash.new

  @states['Drenthe'] = ['Assen' ]
  @states['Flevoland'] = ['Lelystad', 'Almere' ]
  @states['Friesland'] = ['Leeuwarden' ]
  @states['Gelderland'] = ['Arnhem',' Nijmegen' ]
  @states['Groningen'] = ['Groningen' ]
  @states['Limburg'] = ['Maastricht' ]
  @states['North Brabant'] = ['Den Bosch','Eindhoven' ]
  @states['North Holland'] = ['Haarlem','Amsterdam' ]
  @states['Overijssel'] = ['Zwolle','Enschede' ]
  @states['Utrecht'] = ['Utrecht' ]
  @states['Zeeland'] = ['Middelburg' ]
  @states['South Holland'] = ['The Hague','Rotterdam' ]
 
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
