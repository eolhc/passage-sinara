$(document).ready(function() {

  $('.right').fadeIn(3000);

  $('.close').on("click",function() {
    $('#get-started').fadeOut(1000);
  })

  if ($('.logout').css("display") == "block") {
    $('#get-started').fadeIn(1000);
    setTimeout(function() {
      $('#greeting').children().each(function(index) { $(this).delay(100 * index).effect("bounce",{times:1},"slow")})
    },2000);
  }


  $('#login-btn').on("click",function(){
    setTimeout(function() {
      $('#greeting').children().each(function(index) { $(this).delay(100 * index).effect("bounce",{times:1},"slow")})
    },2000);
    $('#get-started').fadeIn(1000);
    $('.start').hide();
    $('.register').hide();
    $('.login').show();
  })

  $('#register-btn').on("click",function(){
    setTimeout(function() {
      $('#greeting').children().each(function(index) { $(this).delay(100 * index).effect("bounce",{times:1},"slow")})
    },2000);
    $('#get-started').fadeIn(1000);
    $('.login').hide();
    $('.start').hide();
    $('.register').show();
  })

  $("#register").on("click",function(){
    $('.login').hide();
    $('.start').hide();
    $('.register').show();
  });

  $("#login").on("click",function(){
    $('.register').hide();
    $('.start').hide();
    $('.login').show();
  });

  $(".overlay-back").on("click",function(){
    if ($('.register').is(":visible")) {
      $('.login').hide();
      $('.register').hide();
      $('.start').show();
    } else if ($('.login').is(":visible")) {
      $('.register').hide();
      $('.login').hide();
      $('.start').show();
    } else if ($('#get-started').is(":visible")) {
      $('#get-started').fadeOut(1000);
    }
  });

  $('#get-started:not(.start)').on("click",function() {
    $('#get-started').fadeOut(1000);
  })

  $('.start').on("click",function(event){
    event.stopPropagation();
  })

  $('.register').on("click",function(event){
    event.stopPropagation();
  })

  $('.login').on("click",function(event){
    event.stopPropagation();
  })





});
