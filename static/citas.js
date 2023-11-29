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

// AÑADIR
function abrirModalAñadir() {
    document.getElementById("modalAñadir").style.display = "block";
    $.datetimepicker.setLocale('es');
    $(".datetimepicker").datetimepicker({
        format: "Y-m-d H:i",  // Formato de fecha y hora
        step: 15,             // Incremento de minutos
    });
}

function cerrarModalAñadir() {
    document.getElementById("modalAñadir").style.display = "none";
}

$(document).ready(function () {
    $("#añadir").submit(function (event) {
        event.preventDefault();
        var formData = $(this).serialize();
        $.ajax({
            type: "POST",
            url: "/citas",
            data: formData,
            dataType: "json",
            success: function (response) {
                alert(response.message);
                cerrarModalAñadir();
                location.reload();
            },
            error: function (error) {
                console.error("Error:", error);
            },
        });
    });
});

// ACTUALIZAR
function abrirModalActualizar() {
    document.getElementById("modalActualizar").style.display = "block";
    $.datetimepicker.setLocale('es');
    $(".datetimepicker").datetimepicker({
        format: "Y-m-d H:i",  // Formato de fecha y hora
        step: 15,             // Incremento de minutos
    });
}

function cerrarModalActualizar() {
    document.getElementById("modalActualizar").style.display = "none";
}

$(document).ready(function () {
    $("#actualizar").submit(function (event) {
        event.preventDefault();
        var formData = $(this).serialize();
        $.ajax({
            type: "PUT",
            url: "/citas",
            data: formData,
            dataType: "json",
            success: function (response) {
                alert(response.message);
                cerrarModalActualizar();
                location.reload();
            },
            error: function (error) {
                console.error("Error:", error);
            },
        });
    });
});

// CERRAR
function abrirModalEliminar() {
    document.getElementById("modalEliminar").style.display = "block";
}

function cerrarModalEliminar() {
    document.getElementById("modalEliminar").style.display = "none";
}

$(document).ready(function () {
    $("#eliminar").submit(function (event) {
        event.preventDefault();
        var formData = $(this).serialize();
        $.ajax({
            type: "DELETE",
            url: "/citas",
            data: formData,
            dataType: "json",
            success: function (response) {
                alert(response.message);
                cerrarModalEliminar();
                location.reload();
            },
            error: function (error) {
                console.error("Error:", error);
            },
        });
    });
});