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

function abrirModalActualizarArticulo(){

}

function abrirModalEliminarArticulo(){
    
}