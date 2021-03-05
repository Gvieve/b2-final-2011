flt1 = Flight.create!(number: 1776, date: "04/05/2021", time: "11:00 am", departure_city: "Denver", arrival_city: "Chicago")
flt2 = Flight.create!(number: 145, date: "04/06/2021", time: "1:00 pm", departure_city: "Seattle", arrival_city: "Denver")
flt3 = Flight.create!(number: 1879, date: "04/05/2021", time: "5:00 pm", departure_city: "Denver", arrival_city: "San Francisco")
flt4 = Flight.create!(number: 9813, date: "04/03/2021", time: "6:00 am", departure_city: "Boston", arrival_city: "Los Angeles")
kim = flt1.passengers.create!(name: "Kim Krause", age: 52)
bob = flt1.passengers.create!(name: "Bob Krause", age: 54)
cody = flt1.passengers.create!(name: "Cody Krause", age: 16)
brad = flt1.passengers.create!(name: "Brad Barajas", age: 18)
eddie = Passenger.create!(name: "Eddie Anderson", age: 25)
flt1.passengers << eddie
flt2.passengers << eddie
