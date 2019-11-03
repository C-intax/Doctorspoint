
var mysql = require('mysql');

var connection = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'doctorspoint'
});

connection.getConnection(function (err) {
  if (err) throw err;
  console.log('connected!');
});

module.exports = connection;

