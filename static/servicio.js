/*
Materia: Ingeniería de Software I 
Maestro: González Zamora Pedro 

Integrantes del equipo: 
- Cárdenas Rosas Sofía 
- Figueroa Hernández Sofia Belem 
- López Cerecer Angélica Guadalupe 
- Matus Valencia Elda Berenice 
- Vega Gutiérrez Marian Eugenia
*/

function abrirModalAñadirServicio(){
    document.getElementById("modalAñadirServicio").style.display = "block";
}

function cerrarModalAñadirServicio() {
    document.getElementById("modalAñadirServicio").style.display = "none";
  }

  $(document).ready(function () {
    $("#añadirServicio").submit(function (event) {
      event.preventDefault();
      var formData = $(this).serialize();
      $.ajax({
        type: "POST",
        url: "/servicios",
        data: formData,
        dataType: "json",
        success: function (response) {
          alert(response.message);
          cerrarModalAñadirServicio();
          location.reload();
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    });
  });

function abrirModalActualizarServicio(){
  document.getElementById("modalActualizarServicio").style.display = "block";
}

function cerrarModalActualizarServicio() {
  document.getElementById("modalActualizarServicio").style.display = "none";
}

$(document).ready(function () {
  $("#actualizarServicio").submit(function (event) {
    event.preventDefault();
    var formData = $(this).serialize();
    $.ajax({
      type: "PUT",
      url: "/servicios",
      data: formData,
      dataType: "json",
      success: function (response) {
        alert(response.message);
        cerrarModalActualizarServicio();
        location.reload();
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});

function abrirModalEliminarServicio(){
  document.getElementById("modalEliminarServicio").style.display = "block";
}

function cerrarModalEliminarServicio() {
  document.getElementById("modalEliminarServicio").style.display = "none";
}

$(document).ready(function () {
  $("#eliminarServicio").submit(function (event) {
    event.preventDefault();
    var formData = $(this).serialize();
    $.ajax({
      type: "DELETE",
      url: "/servicios",
      data: formData,
      dataType: "json",
      success: function (response) {
        alert(response.message);
        cerrarModalEliminarServicio();
        location.reload();
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});