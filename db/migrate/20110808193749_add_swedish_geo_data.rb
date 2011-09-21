# Information obtained from http://en.wikipedia.org/wiki/sweden
# created by Juergen Helmers <juergen.helmers@gmail.com>

class AddSwedishGeoData < ActiveRecord::Migration
  
  @country = "Sweden"
  @states = Hash.new
    
  @states['Stockholm'] = ['Botkyrka','Danderyd','Ekerö','Haninge','Huddinge','Järfälla','Lidingö','Nacka','Norrtälje','Nykvarn','Nynäshamn','Salem','Sigtuna','Sollentuna','Solna','Stockholm','Sundbyberg','Södertälje','Tyresö','Täby','Upplands-Bro','Upplands Väsby','Vallentuna','Vaxholm','Värmdö','Österåker']
  @states['Uppsala'] = ['Älvkarleby','Tierp','Östhammar','Uppsala','Enköping','Håbo','Knivsta','Heby']
  @states['Södermanland'] = ['Eskilstuna','Flen','Gnesta','Katrineholm','Nyköping','Oxelösund','Strängnäs','Trosa','Vingåker']
  @states['Östergötland'] = ['Boxholm','Finspång','Kinda','Linköping','Mjölby','Motala','Norrköping','Söderköping','Vadstena','Valdemarsvik','Ydre','Åtvidaberg','Ödeshög']
  @states['Jönköping'] = ['Aneby','Eksjö','Gislaved','Gnosjö','Habo','Jönköping','Mullsjö','Sävsjö','Vaggeryd','Värnamo']
  @states['Kronoberg'] = ['Alvesta','Lessebo','Ljungby','Markaryd','Tingsryd','Uppvidinge','Växjö','Älmhult']
  @states['Kalmar'] = ['Emmaboda','Hultsfred','Högsby','Kalmar','Mönsterås','Nybro','Oskarshamn','Torsås','Vimmerby','Västervik','Borgholm','Mörbylånga']
  @states['Gotland'] = ['Visby']
  @states['Blekinge'] = ['Karlskrona','Karlshamn','Ronneby','Olofström']
  @states['Skåne'] = ['Bjuv','Bromölla','Burlöv','Båstad','Eslöv','Helsingborg','Hässleholm','Höganäs','Hörby','Höör','Klippan','Kristianstad','Kävlinge','Landskrona','Lomma','Lund','Malmö','Osby','Perstorp','Simrishamn','Sjöbo','Skurup','Staffanstorp','Svalöv','Svedala','Tomelilla','Trelleborg','Vellinge','Ystad','Åstorp','Ängelholm','Örkelljunga','Östra Göinge']
  @states['Halland'] = ['Halmstad','Varberg','Falkenberg','Kungsbacka','Onsala']
  @states['Västra Götaland'] = ['Ale','Alingsås','Bengtsfors','Bollebygd','Borås','Dals-Ed','Essunga','Falköping','Färgelanda','Grästorp','Gullspång','Götene','Gothenburg','Herrljunga','Hjo','Härryda','Karlsborg','Kungälv','Lerum','Lidköping','Lilla Edet','Lysekil','Ale','Alingsås','Bengtsfors','Bollebygd','Borås','Dals-Ed','Essunga','Falköping','Färgelanda','Grästorp','Gullspång','Götene','Gothenburg','Herrljunga','Hjo','Härryda','Karlsborg','Kungälv','Lerum','Lidköping','Lilla Edet','Lysekil','Mariestad','Mark','Mellerud','Munkedal','Mölndal','Orust','Partille','Skara','Skövde','Sotenäs','Stenungsund','Strömstad','Svenljunga','Tanum','Tibro','Tidaholm','Tjörn','Tranemo','Trollhättan','Töreboda','Uddevalla','Ulricehamn','Vara','Vårgårda','Vänersborg','Åmål','Öckerö']
  @states['Värmland'] = ['Arvika','Eda','Filipstad','Forshaga','Grums','Hagfors','Hammarö','Karlstad','Kil','Kristinehamn','Munkfors','Storfors','Sunne','Säffle','Torsby','Årjäng']
  @states['Örebro'] = ['Ljusnarsberg','Hällefors','Lindesberg','Nora','Karlskoga','Örebro','Lekeberg','Degerfors','Kumla','Hallsberg','Laxå','Askersund']
  @states['Västmanland'] = ['Arboga','Fagersta','Hallstahammar','Kungsör','Köping','Norberg','Sala','Skinnskatteberg','Surahammar','Västerås']
  @states['Dalarna'] = ['Avesta','','Borlänge','Falun','Gagnef','Hedemora','Leksand','Ludvika','Malung-Sälen','Mora','Orsa','Rättvik','Smedjebacken','Säter','Vansbro','Älvdalen']
  @states['Gävleborg'] = ['Bollnäs','Gävle','Hofors','Hudiksvall','Ljusdal','Nordanstig','Ockelbo','Ovanåker','Sandviken','Söderhamn']
  @states['Västernorrland'] = ['Härnösand','Kramfors','Sollefteå','Sundsvall','Timrå','Ånge','Örnsköldsvik']
  @states['Jämtland'] = ['Berg','Bräcke','Härjedalen','Krokom','Ragunda','Strömsund','Åre','Östersund']
  @states['Västerbotten'] = ['Bjurholm','Dorotea','Lycksele','Malå','Nordmaling','Norsjö','Robertsfors','Skellefteå','Sorsele','Storuman','Umeå','Vilhelmina','Vindeln','Vännäs','Åsele']
  @states['Norrbotten'] = ['Pajala','Övertorneå','Överkalix','Boden','Kalix','Haparanda','Älvsbyn','Luleå','Piteå','Kiruna','Gällivare','Jokkmokk','Arjeplog','Arvidsjaur']
    
                                 
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
