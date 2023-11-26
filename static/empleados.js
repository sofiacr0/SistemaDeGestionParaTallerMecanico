function abrirModalAñadirEmpleado(){
    document.getElementById("modalAñadirEmpleado").style.display = "block";
}

function cerrarModalAñadirEmpleado() {
    document.getElementById("modalAñadirEmpleado").style.display = "none";
  }

  $(document).ready(function () {
    $("#añadirEmpleado").submit(function (event) {
      event.preventDefault();
      var formData = $(this).serialize();
      $.ajax({
        type: "POST",
        url: "/empleados",
        data: formData,
        dataType: "json",
        success: function (response) {
          alert(response.message);
          cerrarModalAñadirEmpleado();
          location.reload();
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    });
  });

function abrirModalActualizarEmpleado(){
  document.getElementById("modalActualizarEmpleado").style.display = "block";
}

function cerrarModalActualizarEmpleado() {
  document.getElementById("modalActualizarEmpleado").style.display = "none";
}

$(document).ready(function () {
  $("#actualizarEmpleado").submit(function (event) {
    event.preventDefault();
    var formData = $(this).serialize();
    $.ajax({
      type: "PUT",
      url: "/empleados",
      data: formData,
      dataType: "json",
      success: function (response) {
        alert(response.message);
        cerrarModalActualizarEmpleado();
        location.reload();
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});

function abrirModalEliminarEmpleado(){
  document.getElementById("modalEliminarEmpleado").style.display = "block";
}

function cerrarModalEliminarEmpleado() {
  document.getElementById("modalEliminarEmpleado").style.display = "none";
}

$(document).ready(function () {
  $("#eliminarEmpleado").submit(function (event) {
    event.preventDefault();
    var formData = $(this).serialize();
    $.ajax({
      type: "DELETE",
      url: "/empleados",
      data: formData,
      dataType: "json",
      success: function (response) {
        alert(response.message);
        cerrarModalEliminarEmpleado();
        location.reload();
      },
      error: function (error) {
        console.error("Error:", error);
      },
    });
  });
});