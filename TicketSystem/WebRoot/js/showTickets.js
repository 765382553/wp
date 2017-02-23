$('#changecity').click(function() {

	var x = $('.departP').val();
	$('.departP').val($('#destP').val());
	$('.destP').val(x);

})

$('#searchBusTicket').click(function() {

	searchTicket($('.departP').val(), $('.destP').val(), $('#dateObj').val());

})

$('#preDay').click(
		function() {

			searchTicket($('#fromPlace').val(), $('#toPlace').val(),
					getPreDay($('#date_A').val()));

		})

$('#nextDay').click(
		function() {

			searchTicket($('#fromPlace').val(), $('#toPlace').val(),
					getNextDay($('#date_A').val()));

		})

function searchTicket(departPlace, destination, date) {

	$.ajax({

		url : "./ticket/selectByNeed",
		type : "GET",
		data : {

			departPlace : departPlace,
			destination : destination,
			date : date

		},
		async : true,
		dataType : "JSON",
		success : function(data) {

			if (data.length == 0) {

				alert("暂无所需车次")
			} else {

				location.href = "showTickets.jsp";

			}

		},
		error : function() {

			alert("暂无所需车次");
		}
	})

}

function getPreDay(d) {

	d = new Date(d);
	d = d - 1000 * 60 * 60 * 24;
	d = new Date(d);
	var x = d.getFullYear();
	var y = (d.getMonth() + 1);
	var z = d.getDate();
	if (y < 10) {

		y = '0' + y;
	}
	if (z < 10) {

		z = '0' + z;
	}

	return x + "-" + y + "-" + z;
}

function getNextDay(d) {
	d = new Date(d);
	d = +d + 1000 * 60 * 60 * 24;
	d = new Date(d);
	var x = d.getFullYear();
	var y = (d.getMonth() + 1);
	var z = d.getDate();
	if (y < 10) {

		y = '0' + y;
	}
	if (z < 10) {

		z = '0' + z;
	}

	return x + "-" + y + "-" + z;
}

function reserve(obj) {
	$.ajax({

		url : "ticket/buyTicket",
		type : "POST",
		dataType : "text",
		data : {

			ticketId : $(obj).parent("td").find("#ticketId").val()

		},
		success : function(msg) {

			if (msg == "true") {

				alert("购票成功");
				window.location.reload();
				return;
			}
			alert(msg);

		},
		error : function() {

			alert("发生异常，请稍后再试!");
		}
	})
}