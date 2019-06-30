function removePicture (e, uniq) {
  if (uniq) {
    return document.getElementById('photo').remove();
  }
  let findIndex = pictures.findIndex(r => r === this.value);
  if (findIndex !== -1) {
    pictures.splice(findIndex, 1);
  }
  document.getElementById('photo-' + e.dataset.picture).remove();
  e.remove();
}

function deletePicture (e, url, method) {
  e = this.value ? this : e;
  if (url) {
    if ( confirm( "Voulez-vous vraiment supprimer cette image ?" ) ) {
      $.ajax({
        url: url,
        type: method || "delete",
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

function readURL(input, uniq) {
  if (uniq && document.getElementById('photo')) {
    document.getElementById('photo').remove();
  }
  if (input.files && input.files[0]) {
      let reader = new FileReader();

      let nbImg = pictures.length || 0;
      reader.onload = function (e) {
        let colMd = document.createElement("div");
        let preview = document.createElement("div");
        let img = document.createElement("img");
        var inputImg = document.createElement("input");
        var t = document.createTextNode("Suppresion");

        colMd.setAttribute('class','col-md-4');
        colMd.setAttribute('id',uniq ? 'photo' : 'photo-' + 'notApi' + nbImg);
        preview.setAttribute('class','panel-heading preview');
        img.setAttribute('src',e.target.result);
        inputImg.setAttribute('type','file');
        inputImg.setAttribute('style','display: none;');
        inputImg.setAttribute('name',`images[${input.files[0]}]`);

        preview.appendChild(img);
        colMd.appendChild(preview);
        if (!uniq) {
          let button = document.createElement("button");
          button.setAttribute('class','btn-width-full btn btn-transparent-2 btn-xxs');
          button.setAttribute('type','button');
          button.setAttribute('data-picture', 'notApi' + nbImg);
          button.setAttribute('value',e.target.result);

          button.addEventListener("click", uniq ? (function(){ removePicture(this, uniq); }) : deletePicture, false);
          button.appendChild(t);
          colMd.appendChild(button);
        }
        colMd.appendChild(inputImg);
        document.getElementById("photos").appendChild(colMd);
      };

      reader.readAsDataURL(input.files[0]);
      pictures.push(input.files[0]);
  }
}