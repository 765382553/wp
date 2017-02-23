$('#chaxun').click(function(event) {

    if ($('.fromPlace').val() == "" || $('.toPlace').val() == "" || $('#date').val() == "") {

        alert("请检查输入!");
        return;
    }
    $.ajax({

        url: "./ticket/selectByNeed",
        type: "GET",
        data: {

            departPlace: $('.fromPlace').val(),
            destination: $('.toPlace').val(),
            date: $('#date').val()

        },
        async: true,
        dataType: "JSON",
        success: function(data) {

            if (data.length == 0) {

                alert("暂无所需车次");

            } else {

                location.href = "showTickets.jsp";

            }

        },
        error: function() {

            alert("暂无所需车次");

        }
    })

    event.preventDefault();

})