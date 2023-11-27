// JavaScript para manejar la apertura y cierre del sidebar
const sidebar = document.querySelector('.sidebar');

// Por defecto, cierra el sidebar
sidebar.classList.add('closed');

function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    sidebar.classList.toggle('closed');
  }
  