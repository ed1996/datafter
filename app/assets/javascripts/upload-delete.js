function removePicture (e) {
  let findIndex = recipients.findIndex(r => r === this.value);
  if (findIndex !== -1) {
    recipients.splice(findIndex, 1);
  }
  document.getElementById('photo-' + e.dataset.hommagePicture).remove();
  e.remove();
}

function deletePicture (e, url) {
  console.log(e)
  e = this.value ? this : e;
  if (url) {
    if ( confirm( "Voulez-vous vraiment supprimer cette image ?" ) ) {
      $.ajax({
        url: url,
        type: "delete",
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        success: function(response) {
          console.log(response);
          removePicture(e);
          toastr.info('La photo a bien été supprimé');
        }
      });
    }
  } else {
    removePicture(e);
  }
}
let pictures = [];

function readURL(input) {
  if (input.files && input.files[0]) {
    input.files.forEach((picture) => {
      let reader = new FileReader();

      let nbImg = pictures.length || 0;
      reader.onload = function (e) {
        let colMd = document.createElement("div");
        let preview = document.createElement("div");
        let img = document.createElement("img");
        let button = document.createElement("button");
        var inputImg = document.createElement("input");
        var t = document.createTextNode("Suppresion");

        colMd.setAttribute('class','col-md-4');
        colMd.setAttribute('id','photo-' + 'notApi' + nbImg);
        preview.setAttribute('class','panel-heading preview');
        img.setAttribute('src',e.target.result);
        button.setAttribute('class','btn-width-full btn btn-transparent-2 btn-xxs');
        button.setAttribute('type','button');
        button.setAttribute('data-hommage-picture', 'notApi' + nbImg);
        button.setAttribute('value',e.target.result);
        inputImg.setAttribute('type','file');
        inputImg.setAttribute('style','display: none;');
        console.log(picture)
        inputImg.setAttribute('name',`images[${picture}]`);

        button.addEventListener("click", deletePicture, false);

        preview.appendChild(img);
        button.appendChild(t);
        colMd.appendChild(preview);
        colMd.appendChild(button);
        colMd.appendChild(inputImg);
        document.getElementById("photos").appendChild(colMd);
      };

      reader.readAsDataURL(picture);
      pictures.push(picture);
    });
  }
}