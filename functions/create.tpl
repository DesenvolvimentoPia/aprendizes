<?php

if(!empty($_POST['hiddenCreate'])) {


	if(!empty($_POST['dataAlterarAgenda'])) {
		$dataBruta = $_POST['dataAlterarAgenda'];
		$explodir = explode("-", $dataBruta);
		$dataFinal = $explodir[2]."-".$explodir[1]."-".$explodir[0];
		$idUser = $_POST['usuarioAlterarAgenda'];
		if(!empty($_POST['presencaAlterarAgenda']) && $_POST['presencaAlterarAgenda'] == "presente") $presenca = 1;
		else $presenca = 0;

		$sql = "SELECT * FROM relatorios_agendas WHERE data = '".$dataFinal."' AND id_aprendiz = '".$idUser."'";
		$res = mysql_query($sql, $con);
		$num = mysql_num_rows($res);

		if($num > 0) {
			$row = mysql_fetch_array($res);
			$sql = "UPDATE relatorios_agendas SET presenca = '".$presenca."', descricao = '".$_POST['atividadesAlterarAgenda']."' WHERE id = '".$row['id']."'";
			$res = mysql_query($sql, $con);	
			$resultado = "Agenda Editada com Sucesso!";	

			$sql1 = "INSERT INTO relatorios_historico VALUES ('', 'Agenda Alterada', '".date("Y-m-d H:i:s")."', 'A Agenda do dia ".$dataFinal." do Usuário Código ".$idUser." foi Alterada com Sucesso!', '".$_SESSION['userId']."', '3')";
			$res1= mysql_query($sql1, $con);
		}

		else {
			$sql = "INSERT INTO relatorios_agendas (id_aprendiz, turno, data, presenca, descricao) VALUES ('".$idUser."', '1', '".$dataFinal."', '".$presenca."', '".$_POST['atividadesAlterarAgenda']."')";
			$res = mysql_query($sql, $con);		
			$resultado = "Agenda Inserida com Sucesso!";		

			$sql1 = "INSERT INTO relatorios_historico VALUES ('', 'Agenda Inserida', '".date("Y-m-d H:i:s")."', 'A Agenda do dia ".$dataFinal." do Usuário Código ".$idUser." foi Inserida com Sucesso!', '".$_SESSION['userId']."', '3')";
			$res1= mysql_query($sql1, $con);
		}


?>

<style>

#home {
	display: none;
}

#agendas {
	display: block;
}


</style>

<?php


	}
}