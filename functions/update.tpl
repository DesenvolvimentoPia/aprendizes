<?php

if(!empty($_POST['hiddenUpdate'])) {

	if(!empty($_POST['hiddenAprendiz'])) {

		$cortar = explode("/", $_POST['inputNascimento']);
		$nascimento = $cortar[2]."-".$cortar[1]."-".$cortar[0];

		$expediente = substr($_POST['inputExpediente'], 1);

		$sql = "UPDATE relatorios_aprendizes SET nome = '".$_POST['inputNome']."', turno = '".$_POST['inputTurno']."', expediente = '".$expediente."', telefone = '".$_POST['inputTelefone']."', email = '".$_POST['inputEmail']."', matricula = '".$_POST['inputMatricula']."', logradouro = '".$_POST['inputEndereco']."', numero = '".$_POST['inputNumero']."', bairro = '".$_POST['inputBairro']."', cidade = '".$_POST['inputCidade']."', nascimento = '".$nascimento."', instituicao = '".$_POST['inputInstituicao']."', serie = '".$_POST['inputSerie']."', setor = '".$_POST['inputSetor']."', unidade = '".$_POST['inputUnidade']."' WHERE id =".$_POST['hiddenAprendiz'];
		$res= sqlsrv_query($con, $sql);
			
		$resultado = "Aprendiz Alterado com Sucesso!";



		$sql1 = "INSERT INTO relatorios_historico VALUES ('', 'Aprendiz Alterado', '".date("Y-m-d H:i:s")."', 'O Aprendiz ".$_POST['hiddenAprendiz']." foi Alterado com Sucesso!', '".$_SESSION['userId']."', '3')";
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