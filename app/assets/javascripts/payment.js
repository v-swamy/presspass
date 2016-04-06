jQuery(function($) {
  $('#payment-form').submit(function(event) {
    var $form = $(this);

    // Disable the submit button to prevent repeated clicks
    $form.find('button').prop('disabled', true);

    Stripe.card.createToken($form, stripeResponseHandler);

    // Prevent the form from submitting with the default action
    return false;
  });
});

function stripeResponseHandler(status, response) {
  var $form = $('#payment-form');

  if (response.error) {
    // Show the errors on the form
    $form.find('.payment-errors').text(response.error.message);
    $form.find('button').prop('disabled', false);
  } else {
    // response contains id and card, which contains additional card details
    var token = response.id;
    // Insert the token into the form so it gets submitted to the server
    $form.append($('<input type="hidden" name="stripeToken" />').val(token));
    // and submit
    $form.get(0).submit();
  }
};

$(function() {
  $('#presspass-purchase').submit(function(event) {
      var $form = $(this);

      var button = $form.find('.btn').last();
      button.prop('disabled', true);

      var url = window.location.hostname;
      $form.append($('<input type="hidden" name="url" />').val(url));

      $.post("/presspass/purchase", $form.serialize());

      $('#PresspassValidate').modal('show');

      return false;

  });
});

$(function() {
  $('#presspass-validate-purchase').submit(function(event) {
    var $form = $(this);
    var button = $form.find('.btn').last();
    button.prop('disabled', true);
    var email = $('#presspass-purchase').find('#email').val()
    var token;
    $.get("/presspass/get_token", { email: email }, function(response) {
      token = response.token;
      $form.append($('<input type="hidden" name="presspassToken" />').val(token));
      $form.get(0).submit();
    }); 
    return false;
  });
});