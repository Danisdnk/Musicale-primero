//Jquery
$('[data-toggle=offcanvas]').click(function () {
    $('.row-offcanvas').toggleClass('active');
    $('.collapse').toggleClass('in').toggleClass('hidden-xs').toggleClass('visible-xs');
});


$(document).ready(function () {

    $('btn-block').click(function () {
        let url = $('#myModal').data('url');
        $.get(url, function (data) {
            $('#myModal').html(data);
            $('#myModal').modal('show');
        });

    });

});
//


//validacion tipo img
function fileValidation() {

    let fileInput = document.getElementById('ImgPortada');

    let peso = fileInput.files[0];

    let filePath = fileInput.value;
    let allowedExtensions = /(\.jpg|\.jpeg|\.png|\.gif)$/i;
    if (!allowedExtensions.exec(filePath) || (peso.size > 20097152)) {
        $('#myModal').modal('show');
        alert('Please upload file having extensions .jpeg/.jpg/.png/.gif only.');
        fileInput.value = '';
        return false;
    } else {

   // if (oFile.size > 20480) // {alert("File size must under 2mb!"); return; }
        
        //Image preview
        if (fileInput.files && fileInput.files[0]) {
            let reader = new FileReader();
            reader.onload = function (e) {
            document.getElementById('imagePreview').innerHTML = '<img  src="' + e.target.result + '"/>';

            };
            reader.readAsDataURL(fileInput.files[0]);
        }
    }
}


//validacion audio
function fileValidationMP3() {
    let fileInput = document.getElementById('AudioF');
     let peso = fileInput.files[0];
    let filePath = fileInput.value;
    let allowedExtensions = /(\.mp3|\.mpeg|\.ogg|\.wav)$/i;
    if (!allowedExtensions.exec(filePath) || (peso.size > 20097152)) {
        $('#myModal').modal('show');
    
        fileInput.value = '';
        return false;
    } else {


        //Image preview
        if (fileInput.files && fileInput.files[0]) {
            let reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('AudioPreview').innerHTML = '<source src="' + e.target.result + '"/>';
            };
            reader.readAsDataURL(fileInput.files[0]);
        }
    }
}









