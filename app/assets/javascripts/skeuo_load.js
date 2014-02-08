loadSkeo = function(){
    if((typeof window.card === 'undefined' ) && ( typeof Skeuocard != 'undefined')) {
      window.card = new Skeuocard($("#skeuocard"));
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
