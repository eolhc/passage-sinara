$(document).ready(function() {

  $(".slide").not($("#slide0")).css("display","none")

  function slideShow() {
      var displayToggled = false;
      var current1 = $('.slide:visible');
      var nextSlide = current1.next('.slide');
      var hideoptions = {
          "direction": "left",
          "mode": "hide"
      };
      var showoptions = {
          "direction": "right",
          "mode": "show"
      };

      if (current1.is(':last-child')) {
          current1.effect("slide", hideoptions, 1000);
          $("#slide0").effect("slide", showoptions, 1000);
      }
      else {
          current1.effect("slide", hideoptions, 1000);
          nextSlide.effect("slide", showoptions, 1000);
      }
  };
  setInterval(slideShow, 3000);

})
