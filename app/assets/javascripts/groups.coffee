# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
`
$(function(){
    $("a[data-remote='true']").on('click', function(event){
      clickedLink = $(event.target);
      hrefArray = clickedLink.attr('href').split('/');
      G_id = parseInt(hrefArray[hrefArray.length -1]);
      $("#group_id").val(G_id);
    })
});
`
