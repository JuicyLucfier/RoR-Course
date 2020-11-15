# frozen_string_literal: true

require_relative 'company'
require_relative 'instance_counter'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'

# Interface
class Main
  attr_accessor :stations, :trains, :routes, :route, :train

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def show_menu
    loop do
      show_interface
    end
  end

  # Данные методы проходят внутри одного класса и другие классы не должны знать, как работают эти методы
  private

  def make_choice
    gets.chomp.to_i
  end

  def check_find_station(station_name)
    found = stations.select { |station| station.name == station_name }
    return found[0] unless found.empty?
  end

  def check_find_train(train_number)
    found = trains.select { |train| train.number == train_number }
    return found[0] unless found.empty?
  end

  def check_find_route(route_title)
    found = routes.select { |route| route.title == route_title }
    return found[0] unless found.empty?
  end

  def find_station
    station = gets.chomp
    return unless check_find_station(station)

    check_find_station(station)
  end

  def find_train
    puts 'Введите номер поезда:'
    train_number = gets.chomp
    return unless check_find_train(train_number)

    check_find_train(train_number)
  end

  def find_route
    puts 'Введите название маршрута:'
    route_title = gets.chomp
    return unless check_find_route(route_title)

    check_find_route(route_title)
  end

  def find_wagon(train)
    return if train.nil?

    train.wagons.each { |wagon| puts "Введите '#{train.wagons.index(wagon) + 1}', чтобы выбрать вагон #{wagon}" }
    train.wagons[make_choice - 1]
  end

  def create_station
    puts 'Введите название станции:'
    stations << Station.new(gets.chomp)
  end

  def create_train
    puts 'Введите номер поезда:'
    train_number = gets.chomp
    puts 'Введите "1", чтобы выбрать тип поезда "Грузовой"'
    puts 'Введите "2", чтобы выбрать тип поезда "Пассажирский"'
    case make_choice
    when 1 then train = CargoTrain.new(train_number)
    when 2 then train = PassengerTrain.new(train_number)
    end
    trains << train
    puts "Поезд с номером '#{train.number}' типа '#{train.type}' успешно создан!"
  rescue StandardError => e
    puts e.inspect
    retry
  end

  def create_route
    puts 'Введите название начальной станции:'
    first_station = find_station

    puts 'Введите название конечной станции:'
    last_station = find_station

    puts 'Введите название маршрута:'
    route_title = gets.chomp
    return if first_station.nil? || last_station.nil?
    return if first_station == last_station

    routes << Route.new(first_station, last_station, route_title)
  end

  def add_station
    route = find_route
    puts 'Введите название станции:'
    station = find_station
    return if station.nil? || route.nil?

    route.add_station(station)
  end

  def delete_station
    route = find_route
    puts 'Введите название станции:'
    station = find_station
    return if station.nil? || route.nil?

    route.del_station(station)
  end

  def set_route
    train = find_train
    route = find_route
    return if train.nil? || route.nil?

    train.new_route(route)
  end

  def add_wagon
    train = find_train
    return if train.nil?

    puts 'Введите "1", чтобы добавить грузовой вагон'
    puts 'Введите "2", чтобы добавить пассажирский вагон'
    case make_choice
    when 1
      puts 'Введите объем вагона:'
      train.add_wagon(WagonCargo.new(make_choice))
    when 2
      puts 'Введите кол-во мест в вагоне:'
      train.add_wagon(WagonPassenger.new(make_choice))
    end
  end

  def delete_wagon
    train = find_train
    train.delete_wagon
  end

  def train_go
    train = find_train
    train.go
  end

  def train_back
    train = find_train
    train.back
  end

  def wagon_take_a_seat
    train = find_train
    wagon = find_wagon(train)
    return if train.nil? || wagon.nil? || train.type != wagon.type

    wagon.take_a_seat
  end

  def wagon_take_volume
    train = find_train
    wagon = find_wagon(train)
    return if train.nil? || wagon.nil? || train.type != wagon.type

    puts 'Введите кол-во объема, которое требуется занять:'
    wagon.take_volume(make_choice)
  end

  # Эти методы позволяют увидеть "внешнюю" оболочку класса
  protected

  def show_interface
    show_main_menu
    case make_choice
    when 1
      show_creations_menu
      show_main_menu_choice
    when 2
      show_operations_menu
      show_operations_menu_choice
    when 3
      show_objects_menu
      show_objects_menu_choice
    when 0
      exit
    end
  end

  def show_main_menu_choice
    case make_choice
    when 1 then create_station
    when 2 then create_train
    when 3 then create_route
    end
  end

  def show_operations_menu_choice
    case make_choice
    when 1 then add_station
    when 2 then delete_station
    when 3 then set_route
    when 4 then add_wagon
    when 5 then delete_wagon
    when 6 then train_go
    when 7 then train_back
    when 8 then wagon_take_a_seat
    when 9 then wagon_take_volume
    end
  end

  def show_objects_menu_choice
    case make_choice
    when 1 then puts stations
    when 2 then show_trains_on_station
    when 3 then show_wagons
    end
  end

  def show_main_menu
    puts "Введите '1', если вы хотите создать станцию, поезд, вагон или маршрут"
    puts "Введите '2', если вы хотите провести операции с созданными объектами"
    puts "Введите '3', если вы хотите вывести текущие данные об объектах"
    puts "Введите '0', если вы хотите закончить программу"
  end

  def show_creations_menu
    puts "Введите '1', если вы хотите создать станцию"
    puts "Введите '2', если вы хотите создать поезд"
    puts "Введите '3', если вы хотите создать маршрут"
    puts "Введите '0', если вы хотите вернуться назад к меню"
  end

  def show_operations_menu
    puts "Введите '1', если вы хотите добавить станцию в маршрут"
    puts "Введите '2', если вы хотите удалить станцию из маршрута"
    puts "Введите '3', если вы хотите назначить маршрут поезду"
    puts "Введите '4', если вы хотите добавить вагон к поезду"
    puts "Введите '5', если вы хотите отцепить вагон от поезда"
    puts "Введите '6', если вы хотите переместить поезд по маршруту вперед"
    puts "Введите '7', если вы хотите переместить поезд по маршруту назад"
    puts "Введите '8', если вы хотите занять место в вагоне"
    puts "Введите '9', если вы хотите занять объем в вагоне"
    puts "Введите '0', если вы хотите вернуться назад к меню"
  end

  def show_objects_menu
    puts "Введите '1', если вы хотите вывести список станций"
    puts "Введите '2', если вы хотите вывести список поездов на станции"
    puts "Введите '3', если вы хотите вывести список вагонов у поезда"
    puts "Введите '0', если вы хотите вернуться назад к меню"
  end

  def show_trains_on_station
    puts 'Введите название станции:'
    station = find_station
    return if station.nil?

    station.trains_block
  end

  def show_wagons
    train = find_train
    return if train.nil?

    train.wagons_block
  end
end

Main.new.show_menu
