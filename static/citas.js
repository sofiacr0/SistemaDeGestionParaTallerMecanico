// AÑADIR CITA
function abrirModalAñadirCita() {
  document.getElementById("modalAñadirCita").style.display = "block";
  $.datetimepicker.setLocale("es");
  $(".datetimepicker").datetimepicker({
    format: "Y-m-d H:i", // Formato de fecha y hora
    step: 15, // Incremento de minutos
  });
}

function cerrarModalAñadirCita() {
  document.getElementById("modalAñadirCita").style.display = "none";
}

$(document).ready(function () {
  $("#añadirCita").submit(function (event) {
    event.preventDefault();
    var formData = $(this).serialize();
    $.ajax({
      type: "POST",
      url: "/citas",
      data: formData,
      dataType: "json",
      success: function (response) {
        alert(response.message);
        cerrarModalAñadirCita();
        location.reload();
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});

// ACTUALIZAR CITA
function abrirModalActualizarCita() {
  document.getElementById("modalActualizarCita").style.display = "block";
  $.datetimepicker.setLocale("es");
  $(".datetimepicker").datetimepicker({
    format: "Y-m-d H:i", // Formato de fecha y hora
    step: 15, // Incremento de minutos
  });
}

function cerrarModalActualizarCita() {
  document.getElementById("modalActualizarCita").style.display = "none";
}

$(document).ready(function () {
  $("#actualizarCita").submit(function (event) {
    event.preventDefault();
    var formData = $(this).serialize();
    $.ajax({
      type: "PUT",
      url: "/citas",
      data: formData,
      dataType: "json",
      success: function (response) {
        alert(response.message);
        cerrarModalActualizarCita();
        location.reload();
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});

// ELIMINAR CITA
function abrirModalEliminarCita() {
  document.getElementById("modalEliminarCita").style.display = "block";
}

function cerrarModalEliminarCita() {
  document.getElementById("modalEliminarCita").style.display = "none";
}

$(document).ready(function () {
  $("#eliminarCita").submit(function (event) {
    event.preventDefault();
    var formData = $(this).serialize();
    $.ajax({
      type: "DELETE",
      url: "/citas",
      data: formData,
      dataType: "json",
      success: function (response) {
        alert(response.message);
        cerrarModalEliminarCita();
        location.reload();
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});
