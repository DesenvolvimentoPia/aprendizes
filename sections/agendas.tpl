<h2>Agenda Aprendizes</h2>

<?php

$hoje = date("d-m");

$diaSemana = date("N");
$diaNumerico = date("d");
$mesNumerico = date("m");
$anoNumerico = date("Y");

if(!empty($_GET['data'])) {
	$explodir = explode("/", $_GET['data']);
	$diaNumerico = $explodir[0];
	$mesNumerico = $explodir[1];
	$anoNumerico = $explodir[2];
	$diaSemana = date("N", mktime(0, 0, 0, $mesNumerico, $diaNumerico, $anoNumerico));
}

$y = 0;

for($x = $diaSemana; $x > 0; $x--) {
	$dia[$x] = $diaNumerico - $y;
	$y++;

	if($diaNumerico - $y == 0) {

		$mesNumerico--;
		
		if($mesNumerico == 0) {
			$anoNumerico--;
			$mesNumerico = 12;
		}

		$diaNumerico = 31;

		while(!checkdate($mesNumerico, $diaNumerico, $anoNumerico) && $diaNumerico > 0) {
			$diaNumerico--;
			echo "<p>".$diaNumerico."</p>";
		}
		
		$diaNumerico++;
	}

	$data[$x]['dia'] = str_pad($dia[$x], 2, "0", STR_PAD_LEFT);
	$data[$x]['mes'] = str_pad($mesNumerico, 2, "0", STR_PAD_LEFT);
	$data[$x]['ano'] = str_pad($anoNumerico, 2, "0", STR_PAD_LEFT);
}

$diaSemana = date("N");
$diaNumericoFuturo = date("d");

if(!empty($_GET['data'])) {
	$explodir = explode("/", $_GET['data']);
	$diaNumericoFuturo = $explodir[0];
	$mesNumericoFuturo = $explodir[1];
	$anoNumericoFuturo = $explodir[2];
	$diaSemana = date("N", mktime(0, 0, 0, $mesNumericoFuturo, $diaNumericoFuturo, $anoNumericoFuturo));
}

$y = 1;
for($x = $diaSemana +1; $x < 6; $x++) {
	$dia[$x] = $diaNumericoFuturo + $y;
	$y++;
	if(!checkdate($mesNumerico, $dia[$x], $anoNumerico)) {
		$lastDay = $dia[$x];
		$dia[$x] = "01";
		$diaNumericoFuturo = 0;
		$mesNumerico++;
		if($mesNumerico == 13) {
			$mesNumerico = "01";
			$anoNumerico++;
		}
	}

	$data[$x]['dia'] = str_pad($dia[$x], 2, "0", STR_PAD_LEFT);
	$data[$x]['mes'] = str_pad($mesNumerico, 2, "0", STR_PAD_LEFT);
	$data[$x]['ano'] = str_pad($anoNumerico, 2, "0", STR_PAD_LEFT);
}


if(empty($_GET['data'])) {
	$dataVoltar = date("d/m/Y", strtotime("-7 day"));
	$dataAvancar = date("d/m/Y", strtotime("+7 day"));
}

else {
	$explodir = explode("/", $_GET['data']);
	$dataVoltar = date("d/m/Y", strtotime("-7 day", mktime(0, 0, 0, $explodir[1], $explodir[0], $explodir[2])));
	$dataAvancar = date("d/m/Y", strtotime("+7 day", mktime(0, 0, 0, $explodir[1], $explodir[0], $explodir[2])));

?>

<style>

#home {
	display: none;
}

#agendas {
	display: block;
}

div.expediente:nth-child(10) {
    margin-left: 5%;
}

</style>

<?php

}

?>

<a href="./?data=<?=$dataVoltar?>" id="botaoVoltar1"><</a><div class="cabecalhoDia <?php if($data[1]['dia']."-".$data[1]['mes'] == $hoje) echo "hoje"; ?>">Segunda <?=$data[1]['dia']?>/<?=$data[1]['mes']?></div><div class="cabecalhoDia <?php if($data[2]['dia']."-".$data[2]['mes'] == $hoje) echo "hoje"; ?>">Terça <?=$data[2]['dia']?>/<?=$data[2]['mes']?></div><div class="cabecalhoDia <?php if($data[3]['dia']."-".$data[3]['mes'] == $hoje) echo "hoje"; ?>">Quarta <?=$data[3]['dia']?>/<?=$data[3]['mes']?></div><div class="cabecalhoDia <?php if($data[4]['dia']."-".$data[4]['mes'] == $hoje) echo "hoje"; ?>">Quinta <?=$data[4]['dia']?>/<?=$data[4]['mes']?></div><div class="cabecalhoDia <?php if($data[5]['dia']."-".$data[5]['mes'] == $hoje) echo "hoje"; ?>">Sexta <?=$data[5]['dia']?>/<?=$data[5]['mes']?></div><a id="botaoAvancar" href="./?data=<?=$dataAvancar?>">></a>

<?php 

$sql = "SELECT * FROM relatorios_aprendizes ORDER BY nome";
$res = mysql_query($sql, $con);
$num = mysql_num_rows($res);

for($i = 0; $i < $num; $i++) {
	$row = mysql_fetch_array($res);
	$aprendiz[$i]["id"] = $row['id'];
	$aprendiz[$i]["nome"] = $row['nome'];
	$aprendiz[$i]["email"] = $row['email'];
	$aprendiz[$i]["expediente"] = $row['expediente'];
}

?>

<div id="diaExpediente1" class="expediente">

<?php for($i = 0; $i < $num; $i++) { ?>

<h3><?=$aprendiz[$i]['nome']?></h3>
<?php 
if(strstr($aprendiz[$i]['expediente'], '1')) $expediente = "sim";
else $expediente = "nao";

$sqlAgenda = "SELECT * FROM relatorios_agendas WHERE data = '".$data[1]['ano'].'-'.$data[1]['mes'].'-'.$data[1]['dia']."' AND id_aprendiz = '".$aprendiz[$i]['id']."'";
$resAgenda = mysql_query($sqlAgenda, $con);
$numAgenda = mysql_num_rows($resAgenda);

if($numAgenda > 0) {
	$rowAgenda = mysql_fetch_array($resAgenda);
	$detalhes = $rowAgenda['descricao'];
	$presenca = $rowAgenda['presenca'];
}

else { 
	$detalhes = "";
	$presenca = "indeterminada";
}

?>
<input id="detalhes<?=$data[1]['ano'].$data[1]['mes'].$data[1]['dia'].$aprendiz[$i]['id'];?>" type="hidden" value="<?=$detalhes;?>">
<input id="presenca<?=$data[1]['ano'].$data[1]['mes'].$data[1]['dia'].$aprendiz[$i]['id'];?>" type="hidden" value="<?=$presenca;?>">
<div class='turno <?=$expediente?>'><span>M</span></div>
<div <?php if($expediente == "sim") { ?>onclick="alterarAgenda('<?=$data[1]['dia']."-".$mesNumerico."-".$anoNumerico."-".$aprendiz[$i]['nome']."-".$aprendiz[$i]['id']; ?>')"<?php } ?> class='turno <?=$expediente?> presenca<?=$presenca?>'><span>T</span></div>
<div class='turno <?=$expediente?>'><span>N</span></div>

<?php } ?>

</div><div id="diaExpediente2" class="expediente">

<?php for($i = 0; $i < $num; $i++) { ?>

<h3><?=$aprendiz[$i]['nome']?></h3>

<?php 
if(strstr($aprendiz[$i]['expediente'], '2')) $expediente = "sim";
else $expediente = "nao";

$sqlAgenda = "SELECT * FROM relatorios_agendas WHERE data = '".$data[2]['ano'].'-'.$data[2]['mes'].'-'.$data[2]['dia']."' AND id_aprendiz = '".$aprendiz[$i]['id']."'";
$resAgenda = mysql_query($sqlAgenda, $con);
$numAgenda = mysql_num_rows($resAgenda);

if($numAgenda > 0) {
	$rowAgenda = mysql_fetch_array($resAgenda);
	$detalhes = $rowAgenda['descricao'];
	$presenca = $rowAgenda['presenca'];
}

else { 
	$detalhes = "";
	$presenca = "indeterminada";
}

?>
<input id="detalhes<?=$data[2]['ano'].$data[2]['mes'].$data[2]['dia'].$aprendiz[$i]['id'];?>" type="hidden" value="<?=$detalhes;?>">
<input id="presenca<?=$data[2]['ano'].$data[2]['mes'].$data[2]['dia'].$aprendiz[$i]['id'];?>" type="hidden" value="<?=$presenca;?>">
<div class='turno <?=$expediente?>'><span>M</span></div>
<div <?php if($expediente == "sim") { ?>onclick="alterarAgenda('<?=$dia[2]."-".$mesNumerico."-".$anoNumerico."-".$aprendiz[$i]['nome']."-".$aprendiz[$i]['id']; ?>')"<?php } ?> class='turno <?=$expediente?> presenca<?=$presenca?>'><span>T</span></div>
<div class='turno <?=$expediente?>'><span>N</span></div>

<?php } ?>
	
</div><div id="diaExpediente3" class="expediente">

<?php for($i = 0; $i < $num; $i++) { ?>

<h3><?=$aprendiz[$i]['nome']?></h3>

<?php 
if(strstr($aprendiz[$i]['expediente'], '3')) $expediente = "sim";
else $expediente = "nao";

$sqlAgenda = "SELECT * FROM relatorios_agendas WHERE data = '".$data[3]['ano'].'-'.$data[3]['mes'].'-'.$data[3]['dia']."' AND id_aprendiz = '".$aprendiz[$i]['id']."'";
$resAgenda = mysql_query($sqlAgenda, $con);
$numAgenda = mysql_num_rows($resAgenda);

if($numAgenda > 0) {
	$rowAgenda = mysql_fetch_array($resAgenda);
	$detalhes = $rowAgenda['descricao'];
	$presenca = $rowAgenda['presenca'];
}

else { 
	$detalhes = "";
	$presenca = "indeterminada";
}

?>
<input id="detalhes<?=$data[3]['ano'].$data[3]['mes'].$data[3]['dia'].$aprendiz[$i]['id'];?>" type="hidden" value="<?=$detalhes;?>">
<input id="presenca<?=$data[3]['ano'].$data[3]['mes'].$data[3]['dia'].$aprendiz[$i]['id'];?>" type="hidden" value="<?=$presenca;?>">
<div class='turno <?=$expediente?>'><span>M</span></div>
<div <?php if($expediente == "sim") { ?>onclick="alterarAgenda('<?=$data[3]['dia']."-".$mesNumerico."-".$anoNumerico."-".$aprendiz[$i]['nome']."-".$aprendiz[$i]['id']; ?>')"<?php } ?> class='turno <?=$expediente?> presenca<?=$presenca?>'><span>T</span></div>
<div class='turno <?=$expediente?>'><span>N</span></div>

<?php } ?>
	
</div><div id="diaExpediente4" class="expediente">

<?php for($i = 0; $i < $num; $i++) { ?>

<h3><?=$aprendiz[$i]['nome']?></h3>

<?php 
if(strstr($aprendiz[$i]['expediente'], '4')) $expediente = "sim";
else $expediente = "nao";

$sqlAgenda = "SELECT * FROM relatorios_agendas WHERE data = '".$data[4]['ano'].'-'.$data[4]['mes'].'-'.$data[4]['dia']."' AND id_aprendiz = '".$aprendiz[$i]['id']."'";
$resAgenda = mysql_query($sqlAgenda, $con);
$numAgenda = mysql_num_rows($resAgenda);

if($numAgenda > 0) {
	$rowAgenda = mysql_fetch_array($resAgenda);
	$detalhes = $rowAgenda['descricao'];
	$presenca = $rowAgenda['presenca'];
}

else { 
	$detalhes = "";
	$presenca = "indeterminada";
}

?>
<input id="detalhes<?=$data[4]['ano'].$data[4]['mes'].$data[4]['dia'].$aprendiz[$i]['id'];?>" type="hidden" value="<?=$detalhes;?>">
<input id="presenca<?=$data[4]['ano'].$data[4]['mes'].$data[4]['dia'].$aprendiz[$i]['id'];?>" type="hidden" value="<?=$presenca;?>">
<div class='turno <?=$expediente?>'><span>M</span></div>
<div <?php if($expediente == "sim") { ?>onclick="alterarAgenda('<?=$data[4]['dia']."-".$mesNumerico."-".$anoNumerico."-".$aprendiz[$i]['nome']."-".$aprendiz[$i]['id']; ?>')"<?php } ?> class='turno <?=$expediente?> presenca<?=$presenca?>'><span>T</span></div>
<div class='turno <?=$expediente?>'><span>N</span></div>

<?php } ?>
	
</div><div id="diaExpediente5" class="expediente">

<?php for($i = 0; $i < $num; $i++) { ?>

<h3><?=$aprendiz[$i]['nome']?></h3>

<?php 
if(strstr($aprendiz[$i]['expediente'], '5')) $expediente = "sim";
else $expediente = "nao";

$sqlAgenda = "SELECT * FROM relatorios_agendas WHERE data = '".$data[5]['ano'].'-'.$data[5]['mes'].'-'.$data[5]['dia']."' AND id_aprendiz = '".$aprendiz[$i]['id']."'";
$resAgenda = mysql_query($sqlAgenda, $con);
$numAgenda = mysql_num_rows($resAgenda);

if($numAgenda > 0) {
	$rowAgenda = mysql_fetch_array($resAgenda);
	$detalhes = $rowAgenda['descricao'];
	$presenca = $rowAgenda['presenca'];
}

else { 
	$detalhes = "";
	$presenca = "indeterminada";
}

?>
<input id="detalhes<?=$data[5]['ano'].$data[5]['mes'].$data[5]['dia'].$aprendiz[$i]['id'];?>" type="hidden" value="<?=$detalhes;?>">
<input id="presenca<?=$data[5]['ano'].$data[5]['mes'].$data[5]['dia'].$aprendiz[$i]['id'];?>" type="hidden" value="<?=$presenca;?>">
<div class='turno <?=$expediente?>'><span>M</span></div>
<div <?php if($expediente == "sim") { ?>onclick="alterarAgenda('<?=$data[5]['dia']."-".$mesNumerico."-".$anoNumerico."-".$aprendiz[$i]['nome']."-".$aprendiz[$i]['id']; ?>')"<?php } ?> class='turno <?=$expediente?> presenca<?=$presenca?>'><span>T</span></div>
<div class='turno <?=$expediente?>'><span>N</span></div>

<?php } ?>
	
</div>



<div id="divAlterarAgenda" class="alterarAgenda">

<h4 id="h4AlterarAgenda"></h4>
<h5 id="h5AlterarAgenda"></h5>

<form id="formAlterarAgenda" method="post" action="./">

<input type="hidden" name="hiddenCreate" id="hiddenCreate" value="true">
<input type="hidden" name="dataAlterarAgenda" id="dataAlterarAgenda">
<input type="hidden" name="usuarioAlterarAgenda" id="usuarioAlterarAgenda">
<input type="hidden" name="presencaAlterarAgenda" id="presencaAlterarAgenda" required>

<div onclick="this.className = 'selecionado'; document.getElementById('presencaAlterarAgenda').value= 'presente'; document.getElementById('ausente').className = '';" id="presente">Presente</div><div onclick="this.className = 'selecionado'; document.getElementById('presencaAlterarAgenda').value= 'ausente'; document.getElementById('presente').className = '';" id="ausente">Ausente</div>

<textarea name="atividadesAlterarAgenda" id="atividadesAlterarAgenda" placeholder="Atividades do Dia"></textarea>

<input type="submit" value="Salvar">

</form>
	
</div>



<script type="text/javascript">
<?php
$diaHoje = date("d");
$mesHoje = date("m");
$anoHoje = date("Y");
$hoje = $anoHoje.$mesHoje.$diaHoje;

echo "var diaHoje = ".$hoje.";";
?>

	function alterarAgenda(diaMes) {
		var variaveis = diaMes.split('-');

		var dia = variaveis[0];

		var str = "" + dia;
		var pad = "00";
		var dia = pad.substring(0, pad.length - str.length) + str;

		var mes = variaveis[1];

		var ano = variaveis[2];
		var user = variaveis[3];
		var idUser = variaveis[4];
		var diaString = ano.toString().concat(mes.toString(),dia.toString());
		var idInput = "#detalhes"+diaString+idUser;
		var conteudo = $(idInput).val();
		var idInput2 = "#presenca"+diaString+idUser;
		var presenca = $(idInput2).val();
		
		/*if(diaString > diaHoje) {
			document.getElementById("presente").style.pointerEvents = "none";
			document.getElementById("presente").style.opacity = "0.16";
			document.getElementById("presente").className = "";
			document.getElementById("ausente").style.pointerEvents = "none";
			document.getElementById("ausente").style.opacity = "0.16";
			document.getElementById("ausente").className = "";
			document.getElementById("presencaAlterarAgenda").value = "";
		}

		else {
			document.getElementById("presente").style.pointerEvents = "auto";
			document.getElementById("presente").style.opacity = "1";
			document.getElementById("ausente").style.pointerEvents = "auto";
			document.getElementById("ausente").style.opacity = "1";
		}*/

		$('#sombraBranca').fadeIn();
		$('#divAlterarAgenda').fadeIn();
		$('#h4AlterarAgenda').html(user);
		$('#usuarioAlterarAgenda').val(idUser);
		$('#dataAlterarAgenda').val(dia+"-"+mes+"-"+ano);
		$('#h5AlterarAgenda').html("Agenda do dia "+dia+"/"+mes+"/"+ano);
		$('#atividadesAlterarAgenda').val(conteudo);
		//alert(presenca);
		if(presenca == 1) {
			document.getElementById("ausente").className = "";
			document.getElementById("presente").className = "selecionado";
			$('#presencaAlterarAgenda').val("1");
		}

		else if(presenca == 0) {
			document.getElementById("ausente").className = "selecionado";
			document.getElementById("presente").className = "";
			$('#presencaAlterarAgenda').val("0");
		}

		else {
			document.getElementById("ausente").className = "";
			document.getElementById("presente").className = "";
		}
	}
</script>