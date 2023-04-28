
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'bundler/setup'
require 'sqlite3'

def is_barber_exists? db, name
  db.execute('select * from Barbers where name=?', [name]).length > 0
end

def seed_db db, barbers 

  barbers.each do |barber|
    if !is_barber_exists? db, barber
      db.execute 'insert into Barbers (name) values (?)', [barber]
    end
  end

end

# определение метода get_db
def get_db
  db = SQLite3::Database.new "barbershop.db"
  db.results_as_hash = true
  return db
end

before do 
  db = get_db
  @barbers = db.execute 'select * from Barbers'
end

configure do 
  db = get_db
  db.execute 'CREATE TABLE IF NOT EXISTS "Users" (
    "id"	INTEGER,
    "username"	TEXT,
    "phone"	TEXT,
    "datestamp"	TEXT,
    "barber"	TEXT,
    "color"	TEXT,
    PRIMARY KEY("id" AUTOINCREMENT)
  )'

  db.execute 'CREATE TABLE IF NOT EXISTS "Barbers" (
    "id"	INTEGER,
    "name"	TEXT,
    PRIMARY KEY("id" AUTOINCREMENT)
    
  )'
  seed_db db, ['Марина', 'Светлана', 'Анна', 'Людмила']
end

# db = get_db

# db.execute 'select * from Users' do |row|
#   print row['username']
#   print "\t-\t"
#   print row['datestamp']
#   puts '==='
  
# end


  
  get '/' do 
    erb :index
  end
    
  get '/about' do 
    #@error = 'something wrong!'
    erb :about
  
  end
  
  get '/visit' do 
    erb :visit
  end

  get '/pricing' do
    erb :pricing
  end

  
  get '/contacts' do
    erb 'Phone: 111222'
  end

  post '/about' do
     "OK"
  end

  get '/showusers' do 
    db = get_db

    @results = db.execute 'select * from Users order by id desc'
   
    erb :showusers
  end

  

  post '/visit' do
    @username = params[:username]
    @phone = params[:phone]
    @datetime = params[:datetime]
    @barber = params[:barber]
    @color = params[:color]

    hh = { :username => 'Введите имя',
           :phone => 'Введите телефон', 
           :datetime => 'Введите дату и время' }



    @error = hh.select {|key,_| params[key] == ""}.values.join(", ")

    if @error != ''
      return erb :visit
    end




    # hh.each do |key, value|

      # если параметр пуст
      # if params[key] == ''
        # переменной error присвоить value из хеша hh
        # (а value из хеша hh это сообщение об ошибке)
        # т.e. переменной error присвоить сообщение об ошибке
        #@error = hh[key]

        # вернуть представление visit
        # return erb :visit
          
      # end
    # end
  db = get_db
  db.execute 'insert into Users (username, phone, datestamp, barber,color) values (?, ?, ?, ?, ?)', [@username, @phone, @datetime, @barber, @color]

    erb "<h2>Спасибо, вы записались.</h2>"
  end

  

  