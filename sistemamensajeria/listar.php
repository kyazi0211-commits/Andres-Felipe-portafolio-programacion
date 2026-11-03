<?php

include("conexion.php");

$resultado=$conexion->query("SELECT * FROM envios");

echo "<h2>Lista de Envíos</h2>";

echo "<table border='1' cellpadding='10'>";

echo "<tr>

<th>ID</th>

<th>Remitente</th>

<th>Destinatario</th>

<th>Origen</th>

<th>Destino</th>

<th>Peso</th>

<th>Fecha</th>

</tr>";

while($fila=$resultado->fetch_assoc()){

echo "<tr>";

echo "<td>".$fila["id"]."</td>";

echo "<td>".$fila["remitente"]."</td>";

echo "<td>".$fila["destinatario"]."</td>";

echo "<td>".$fila["ciudadOrigen"]."</td>";

echo "<td>".$fila["ciudadDestino"]."</td>";

echo "<td>".$fila["peso"]." Kg</td>";

echo "<td>".$fila["fecha"]."</td>";

echo "</tr>";

}

echo "</table>";

?>