<h2>Aprendizes</h2>

	<input placeholder="Pesquisa Rápida" name="pesquisarAprendizes" id="pesquisarAprendizes" type="text" ng-model="filtro"><a id="adicionarAprendiz">Adicionar</a>

	<div class="tituloResultados">
	<a  class="linkTitulo selecionado" ng-click="ordenar('id');">ID</a><a  class="linkTitulo" ng-click="ordenar('nome');">Nome</a><a  class="linkTitulo" ng-click="ordenar('email');">E-mail</a><a  class="linkTitulo" ng-click="ordenar('expediente');">Expediente</a>
	</div>

	<a data-cod="{{x.id}}" class="linhaResultado" ng-repeat="x in recordsAprendizes | orderBy:myOrderBy | filter: filtro">
		<div class="colunaResultado">{{x.id}}</div><div class="colunaResultado">{{x.nome}}</div><div class="colunaResultado">{{x.email}}</div><div class="colunaResultado {{x.expediente}}"><span>S</span><span>T</span><span>Q</span><span>Q</span><span>S</span></div>
	</a>

	<script>

	$(function() {
		$('.linkTitulo').click(function() {
			var elementos = document.getElementsByClassName('linkTitulo');

		for (var x = 0; x < elementos.length; x++) {
			elementos[x].className = "linkTitulo";
		}

		this.className = "linkTitulo selecionado";

		});
	});

	var app = angular.module("appAprendizes", []);
	app.controller("myCtrlAprendizes", function($scope) {
    
    $scope.recordsAprendizes = [

	<?php

	$sql = "SELECT * FROM relatorios_aprendizes ORDER BY nome";
	$res = mysql_query($sql, $con);
	$num = mysql_num_rows($res);

	for($i = 0; $i < $num; $i++) {
	$row = mysql_fetch_array($res);
		if($i == 0) echo "{";
		else echo ", {";

		$expediente = "";

		$explodir = explode(",", $row['expediente']);
		for($j = 0; $j < count($explodir); $j++) {
			$expediente .= " dia".$explodir[$j]; 
		}


		echo "'id': ".$row['id'].", 'nome': '".$row['nome']."', 'email': '".$row['email']."', 'expediente': '".$expediente."' }";
	}
	
	?>

    ];
      $scope.ordenar = function(x) {
      	if($scope.myOrderBy == x) x = "-"+x;
	    $scope.myOrderBy = x;
	  }

});


$(function () {
	$( "section" ).delegate( ".linhaResultado", "click", function() {
	    var id = $(this).data('cod');
	    //alert("AQUI: "+id);
		//$('#telefones').html('Carregando...');
		// Do an ajax request
		$.ajax({
		  url: "aprendiz.php?id="+id
		}).done(function(data) { // data what is sent back by the php page
		  $('#aprendizes').html(data); // display data
		});

	});

	$('#adicionarAprendiz').click(function() {

		//$('#aprendizes').html('Carregando...');
		// Do an ajax request
		$.ajax({
		  url: "aprendiz.php?id=novo"
		}).done(function(data) { // data what is sent back by the php page
		  $('#aprendizes').html(data); // display data
		});

	});
});
	
</script>