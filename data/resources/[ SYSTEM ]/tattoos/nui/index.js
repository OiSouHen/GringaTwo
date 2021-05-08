$(document).ready(function(){
	window.addEventListener("message",function(event){
		let _ = event.data;
		switch(_.action){
			case "openUI":
				getTattooList();
				$("#all-cont").fadeIn(200);
			break;

			case "closeUI":
				$("#all-cont").fadeOut(200);
			break;

			case "refreshTattoos":
				updateBoxRefresh();
			break;
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
            $.post("http://tattoos/L1Tattoos_clearLastPreviewTattoo",JSON.stringify({}))
			$.post("http://tattoos/L1Tattoos_closeUI");
		}
	};
});

const updateButtons = () => {
    $("#openmenu").click(function(e) {
        if ($("#container-types").hasClass("menuopened")) {
            $("#container-types").removeClass("menuopened").fadeOut(200);
        }else {
            $("#container-types").addClass("menuopened").fadeIn(200);
        };
    });

    $(".box").click(function() {
        if ($(this).hasClass("selected")) {
            $.post("http://tattoos/L1Tattoos_clearLastPreviewTattoo",JSON.stringify({}))
            $(this).removeClass("selected");
        }else {
            $.post("http://tattoos/L1Tattoos_clearLastPreviewTattoo",JSON.stringify({}))
            $(".box").removeClass("selected");
            $(this).addClass("selected");
            $.post("http://tattoos/L1Tattoos_previewTattoo",JSON.stringify({tattooIndex: $(this).data("index"), tattooType: $(".boxed-types.selected").data("toped")}))
        }
    });    
}

const updateBoxRefresh = () => {
    var boxIndex = $(".boxed-types.selected").data("toped")
    $.post("http://tattoos/L1Tattoos_getTattoosFromType",JSON.stringify({tattooType: boxIndex}),(data) => {
        $("#container").html(`
            <div class="sa"><i class="fas fa-bars" id="openmenu"></i></div>
                <h1>Tatuagens</h1>
                <div class="tattoos" id="${boxIndex}">
            </div>
        `)
        const tattooListAll = data.tattoosList.sort((a,b) => (a._name - b._name));
        $.each(tattooListAll, function (indexInArray, valueOfElement) { 
            $("#"+boxIndex).append(`
                <div class="box ${valueOfElement._owned}" data-index="${valueOfElement._index}">
                    <a>Modelo ${valueOfElement._name}</a>
                    <img src="assets/${valueOfElement._index}.png">
                    <a class="dolar">$${valueOfElement._price}</a>
                </div>
            `)
        });
        $("#"+boxIndex).fadeIn();
        updateButtons()
    })
}

const refreshBoxedTypes = () => {
    $(".boxed-types").click(function() {
        $(".tattoos").hide();
        if ($(this).hasClass("selected")) {
            $(this).removeClass("selected");
        }else {
            $(".boxed-types").removeClass("selected");
            $(this).addClass("selected");
            
            var boxIndex = $(this).data("toped")
            
            $.post("http://tattoos/L1Tattoos_getTattoosFromType",JSON.stringify({tattooType: boxIndex}),(data) => {
                $("#container").html(`
                    <div class="sa"><i class="fas fa-bars" id="openmenu"></i></div>
                        <h1>Tatuagens</h1>
                        <div class="tattoos" id="${boxIndex}">
                    </div>
                `)
                const tattooListAll = data.tattoosList.sort((a,b) => (a._name - b._name));
                $.each(tattooListAll, function (indexInArray, valueOfElement) { 
                    $("#"+boxIndex).append(`
                        <div class="box ${valueOfElement._owned}" data-index="${valueOfElement._index}">
                            <a>Modelo ${valueOfElement._name}</a>
                            <img src="assets/${valueOfElement._index}.png">
                            <a class="dolar">$${valueOfElement._price}</a>
                        </div>
                    `)
                });
                $("#"+boxIndex).fadeIn();
                updateButtons()
            })
        }
    });
}

const getTattooList = () => {
    $("#tattoos-types").empty();
    $(".tattoos").empty();
    $.post("http://tattoos/L1Tattoos_getTattooTypeList",JSON.stringify({}),(data) => {
        $.each(data.tattooType, function (indexInArray, valueOfElement) { 
            $("#tattoos-types").append(`
                <div class="boxed-types" data-toped="${indexInArray}">
                    <a>${valueOfElement._title}</a>
                </div>
            `)
        });
        refreshBoxedTypes()
    })
}

$(".clickb").click(function() {
    $.post("http://tattoos/L1Tattoos_saveTattoo",JSON.stringify({tattooIndex: $(".box.selected").data("index"), tattooType: $(".boxed-types.selected").data("toped")}))
});

$(".rotate.mais").click(function() {
    $.post("http://tattoos/L1Tattoos_rotatePed",JSON.stringify({ rotateMais: 10 }))
});

$(".rotate.menos").click(function() {
    $.post("http://tattoos/L1Tattoos_rotatePed",JSON.stringify({ rotateMenos: 10 }))
});