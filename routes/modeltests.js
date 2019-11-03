/************************************************************/
/*                   Route Name : modelTests                */
/************************************************************/

var express = require("express");
var router = express.Router();
var db = require("../server");
var bodyParser = require("body-parser");

router.use(bodyParser.json()); // for parsing application/json

/*------------------------------------- get method for fetch all modeltests -------------------------------------*/
router.get("/",function (req, res, next) {
  var sql = "SELECT * FROM splenday_company WHERE id > 1";
  db.query(sql, function (err, rows, fields) {
    if (err) {
      res.status(500).send({ error: "Something failed!" });
    }
    res.json(rows);
  });
});

/*--------------------------------------- post method for create modeltests ----------------------------------------*/
router.post("/create", function (req, res, next) {
  var item_title = req.body.item_title;
  var test_difficulty = req.body.test_difficulty;

  modelTest = {
    item_title: item_title,
    test_difficulty: test_difficulty
  };

  var sql = `INSERT INTO modeltests SET ?`;
  db.query(sql, [modelTest], function (err, result) {
    if (err) {
      res.status(500).send({ error: "Something failed!" });
      res.json({
        status: "danger",
        title: "Failed",
        subtitle: "The model test could not be added"
      });
    }
    res.json({
      status: "success",
      id: result.insertId,
      title: "Successful",
      subtitle: item_title + " (id: " + result.insertId + ")" + " is added"
    });
  });
});

/*---------------------------------------   put method for update modeltests --------------------------------------------*/
router.put("/update", function (req, res, next) {
  var id = req.body.id;
  var item_title = req.body.item_title;
  var test_difficulty = req.body.test_difficulty;

  var sql = `UPDATE modeltests SET item_title=?, test_difficulty=? WHERE id=?`;
  db.query(sql, [item_title, test_difficulty, id], function (err, result) {
    if (err) {
      res.status(500).send({ error: "Something failed!" });
      res.json({
        status: "danger",
        subtitle: "The model test could not be updated"
      });
    }
    res.json({
      status: "success",
      id: result.insertId,
      title: "Successful",
      subtitle: item_title + " (id: " + result.insertId + ")" + " is Updated"
    });
  });
});

/*----------------------------------------- delete method for delete modeltests ------------------------------------------*/
router.delete("/delete/:id", function (req, res, next) {
  var id = req.params.id;
  var sql = `DELETE FROM modeltests WHERE id=?`;
  db.query(sql, [id], function (err, result) {
    if (err) {
      res.status(500).send({ error: "Something failed!" });
      res.json({
        status: "danger",
        title: "Failed",
        subtitle: "Item cannot be deleted"
      });
    }
    res.json({
      status: "success",
      id: result.insertId,
      title: "Successful",
      subtitle: "Item has been deleted"
    });
  });
});

module.exports = router;
