# Information obtained from http://en.wikipedia.org/wiki/Regions_of_Morocco
# created by Juergen Helmers <juergen.helmers@gmail.com>

class AddLatvianGeoData < ActiveRecord::Migration
  
  @country = "Latvia"
  @states = Hash.new

  @states['Riga'] = ['Riga','Jūrmala']
  @states['Kurzeme'] = ['Liepāja','Ventspils']
  @states['Latgale'] = ['Daugavpils']
  @states['Zemgale'] = ['Jelgava']
  @states['Vidzeme'] = ['Valmiera']


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