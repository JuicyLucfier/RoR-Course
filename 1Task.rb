class Station

  attr_accessor:name
  attr_accessor:gruz
  attr_accessor :pass
  attr_accessor :trains
  attr_accessor :gruz_trains
  attr_accessor :pass_trains

  def initialize(name)
    @name = name
    @trains = Array.new
    @gruz_trains = Array.new
    @pass_trains = Array.new
    @gruz = 0
    @pass = 0
  end

  def get_train(number,type,station)
    @trains.push(number)
    if type == "Грузовой"
      station.gruz += 1
      @gruz_trains.push(number)
    else
      station.pass += 1
      @pass_trains.push(number)
    end
  end

  def trains
    if @trains.empty?
      print "На станции нет поездов!"
    else
      print "Все поезда: #{@trains}"
    end
  end

  def type_trains
    puts "Грузовых поездов: #{self.gruz}, #{self.gruz_trains}."
    puts "Пассажирских поездов: #{self.pass}, #{self.pass_trains}."
  end

  def send_train(number,type,station)
    @trains.delete(number)
    if type == "Грузовой"
      station.gruz -= 1
      @gruz_trains.delete(number)
    else
      station.pass -= 1
      @pass_trains.delete(number)
    end
  end
end

class Route

  attr_accessor :first_station
  attr_accessor :last_station
  attr_accessor:list

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @list = [first_station,last_station]
  end

  def add_station(station)
    if self.list.include? station
      puts "Станция уже есть в маршруте!"
    else
      self.list.pop
      self.list += [station]
      self.list += [self.last_station]
    end
  end

  def del_station(station)
    if self.list.include? station
      if station != self.first_station && station != self.last_station
        self.list.delete(station)
      else
        puts "Нельзя удалить начальную или конечную станции!"
      end
    else
      puts "Станции нет в маршруте!"
    end
  end

end

class Train

  attr_accessor :speed
  attr_accessor :wagons
  attr_accessor :route
  attr_accessor :pos
  attr_accessor :number
  attr_accessor :type

  def initialize(number,type,wagons)
    @speed = 0
    @route = []
    @number = number
    @type = type
    @wagons = wagons
    @pos = ''
  end

  def accelerate(value)
    self.speed += value
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    if self.speed == 0
      self.wagons += 1
    else puts "Поезд движется!"
    end
  end

  def del_wagon
    if self.speed == 0
      if self.wagons > 0
        self.wagons -= 1
      else
        puts "Вагонов не осталось!"
      end
    else puts "Поезд движется!"
    end
  end

  def new_route(route)
    temp=[]
    for i in 0..route.list.length-1
      temp += [route.list[i]]
    end
    self.route = temp
    self.pos = self.route[0]
    self.pos.get_train(self.number,self.type,self.pos)
  end

  def go
    ind = self.route.index(self.pos)
    if ind != self.route.length-1
      self.pos.send_train(self.number,self.type,self.pos)
      self.pos = self.route[ind+1]
      self.pos.get_train(self.number,self.type,self.pos)
    else
      puts "Поезд на конечной станции!"
    end
  end

  def back
    ind = self.route.index(self.pos)
    if ind != 0
      self.pos.send_train(self.number,self.type,self.pos)
      self.pos = self.route[ind-1]
      self.pos.get_train(self.number,self.type,self.pos)
    else
      puts "Поезд на начальной станции!"
    end
  end

  def stations
    ind = self.route.index(self.pos)
    if ind == 0
      puts "Поезд на начальной станции: '#{self.pos.name}', следующая станция: '#{self.route[ind+1].name}'"
    elsif ind == self.route.length-1
      puts "Поезд на конечной станции: '#{self.pos.name}', предыдущая станция: '#{self.route[ind-1].name}'"
    else
      puts "Поезд на станции: '#{self.pos.name}', предыдущая станция: '#{self.route[ind-1].name}', следующая станция: '#{self.route[ind+1].name}'"
    end
  end
end
