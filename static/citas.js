// AÑADIR CITA
function abrirModalAñadirCita() {
  document.getElementById("modalAñadirCita").style.display = "block";
}

function cerrarModalAñadirCita() {
  document.getElementById("modalAñadirCita").style.display = "none";
}

window.onclick = function (event) {
  if (event.target == document.getElementById("modalAñadirCita")) {
    cerrarModalAñadirCita();
  }
};

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

// ELIMINAR CITA
