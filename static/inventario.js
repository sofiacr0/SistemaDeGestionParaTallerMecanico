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
  

function abrirModalActualizarArticulo(){

}

function abrirModalEliminarArticulo(){
    
}