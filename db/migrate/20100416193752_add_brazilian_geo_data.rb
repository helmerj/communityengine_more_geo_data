
# Information obtained from http://en.wikipedia.org/wiki/States_of_Brazil
# created by Juergen Helmers <juergen dot helmers at gmail dot com>

class AddBrazilianGeoData < ActiveRecord::Migration
  
  @country = "Brazil"
  @states = Hash.new

  @states['Acre'] = ['Rio Branco']
  @states['Alagoas'] = ['Maceió']
  @states['Amapá'] = ['Macapá']
  @states['Amazonas'] = ['Manaus']
  @states['Bahia'] = ['Salvador']
  @states['Ceará'] = ['Fortaleza']
  @states['Distrito Federal'] = ['Brasília']
  @states['Espírito Santo'] = ['Vitória']
  @states['Goiás'] = ['Goiânia']
  @states['Maranhão'] = ['São Luís']
  @states['Mato Grosso'] = ['Cuiabá']
  @states['Mato Grosso do Sul'] = ['Campo Grande']
  @states['Minas Gerais'] = ['Belo Horizonte']
  @states['Pará'] = ['Belém']
  @states['Paraíba'] = ['João Pessoa']
  @states['Paraná'] = ['Curitiba']
  @states['Pernambuco'] = ['Recife']
  @states['Piauí'] = ['Teresina']
  @states['Rio de Janeiro'] = ['Rio de Janeiro']
  @states['Rio Grande do Norte'] = ['Natal']
  @states['Rio Grande do Sul'] = ['Porto Alegre']
  @states['Rondônia'] = ['Porto Velho']
  @states['Roraima'] = ['Boa Vista']
  @states['Santa Catarina'] = ['Florianópolis']
  @states['São Paulo'] = ['São Paulo']
  @states['Sergipe'] = ['Aracaju']
  @states['Tocantins'] = ['Palmas']
  
   
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
