loadSkeo = function(){
    if(typeof Skeuocard != 'undefined') {
      new Skeuocard($("#skeuocard"));
    }
};
validateform = function(){
  var resp = card.isValid();
  if(resp) {
    $('#credit_card_form').submit();
    return true;
  }
  alert("Kindly correct all credit card details");
  return false;
};

$(document).on('ready', loadSkeo);
$(document).on('page:load', loadSkeo);
