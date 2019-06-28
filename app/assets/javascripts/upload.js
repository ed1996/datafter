function removePicture (e) {
  e = this.value ? this : e;
  let findIndex = recipients.findIndex(r => r === this.value);
  if (findIndex !== -1) {
    recipients.splice(findIndex, 1);
  }
  e.remove();
}

function deletePicture (e, url) {
  if (url) {
    if ( confirm( "Voulez-vous vraiment supprimer cette image ?" ) ) {
      if (confirmDelete) {
        $.ajax({
          url: url,
          type: "delete",
          beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
          success: function(response) {
            console.log(response);
            //update the DOM
          }
        });
        removeRecipient(e);
      }
    }
  } else {
    removeRecipient(e);
  }
}