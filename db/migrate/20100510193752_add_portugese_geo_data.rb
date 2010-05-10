
# Information obtained from http://en.wikipedia.org/wiki/States_of_Brazil
# created by Juergen Helmers <juergen dot helmers at gmail dot com>

class AddPortugeseGeoData < ActiveRecord::Migration
  
  @country = "Portugal"
  @states = Hash.new
  
  @states['Aveiro'] = ['Aveiro']
  @states['Azores'] =  ['Ponta Delgada']
  @states['Beja'] = ['Beja']
  @states['Braga'] = ['Braga']
  @states['Bragança'] = ['Bragança']
  @states['Castelo Branco'] = ['Castelo Branco']
  @states['Coimbra'] = ['Coimbra']
  @states['Évora'] = ['Évora']
  @states['Faro'] = ['Faro']
  @states['Guarda'] = ['Guarda']
  @states['Leiria'] = ['Leiria']
  @states['Lisboa'] = ['Lisboa']
  @states['Madeira'] = ['Funchal']
  @states['Portalegre'] = ['Portalegre']
  @states['Porto'] = ['Porto']
  @states['Santarém'] =  ['Santarém']
  @states['Setúbal'] = ['Setúbal']
  @states['Viana do Castelo'] = ['Viana do Castelo']  
  @states['Vila Real'] = ['Vila Real']
  @states['Viseu'] = ['Viseu']
  
#  @states['Norte'] = ['Alto Trás-os-Montes', 'Ave', 'Cávado','Douro', 'Entre Douro e Vouga', 'Grande Porto', 'Minho-Lima', 'Tâmega']
#  @states['Centro'] = ['Baixo Mondego','Baixo Vouga', 'Beira Interior Norte', 'Beira Interior Sul', 'Cova da Beira', 'Dão-Lafões', 'Médio Tejo', 'Oeste', 'Pinhal Interior Norte', 'Pinhal Interior Sul', 'Pinhal Litoral', 'Serra da Estrela']
#  @states['Lisboa'] = ['Grande Lisboa', 'Península de Setúbal']
#  @states['Alentejo'] = ['Alentejo Central', 'Alentejo Litoral', 'Alto Alentejo', 'Baixo Alentejo', 'Lezíria do Tejo']
#  @states['Algarve'] = ['Algarve']
#  @states['Autonomous Region of Azores '] = ['Autonomous Region of Azores ']
#  @states['Autonomous Region of Madeira'] = ['Autonomous Region of Madeira']
   
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
