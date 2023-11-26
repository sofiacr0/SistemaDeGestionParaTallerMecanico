// AÑADIR CLIENTE
function abrirModalAñadirCliente() {
    document.getElementById("modalAñadirCliente").style.display = "block";
  }
  
  function cerrarModalAñadirCliente() {
    document.getElementById("modalAñadirCliente").style.display = "none";
  }
  
  $(document).ready(function () {
    $("#añadirCliente").submit(function (event) {
      event.preventDefault();
      var formData = $(this).serialize();
      $.ajax({
        type: "POST",
        url: "/clientes",
        data: formData,
        dataType: "json",
        success: function (response) {
          alert(response.message);
          cerrarModalAñadirCliente();
          location.reload();
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    });
  });
  
  // ACTUALIZAR CLIENTE
  function abrirModalActualizarCliente() {
    document.getElementById("modalActualizarCliente").style.display = "block";
  }
  
  function cerrarModalActualizarCliente() {
    document.getElementById("modalActualizarCliente").style.display = "none";
  }
  
  $(document).ready(function () {
    $("#actualizarCiente").submit(function (event) {
      event.preventDefault();
      var formData = $(this).serialize();
      $.ajax({
        type: "PUT",
        url: "/clientes",
        data: formData,
        dataType: "json",
        success: function (response) {
          alert(response.message);
          cerrarModalActualizarCliente();
          location.reload();
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    });
  });
  
  // ELIMINAR CLIENTE
  function abrirModalEliminarCliente() {
    document.getElementById("modalEliminarCliente").style.display = "block";
  }
  
  function cerrarModalEliminarCliente() {
    document.getElementById("modalEliminarCliente").style.display = "none";
  }
  
  $(document).ready(function () {
    $("#eliminarCliente").submit(function (event) {
      event.preventDefault();
      var formData = $(this).serialize();
      $.ajax({
        type: "DELETE",
        url: "/clientes",
        data: formData,
        dataType: "json",
        success: function (response) {
          alert(response.message);
          cerrarModalEliminarCliente    ();
          location.reload();
        },
        error: function (error) {
          console.error("Error:", error);
        },
      });
    });
  });
  