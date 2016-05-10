var jqXML = $.get('entries.xml', createEntry).complete(function(){     
    
    //slideshow for the thumnail
     $('.slideThumb').cycle({
         fx: 'fade',
         speed: 1000,
         timeout: 500
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
      
     tagMapping("#wrapper .item span");
     
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
    
        //define item clicking AKA site navigation
    $('#0').click(function(){
        //var category = $(this).children('p').html();
        //$('#wrapper .item').addClass('invis').fadeOut(350);
        //$('.content').load("entries/content.html #the-mixed-feeling-of-ecstasy-and-agony", function(){
        //  $(this).append('<p>' + category + '</p>');
        //});
        //console.log(category);
        
    });
     
});
  
/********** The joke ***********/
(function(){
  var $drag = $('.drag');
  var $wrapper_w = $('#wrapper').width();
  var $side_w = $('#sideColumn').width();
  var $canvas_w = $(window).width() - 320;
  var isClicked = false;
 
  $drag.click(function(){
    if (!isClicked) {
      $('#sideColumn').animate({'width': $canvas_w}, 500);
      $('#wrapper').animate({'margin-left': $canvas_w, 'width':252}, 500);
      $('#wrapper').masonry({
             itemSelector: '.item',
             isAnimated: !Modernizr.csstransitions
       });
      
      isClicked = true;
      
      $(this).removeClass("notClicked").addClass("clicked");
      $(this).html("I told ya. Now click me.");
      
      $(this).hover(
        function(){
          $(this).html("Go ahead. Click.");
        },
        function(){
          $(this).html("I told ya. Now click me.");
      });
    } else {
      window.location.reload();
    }
  });
  
  $('.notClicked').hover(
    function(){
      $(this).html("Hey you. Don't.");
    },
    function(){
      $(this).html("Do not click me.");
  }); 
})();

  
/******** Show/Hide plugin credit list at the foot ********/
(function(){
  var $foot = $('#foot');
  
  $('#foot #showCredit').click(function(){
      $('#foot .hide').show('fast');
  });
  
  $('#foot #hideCredit').click(function(){
      $('#foot .hide').hide('fast');
  });
})();


/*************Global function ****************/
/*********************************************/

/****** Retrieve tag data from marked up HTML ********/
function createEntry(xml){
  var $items = $(xml).find('item'); //store the items in an array
  
  var itemCounter = 0; //the unique id set for $('.item').
  
  $items.each(function(){ //adding item div into #wrapper, running loop
    var uid = itemCounter.toString();
    var id = "#" + uid;
    var newItem_string = "<div class='item' id='"
                          + uid
                          + "'><div class='label'></div><div class='thumb'><div class='thumbOverlay'></div></div><h1></h1><p></p></div>";
    var imgs = $(this).find('thumb');
    
    $(newItem_string).appendTo('#wrapper');
    $( id + ' .label').addClass($(this).find('label').text());
    
    if(imgs.attr('isSlide') == "true"){
      $(id + ' .thumb').append('<div class="slideThumb">'+imgs.text()+'</div>');
    }else{
      $(id + ' .thumb').append(imgs.text());
    }
    
    $(id + " h1").html($(this).find('title').text());

    //retrieve tag information
    var tag_set = $(this).find('tag'),
        tags = [];
    
    for (i=0; i<tag_set.length; i++){
      
      var tag_txt = $(tag_set[i]).text();
      $(id).addClass(tag_txt);
      
      if(i==tag_set.length-1){
        tags += ("<span class='nav_link "+ tag_txt + "_color'>" + tag_txt + "</span>");
      }else{
        tags += ("<span class='nav_link "+ tag_txt + "_color'>" + tag_txt + "</span>, ");
      }
      
    }
    
    $(id + " p").html("Filed under: " + tags);

    //Set .item block size, so that masonry can function properly later
    $(id).imagesLoaded( function(){

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
    
    itemCounter ++;
  }); //end of each()
  $('#tagCloud p .count').html(itemCounter + 1);
}
  
  
  
 /***** Set up the tag array with unique names *****/
function tagMapping (selector){
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







