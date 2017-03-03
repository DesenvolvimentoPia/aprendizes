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
		$res = sqlsrv_query($con, $sql);
		$num = sqlsrv_has_rows($res);

		if($num > 0) {
			$row = sqlsrv_fetch_array($res);
			$sql = "UPDATE relatorios_agendas SET presenca = '".$presenca."', descricao = '".$_POST['atividadesAlterarAgenda']."' WHERE id = '".$row['id']."'";
			$res = sqlsrv_query($con, $sql);	
			$resultado = "Agenda Editada com Sucesso!";	

			$sql1 = "INSERT INTO relatorios_historico VALUES ('', 'Agenda Alterada', '".date("Y-m-d H:i:s")."', 'A Agenda do dia ".$dataFinal." do Usuário Código ".$idUser." foi Alterada com Sucesso!', '".$_SESSION['userId']."', '3')";
			$res1= sqlsrv_query($con, $sql1);
		}

		else {
			$sql = "INSERT INTO relatorios_agendas (id_aprendiz, turno, data, presenca, descricao) VALUES ('".$idUser."', '1', '".$dataFinal."', '".$presenca."', '".$_POST['atividadesAlterarAgenda']."')";
			$res = sqlsrv_query($con, $sql);		
			$resultado = "Agenda Inserida com Sucesso!";		

			$sql1 = "INSERT INTO relatorios_historico VALUES ('', 'Agenda Inserida', '".date("Y-m-d H:i:s")."', 'A Agenda do dia ".$dataFinal." do Usuário Código ".$idUser." foi Inserida com Sucesso!', '".$_SESSION['userId']."', '3')";
			$res1= sqlsrv_query($con, $sql1);
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

	else if(!empty($_POST['hiddenNovoAprendiz'])) {

		$cortar = explode("/", $_POST['inputNascimento']);
		$nascimento = $cortar[2]."-".$cortar[1]."-".$cortar[0];

		$expediente = substr($_POST['inputExpediente'], 1);

		$sql = "INSERT INTO relatorios_aprendizes (nome, turno, expediente, telefone, email, matricula, logradouro, numero, bairro, cidade, nascimento, instituicao, serie, setor, unidade) VALUES ('".$_POST['inputNome']."', '".$_POST['inputTurno']."', '".$expediente."', '".$_POST['inputTelefone']."', '".$_POST['inputEmail']."', '".$_POST['inputMatricula']."', '".$_POST['inputEndereco']."', '".$_POST['inputNumero']."', '".$_POST['inputBairro']."', '".$_POST['inputCidade']."', '".$nascimento."', '".$_POST['inputInstituicao']."', '".$_POST['inputSerie']."', '".$_POST['inputSetor']."', '".$_POST['inputUnidade']."')";
		$res= sqlsrv_query($con, $sql);
			
		$resultado = "Aprendiz Inserido com Sucesso!";



		$sql1 = "INSERT INTO relatorios_historico VALUES ('', 'Novo Aprendiz Inserido', '".date("Y-m-d H:i:s")."', 'Um Novo Aprendiz foi Inserido com Sucesso!', '".$_SESSION['userId']."', '3')";
		$res1= sqlsrv_query($con, $sql1);

		?>

		<style>

#home {
	display: none;
}

#aprendizes {
	display: block;
}


</style>

		<?php
	} 
}