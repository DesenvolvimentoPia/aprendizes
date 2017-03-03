<h2>Relatorio de Atividades</h2>


<form action="./exportarPDF.php" id="formRelatorio" method="post">
<input name="dataInicial" id="inputDataInicial" title="Data Inicial" required type="date">
<input name="dataFinal" id="inputDataFinal" title="Data Final" required type="date">
<select name="selectAprendiz" id="selectAprendiz">

<?php

$sql = "SELECT * FROM relatorios_aprendizes ORDER BY id";
$res = sqlsrv_query($con, $sql);
$i = -1;
while($row = sqlsrv_fetch_array($res)) {
	$i++;

?><option value="<?=$row['id']?>"><?=$row['nome']?></option><?php } ?>

</select>
<input type="submit" value="Imprimir Relatório">
</form>