# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
`
$(function(){
    $("#g_name").on('click', function(event){
      clickedLable = $(event.target);
      clickedLable.css('background-color',"#ccc")
      G_id = parseInt(clickedLable.attr('val'));
      $("#group_id").val(G_id);

    $.ajax({
                 url: "groups/members", // Route to the Script Controller method
                type: "POST",
            dataType: "json",
                data: { group_ID: G_id }, // This goes to Controller in params hash,
            complete: function() {},
             success: function(data, textStatus, xhr) {
                        console.log(data);
                      $("#tst").text("");
                      data.forEach(function(entry) {
                      console.log(entry.name);
                    // $("#tst").text(entry.name);
                      var txt2 = $("<li></li>").text(entry.name);
                      $("#tst").append(txt2);

                  });
                      },
               error: function() {
                        alert("Ajax error!")
                      }
    });
    });
});


`
