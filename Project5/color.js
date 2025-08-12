const baseURL = "http://127.0.0.1:8080";

let data = [];

function displayColors(info) {
  // Save the current data into global object for later edit/update
  data = JSON.parse(JSON.stringify(info.rows));

  // Clear existing rows
  document
  .querySelectorAll("#outputDiv > div:not(:first-child)")
  .forEach((item) => item.remove());

  // Add rows using returned data
  info.rows.forEach((row) => {
    const { COLOR_ID, COLOR_NAME, COLOR_HEX } = row;
    let div = document.createElement('div')
    div.className = "row";
    let tbl = `<div class='col1'>${COLOR_ID}</div>\n`;
    tbl += `<div class='col2'>${COLOR_NAME}</div>\n`;
    tbl += `<div class='col3'>${COLOR_HEX}</div>\n`;
    tbl += "<div class='col4'>";
    tbl += `<button id='${COLOR_ID}' onclick='showEditForm(this)'>Edit</button>&nbsp;`;
    tbl += `<button id='${COLOR_ID}' onclick='deleteColor(this)'>Delete</button>`;
    tbl += "</div>\n";
    div.innerHTML = tbl;
    document.querySelector('#outputDiv').appendChild(div);
  });
}

function getColors() {
  console.log("Requesting colors...");
  fetch(`${baseURL}/colors/`, {
    method: "GET",
    headers: new Headers({ "Content-Type": "application/json" }),
  })
    .then((response) => response.json())
    .then((info) => {
      console.log("Colors retrieved");
      displayColors(info);
    })
    .catch((error) => {
      console.log("Error:", error);
    });
}

function deleteColor(me) {
  console.log("Deleting color...");
  let id = me.id;
  if (confirm(`Delete ${id}?`)) {
    fetch(`${baseURL}/colors/${id}`, {
      method: "DELETE",
      headers: new Headers({ "Content-Type": "application/json" }),
    })
      .then((response) => response.json())
      .then(() => {
        console.log(`Color ${id} deleted`);
        getColors();
      })
      .catch((error) => {
        console.log("Error:", error);
      });
  } else {
    console.log("Delete cancelled");
  }
}

function addColor() {
  console.log("Adding color...");

  // Get add panel input box data
  const color = document.querySelector("#colorAdd").value;
  const hex = document.querySelector("#hexAdd").value;

  // Process POST
  fetch(`${baseURL}/colors/`, {
    method: "POST",
    headers: new Headers({
      Accept: "application/json",
      "Content-Type": "application/json",
    }),
    body: JSON.stringify({ color, hex }),
  })
    .then((response) => response.json())
    .then((info) => {
      console.log(`Color ${color}, ${hex} added`);
      // Clear input boxes, and hide panel
      document.querySelector("#colorAdd").value = "";
      document.querySelector("#hexAdd").value = "";
      document.querySelector("#addPanel").style.display = "none";
      getColors();
    })
    .catch((error) => {
      console.log("Error:", error);
    });
}

function showEditForm(me) {
  document.querySelector("#editPanel").style.display = "block";
  document.querySelector("#idEdit").textContent = me.id;
  const filtered = data.filter( row => row.COLOR_ID === parseInt(me.id, 10));
  if (filtered.length > 0) {
    console.log(filtered[0].COLOR_NAME)
    document.querySelector("#colorEdit").value = filtered[0].COLOR_NAME;
    document.querySelector("#hexEdit").value = filtered[0].COLOR_HEX;
  }
}

function showAddForm(me) {
  document.querySelector("#addPanel").style.display = "block";
  document.querySelector("#idAdd").value = me.id;
}

function editColor() {
  console.log("Updating color...");
  // Get edit panel input box data
  let id = document.querySelector("#idEdit").textContent;
  console.log("ID:", id)
  let color = document.querySelector("#colorEdit").value;
  let hex = document.querySelector("#hexEdit").value;

  // Process PUT
  fetch(`${baseURL}/colors/${id}`, {
    method: "PUT",
    headers: new Headers({
      Accept: "application/json",
      "Content-Type": "application/json",
    }),
    body: JSON.stringify({ color, hex }),
  })
    .then((response) => response.json())
    .then((info) => {
      console.log(`Color ${color}, ${hex} added`);
      // Clear input boxes, and hide panel
      document.querySelector("#colorEdit").value = "";
      document.querySelector("#hexEdit").value = "";
      document.querySelector("#editPanel").style.display = "none";
      getColors();
    })
    .catch((error) => {
      console.log("Error:", error);
    });
}

function startup() {
  window.addEventListener("load", () => {
    document
      .querySelector("#showAddColorPanelButton")
      .addEventListener("click", showAddForm);
    document
      .querySelector("#addColorButton")
      .addEventListener("click", addColor);
    document
      .querySelector("#editColorButton")
      .addEventListener("click", editColor);
    document
      .querySelector("#addColorCancelButton")
      .addEventListener("click", () => {
        document.querySelector("#addPanel").style.display = "none";
      });
    document
      .querySelector("#editColorCancelButton")
      .addEventListener("click", () => {
        document.querySelector("#editPanel").style.display = "none";
      });
    getColors();
  });
}

startup();