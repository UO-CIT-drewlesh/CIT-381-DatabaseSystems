
//Require() Libraries for SQL Connection, Filesystem Library, and Fastify Framework 
const fs = require("fs");
const mysql = require("mysql2");
const fastify = require("fastify")();

const ObjectQueriesToggle = false;
const DO_DEBUG = true;
const DO_STATUS = true;


// GET verb route for courses 
fastify.get('/courses/:CourseID?', (request, reply) => {
    // request object using deconstruction for CourseID
    const {CourseID = "" } = request.params;

    // Initialize data query object
    let data = [];

    // Embedded query
    let sql = "SELECT * FROM courses";

    // Query in case of CourseID as a parameter
    if (CourseID.length > 0) {
        // If ? is used, add sql that reflects the parameter(InstructorID) that replaces ?
        if (!ObjectQueriesToggle) {
            sql += " WHERE CourseID = ?";
            data.push(CourseID);
        } 
        if(DO_DEBUG) console.log(data);
    }
    if (DO_DEBUG) console.log("SQL", sql);

    // Response Object -- holds 
    const response = {
        error: "",
        statusCode: 200,
        rows: []
    };

    // Execute the query and respond
    connection.query(sql, data, (errQuery, rows) => {
        // capture error if there is one -- StatusCode 400, if no data -- statusCode 204 
        // otherwise STATUS log # of rows in reponse data, and respond to the server with data
        if(errQuery) {
            if(DO_STATUS) console.log(errQuery);
            response.error = errQuery;
            response.statusCode = 400;
        } else if (rows.length > 0) {
            if (DO_STATUS) console.log("Rows returned", rows.length);
            response.rows = rows;
        } else {
            if (DO_STATUS) console.log("No Course rows...\n");
            response.statusCode = 204;
        }

        // Server response
        reply
        .code(response.statusCode)
        .header("Content-Type", "application/json, charset=utf-8")
        .send(response);
    });
});

// GET route for instructors
fastify.get('/instructors/:InstructorID?', (request, reply) => {
    // request object using deconstruction for CourseID
    const {InstructorID = "" } = request.params;

    // Initialize data query object
    let data = [];

    // Initialize SQL Embedded query
    let sql = "SELECT * FROM instructors";

    // Query in case of CourseID as a parameter
    if (InstructorID.length > 0) {
        // If ? is used, add sql that reflects the parameter(InstructorID) that replaces ?
        if (!ObjectQueriesToggle) {
            sql += " WHERE InstructorID = ?";
            data.push(InstructorID);
        } 
        if(DO_DEBUG) console.log(data);
    }
    if (DO_DEBUG) console.log("SQL", sql);

    // Create response Object
    const response = {
        error: "",
        statusCode: 200,
        rows: []
    };

    // Execute the query and respond
    connection.query(sql, data, (errQuery, rows) => {
        // capture error if there is one -- StatusCode 400, if no data -- statusCode 204 
        // otherwise STATUS log # of rows in reponse data, and respond to the server with data
        if(errQuery) {
            if(DO_STATUS) console.log(errQuery);
            response.error = errQuery;
            response.statusCode = 400;
        } else if (rows.length > 0) {
            if (DO_STATUS) console.log("Rows returned", rows.length);
            response.rows = rows;
        } else {
            if (DO_STATUS) console.log("No Instructor rows...\n");
            response.statusCode = 204;
        }

         // Server response
        reply
            .code(response.statusCode)
            .header("Content-Type", "application/json, charset=utf-8")
            .send(response);
    });
});


// POST route to add an instructor
fastify.post("/courses/", (request, reply) => {
    const { CourseID: CourseID, 
            CourseName: CourseName, 
            CourseLevel: CourseLevel, 
            CourseTerm: CourseTerm, 
            CourseYear: CourseYear, 
            InstructorID: InstructorID } = request.body;
    if(DO_DEBUG) console.log("Route /instructors POST", CourseID, CourseName, CourseLevel, CourseTerm, CourseYear, InstructorID);

    // Define initial query (embedded query), and data object
    let sql = "INSERT INTO courses (CourseID, CourseName, CourseLevel, CourseTerm, CourseYear, InstructorID ) VALUES (?, ?, ?, ?, ?, ?)";
    let data = [CourseID, CourseName, CourseLevel, CourseTerm, CourseYear, InstructorID];
    if (ObjectQueriesToggle) {
      sql = "INSERT INTO courses SET ?";
      data = { CourseID, CourseName, CourseLevel, CourseTerm, CourseYear, InstructorID };
    }
  
    // Setup default response object
    const response = {
      error: "",
      statusCode: 201,
      id: "",
    };
  

    // Execute query and respond
    connection.query(sql, data, (errQuery) => {
        if (errQuery) {
          if (DO_STATUS) console.log(errQuery);
          response.error = errQuery;
          response.statusCode = 400;
        } else {
          if (DO_STATUS) console.log("Insert CourseID: ", CourseID);
          response.id = CourseID;
        }

        // Webserver response
        reply
            .code(response.statusCode)
            .header("Content-Type", "application/json; charset=utf-8")
            .send(response);
    });
});

// POST route to add an instructor
fastify.post("/instructors/", (request, reply) => {
    const { InstructorID: InstructorID, 
            InstructorLastName: InstructorLastName, 
            InstructorGender: InstructorGender, 
            InstructorDepartment: InstructorDepartment} = request.body;
    if(DO_DEBUG) console.log("Route /instructors POST", InstructorID, InstructorLastName);

    // Define initial query (embedded query), and data object
    let sql = "INSERT INTO instructors (InstructorID, InstructorLastName, InstructorGender, InstructorDepartment ) VALUES (?, ?, ?, ?)";
    let data = [InstructorID, InstructorLastName, InstructorGender, InstructorDepartment];
    if (ObjectQueriesToggle) {
      sql = "INSERT INTO instructors SET ?";
      data = { InstructorID, InstructorLastName, InstructorGender,InstructorDepartment };
    }
  
    // Setup default response object
    const response = {
      error: "",
      statusCode: 201,
      id: "",
    };
  

    // Execute query and respond
    connection.query(sql, data, (errQuery) => {
        if (errQuery) {
          if (DO_STATUS) console.log(errQuery);
          response.error = errQuery;
          response.statusCode = 400;
        } else {
          if (DO_STATUS) console.log("Insert InstructorID: ", InstructorID);
          response.id = InstructorID;
        }

        // Webserver response
        reply
            .code(response.statusCode)
            .header("Content-Type", "application/json; charset=utf-8")
            .send(response);
    });
});


// DELETE a course
fastify.delete("/courses/:CourseID?", (request, reply) => {
    const { CourseID = "" } = request.params;
    if(DO_DEBUG) console.log("Route /courses DELETE", CourseID);

    let sql = "DELETE FROM courses WHERE CourseID = ?";
    let data = [CourseID];
    // initiate default response object
    const response = {
        error: "",
        statusCode: 201,
        id: ""
    };

    if (CourseID.length > 0) {
        // Delete one row
        connection.query(sql, data, (errQuery, result) => {
            if (errQuery) {
                if(DO_STATUS) console.log(errQuery);
                response.error = errQuery;
                response.statusCode = 400;
            } else {
                const { affectedRows = 0 } = result;
                if (affectedRows>0) {
                    if(DO_STATUS) console.log("DELETE CourseID: ", CourseID);
                    response.id = CourseID;
                } else {
                    if(DO_STATUS) console.log("Unknown CourseID: ", CourseID);
                    response.statusCode = 404;
                    response.error = "No courses in the database that match this ID";
                    response.id = CourseID;
                }
            }
            if (DO_DEBUG) console.log(result);
            
            // Server Response
            reply
                .code(response.statusCode)
                .header("Content-Type", "application/json; charset=utf-8")
                .send(response);
        });
    }
    else {
        // In case of deletion of all rows
        response.statusCode = 405;
        response.error = "Request to delete all rows not allowed"
    }
});

// DELETE an instructor
fastify.delete("/instructors/:InstructorID?", (request, reply) => {
    const { InstructorID = "" } = request.params;
    if(DO_DEBUG) console.log("Route /instructors DELETE", InstructorID);

    let sql = "DELETE FROM instructors WHERE InstructorID = ?";
    let data = [InstructorID];
    // initiate default response object
    const response = {
        error: "",
        statusCode: 201,
        id: ""
    };

    if (InstructorID.length > 0) {
        // Delete one row
        connection.query(sql, data, (errQuery, result) => {
            if (errQuery) {
                if(DO_STATUS) console.log(errQuery);
                response.error = errQuery;
                response.statusCode = 400;
            } else {
                const { affectedRows = 0 } = result;
                if (affectedRows>0) {
                    if(DO_STATUS) console.log("DELETE InstructorID: ", InstructorID);
                    response.id = InstructorID;
                } else {
                    if(DO_STATUS) console.log("Unknown InstructorID: ", InstructorID);
                    response.statusCode = 404;
                    response.error = "No instructors in the database match this ID";
                    response.id = InstructorID;
                }
            }
            if (DO_DEBUG) console.log(result);
            
            // Server Response
            reply
                .code(response.statusCode)
                .header("Content-Type", "application/json; charset=utf-8")
                .send(response);
        });
    }
    else {
        // In case of deletion of all rows
        response.statusCode = 405;
        response.error = "Request to delete all rows not allowed"
    }
});


// PUT verb route to update instructor items
fastify.put("/instructors/:InstructorID?", (request, reply) => {
    const { InstructorID = "" } = request.params;
    const { InstructorLastName: InstructorLastName, InstructorGender: InstructorGender, InstructorDepartment: InstructorDepartment } = request.body;
    if (DO_DEBUG) console.log("Route /instructors PUT", InstructorID, InstructorLastName, InstructorGender)

    // initiate SQL embedded query and data object
    let sql = "UPDATE instructors SET ";
    let setSQL = "";
    let data = [];

    if (!ObjectQueriesToggle) {
        if (InstructorLastName) {
            if(setSQL.length > 0) {
                setSQL += ", ";
            }
            setSQL = "InstructorLastName = ?";
            data.push(InstructorLastName);

        }
        if (InstructorGender) {
            if (setSQL.length > 0) {
                setSQL += ", ";
            }
            setSQL += "InstructorGender = ?";
            data.push(InstructorGender);
        }
        if (InstructorDepartment) {
            if (setSQL.length > 0) {
                setSQL += ", ";
            }
            setSQL += "InstructorDepartment = ?";
            data.push(InstructorDepartment);
        }
        if (setSQL.length > 0 && InstructorID.length > 0) {
            setSQL += " WHERE InstructorID = ?";
            data.push(InstructorID);
        }
    }

    // Initiate default response object
    const response = {
        error: "",
        statusCode: 201,
        id: ""
    };

    // Query and response
    if(InstructorID.length>0) {
        if(setSQL.length === 0 || data.length === 0) {
            response.statusCode = 400;
            response.error = "No data applied for an update";      
        } else {
        // Update single item
            sql += setSQL;
            connection.query(sql, data, (errQuery, result) => {
                if(errQuery) {
                    if(DO_STATUS) console.log(errQuery);
                    response.error = errQuery;
                    response.statusCode = 400;
                    reply
                        .code(response.statusCode)
                        .header("Content-Type", "application/json; charset=utf-8")
                        .send(response);  
                } else {
                    const { affectedRows = 0 } = result;
                    if (affectedRows > 0) {
                        if(DO_STATUS) console.log("Update ID: ", InstructorID);
                        response.id = InstructorID;
                    } else {
                        if (DO_STATUS) console.log("Unknown ID: ", InstructorID);
                        response.statusCode = 404;
                        response.error = "No instructors in the database match this ID";
                        response.id = InstructorID;
                    }
                }
                
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


// Unmatched route handler
function unmatchedRouteHandler(reply) {
    // Setup default response object
    const response = {
      error: "Unsupported request",
      statusCode: 404,
    };

    // reply to the server using the response object
    reply
      .code(response.statusCode)
      .header("Content-Type", "application/json; charset=utf-8")
      .send(response);
};

//Unmatched verbs
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


// Create a database Connection using a variable 'connection'
console.log("Creating connection...\n");
let connection = mysql.createConnection({
    host: "localhost",
    port: "3306",
    user: "root",
    password: "cit381",
    database: "cit381-assign08-schema"
});

// Connect to mySQL database -- 'cit381-assign08-schema'
connection.connect(function(err) {
    //log that a connection that has started
    console.log("Connecting to database... \n");

    if(err) {
        // Log errors if any
        console.log(err);
        console.log("Exiting application...\n");
    } else {
        // If no errors, log that a connection has been made
        console.log("Connected to database...\n");

        // Connect to server
        const host = "localhost";
        const port = 8080;

        // listen for a new connection
        fastify.listen({ host, port }, (err, address) => {
          if (err) {
            console.log(err);
            process.exit(1);
          }
          console.log(`Server listening on ${address}`);
        });
    }
});