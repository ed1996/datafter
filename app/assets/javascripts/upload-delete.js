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
    if ( confirm( "Voulez-vous vraiment supprimer cette image ?" ) ) {
      removePicture(e);
      toastr.info('La photo a bien été supprimé');
    }
  }
}
let pictures = [];

function readURL (picture,uniq) {
  let reader = new FileReader();

  let nbImg = pictures.length || 0;
  reader.onload = function (e) {
    let colMd = document.createElement("div");
    let preview = document.createElement("div");
    let img = document.createElement("img");
    let t = document.createTextNode("Suppresion");

    colMd.setAttribute('class','col-md-4 photo-not-send');
    colMd.setAttribute('id',uniq ? 'photo' : 'photo-' + 'notApi' + nbImg);
    preview.setAttribute('class','panel-heading preview');
    img.setAttribute('src',e.target.result);

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

    document.getElementById("photos").appendChild(colMd);
  };
  reader.readAsDataURL(picture);
  pictures.push(picture);
}

function removeElementsByClass(className){
  let elements = document.getElementsByClassName(className);
  while(elements.length > 0){
    elements[0].parentNode.removeChild(elements[0]);
  }
}

function addPicture(input, uniq) {
  if (uniq && document.getElementById('photo')) {
    document.getElementById('photo').remove();
  }

  if (input.files && input.files.length) {
    if (input.multiple) {
      removeElementsByClass('photo-not-send');
      for (let i = 0; i < input.files.length; i++) {
        readURL(input.files[i], uniq);
      }
    }
    else {
      readURL(input.files[0], uniq);
    }
  }
}