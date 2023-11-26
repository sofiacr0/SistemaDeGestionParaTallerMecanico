function abrirModalAñadirVehiculo(){
    document.getElementById("modalAñadirVehiculo").style.display = "block";
}

function cerrarModalAñadirVehiculo() {
    document.getElementById("modalAñadirVehiculo").style.display = "none";
  }

  $(document).ready(function () {
    $("#añadirVehiculo").submit(function (event) {
      event.preventDefault();
      var formData = $(this).serialize();
      $.ajax({
        type: "POST",
        url: "/vehiculos",
        data: formData,
        dataType: "json",
        success: function (response) {
          alert(response.message);
          cerrarModalAñadirVehiculo();
          location.reload();
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    });
  });

function abrirModalActualizarVehiculo(){
  document.getElementById("modalActualizarVehiculo").style.display = "block";
}

function cerrarModalActualizarVehiculo() {
  document.getElementById("modalActualizarVehiculo").style.display = "none";
}

$(document).ready(function () {
  $("#actualizarVehiculo").submit(function (event) {
    event.preventDefault();
    var formData = $(this).serialize();
    $.ajax({
      type: "PUT",
      url: "/vehiculos",
      data: formData,
      dataType: "json",
      success: function (response) {
        alert(response.message);
        cerrarModalActualizarVehiculo();
        location.reload();
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});

function abrirModalEliminarVehiculo(){
  document.getElementById("modalEliminarVehiculo").style.display = "block";
}

function cerrarModalEliminarVehiculo() {
  document.getElementById("modalEliminarVehiculo").style.display = "none";
}

$(document).ready(function () {
  $("#eliminarVehiculo").submit(function (event) {
    event.preventDefault();
    var formData = $(this).serialize();
    $.ajax({
      type: "DELETE",
      url: "/vehiculos",
      data: formData,
      dataType: "json",
      success: function (response) {
        alert(response.message);
        cerrarModalEliminarVehiculo();
        location.reload();
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});