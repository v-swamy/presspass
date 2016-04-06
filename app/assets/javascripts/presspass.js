$(function() {
  $('#presspass-form').submit(function(event) {
      var $form = $(this);

      var button = $form.find('.btn').last();
      button.prop('disabled', true);

      var url = window.location.hostname;
      $form.append($('<input type="hidden" name="url" />').val(url));

      $.post("/presspass/sign_in", $form.serialize());

      $('#PresspassModal').modal('hide');
      $('#PresspassValidate').modal('show');

      return false;

  });
});

$(function() {
  $('#presspass-validate').submit(function(event) {
    var $form = $(this);
    var button = $form.find('.btn').last();
    button.prop('disabled', true);
    var email = $('#presspass-form').find('#email').val()
    var token;
    $.get("/presspass/get_token", { email: email }, function(response) {
      token = response.token;
      $form.append($('<input type="hidden" name="email" />').val(email));
      $form.append($('<input type="hidden" name="presspassToken" />').val(token));
      $form.get(0).submit();
    }); 
    // {
    //   token = response.token;
    //   $form.append($('<input type="hidden" name="email" />').val(email));
    //   $form.append($('<input type="hidden" name="presspassToken" />').val(token));
    // });
    return false;
  });
});
