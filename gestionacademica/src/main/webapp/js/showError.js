function showError(errorMessage) {
    Swal.fire({
        icon: 'error',
        title: 'ERROR:',
        iconColor: '#DC3545',
        confirmButtonColor: '#DC3545',
        confirmButtonText: "Regresar",
        text: errorMessage,
        footer: '<a href="">Volver a ingresar los datos</a>'
    });
}


function errorCredentials(errorMessage) {
    Swal.fire({
        icon: 'error',
        title: 'ERROR:',
        iconColor: '#DC3545',
        confirmButtonColor: '#DC3545',
        confirmButtonText: "Volver a ingresar los datos",
        text: errorMessage,
    });
}

