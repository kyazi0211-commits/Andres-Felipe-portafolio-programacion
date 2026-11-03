document.getElementById("formulario").addEventListener("submit",function(e){

let peso=document.getElementsByName("peso")[0].value;

if(peso<=0){

alert("Ingrese un peso válido.");

e.preventDefault();

}

});