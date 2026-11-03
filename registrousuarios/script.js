const formulario = document.getElementById("formulario");
const mensaje = document.getElementById("mensaje");

formulario.addEventListener("submit", function(e){

    e.preventDefault();

    let nombre = document.getElementById("nombre");
    let correo = document.getElementById("correo");
    let usuario = document.getElementById("usuario");
    let password = document.getElementById("password");
    let confirmar = document.getElementById("confirmar");

    let valido = true;

    mensaje.innerHTML = "";
    mensaje.style.color = "red";

    const campos = [nombre, correo, usuario, password, confirmar];

    campos.forEach(campo=>{
        campo.classList.remove("error");
        campo.classList.remove("correcto");
    });

    campos.forEach(campo=>{
        if(campo.value.trim()==""){
            campo.classList.add("error");
            valido=false;
        }else{
            campo.classList.add("correcto");
        }
    });

    let expresion=/^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if(!expresion.test(correo.value)){
        correo.classList.add("error");
        valido=false;
    }

    if(password.value.length<6){
        password.classList.add("error");
        mensaje.innerHTML="La contraseña debe tener mínimo 6 caracteres.";
        return;
    }

    if(password.value!=confirmar.value){
        confirmar.classList.add("error");
        mensaje.innerHTML="Las contraseñas no coinciden.";
        return;
    }

    if(valido){

        mensaje.style.color="green";
        mensaje.innerHTML="¡Usuario registrado correctamente!";

        formulario.reset();

        campos.forEach(campo=>{
            campo.classList.remove("correcto");
        });

    }else{

        mensaje.innerHTML="Complete correctamente todos los campos.";

    }

});