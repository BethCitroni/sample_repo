$(document).ready(function(){

  $('button').on('click', function(e){
    e.preventDefault();
    $(this).text('clicked!');
  });
});
