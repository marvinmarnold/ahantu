loadSkeo = function(){
    if(typeof window.card === 'undefined') {
      window.card = new Skeuocard($("#skeuocard"));
    }
  };
validateform = function(){
  var resp = card.isValid();
  if(resp) {
    $('#credit_card_form').submit();
    return true;
  }
  alert("Kindly Correct all Credit Card Details");
  return false;
};

$(document).on('ready', loadSkeo);
$(document).on('page:load', loadSkeo);
