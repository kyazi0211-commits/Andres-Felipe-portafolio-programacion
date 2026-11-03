<?php

include("conexion.php");

$remitente=$_POST["remitente"];
$destinatario=$_POST["destinatario"];
$telefonoRemitente=$_POST["telefonoRemitente"];
$telefonoDestinatario=$_POST["telefonoDestinatario"];
$ciudadOrigen=$_POST["ciudadOrigen"];
$ciudadDestino=$_POST["ciudadDestino"];
$direccion=$_POST["direccion"];
$tipoPaquete=$_POST["tipoPaquete"];
$peso=$_POST["peso"];
$descripcion=$_POST["descripcion"];
$fecha=$_POST["fecha"];

$sql="INSERT INTO envios(remitente,destinatario,telefonoRemitente,telefonoDestinatario,ciudadOrigen,ciudadDestino,direccion,tipoPaquete,peso,descripcion,fecha)

VALUES('$remitente','$destinatario','$telefonoRemitente','$telefonoDestinatario','$ciudadOrigen','$ciudadDestino','$direccion','$tipoPaquete','$peso','$descripcion','$fecha')";

if($conexion->query($sql)){

echo "<h2>Registro guardado correctamente</h2>";

echo "<a href='index.html'>Volver</a>";

}else{

echo "Error";

}

?>