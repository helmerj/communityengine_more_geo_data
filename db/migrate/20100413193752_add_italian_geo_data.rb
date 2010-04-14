
# Information obtained from http://en.wikipedia.org/wiki/Provinces_of_Italy
# created by Juergen Helmers <juergen dot helmers at gmail dot com>

class AddItalianGeoData < ActiveRecord::Migration
  
  @country = "Italy"
  @states = Hash.new
 
  @states['Abruzzo'] = ['L\'Aquila', 'Chieti', 'Pescara', 'Teramo' ]
  @states['Apulia'] = ['Bari','Barletta-Andria-Trani','Brindisi','Foggia','Lecce','Taranto']
  @states['Basilicata'] = ['Potenza', 'Matera']
  @states['Calabria'] = ['Catanzaro','Cosenza','Crotone','Reggio Calabria','Vibo Valentia']
  @states['Campania'] = ['Avellino','Benevento','Caserta','Naples (Napoli)','Salerno']
  @states['Emilia-Romagna'] = ['Bologna','Ferrara','Forlì-Cesena','Modena','Parma','Piacenza','Ravenna','Reggio Emilia','Rimini']
  @states['Friuli-Venezia Giulia'] = ['Gorizia','Pordenone','Trieste','Udine']
  @states['Lazio'] = ['Frosinone','Latina','Rieti','Rome (Roma)','Viterbo']
  @states['Liguria'] = ['Genoa (Genova)','Imperia','La Spezia','Savona']
  @states['Lombardy'] = ['Bergamo','Brescia','Como','Cremona','Lecco','Lodi','Mantua (Mantova)','Milan (Milano)','Monza and Brianza','Pavia','Sondrio','Varese']
  @states['Marche'] = ['Ancona','Ascoli Piceno','Fermo','Macerata','Pesaro and Urbino']
  @states['Molise'] = ['Campobasso','Isernia']
  @states['Piedmont'] = ['Alessandria','Asti','Biella','Cuneo','Novara','Turin','Verbano-Cusio-Ossola','Vercelli']
  @states['Sardinia'] = ['Cagliari','Carbonia-Iglesias','Medio Campidano','Nuoro','Ogliastra','Olbia-Tempio','Oristano','Sassari']
  @states['Sicily'] = ['Agrigento','Caltanissetta','Catania','Enna','Messina','Palermo','Ragusa','Syracuse (Siracusa)','Trapani']
  @states['Trentino-Alto Adige'] = ['Trento','Bolzano-Bozen (Alto Adige/Südtirol) ']
  @states['Tuscany'] = ['Arezzo','Florence (Firenze)','Grosseto','Leghorn (Livorno)','Lucca','Massa-Carrara','Pisa','Pistoia','Prato','Siena',]
  @states['Umbria'] = ['Perugia','Terni']
  @states['Veneto'] = ['Belluno','Padua (Padova)','Rovigo','Treviso','Venice (Venezia)','Verona','Vicenza']
  
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
