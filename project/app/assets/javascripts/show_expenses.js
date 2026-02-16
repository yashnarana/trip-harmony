// toggle_display.js
document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('show-trip-details').addEventListener('click', function() {
      document.getElementById('trip-details').style.display = 'grid';
      document.getElementById('expenses').style.display = 'none';
    });
  
    document.getElementById('show-expenses').addEventListener('click', function() {
      document.getElementById('trip-details').style.display = 'none';
      document.getElementById('expenses').style.display = 'grid';
    });
  });