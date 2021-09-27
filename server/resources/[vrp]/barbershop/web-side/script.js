$(document).ready(function(){
	var documentWidth = document.documentElement.clientWidth;
	var documentHeight = document.documentElement.clientHeight;
	var cursor = $('#cursorPointer');
	var cursorX = documentWidth/2;
	var cursorY = documentHeight/2;

	function triggerClick(x,y){
		var element = $(document.elementFromPoint(x,y));
		element.focus().click();
		return true;
	}

	window.addEventListener('message',function(event){
		$("#hair").attr("max",event.data.maxHair);

		document.getElementById("skinColor").value = event.data.skinColor;
		document.getElementById("eyesColor").value = event.data.eyesColor;
		document.getElementById("complexionModel").value = event.data.complexionModel;
		document.getElementById("blemishesModel").value = event.data.blemishesModel;
		document.getElementById("frecklesModel").value = event.data.frecklesModel;
		document.getElementById("ageingModel").value = event.data.ageingModel;
		document.getElementById("hairModel").value = event.data.hairModel;
		document.getElementById("firstHairColor").value = event.data.firstHairColor;
		document.getElementById("secondHairColor").value = event.data.secondHairColor;
		document.getElementById("makeupModel").value = event.data.makeupModel;
		document.getElementById("blushModel").value = event.data.blushModel;
		document.getElementById("blushColor").value = event.data.blushColor;
		document.getElementById("lipstickModel").value = event.data.lipstickModel;
		document.getElementById("lipstickColor").value = event.data.lipstickColor;
		document.getElementById("eyebrowsModel").value = event.data.eyebrowsModel;
		document.getElementById("eyebrowsColor").value = event.data.eyebrowsColor;
		document.getElementById("beardModel").value = event.data.beardModel;
		document.getElementById("beardColor").value = event.data.beardColor;

    updateSlider();

		if(event.data.openBarbershop == true){
			$(".openBarbershop").css("display","flex");

      updateSlider();
		}

		if(event.data.openBarbershop == false){
			$(".openBarbershop").css("display","none");
		}

		if (event.data.type == "click") {
			triggerClick(cursorX-1,cursorY-1);
		}
	});

	$('input').on('input', function(){
    updateSlider();
		$.post('http://barbershop/updateSkin',JSON.stringify({
			value: false,
			skinColor: $('.skinColor').val(),
			eyesColor: $('.eyesColor').val(),
			complexionModel: $('.complexionModel').val(),
			blemishesModel: $('.blemishesModel').val(),
			frecklesModel: $('.frecklesModel').val(),
			ageingModel: $('.ageingModel').val(),
			hairModel: $('.hairModel').val(),
			firstHairColor: $('.firstHairColor').val(),
			secondHairColor: $('.secondHairColor').val(),
			makeupModel: $('.makeupModel').val(),
			blushModel: $('.blushModel').val(),
			blushColor: $('.blushColor').val(),
			lipstickModel: $('.lipstickModel').val(),
			lipstickColor: $('.lipstickColor').val(),
			eyebrowsModel: $('.eyebrowsModel').val(),
			eyebrowsColor: $('.eyebrowsColor').val(),
			beardModel: $('.beardModel').val(),
			beardColor: $('.beardColor').val()
		}));
	});

	$('.submit-button').on('click',function(e){
		e.preventDefault();

		$.post('http://barbershop/updateSkin',JSON.stringify({
			value: true,
			skinColor: $('.skinColor').val(),
			eyesColor: $('.eyesColor').val(),
			complexionModel: $('.complexionModel').val(),
			blemishesModel: $('.blemishesModel').val(),
			frecklesModel: $('.frecklesModel').val(),
			ageingModel: $('.ageingModel').val(),
			hairModel: $('.hairModel').val(),
			firstHairColor: $('.firstHairColor').val(),
			secondHairColor: $('.secondHairColor').val(),
			makeupModel: $('.makeupModel').val(),
			blushModel: $('.blushModel').val(),
			blushColor: $('.blushColor').val(),
			lipstickModel: $('.lipstickModel').val(),
			lipstickColor: $('.lipstickColor').val(),
			eyebrowsModel: $('.eyebrowsModel').val(),
			eyebrowsColor: $('.eyebrowsColor').val(),
			beardModel: $('.beardModel').val(),
			beardColor: $('.beardColor').val()
		}));
	});

	document.onkeydown = function(data){
		if(data.which == 65){
			$.post('http://barbershop/rotate',JSON.stringify("right"));
		}
		if(data.which == 68){
			$.post('http://barbershop/rotate',JSON.stringify("left"));
		}
	}

  function updateSlider() {
    $('input').each(function(){
      var max = $(this).attr('max'), val = $(this).val();
      $(this).parent().parent().find('label').find('p:last-child').text(val+' / '+max);
    });

    for (let e of document.querySelectorAll('input[type="range"].slider-progress')) {
      e.style.setProperty('--value', e.value);
      e.style.setProperty('--min', e.min == '' ? '0' : e.min);
      e.style.setProperty('--max', e.max == '' ? '100' : e.max);
      e.addEventListener('input', () => e.style.setProperty('--value', e.value));
    }
  }
});