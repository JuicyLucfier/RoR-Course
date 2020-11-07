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
    filter.length
    filter
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
      nil
    else
      list.insert(-2, station)
    end
  end

  def del_station(station)
    list.delete(station) if list.include? station
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
    self.wagons += 1 if self.speed.zero?
  end

  def del_wagon
    if self.speed.zero?
      self.wagons -= 1 if self.wagons.positive?
    end
  end

  def new_route(route)
    self.route = route
    self.pos = route.list[0]
    pos.get_train(self)
  end

  def go
    if find_next_station
      pos.send_train(self)
      self.pos = route.list[route.list.index(pos) + 1]
      pos.get_train(self)
    end
  end

  def back
    if find_last_station
      pos.send_train(self)
      self.pos = route.list[route.list.index(pos) - 1]
      pos.get_train(self)
    end
  end

  def cur_station
    pos
  end

  def last_station
    route.list[route.list.index(pos) - 1] if find_last_station
  end

  def find_last_station
    route.list.index(pos) != 0
  end

  def find_next_station
    route.list.index(pos) != route.list.length - 1
  end

  def next_station
    route.list[route.list.index(pos) + 1] if find_next_station
  end
end
