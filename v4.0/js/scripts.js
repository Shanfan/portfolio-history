$(document).ready(function(){     
    //Set .item block size, so that masonry can function properly later
    $('.item').each( function() {
      $(this).imagesLoaded( function(){
            var $h = $(this).find('img').height();
            var $w = $(this).find('img').width();
           $(this).find('.thumb').css('height', $h).find('.thumbOverlay').css('height', $h); //adding the slash pattern to the img thumbnail
           
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
           $(this).find('.thumbOverlay').animate({'opacity': 0}, 'fast');
        },
        function(){
            $(this).find('.thumbOverlay').animate({'opacity': 1}, 'slow');
        }
    );
    
        //slideshow for the thumnail

     $('.slideThumb').each(function(){
        var speed = Math.random()*750 + 750;
        $(this).cycle({
         fx: 'fade',
         speed: speed,
         timeout: 500
        });
     });
     
     //markup identifiers
    $('#wrapper .item').each(function(){
      
    /* $1.(){ RETRIEVE THE <H1> CONTENT AND OUTPUT AS '.ITEM' ID and its href } */
      var id = $(this).find('h1').text();
      id = id.toLowerCase().replace(/( |: )/gi, '_');
      $(this).parent('a').attr({
        'id': id,
        'href': 'entries/'+id +'.html'  
      });
    
    /* $2.(){ RETRIEVE THE <tag> CONTENT AND OUTPUT AS '.tag' color class, and its parent's class } */
      $(this).find('span.tag').each( function(){
          var category = $(this).text();
          
          $(this).parents('.item').addClass(category);
          category += '_color';
          $(this).addClass(category);
        });

    });
      
    //Out put the tags to the side column $('#tagCloud')   
     tagMapping("#wrapper .item span.tag");
     
    //Set up mansory
     $('#wrapper').imagesLoaded( function(){
       $(this).masonry({
             itemSelector: '.item:not(.invis)',
             isAnimated: !Modernizr.csstransitions
       });
     });
          
    //set up filtering class
    $('span.nav_link').click(function(){
      var category = $(this).text();
      $('.nav_link.'+category + '_color').removeClass('nav_link').addClass('nav_link_clicked');
      $('.nav_link_clicked').not('.'+category+'_color').addClass('nav_link').removeClass('nav_link_clicked');
      $('.content').html('');
      
      if (category == 'total'){
        $('.item').removeClass('invis').fadeIn(700);
        
      }else{
        
        $('.item').not('.' + category).not('.invis').toggleClass('invis').fadeOut(700);
        $('.' + category + '.invis').toggleClass('invis').fadeIn(700);
      
      }
    
      $('#wrapper').masonry();
      return false;
    });
});    

     

/********** The joke ***********/
//(function(){
//  var $drag = $('.drag');
//  var $wrapper_w = $('#wrapper').width(),
//      $side_w = $('#sideColumn').width(),
//      $canvas_w = $(window).width() - 320;
//  var isClicked = false;
//  var create_canvas = '<script src="js/libs/processing-1.3.6.min.js"></script>';
//      
//  create_canvas +='<canvas id="site_info"></canvas>';
//  create_canvas += '<script src="js/site_info.js"></script>'
//
//  $drag.click(function(){
//    if (!isClicked) {
//      $('#sideColumn').animate({'width': $canvas_w}, 500);
//      $('#wrapper').animate({'margin-left': $canvas_w, 'width':252}, 500);
//      $('#wrapper').masonry({
//             itemSelector: '.item',
//             isAnimated: !Modernizr.csstransitions
//       });
//      
//      isClicked = true;
//      
//      $(this).removeClass("notClicked").addClass("clicked");
//      $(this).html("I told ya. Now click me.");
//      
//      $(this).hover(
//        function(){
//          $(this).html("Go ahead. Click.");
//        },
//        function(){
//          $(this).html("I told ya. Now click me.");
//      });
//      
//      $('#create_canvas').addClass('sideCol').append(create_canvas);
//      
//    } else {
//      window.location.reload();
//    }
//  });
//  
//  $('.notClicked').hover(
//    function(){
//      $(this).html("Think twice.");
//    },
//    function(){
//      $(this).html("Do not click me.");
//  }); 
//})();
//  


/******** head and foot ********/
(function(){
  
  $('#foot #showCredit').click(function(){
      $('#foot .hide').show('fast');
  });
  
  $('#foot #hideCredit').click(function(){
      $('#foot .hide').hide('fast');
  });
  
  $('#head').hover(
      function() {
        $(this).find('img').attr('src','http://www.shanfanhuang.com/img/shanfan_huang_logo_hover.png'); //CHANGE THIS TO ABSOLUTE PATH WHEN DEPLOY TO THE SERVER
      },
      function() {
        $(this).find('img').attr('src','http://www.shanfanhuang.com/img/shanfan_huang_logo.png');
      });
})();

  
  
 /***** Set up the tag array with unique names *****/
function tagMapping (selector){
  
    var total_item = $('#wrapper .item').length;
    $('#tagCloud .total.count').text(total_item);
  
  
  
    var tag_array = $(selector).get(); //Create a native array of <span>
    var tag_names = [], //with duplicated names
        tags = [], //sorted and without duplicated names
        tag_counts = [];
    
    for (x in tag_array) { //change jq native array to an array of strings
      tag_names.push($(tag_array[x]).html());
    }

    // remove the duplicated tag names
    tag_names.sort();
    tags =[tag_names[0]];
    for (i=0; i<tag_names.length-1; i++){
      if (tag_names[i] != tag_names[i+1]){
        tags.push(tag_names[i+1]);
      }
    }

    // Count the tags
    for (x in tags){
      var txt = "#wrapper span." + tags[x] + '_color';
      tag_counts.push($(txt).length);
    }
    // Out put the tags and counts to the side column
    
    for (x in tags){
      var tag_color = tags[x] + '_color';
      var tag_size = tags[x] + '_size';
      var newSpan;

    
      if(x==0){
        var be_string;
        if (tag_counts[x] > 1){ be_string = " were "; } else { be_string = " was "};
        
        newSpan = '<span class="count ' + tag_color + '">'
                      + tag_counts[x] + '</span>' + be_string
                      + 'filed under <span class="nav_link ' + tag_color +' ' + tag_size +'">' + tags[x] +'</span>, ';
        
        $('#tagCloud p').append(newSpan);
        
      }else if( x == tags.length - 1){
        newSpan = 'and <span class="count ' + tag_color + '">'
                      + tag_counts[x] + '</span> under <span class="nav_link ' +tag_color +' ' + tag_size +'">' + tags[x] +'</span>.';
        $('#tagCloud p').append(newSpan);
      }else{
        newSpan = '<span class="count ' + tag_color + '">'
                      + tag_counts[x] + '</span> under <span class="nav_link ' + tag_color +' ' + tag_size +'">' + tags[x] +'</span>, ';
        $('#tagCloud p').append(newSpan);
      }
    }
    
    //Set the font size for the tag cloud
    var count_min = Math.min.apply(Math, tag_counts) , count_max = Math.max.apply(Math, tag_counts); //found the min and max count
    var size_min = 0.9, size_max = 1.5;
    for (x in tag_counts){    
      var tag_size = size_max * (tag_counts[x] - count_min)/(count_max - count_min);
      var selector = '.'+tags[x]+'_size';
      
      if (tag_size < size_min){
        $(selector).css({'font-size':(size_min + 'em')});
      }else{
        $(selector).css({'font-size':(tag_size + 'em')});
      }
    }
      
 }







