# Information obtained from http://en.wikipedia.org/wiki/Provinces_of_Ireland
# created by Juergen Helmers <juergen.helmers@gmail.com>

class AddIrishGeoData < ActiveRecord::Migration
  
  @country = "Ireland"
  @states = Hash.new

  @states['Leinster'] = ['Dublin','Tallaght','Drogheda','Dundalk','Swords','Bray','Navan','Kilkenny','Carlow','Portlaoise','Naas','Newbridge','Mullingar','Wexford','Athlone','Celbridge','Balbriggan','Malahide','Leixlip','Greystones','Tullamore','Arklow','Maynooth','Wicklow']
  @states['Munster'] = ['County Clare','County Cork','Cork city','County Kerry','County Limerick','Limerick city','North Tipperary','South Tipperary','County Waterford','Waterford city']
  @states['Connacht'] = ['Sligo','Castlebar','Tubbercurry','Bearna','Ballina','Westport','Loughrea','Boyle','Riverstow']


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