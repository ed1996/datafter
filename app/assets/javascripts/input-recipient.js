const validate = (email) => {
  const expression = /(?!.*\.{2})^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;

  return expression.test(String(email).toLowerCase())
};
let recipients = [];

function removeRecipient (e) {
  e = this.value ? this : e;
  let findIndex = recipients.findIndex(r => r === this.value);
  if (findIndex !== -1) {
    recipients.splice(findIndex, 1);
  }
  e.remove();
}

function confirmDelete () {
  let e = confirm("Voulez-vous vraiment supprimer ce destinataire ?");
  if (e === true)
    return e;
}

function deleteRecipient (e, url) {
  if (url) {
    if ( confirm( "Voulez-vous vraiment supprimer ce destinataire ?" ) ) {
      $.ajax({
        url: url,
        type: "delete",
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        success: function() {
          removeRecipient(e);
          toastr.info('Le destinataire a bien été supprimé');
        }
      });
    }
  } else {
    removeRecipient(e);
  }
}

function addRecipient() {
  let recipient = document.getElementById("input-recipient").value;
  let errors = [];

  if (!recipient.length) {
    errors.push('Aucune adresse email n\'est saisi');
  }

  if (!validate(recipient)) {
    errors.push('Cette adresse email n\'est pas valide');
  }

  if (!!recipients.find(r => r === recipient)) {
    errors.push('Vous avez déjà ajouter ce destinataire');
  }

  if (errors.length <= 0) {
    let btn = document.createElement("button");
    btn.setAttribute('type','button');
    btn.addEventListener("click", deleteRecipient, false);
    btn.setAttribute('value',recipient);
    btn.setAttribute('class','btn btn-xs2 btn-meta btn-icon btn-icon-right delete-recipient');
    let icon = document.createElement("span");
    icon.setAttribute('class', 'icon fa-trash');
    btn.appendChild(icon);
    let contentBtn = document.createTextNode(recipient);
    btn.appendChild(contentBtn);
    let input = document.createElement("input");
    input.setAttribute('type', 'hidden');
    input.setAttribute('name', `recipients[${recipient}]`);
    input.setAttribute('value', recipient);
    btn.appendChild(input);
    recipients.push(recipient);
    document.getElementById("list-recipient").appendChild(btn);
  }
  else {
    toastr.warning(errors.join(', '));
  }
}