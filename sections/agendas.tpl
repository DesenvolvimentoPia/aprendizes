<h2>Agenda Aprendizes</h2>

<?php

$hoje = date("d-m");

$diaSemana = date("N");
$diaNumerico = date("d");
$mesNumerico = date("m");
$y = 0;

for($x = $diaSemana; $x > 0; $x--) {
	$dia[$x] = $diaNumerico - $y;
	$y++;

	if($diaNumerico - $y == 0) {

	}
}

$diaSemana = date("N");
$diaNumerico = date("d");
$mesNumerico = date("m");

$y = 1;
for($x = $diaSemana +1; $x < 6; $x++) {
	$dia[$x] = $diaNumerico + $y;
	$y++;
}



?>

<div id="botaoVoltar"><</div>

<div class="cabecalhoDia <?php if($dia[1]."-".$mesNumerico == $hoje) echo "hoje"; ?>">Segunda <?=$dia[1]?>/<?=$mesNumerico?></div><div class="cabecalhoDia <?php if($dia[2]."-".$mesNumerico == $hoje) echo "hoje"; ?>">Terça <?=$dia[2]?>/<?=$mesNumerico?></div><div class="cabecalhoDia <?php if($dia[3]."-".$mesNumerico == $hoje) echo "hoje"; ?>">Quarta <?=$dia[3]?>/<?=$mesNumerico?></div><div class="cabecalhoDia <?php if($dia[4]."-".$mesNumerico == $hoje) echo "hoje"; ?>">Quinta <?=$dia[4]?>/<?=$mesNumerico?></div><div class="cabecalhoDia <?php if($dia[5]."-".$mesNumerico == $hoje) echo "hoje"; ?>">Sexta <?=$dia[5]?>/<?=$mesNumerico?></div>

<div id="botaoAvancar">></div>

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
?>
<div class='turno <?=$expediente?>'><span>M</span></div>
<div <?php if($expediente == "sim") { ?>onclick="alterarAgenda('<?=$dia[1]."-".$mesNumerico."-".$aprendiz[$i]['id']; ?>')"<?php } ?> class='turno <?=$expediente?>'><span>T</span></div>
<div class='turno <?=$expediente?>'><span>N</span></div>

<?php } ?>

</div><div id="diaExpediente2" class="expediente">

<?php for($i = 0; $i < $num; $i++) { ?>

<h3><?=$aprendiz[$i]['nome']?></h3>

<?php 
if(strstr($aprendiz[$i]['expediente'], '2')) $expediente = "sim";
else $expediente = "nao";
?>
<div class='turno <?=$expediente?>'><span>M</span></div>
<div <?php if($expediente == "sim") { ?>onclick="alterarAgenda('<?=$dia[2]."-".$mesNumerico."-".$aprendiz[$i]['id']; ?>')"<?php } ?> class='turno <?=$expediente?>'><span>T</span></div>
<div class='turno <?=$expediente?>'><span>N</span></div>

<?php } ?>
	
</div><div id="diaExpediente3" class="expediente">

<?php for($i = 0; $i < $num; $i++) { ?>

<h3><?=$aprendiz[$i]['nome']?></h3>

<?php 
if(strstr($aprendiz[$i]['expediente'], '3')) $expediente = "sim";
else $expediente = "nao";
?>
<div class='turno <?=$expediente?>'><span>M</span></div>
<div <?php if($expediente == "sim") { ?>onclick="alterarAgenda('<?=$dia[3]."-".$mesNumerico."-".$aprendiz[$i]['id']; ?>')"<?php } ?> class='turno <?=$expediente?>'><span>T</span></div>
<div class='turno <?=$expediente?>'><span>N</span></div>

<?php } ?>
	
</div><div id="diaExpediente4" class="expediente">

<?php for($i = 0; $i < $num; $i++) { ?>

<h3><?=$aprendiz[$i]['nome']?></h3>

<?php 
if(strstr($aprendiz[$i]['expediente'], '4')) $expediente = "sim";
else $expediente = "nao";
?>
<div class='turno <?=$expediente?>'><span>M</span></div>
<div <?php if($expediente == "sim") { ?>onclick="alterarAgenda('<?=$dia[4]."-".$mesNumerico."-".$aprendiz[$i]['id']; ?>')"<?php } ?> class='turno <?=$expediente?>'><span>T</span></div>
<div class='turno <?=$expediente?>'><span>N</span></div>

<?php } ?>
	
</div><div id="diaExpediente5" class="expediente">

<?php for($i = 0; $i < $num; $i++) { ?>

<h3><?=$aprendiz[$i]['nome']?></h3>

<?php 
if(strstr($aprendiz[$i]['expediente'], '5')) $expediente = "sim";
else $expediente = "nao";
?>
<div class='turno <?=$expediente?>'><span>M</span></div>
<div <?php if($expediente == "sim") { ?>onclick="alterarAgenda('<?=$dia[5]."-".$mesNumerico."-".$aprendiz[$i]['id']; ?>')"<?php } ?> class='turno <?=$expediente?>'><span>T</span></div>
<div class='turno <?=$expediente?>'><span>N</span></div>

<?php } ?>
	
</div>



<div id="divAlterarAgenda">
	
</div>


<script type="text/javascript">
	function alterarAgenda(diaMes) {
		var variaveis = diaMes.split('-');
		
		var dia = variaveis[0];
		var mes = variaveis[1];
		var user = variaveis[2];

		$('#sombraBranca').fadeIn();
		$('#divAlterarAgenda').fadeIn();
	}
</script>