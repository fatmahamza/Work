// var hotel = new Object();
// hotel.name = 'Park';
// hotel.rooms = 120;
// hotel.booked = 78;
// hotel.checkAvailability = function() {
//   return this.rooms - this.booked;
// };

function Hotel(name, rooms, booked) {
  this.name = name;
  this.rooms = rooms;
  this.booked = booked;
  this.checkAvailability = function() {
    return this.rooms - this.booked;
  }
};

var quayHotel = new Hotel('Quay', 40, 25);
var parkHotel = new Hotel('Park', 120, 78);
var hotels = [quayHotel, parkHotel];

var el = document.getElementById('table_data');
el.innerHTML = "<th>Name</th> <th>Rooms</th> <th>Booked</th> <th>Available</th>"
var i = 0;
el.innerHTML += "<tr><td>" + hotels[i]['name'] + "</td><td>" + hotels[i]['rooms'] + "</td><td>" + hotels[i]['booked'] + "</td><td>" + hotels[i].checkAvailability() + "</td></tr>";

i = 1;
el.innerHTML += "<tr><td>" + hotels[i]['name'] + "</td><td>" + hotels[i]['rooms'] + "</td><td>" + hotels[i]['booked'] + "</td><td>" + hotels[i].checkAvailability() + "</td></tr>";

// var hotel = {
//   name: 'Quay',
//   rooms: 40,
//   booked: 25,
//   checkAvailability: function() {
//     return this.rooms - this.booked; 
//   }
// };