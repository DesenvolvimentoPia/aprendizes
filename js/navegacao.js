/* Javascript Navegação */

$(document).ready(function() {
	$('.acao').click(function(e) {
		var elementos = document.getElementsByClassName('acao');

		for (var x = 0; x < elementos.length; x++) {
			elementos[x].className = "acao";
		}

		this.className = "acao selecionado";
		e.preventDefault(); // Previne o Comportamento padrão do Link
		var exibir = this.href.split('#'); // Recebe a Página para Navegação

		$('section').hide(); // Esconde Páginas
		$('.aparelho').fadeIn(700); // Exibe Página Selecionada
		$('#'+exibir[1]).fadeIn(700); // Exibe Página Selecionada
	});


	$('#backToTop').click(function() {
		$('html, body').animate({ scrollTop: 0 }, 800);
	});

	$( window ).scroll(function() {
		if($( window ).scrollTop() > 1240) 	$('#backToTop').fadeIn();
		else $('#backToTop').fadeOut();
	});
});