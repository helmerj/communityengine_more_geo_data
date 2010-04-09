# Information obtained from http://www.europa-auf-einen-blick.de/finnland/regionen.php
# created by Juergen Helmers <juergen.helmers@gmail.com>

class AddCzechGeoData < ActiveRecord::Migration
  
  @country = "Czech Republic"
  @states = Hash.new
  @states['Central Bohemian Region (Středočeský kraj)'] = ['Prague (Praha)']        
  @states['South Bohemian Region (Jihočeský kraj)'] = ['České Budějovice']       
  @states['Plzeň Region (Plzeňský kraj)'] = ['Plzeň']        
  @states['Karlovy Vary Region (Karlovarský kraj)'] = ['Karlovy Vary']       
  @states['Ústí nad Labem Region (Ústecký kraj)'] = ['Ústí nad Labem']       
  @states['Liberec Region (Liberecký kraj)'] = ['Liberec']        
  @states['Hradec Králové Region (Královéhradecký kraj)'] = ['Hradec Králové']        
  @states['Pardubice Region (Pardubický kraj)'] = ['Pardubice']        
  @states['Olomouc Region (Olomoucký kraj)'] = ['Olomouc']        
  @states['Moravian-Silesian Region (Moravskoslezský kraj)'] = ['Ostrava']        
  @states['South Moravian Region (Jihomoravský kraj)'] = ['Brno']        
  @states['Zlín Region (Zlínský kraj)'] = ['Zlín']        
  @states['Vysočina Region (Vysočina)'] = ['Jihlava']
    
                                 
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
