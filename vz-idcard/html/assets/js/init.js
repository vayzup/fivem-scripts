$(document).ready(function () {
  // LUA listener
  window.addEventListener('message', function (event) {
    if (event.data.action == 'open') {
      var type = event.data.type;
      var userData = event.data.array;
      var licenseData = null 
// ID CARD 
if(type == 'idcard'){
  $('#id-card').show();
  $('#id-card #firstname').text(userData.firstname);
  $('#id-card #lastname').text(userData.lastname)
  $('#dob').text(userData.birthdate);
  $('#height').text(userData.height);
  $('#sex').text(userData.gender);
  if(userData.gender == 0){
    $('#sex').text("Mann");
  }else{
    $('#sex').text("Kvinne");
  }
  $('#signature').text(userData.firstname + ' ' + userData.lastname);
  $('#id-card').css('background', 'url(assets/images/idbg.png)');
}

if (type == 'driver' || type == null) {
        $('#driverlicense').show();
        $('#driverlicense #lastname').text(userData.lastname);
        $('#driverlicense #firstname').text(userData.firstname);
        $('#driverlicense #dob').text(userData.birthdate);
        $('#driverlicense #signature').text(userData.firstname + ' ' + userData.lastname);
        $("#driverlicense #licenses").text(userData.type);
}

    }else if (event.data.action == 'close') {
      $('#driverlicense').hide();
      $('#id-card').hide();
      $('#name').text('');
      $('#dob').text('');
      $('#height').text('');
      $('#signature').text('');
      $('#sex').text('');
      $('#id-card').hide();
      $('#licenses').html('');
    }


  });



});