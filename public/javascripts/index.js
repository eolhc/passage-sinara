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
          "direction": "right",
          "mode": "show"
      };

      if (currentSlide.is(':last-child')) {
          currentSlide.effect("slide", hideoptions, 1000);
          $("#slide0").effect("slide", showoptions, 1000);
      }
      else {
          currentSlide.effect("slide", hideoptions, 1000);
          nextSlide.effect("slide", showoptions, 1000);
      }
  };
  setInterval(slideShow, 3000);

})
