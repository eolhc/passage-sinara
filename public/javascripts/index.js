$(document).ready(function() {

  $(".slide").not($("#slide0")).css("display","none")

  function slideShow() {
      var displayToggled = false;
      var currentSlide = $('.slide:visible');
      var nextSlide = currentSlide.next('.slide');
      var hideoptions = {
          "direction": "left",
          "mode": "hide"
      };
      var showoptions = {
          "direction": "left",
          "mode": "show"
      };

      if (currentSlide.is(':last-child')) {
          currentSlide.effect("slide", hideoptions, 200);
          $("#slide0").effect("slide", showoptions, 200);
      }
      else {
          currentSlide.effect("slide", hideoptions, 200);
          nextSlide.effect("slide", showoptions, 200);
      }
  };
  setInterval(slideShow, 100);

})
