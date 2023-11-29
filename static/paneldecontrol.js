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

// JavaScript para manejar la apertura y cierre del sidebar
const sidebar = document.querySelector('.sidebar');

// Por defecto, cierra el sidebar
sidebar.classList.add('closed');

function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    sidebar.classList.toggle('closed');
  }
  