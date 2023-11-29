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

function abrirModalAñadirArticulo(){
    document.getElementById("modalAñadirArticulo").style.display = "block";
    $.datetimepicker.setLocale('es');
  $(".datetimepicker").datetimepicker({
    format: "Y-m-d H:i",  // Formato de fecha y hora
    step: 15,             // Incremento de minutos
  });
}

function cerrarModalAñadirArticulo() {
    document.getElementById("modalAñadirArticulo").style.display = "none";
  }

  $(document).ready(function () {
    $("#añadirArticulo").submit(function (event) {
      event.preventDefault();
      var formData = $(this).serialize();
      $.ajax({
        type: "POST",
        url: "/inventario",
        data: formData,
        dataType: "json",
        success: function (response) {
          alert(response.message);
          cerrarModalAñadirArticulo();
          location.reload();
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    });
  });

function abrirModalActualizarArticulo(){
  document.getElementById("modalActualizarArticulo").style.display = "block";
  $.datetimepicker.setLocale('es');
$(".datetimepicker").datetimepicker({
  format: "Y-m-d H:i",  // Formato de fecha y hora
  step: 15,             // Incremento de minutos
});
}

function cerrarModalActualizarArticulo() {
  document.getElementById("modalActualizarArticulo").style.display = "none";
}

$(document).ready(function () {
  $("#actualizarArticulo").submit(function (event) {
    event.preventDefault();
    var formData = $(this).serialize();
    $.ajax({
      type: "PUT",
      url: "/inventario",
      data: formData,
      dataType: "json",
      success: function (response) {
        alert(response.message);
        cerrarModalActualizarArticulo();
        location.reload();
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});

function abrirModalEliminarArticulo(){
  document.getElementById("modalEliminarArticulo").style.display = "block";
}

function cerrarModalEliminarArticulo() {
  document.getElementById("modalEliminarArticulo").style.display = "none";
}

$(document).ready(function () {
  $("#eliminarArticulo").submit(function (event) {
    event.preventDefault();
    var formData = $(this).serialize();
    $.ajax({
      type: "DELETE",
      url: "/inventario",
      data: formData,
      dataType: "json",
      success: function (response) {
        alert(response.message);
        cerrarModalEliminarArticulo();
        location.reload();
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});