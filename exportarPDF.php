<?php

include "../conexao.php";

$alterar = explode("-", $_POST['dataInicial']);
$_POST['dataInicial'] = $alterar[2]."/".$alterar[1]."/".$alterar[0];

$alterar = explode("-", $_POST['dataFinal']);
$_POST['dataFinal'] = $alterar[2]."/".$alterar[1]."/".$alterar[0];

$sql = "SELECT * FROM relatorios_aprendizes WHERE id=".$_POST['selectAprendiz'];
$res = mysql_query($sql, $con);
$row = mysql_fetch_array($res);

$html = "<body>";

$html .= "<style>";
$html .= "body { color: #434343; }";
$html .= "h1, h2 { text-align: center; font-weight: normal;}";
$html .= "h1 { background: #525252; color: #FFF; margin: -12px 0 0; padding: 20px 0; font-size: 28px; }";
$html .= "h2 { background: #D1D1D1; margin: 0px 0px 10px; padding: 14px 0;  font-size: 16px; }";
$html .= ".right { text-align: right; }";
$html .= ".center { text-align: center; margin: 5px 0; }";
$html .= ".center:nth-child(odd) { background: #EEE; }";
$html .= "span { display: inline-block; margin-bottom: -43px;}";
$html .= "span.data { width: 20%; background: #dc5c51; padding: 7px 0; color: #FFF; }";
$html .= "span.data.presenca1 {  background: #5eaf81; }";
$html .= "span.conteudo { width: 76%; text-align: left; padding: 7px 2%; }";
$html .= "div.assinatura { display: inline-block; color: #999; text-align: center; padding-top: 16px; width: 40%; font-size: 14px; margin: 106px 5% 0; border-top: 1px solid #DDD; }";
$html .= "</style>";

if($row['turno'] == "T") $turno = "Tarde";
else if($row['turno'] == "N") $turno = "Noite";
else $turno = "Manhã";

$html .= "<h1><img src='../img/logo2.png' style='width: 160px; float: left; margin: -6px -80px 0 16px;'>Relatório de Atividades</h1>";
$html .= "<h2>".$row['matricula']." - ".$row['nome']." | Período: ".$_POST['dataInicial']." - ".$_POST['dataFinal']." | Turno: ".$turno."</h2>";

$converter = explode("/", $_POST['dataInicial']);
$dataInicial = $converter[2]."-".$converter[1]."-".$converter[0];

$converter = explode("/", $_POST['dataFinal']);
$dataFinal = $converter[2]."-".$converter[1]."-".$converter[0];

$sqlAgenda = "SELECT * FROM relatorios_agendas WHERE id_aprendiz=".$_POST['selectAprendiz']." ORDER BY data";
$resAgenda = mysql_query($sqlAgenda, $con);
$numAgenda = mysql_num_rows($resAgenda);

//$html .= $sqlAgenda;

for($i = 0; $i < $numAgenda; $i++) {
	$rowAgenda = mysql_fetch_array($resAgenda); 


	$converter = explode("/", $_POST['dataInicial']);
	$dataInicialComp = $converter[2].$converter[1].$converter[0];

	$converter = explode("/", $_POST['dataFinal']);
	$dataFinalComp = $converter[2].$converter[1].$converter[0];

	$converter = explode("-", $rowAgenda['data']);
	$dataComp = $converter[0].$converter[1].$converter[2];

	$data = $converter[2]."/".$converter[1]."/".$converter[0];
	//$html .= $dataComp;

	if($rowAgenda['presenca'] == 1) $presente = "Presente";
	else $presente = "Ausente";

	if($dataComp >= $dataInicialComp && $dataComp <= $dataFinalComp) $html .= "<p class='center'><span class='data presenca".$rowAgenda['presenca']."'>".$data."<br>".$presente."</span><span class='conteudo'>".$rowAgenda['descricao']."</span></p>";
}


$html .= "<div class='assinatura'>Assinatura ".$row['nome']."</div>";
$html .= "<div class='assinatura'>Assinatura do Responsável</div>";

echo "Aguarde enquanto o PDF é Gerado...";
//echo $html;

// include autoloader
require_once 'dompdf/autoload.inc.php';

// reference the Dompdf namespace
use Dompdf\Dompdf;

// instantiate and use the dompdf class
$dompdf = new Dompdf();
$dompdf->set_option('defaultFont', 'sans-serif');
$dompdf->loadHtml($html);

// Render the HTML as PDF
$dompdf->render();

$output = $dompdf->output();
//file_put_contents('impressaoSAC.pdf', $output);
file_put_contents('./relatorioAprendizes.pdf', $output);

//echo "<meta http-equiv='refresh' content='0; url=./index2.php?impressaoConcluida=SIM'>";

echo "<script> setTimeout(function(){ window.open('./relatorioAprendizes.pdf'); }, 700);</script>";
echo "<script> setTimeout(function(){ window.open('./', '_self'); }, 1600);</script>";