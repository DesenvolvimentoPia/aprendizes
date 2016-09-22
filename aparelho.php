<?php

session_start();

// Exibir Erros Oriundos do PHP
ini_set('display_errors',1);
ini_set('display_startup_erros',1);
error_reporting(E_ALL);

if(empty($_SESSION['usuario'])) header("location: ../login.php");

else {

	//echo "AQUI: ".$_GET['id'];

// Incluindo Cabeçalho Padrão
if($_GET['id'] == 'novo') include "includes/novo.html";
else include "includes/aparelho.html";

}

