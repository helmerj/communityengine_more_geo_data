
# Information obtained from http://en.wikipedia.org/wiki/States_and_territories_of_Australia
# created by Juergen Helmers <juergen.helmers@gmail.com>

class AddAustralianGeoData < ActiveRecord::Migration
  
  @country = "Australia"
  @states = Hash.new
  @states['Ashmore and Cartier Islands'] = ['(West Islet)']   
  @states['Australian Antarctic Territory'] = ['(Mawson Station)']
  @states['Australian Capital Territory'] = ['Canberra']
  @states['Christmas Island'] = ['Flying Fish Cove']
  @states['Cocos (Keeling) Islands'] = ['West Island']
  @states['Coral Sea Islands Territory'] = ['(Willis Island)']
  @states['Heard Island and McDonald Islands'] = ['(Atlas Cove)']
  @states['Jervis Bay Territory'] = ['(Jervis Bay Village)']   
  @states['New South Wales'] = ['Sydney', 'Newcastle', 'Wollongong', 'Wagga Wagga', 'Tweed Heads', 'Coffs Harbour']
  @states['Norfolk Island'] = ['Kingston']
  @states['Northern Territory'] = ['Darwin', 'Palmerston', 'Alice Springs']
  @states['Queensland'] = ['Brisbane', 'Rockhampton', 'Gladstone', 'Gympie', 'Toowoomba']
  @states['South Australia'] = ['Adelaide', 'Mount Gambier', 'Whyalla']
  @states['Tasmania'] = ['Hobart']
  @states['Victoria'] = ['Melbourne']   
  @states['Western Australia'] = ['Perth', 'Geraldton', 'Bunburry', 'Albany', 'Kalgoorlie', 'Port Hedland']
 
   
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
