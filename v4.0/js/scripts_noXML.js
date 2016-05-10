 /******* When document is loaded ********/
$(document).ready(function(){

     //Set up mansory
  var $wrapper = $('#wrapper');
  $wrapper.imagesLoaded( function(){
    $wrapper.masonry({
          itemSelector: '.item'
    });
  });
  
      //slideshow for the thumnail
     $('.slideThumb').cycle({
         fx: 'fade',
         speed: 1000,
         timeout: 2000
     });

});

/*************Global function ****************/
/*********************************************/
/******* Entry thumbnail mouseover interaction ********/
//adding the slash pattern to the img thumbnail
 //Thumbnail overlay
 
  $('#wrapper .item').imagesLoaded( function(){
        $(this).each( function() {
            var $h = $(this).find('img').height();
            var $w = $(this).find('img').width();
           $(this).find('.thumb').css('height', $h).find('.thumbOverlay').css('height', $h);
           
           $(this).find('.slideThumb').css({
                    'height': $h,
                    'width': $w,
                    'top':'-60px',
                    'position':'absolute'
                }).children().css({
                    'top':'0',
                    'position': 'absolute'
                });
       });
    });
  //hover interaction
  $('#wrapper .item').hover(
      function() {
         $(this).css('border', '1px solid #ddd');
         $(this).find('.thumbOverlay').animate({'opacity': 0}, 'fast');
      },
      function(){
          $(this).css('border', 'none');
          $(this).find('.thumbOverlay').animate({'opacity': 1}, 'slow');
      }
  ); 

 /********** The joke ***********/
  var dragTxt = $('.drag').html();
  $('.drag').hover(
    function(){
      $(this).html("Hey you. DO NOT.");
    },
    function(){
      $(this).html(dragTxt);
    }
  )
  
  
  /******** Show/Hide plugin credit list at the foot ********/
  var $foot = $('#foot');
  
  $('#foot #showCredit').click(function(){
      $('#foot .hide').show('fast');
  });
  
  $('#foot #hideCredit').click(function(){
      $('#foot .hide').hide('fast');
  });

