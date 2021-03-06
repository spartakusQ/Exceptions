require_relative 'instance_counter'
require_relative 'company_name'

class Train
  include Validation
  include InstanceCounter
  include CompanyName
  attr_accessor :number, :route, :station

  VALID_NUMBER = /^[a-z\d]{3}-?[a-z\d]{2}$/i

  def initialize(number)
    @number = number
    @carriage = []
    @speed = 0
    validate!
    @@trains[number] = self
    register_instance
  end

  def stop
    self.speed = 0
  end

  def up_speed(speed)
    @speed += 10
  end

  def current_speed
    self.speed
  end

  def down_speed(speed)
    @speed -= 10
    @speed = 0 if @speed < 0
  end

  def add_carriage
    if speed.zero?
      self.carriage += 1
    else
      puts "Для прицепки вагонов, поезд должен стоять."
    end
  end

  def remove_carriage
    if carriage.zero?
      puts "Вагонов уже не осталось."
    elsif speed.zero?
      self.carriage -= 1
    else
      puts "На ходу нельзя отцеплять вагоны!"
    end
  end

  def take_route(route)
    self.route = route
    puts "Поезду с номером #{number} задан маршрут #{route.stations.first.station_name} - #{route.stations.last.station_name}"
  end

  def go_to(station)
    if route.nil?
      puts "Без маршрута следования поезд не может отправиться."
    elsif @station == station
      puts "Поезд с номером #{@number} и так на станции #{@station.station_name}"
    elsif route.stations.include?(station)
      @station.send_train(self) if @station
      @station = station
      station.get_train(self)
    else
      puts "Станция #{station.station_name} не входит в маршрут поезда с номером#{number}"
    end
  end

  def stations_around
    if route.nil?
      puts "Маршрут следования поезда не задан."
    else
      station_index = route.stations.index(station)
      puts "Сейчас поезд на станции #{station.station_name}."
      puts "Предыдущая станция - #{route.stations[station_index - 1].station_name}." if station_index != 0
      puts "Следующая - #{route.stations[station_index + 1].station_name}." if station_index != route.stations.size - 1
    end
  end

  def self.find(number)
    @@trains[number]
  end

  protected

  def validate!
    raise 'Номер поезда неправильного формата' if number.to_s !~ VALID_NUMBER
  end


end
