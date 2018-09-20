class Route
  attr_reader :stations, :from, :to

  def initialize(from, to)
    @stations = [from, to]
    puts "Создан маршрут следования #{from.station_name} - #{to.station_name}"
  end

  def add_station(station)
    self.stations.insert(-2, station)
    puts "К маршруту #{stations.first.station_name} - #{stations.last.station_name} добавлена станция #{station.station_name}"
  end

  def remove_station(station)
    if [stations.first, stations.last].include?(station)
      puts "Первую и последнюю станции маршрута удалять нельзя!"
    else
      self.stations.delete(station)
      puts "Из маршрутного листа #{stations.first.station_name} - #{stations.last.station_name} удалена станция #{station.station_name}"
    end
  end

  def show_stations
    puts "В маршрутный лист #{stations.first.station_name} - #{stations.last.station_name} входят станции с именами: "
    stations.each{|station| puts " #{station.station_name}" }
  end
end
