# Station
class Station
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    trains.push(train)
  end

  def trains_by_type(type)
    filter = trains.select { |trains| trains.type == type }
    count = filter.length
    puts "Поездов данного типа: #{count}, #{filter}."
  end

  def send_train(train)
    trains.delete(train)
  end
end

# Route
class Route
  attr_accessor :first_station, :last_station, :list

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @list = [first_station, last_station]
  end

  def add_station(station)
    if list.include? station
      puts 'Станция уже есть в маршруте!'
    else
      list.insert(-2, station)
    end
  end

  def del_station(station)
    if list.include? station
      if station != first_station && station != last_station
        list.delete(station)
      else
        puts 'Нельзя удалить начальную или конечную станции!'
      end
    else
      puts 'Станции нет в маршруте!'
    end
  end
end

# Train
class Train
  attr_accessor :speed, :wagons, :route, :pos, :number, :type

  def initialize(number, type, wagons)
    @speed = 0
    @number = number
    @type = type
    @wagons = wagons
  end

  def accelerate(value)
    self.speed += value
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    if self.speed.zero?
      self.wagons += 1
    else puts 'Поезд движется!'
    end
  end

  def del_wagon
    if self.speed.zero?
      if self.wagons.positive?
        self.wagons -= 1
      else
        puts 'Вагонов не осталось!'
      end
    else puts 'Поезд движется!'
    end
  end

  def new_route(route)
    self.route = route
    self.pos = route.list[0]
    pos.get_train(self)
  end

  def go
    ind = route.list.index(pos)
    if ind == route.list.length - 1
      puts 'Поезд на конечной станции!'
    else
      pos.send_train(self)
      self.pos = route.list[ind + 1]
      pos.get_train(self)
    end
  end

  def back
    ind = route.list.index(pos)
    if ind.zero?
      puts 'Поезд на начальной станции!'
    else
      pos.send_train(self)
      self.pos = route.list[ind - 1]
      pos.get_train(self)
    end
  end

  def cur_station
    puts "Поезд на станции: '#{pos.name}'"
  end

  def last_station
    ind = route.list.index(pos)
    if ind.zero?
      puts 'Поезд на начальной станции!'
    else
      puts "Предыдущая станция: '#{route.list[ind - 1].name}'"
    end
  end

  def next_station
    ind = route.list.index(pos)
    if ind == route.list.length - 1
      puts 'Поезд на конечной станции!'
    else
      puts "Следующая станция: '#{route.list[ind + 1].name}'"
    end
  end
end
