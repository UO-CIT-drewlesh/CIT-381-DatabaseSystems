/*
  REST API/CRUD HTTP Verb and Status Codes
  CRUD    Verb    Entire Collection   Single Item
  ------------------------------------------------------------------------
  Default for bad URLs                404 (Not Found - Bad URL)
  Default for errors                  400 (Bad Request)
  Create  POST    405 (Not Allowed)   201 (Created)
                                      409 (Conflict - already exists)
  Read    GET     200 (OK)            200 (OK - content found)
                                      204 (No Content - can't find content)
  Update  PUT     405 (Not Allowed)   204 (OK - content updated)
                                      204 (No Content - can't find content)
  Delete  DELETE  405 (Not Allowed)   200 (OK - content deleted)
                                      204 (No Content - can't find content)
*/

// #region  **** Libraries ****
// Require filesystem library
const fs = require("fs");

// Require mysql connection library
const mysql = require("mysql2");

// Require the Fastify framework and instantiate it
const fastify = require("fastify")();
// #endregion

// #region  **** Connection information ****
// Include server access information
const dbInfo = require("./dbInfo.js");
// #endregion

// #region **** Use non-object or object version of SQL parameterization ****
// Toggle between using object method for queries
const ObjectQueriesToggle = false;
// #endregion

// #region  **** Console output settings ****
// Debug toggle: output debug statements to console
const DO_DEBUG = true;

// Status toggle: output status messages to console
const DO_STATUS = true;
// #endregion

// #region **** Web Page
// Handle "/" GET route
fastify.get("/", (request, reply) => {
  fs.readFile(`${__dirname}/index.html`, (err, data) => {
    if (err) {
      reply
        .code(500)
        .header("Content-Type", "text/html; charset=utf-8")
        .send("<h1>Server error.</h1>");
    } else {
      reply
        .code(200)
        .header("Content-Type", "text/html; charset=utf-8")
        .send(data);
    }
  });
});
// Handle request for CSS file
fastify.get("/color.css", (request, reply) => {
  fs.readFile(`${__dirname}/color.css`, (err, data) => {
    if (err) {
      reply
        .code(500)
        .header("Content-Type", "text/html; charset=utf-8")
        .send("<h1>Server error.</h1>");
    } else {
      reply
        .code(200)
        .header("Content-Type", "text/css; charset=utf-8")
        .send(data);
    }
  });
});
// Handle request for JS file
fastify.get("/color.js", (request, reply) => {
  fs.readFile(`${__dirname}/color.js`, (err, data) => {
    if (err) {
      reply
        .code(500)
        .header("Content-Type", "text/html; charset=utf-8")
        .send("<h1>Server error.</h1>");
    } else {
      reply
        .code(200)
        .header("Content-Type", "text/javascript; charset=utf-8")
        .send(data);
    }
  });
});
// #endregion

// #region  **** Read/GET (CRUD/HTTP verb) ****
// Read/GET: Get colors
fastify.get("/colors/:COLOR_ID?", (request, reply) => {
  // Extract COLOR_ID from request object using deconstruction
  const { COLOR_ID = "" } = request.params;
  if (DO_DEBUG) console.log("Route /colors GET", COLOR_ID);

  // Initialize data object for query
  let data = [];

  // Define initial query (embedded query)
  let sql = "SELECT * FROM COLOR";

  // Construct query using ? as replacement parameters replaced from data
  if (COLOR_ID.length > 0) {
    if (!ObjectQueriesToggle) {
      // Non-object technique
      sql += " WHERE COLOR_ID = ?";
      data.push(COLOR_ID);
    } else {
      // Object technique, only works if request parameter(s) match database column names
      sql += " WHERE ?";
      data = request.params;
    }
    if (DO_DEBUG) console.log(data);
  } else {
    sql += " ORDER BY COLOR_NAME";
  }
  if (DO_DEBUG) console.log("SQL", sql);

  // Setup default response object
  const response = {
    error: "",
    statusCode: 200,
    rows: [],
  };

  // Execute query and respond
  connection.query(sql, data, (errQuery, rows) => {
    if (errQuery) {
      if (DO_STATUS) console.log(errQuery);
      response.error = errQuery;
      response.statusCode = 400;
    } else if (rows.length > 0) {
      if (DO_STATUS) console.log("Rows returned", rows.length);
      response.rows = rows;
    } else {
      if (DO_STATUS) console.log("No color rows...\n");
      response.statusCode = 204;
    }

    // Webserver response
    reply
      .code(response.statusCode)
      .header("Content-Type", "application/json; charset=utf-8")
      .send(response)
      .send(response);
  });
});
// #endregion

// #region **** Create/POST (CRUD/HTTP verb) ****
// Create/POST: Add color
// Note: The trailing / (e.g. /colors/) is required to make POST work
fastify.post("/colors/", (request, reply) => {
  // Create renamed local variables from request body object color and hex properties
  const { color: COLOR_NAME, hex: COLOR_HEX } = request.body;
  if (DO_DEBUG) console.log("Route /colors POST", COLOR_NAME, COLOR_HEX);

  // Define initial query (embedded query), and data object
  let sql = "INSERT INTO COLOR (COLOR_NAME, COLOR_HEX) VALUES (?, ?)";
  let data = [COLOR_NAME, COLOR_HEX];
  if (ObjectQueriesToggle) {
    sql = "INSERT INTO COLOR SET ?";
    data = { COLOR_NAME, COLOR_HEX };
  }

  // Setup default response object
  const response = {
    error: "",
    statusCode: 201,
    id: "",
  };

  // Execute query and respond
  connection.query(sql, data, (errQuery, result) => {
    if (errQuery) {
      if (DO_STATUS) console.log(errQuery);
      response.error = errQuery;
      response.statusCode = 400;
    } else {
      if (DO_STATUS) console.log("Insert ID: ", result.insertId);
      response.id = result.insertId;
    }

    // Webserver response
    reply
      .code(response.statusCode)
      .header("Content-Type", "application/json; charset=utf-8")
      .send(response);
  });
});
// #endregion

// #region **** Delete/DELETE (CRUD/HTTP verb) ****
// Delete/DELETE: Delete color
fastify.delete("/colors/:COLOR_ID?", (request, reply) => {
  // Extract COLOR_ID from request object using deconstruction
  const { COLOR_ID = "" } = request.params;
  if (DO_DEBUG) console.log("Route /colors DELETE", COLOR_ID);

  // Define initial query (embedded query), and data object
  let sql = "DELETE FROM COLOR WHERE COLOR_ID = ?";
  let data = [COLOR_ID];
  if (ObjectQueriesToggle) {
    sql = "DELETE FROM COLOR WHERE ?";
    data = { COLOR_ID };
  }

  // Setup default response object
  const response = {
    error: "",
    statusCode: 201,
    id: "",
  };

  // Execute query and respond
  if (COLOR_ID.length > 0) {
    // Delete single item
    connection.query(sql, data, (errQuery, result) => {
      if (errQuery) {
        if (DO_STATUS) console.log(errQuery);
        response.error = errQuery;
        response.statusCode = 400;
      } else {
        const { affectedRows = 0 } = result;
        if (affectedRows > 0) {
          if (DO_STATUS) console.log("Delete ID: ", COLOR_ID);
          response.id = COLOR_ID;
        } else {
          if (DO_STATUS) console.log("Unknown ID: ", COLOR_ID);
          response.statusCode = 404;
        }
      }
      if (DO_DEBUG) console.log(result);

      // Webserver response
      reply
        .code(response.statusCode)
        .header("Content-Type", "application/json; charset=utf-8")
        .send(response);
    });
  } else {
    // Attempt to delete collection not supported
    // Webserver response
    response.statusCode = 405;
    response.error = "Delete entire collection not allowed";
    reply
      .code(response.statusCode)
      .header("Content-Type", "application/json; charset=utf-8")
      .send(response);
  }
});
// #endregion

// #region **** Update/PUT: Update color ****
fastify.put("/colors/:COLOR_ID?", (request, reply) => {
  // Extract COLOR_ID from request object using deconstruction
  const { COLOR_ID = "" } = request.params;
  const { color: COLOR_NAME, hex: COLOR_HEX } = request.body;
  if (DO_DEBUG) console.log("Route /colors PUT", COLOR_ID, COLOR_NAME, COLOR_HEX);

  // Define initial query (embedded query), and data object
  let sql = "UPDATE COLOR SET ";
  let setSQL = "";
  let data = [];
  if (!ObjectQueriesToggle) {
    if (COLOR_NAME) {
      setSQL = "COLOR_NAME = ?";
      data.push(COLOR_NAME);
    }
    if (COLOR_HEX) {
      if (setSQL.length > 0) {
        setSQL += ", ";
      }
      setSQL += "COLOR_HEX = ?";
      data.push(COLOR_HEX);
    }
    if (setSQL.length > 0 && COLOR_ID.length > 0) {
      setSQL += " WHERE COLOR_ID = ?";
      data.push(COLOR_ID);
    }
  } else {
    // Object version
    sql = "UPDATE COLOR SET ? WHERE COLOR_ID=?";
    data = { COLOR_ID };
  }

  // Setup default response object
  const response = {
    error: "",
    statusCode: 201,
    id: "",
  };

  // Execute query and respond
  if (COLOR_ID.length > 0) {
    // Verify sql and data populated for update
    if (setSQL.length === 0 || data.length === 0) {
    // Webserver response
    response.statusCode = 400;
    response.error = "Data missing for update";
    reply
      .code(response.statusCode)
      .header("Content-Type", "application/json; charset=utf-8")
      .send(response);
    } else {
      // Delete single item
      sql += setSQL;
      connection.query(sql, data, (errQuery, result) => {
        if (errQuery) {
          if (DO_STATUS) console.log(errQuery);
          response.error = errQuery;
          response.statusCode = 400;
        } else {
          const { affectedRows = 0 } = result;
          if (affectedRows > 0) {
            if (DO_STATUS) console.log("Update ID: ", COLOR_ID);
            response.id = COLOR_ID;
          } else {
            if (DO_STATUS) console.log("Unknown ID: ", COLOR_ID);
            response.statusCode = 404;
          }
        }
        // if (DO_DEBUG) console.log(result);

        // Webserver response
        reply
          .code(response.statusCode)
          .header("Content-Type", "application/json; charset=utf-8")
          .send(response);
      });
    }
  } else {
    // Attempt to delete collection not supported
    // Webserver response
    response.statusCode = 405;
    response.error = "Delete entire collection not allowed";
    reply
      .code(response.statusCode)
      .header("Content-Type", "application/json; charset=utf-8")
      .send(response);
  }
});
// #endregion

// #region **** Ummatched routes ****
// Unmatched route handler
function unmatchedRouteHandler(reply) {
  // Setup default response object
  const response = {
    error: "Unsupported request",
    statusCode: 404,
  };
  reply
    .code(response.statusCode)
    .header("Content-Type", "application/json; charset=utf-8")
    .send(response);
}

// Unmatched verbs
fastify.get("*", (_, reply) => {
  unmatchedRouteHandler(reply);
});
fastify.post("*", (_, reply) => {
  unmatchedRouteHandler(reply);
});
fastify.delete("*", (_, reply) => {
  unmatchedRouteHandler(reply);
});
fastify.put("*", (_, reply) => {
  unmatchedRouteHandler(reply);
});
// #endregion

/*

// Update/PUT: Update color
app.put('/colors', function (req, res) {
   console.log("Route /colors PUT");
   let data = [{COLOR_NAME: req.body.color, COLOR_HEX: req.body.hex}, req.body.id];
   connection.query("UPDATE COLOR SET ? WHERE COLOR_ID=?",  
      data, 
      function (errQuery, result) {
         if (errQuery) {
            console.log(errQuery);
            res.json({status: "Error", err: errQuery});
         } else {
            console.log("Updated ID: ", req.body.id, ", Affected Rows: ", result.affectedRows);
            res.json({status: req.body.id, err: "", message: "Row updated"});         }
      }
   );
});
*/

// #region **** Create database connection ****
// Note: Output all of the DB connection statements
console.log("Creating connection...\n");
let connection = mysql.createConnection({
  host: dbInfo.dbHost,
  port: dbInfo.dbPort,
  user: dbInfo.dbUser,
  password: dbInfo.dbPassword,
  database: dbInfo.dbDatabase,
});
// Connect to database
connection.connect(function (err) {
  console.log("Connecting to database...\n");

  if (err) {
    // Handle any errors
    console.log(err);
    console.log("Exiting application...\n");
  } else {
    console.log("Connected to database...\n");
    // Start server and listen to requests using Fastify
    // Note: Latest version of fastify listen requires object as first parameter
    const host = "127.0.0.1";
    const port = 8080;
    fastify.listen({ host, port }, (err, address) => {
      if (err) {
        console.log(err);
        process.exit(1);
      }
      console.log(`Server listening on ${address}`);
    });
  }
});

// #endregions
