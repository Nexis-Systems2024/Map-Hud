window.addEventListener('message', function(event) {
  var item = event.data;

  if (item.data == "updateHA") {
    var health = $("#healBar");
    var armor = $("#armorBar");

    if (item.heal > 20) {
      $("#healBar").css("background", "linear-gradient(90deg, rgba(30,133,63,1) 0%, rgba(51,218,87,1) 100%)");
    } else {
      $("#healBar").css("background", "rgb(218, 51, 51)");
    }

    if (item.armor > 20) {
      $("#armorBar").css("background", "linear-gradient(90deg, rgba(30,79,133,1) 0%, rgba(10,153,240,1) 100%)");
    } else {
      $("#armorBar").css("background", "rgb(51, 90, 218)");
    }

    health.css("width", (item.heal - 100) + "%");
    armor.css("width", (item.armor) + "%");
  }

  // Update Color
  if (item.data == "updateColor") {
    $("#armor").css("border-color", item.color);
    $("#heal").css("border-color", item.color);
    $(".mapborder").css("border-color", item.color);
  }
});
