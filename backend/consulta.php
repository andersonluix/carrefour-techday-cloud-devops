<?php
$servername = "mysql-read";
$username = "root";
$password = "Senha123";
$dbname = "meubanco";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT id, nome, email, comentario FROM mensagens";
$result = $conn->query($sql);

$sql2 = "SELECT @@server_id,NOW()";
$result2 = $conn->query($sql2);

echo "Id servidor que respondeu a requisição de consulta: <br>";
if ($result2->num_rows > 0) {
  // output data of each row
  while($row2 = $result2->fetch_assoc()) {
    echo "ServerId: " . $row2["@@server_id"]. " - Date: " . $row2["NOW()"]. "<br>";
  }
} else {
  echo "0 results";
}


if ($result->num_rows > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
    echo "Id: " . $row["id"]. " - Nome: " . $row["nome"]. " - Email: " . $row["email"]. " - Comentario: " . $row["comentario"]. "<br>";
  }
} else {
  echo "0 results";
}
$conn->close();
?>
