
# Information obtained from http://en.wikipedia.org/wiki/Provinces_of_Argentina
# created by Juergen Helmers <juergen.helmers@gmail.com>

class AddArgentinaGeoData < ActiveRecord::Migration
  
  @country = "Argentina"
  @states = Hash.new
  @states['Buenos Aires'] = ['Buenos Aires']   
  @states['Buenos Aires Province'] = ['La Plata']
  @states['Catamarca Province'] = ['S.F.V. de Catamarcaa']
  @states['Chaco Province'] = ['Resistencia']
  @states['Chubut Province'] = ['Rawson']
  @states['Córdoba Province'] = ['Córdoba']
  @states['Corrientes Province'] = ['Corrientes']
  @states['Entre Ríos Province'] = ['Paraná']
  @states['Formosa Province'] = ['Formosa']
  @states['Jujuy Province'] = ['San Salvador de Jujuy']
  @states['La Pampa Province'] = ['Santa Rosa']
  @states['La Rioja Province'] = ['La Rioja']
  @states['Mendoza Province'] = ['Mendoza']
  @states['Misiones Province'] = ['Posadas']
  @states['Neuquén Province'] = ['Neuquén']
  @states['Río Negro Province'] = ['Viedma']
  @states['Salta Province'] = ['Salta']
  @states['San Juan Province'] = ['San Juan']
  @states['San Luis Province'] = ['San Luis']
  @states['Santa Cruz Province'] = ['Río Gallegos']
  @states['Santa Fe Province'] = ['Santa Fe']
  @states['Santiago del Estero Province  '] = ['Santiago del Estero']
  @states['Tierra del Fuego Province'] = ['Ushuaia']
  @states['Tucumán Province'] = ['San Miguel de Tucumán ']
                                  
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
