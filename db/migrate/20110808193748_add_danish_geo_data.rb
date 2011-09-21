# Information obtained from http://en.wikipedia.org/wiki/Regions_of_Denmark
# created by Juergen Helmers <juergen.helmers@gmail.com>

class AddDanishGeoData < ActiveRecord::Migration
  
  @country = "Denmark"
  @states = Hash.new
  
  
  @states['Hovedstaden'] = ['Albertslund','Allerød','Ballerup','Bornholm Regional','Brøndby','Copenhagen','Dragør','Egedal','Fredensborg','Frederiksberg','Frederikssund','Furesø','Gentofte','Gladsaxe','Glostrup','Gribskov','Halsnæs','Helsingør','Herlev','Hillerød','Hvidovre','Høje-Taastrup','Hørsholm','Ishøj','Lyngby-Taarbæk','Rudersdal','Rødovre','Tårnby','Vallensbæk']         
  @states['Midtjylland'] = ['Århus','Favrskov','Hedensted','Herning','Holstebro','Horsens','Ikast-Brande','Lemvig','Norddjurs','Odder','Randers','Ringkøbing-Skjern','Samsø','Silkeborg','Skanderborg','Skive','Struer','Syddjurs','Viborg']        
  @states['Nordjylland'] = ['Aalborg','Brønderslev','Frederikshavn','Hjørring','Jammerbugt','Læsø','Mariagerfjord','Morsø','Rebild','Thisted','Vesthimmerland']       
  @states['Sjælland'] = ['Faxe','Greve','Guldborgsund','Holbæk','Kalundborg','Køge','Lejre','Lolland','Næstved','Odsherred','Ringsted','Roskilde','Slagelse','Solrød','Sorø','Stevns','Vordingborg']        
  @states['Syddanmark'] = ['Aabenraa','Assens','Billund','Esbjerg','Faaborg-Midtfyn','Fanø','Fredericia','Haderslev','Kerteminde','Kolding','Langeland','Middelfart','Nordfyn','Nyborg','Odense','Svendborg','Sønderborg','Tønder','Varde','Vejen','Vejle','Ærø']       
  
    
                                 
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
