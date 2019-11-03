/************************************************************/
/*                     Route Name : users                   */
/************************************************************/

var express = require('express');
var router = express.Router();
_ = require('lodash'),
  config = require('../config'),
  jwt = require('jsonwebtoken')
var db = require('../server');
var bodyParser = require('body-parser');

router.use(bodyParser.json()); // for parsing application/json


var secretKey = "don't share this key";


function createToken(user) {
  return jwt.sign(_.omit(user, 'password'), config.secretKey, { expiresIn: 60 * 60 * 5 });
}


function getUser(username, done) {
  db.query('SELECT * FROM users WHERE username = ? LIMIT 1', [username], function (err, rows, fields) {
    if (err) throw err;
    done(rows[0]);
  });
}


router.post('/create', function (req, res) {
  var username = req.body.username;
  var password = req.body.password;
  var email = req.body.email;
  if (!username || !password) {
    return res.status(400).send("You must send the username and the password");
  }
  getUser(username, function (user) {
    if (!user) {
      user = {
        username: username,
        password: password,
        email: email
      };
      var sql = 'INSERT INTO users SET ?';
      db.query(sql, [user], function (err, result) {
        if (err) throw err;
        newUser = {
          id: result.insertId,
          username: user.username,
          password: user.password,
          email: user.email
        };
        res.status(201).send({
          id_token: createToken(newUser)
        });
      });
    }
    else res.status(400).send("A user with that username already exists");
  });
});


router.post('/login', function (req, res, next) {
  var username = req.body.username;
  var password = req.body.password;
  if (!username || !password) {
    return res.status(400).json("You must send the username and the password");
  }
  getUser(username, function (user) {
    if (!user) {
      return res.status(201).json({ status: 'danger', title: 'Failed', subtitle: 'Wrong Username or Password' });
    }
    if (user.password != req.body.password) {
      return res.status(201).json({ status: 'danger', title: 'Failed', subtitle: 'Wrong Password' });
    }
    res.status(201).send({
      status: 'success',
      id: user.id,
      username: user.username,
      password: user.password,
      email: user.email,
      token: createToken(user)
    });
  });
});


router.get('/check', function (req, res) {
  var username = req.body.username;
  if (!username) {
    return res.status(400).send("You must send a username");
  }
  getUserDB(username, function (user) {
    if (!user) res.status(201).send({ username: "OK" });
    else res.status(400).send("A user with that username already exists");
  });
});

module.exports = router;
