function style() {

	var oTab = document.getElementById('tabs');
	var oA = oTab.getElementsByTagName('a');
	var oSw = document.getElementById('swiper-wrapper');
	var oSli = getElementByClassName(oSw, 'swiper-slide');

	for (var i = 0; i < oA.length; i++) {
		oA[i].index = i;
		oA[i].onclick = function() {
			for (var i = 0; i < oA.length; i++) {
				oSli[i].style.display = 'none';
			}
			oSli[this.index].style.display = 'block';
		}
	}

}

$('.order').click(function() {
	$('.order').attr('value', '');
})

$(".tabs a").on('touchstart mousedown', function(e) {
	e.preventDefault();
	$(".tabs .active").removeClass('active');
	$(this).addClass('active');
	// tabsSwiper.swipeTo($(this).index());
});

$(".tabs a").click(function(e) {
	e.preventDefault();
});
function getElementByClassName(obj, classname) {
	if (obj.getElementByClassName) {
		return obj.getElementsByClassName(classname)
	} else {
		var aElem = obj.getElementsByTagName("*");
		var me = new RegExp('\\b' + classname + '\\b', 'i')
		var Result = [];
		for (var i = 0; i < aElem.length; i++) {
			if (me.test(aElem[i].className)) {
				Result.push(aElem[i]);
			}
		}
		return Result;
	}
}
function returnTicket(obj) {

	var text = $(obj).parents('.aa').find('.content-slide-main-top').find(
			'.orderNumValue').val()
	$.ajax({

		url : "order/refunTicket",
		type : "POST",
		data : {

			orderNum : text

		},
		dataType : "text",
		success : function(data) {

			if (data == "true") {

				alert("退订成功");
				window.location.reload();

			} else {

				alert("退订失败，不满足退订条件!")
			}

		}

	})
}
function getUserPageNum() {

	$.ajax({

		url : "order/getUserPageNum",
		type : "POST",
		async : false,
		data : {

			account : ""
		},
		success : function(data) {

			$('#pageNum1').val(data);
			FPage1(1);

		}

	})
}
function selectMyOrder() {
	$
			.ajax({

				url : "order/selectMyOrder",
				type : "POST",
				data : {

					page : 1

				},
				dataType : "JSON",
				success : function(data) {

					var code = "";
					var status = ""

					for (var i = 0; i < data.length; i++) {

						if (data[i].ticketStatus == 1) {

							status = "出票成功";
						} else {

							status = "已退订";
						}

						code += "<div class='aa' class='content-slide-main marginCen'>";
						code += "<div class='content-slide-main-top'>";
						code += "<input type='hidden' class='orderNumValue' value='"
								+ data[i].orderNum + "' />";
						code += "<p>时间:" + data[i].date + "订单号:"
								+ data[i].orderNum + "</p>";
						code += "<img tilte='123' onClick='deleteOrder(this)' class='a' src='imgs/del.png' />";
						code += "</div><div class='content-slide-main-main'>";
						code += "<table><td>" + data[i].departPlace + "-"
								+ data[i].destination + "</td>";
						code += "<td>" + data[i].trainsNum + "</td><td>￥"
								+ data[i].totalPrice + "</td>";
						code += "<td>" + data[i].seatNum + "</td><td>"
								+ data[i].ticketBarrier + "</td>";
						code += "<td>" + data[i].departTime + "</td>";
						if (data[i].ticketStatus == 1) {
							code += "<td><span style='color:green'>" + status
									+ "</span></td>";
							code += "<td><a  href='javascript:void(0);' onclick='returnTicket(this)'  class='returnTicket' >退订</a></td></table></div></div>";
						} else {
							code += "<td><span style='color:red'>" + status
									+ "</span></td>";
						}
						code += "<td><a href='#'></a></td></table></div></div>";

					}

					$('#orderContent').html(code);

				}

			})
}

$('#order_1').click(function() {

	$('#tcdPageCode1').css('display', 'block');
	$('#tcdPageCode2').css('display', 'hidden');
	$('#tcdPageCode3').css('display', 'hidden');

})
$('#order_2').click(function() {

	$.ajax({

		url : "order/selectByStatusCount",
		method : "POST",
		async : false,
		data : {

			status : 1

		},
		success : function(data) {

			$('#pageNum2').val(data);
			FPage2(1);

		}

	})
	var code = getListByStatus(1, 1);
	$('#orderContent_1').html(code);
	$('#tcdPageCode1').css('display', 'hidden');
	$('#tcdPageCode2').css('display', 'block');
	$('#tcdPageCode3').css('display', 'hidden');

})

$('#order_3').click(function() {

	$.ajax({

		url : "order/selectByStatusCount",
		method : "POST",
		async : false,
		data : {

			status : 2

		},
		success : function(data) {

			$('#pageNum3').val(data);
			FPage3(1);

		}
	})

	var code = getListByStatus(2, 1);
	$('#orderContent_2').html(code);
	$('#tcdPageCode1').css('display', 'hidden');
	$('#tcdPageCode2').css('display', 'hidden');
	$('#tcdPageCode3').css('display', 'block');

})
function getListByStatus(status, page) {

	var code = "";
	$
			.ajax({

				url : "order/selectOrderListByStatus",
				type : "POST",
				data : {

					status : status,
					page : page

				},
				async : false,
				dataType : "JSON",
				success : function(data) {

					var status = ""

					for (var i = 0; i < data.length; i++) {

						if (data[i].ticketStatus == 1) {

							status = "出票成功";
						} else {

							status = "已退订";
						}

						code += "<div class='aa' class='content-slide-main marginCen'>";
						code += "<div class='content-slide-main-top'>";
						code += "<input type='hidden' class='orderNumValue' value='"
								+ data[i].orderNum + "' />";
						code += "<p>时间:" + data[i].date + "订单号:"
								+ data[i].orderNum + "</p>";
						code += "<img tilte='123' onClick='deleteOrder(this)' class='a' src='imgs/del.png' />";
						code += "</div><div class='content-slide-main-main'>";
						code += "<table><td>" + data[i].departPlace + "-"
								+ data[i].destination + "</td>";
						code += "<td>" + data[i].trainsNum + "</td><td>￥"
								+ data[i].totalPrice + "</td>";
						code += "<td>" + data[i].seatNum + "</td><td>"
								+ data[i].ticketBarrier + "</td>";
						code += "<td>" + data[i].departTime + "</td>";
						if (data[i].ticketStatus == 1) {
							code += "<td><span style='color:green'>" + status
									+ "</span></td>";
							code += "<td><a  href='javascript:void(0);' onclick='returnTicket(this)'  class='returnTicket' >退订</a></td></table></div></div>";
						} else {
							code += "<td><span style='color:red'>" + status
									+ "</span></td>";
						}
						code += "<td><a href='#'></a></td></table></div></div>";

					}

				}

			})
	return code;

}
function deleteOrder(obj) {

	if (confirm("确定要删除么？(不可恢复)")) {

		/*
		 * var txt = $(obj).parent().parent('.aa').find(".orderNumValue").val();
		 * alert(txt)
		 */
		// 后台删除
		$.ajax({

			url : "order/delteOrder",
			type : "POST",
			data : {

				orderNum : $(obj).parent().parent('.aa').find(".orderNumValue")
						.val()
			},
			dataType : "text",
			success : function(data) {

				if (data == 'false') {

					alert("删除失败..")
				} else {

					// 前台删除
					$(obj).parents(".aa").remove();

				}

			}

		})

	}

}

function FPage1(page) {

	$("#tcdPageCode1")
			.createPage(
					{
						pageCount : $('#pageNum1').val(),
						current : page,
						backFn : function(p) {

							$
									.ajax({

										url : "order/selectMyOrder",
										type : "POST",
										data : {

											page : p

										},
										dataType : "JSON",
										success : function(data) {

											$('#orderContent').children()
													.remove();

											var code = "";
											var status = ""

											for (var i = 0; i < data.length; i++) {

												if (data[i].ticketStatus == 1) {

													status = "出票成功";
												} else {

													status = "已退订";
												}

												code += "<div class='aa' class='content-slide-main marginCen'>";
												code += "<div class='content-slide-main-top'>";
												code += "<input type='hidden' class='orderNumValue' value='"
														+ data[i].orderNum
														+ "' />";
												code += "<p>时间:" + data[i].date
														+ "订单号:"
														+ data[i].orderNum
														+ "</p>";
												code += "<img tilte='123' onClick='deleteOrder(this)' class='a' src='imgs/del.png' />";
												code += "</div><div class='content-slide-main-main'>";
												code += "<table><td>"
														+ data[i].departPlace
														+ "-"
														+ data[i].destination
														+ "</td>";
												code += "<td>"
														+ data[i].trainsNum
														+ "</td><td>￥"
														+ data[i].totalPrice
														+ "</td>";
												code += "<td>"
														+ data[i].seatNum
														+ "</td><td>"
														+ data[i].ticketBarrier
														+ "</td>";
												code += "<td>"
														+ data[i].departTime
														+ "</td>";
												if (data[i].ticketStatus == 1) {
													code += "<td><span style='color:green'>"
															+ status
															+ "</span></td>";
													code += "<td><a  href='javascript:void(0);' onclick='returnTicket(this)'  class='returnTicket' >退订</a></td></table></div></div>";
												} else {
													code += "<td><span style='color:red'>"
															+ status
															+ "</span></td>";
												}
												code += "<td><a href='#'></a></td></table></div></div>";

											}

											$('#orderContent').html(code);

										}

									})
						}
					});
}

function FPage2(page) {
	$("#tcdPageCode2").createPage({
		pageCount : $('#pageNum2').val(),
		current : page,
		backFn : function(p) {

			var code = getListByStatus(1, p);

			$('#orderContent_1').html(code);
		}
	});
}

function FPage3(page) {
	$("#tcdPageCode3").createPage({
		pageCount : $('#pageNum3').val(),
		current : page,
		backFn : function(p) {

			var code = getListByStatus(2, p);

			$('#orderContent_2').html(code);
		}
	});
}