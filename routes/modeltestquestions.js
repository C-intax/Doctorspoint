/************************************************************/
/*                Route Name : modelTestQuestions           */
/************************************************************/

var express = require("express");
var router = express.Router();
var db = require("../server");
var bodyParser = require("body-parser");

router.use(bodyParser.json()); // for parsing application/json

/*--------------------------------- get method for fetch all modeltestsquestions ---------------------------------*/
router.get("/:foreign_id", function(req, res, next) {
  var foreign_id = req.params.foreign_id;
  var sql = "SELECT * FROM modeltestquestions WHERE foreign_id=?";
  db.query(sql,[foreign_id],function(err, rows, fields) {
    if (err) {
      res.status(500).send({ error: "Something failed!" });
    }
    res.json(rows);
  });
});

/*------------------------------------ post method for create modeltestsquestions ------------------------------------*/
router.post("/create", function(req, res, next) {
  var question = req.body.question;
  var i_answer_1 = req.body.i_answer_1;
  var i_answer_2 = req.body.i_answer_2;
  var i_answer_3 = req.body.i_answer_3;
  var c_answer = req.body.c_answer;
  var foreign_id = req.body.foreign_id;

  question = {
    question: question,
    i_answer_1: i_answer_1,
    i_answer_2: i_answer_2,
    i_answer_3: i_answer_3,
    c_answer: c_answer,
    foreign_id: foreign_id
  };

  var sql = `INSERT INTO modeltestquestions SET ?`;

  db.query(sql, [question], function(err, result) {
    if (err) {
      res.status(500).send({ error: "Something failed!" });
      res.json({
        status: "danger",
        title: "Failed",
        subtitle: "The question could not be added"
      });
    }
    res.json({
      status: "success",
      id: result.insertId,
      title: "Successful",
      subtitle: "New question (id: " + result.insertId + ") is added"
    });
  });
});

/*--------------------------------- put method for update modeltestsquestions ---------------------------------*/
router.put("/update", function(req, res, next) {
  var question_id = req.body.question_id;
  var question = req.body.question;
  var i_answer_1 = req.body.i_answer_1;
  var i_answer_2 = req.body.i_answer_2;
  var i_answer_3 = req.body.i_answer_3;
  var c_answer = req.body.c_answer;
  var foreign_id = req.body.foreign_id;

  var sql = `UPDATE modeltestquestions SET question= ?, i_answer_1= ?, i_answer_2= ?, i_answer_3= ?, c_answer= ?, foreign_id=? WHERE question_id = ?`;
  db.query(
    sql,
    [
      question,
      i_answer_1,
      i_answer_2,
      i_answer_3,
      c_answer,
      foreign_id,
      question_id
    ],
    function(err, result) {
      if (err) {
        res.status(500).send({ error: "Something failed!" });
        res.json({
          status: "danger",
          title: "Failed",
          subtitle: "The Question could not be updated"
        });
      }
      res.json({
        status: "success",
        id: question_id,
        title: "Successful",
        subtitle: "Question (id: " + question_id + ")" + " is edited"
      });
    }
  );
});

/*--------------------------------- delete method for delete modeltestsquestions ---------------------------------*/
router.delete("/delete/:question_id", function(req, res, next) {
  var question_id = req.params.question_id;
  var sql = `DELETE FROM modeltestquestions WHERE question_id=${question_id}`;
  db.query(sql, function(err, result) {
    if (err) {
      res.status(500).send({ error: "Something failed!" });
      res.json({
        status: "danger",
        title: "Failed",
        subtitle: "Question (" + question_id + ") cannot be deleted"
      });
    }
    res.json({
      status: "success",
      title: "Successful",
      subtitle: "Question (id: " + question_id + ") has been deleted"
    });
  });
});

module.exports = router;
