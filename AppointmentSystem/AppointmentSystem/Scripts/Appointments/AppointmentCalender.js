var events = [];
var Appointments = {
    Init: function () {
        Appointments.GetAllAppointments();
        $("#btnDelete").click(Appointments.DeleteAppointment);
    },
    //Function to get all appointments in calendar
    GetAllAppointments: function () {
        var url = "/Appointment/GetAppointments/";
        $.ajax({
            type: "GET",
            url: url ,
            success: function (data) {
                $.each(data, function (i, v) {
                    events.push({
                        title: v.AppointmentTitle,
                        start: moment(v.AppointmentTime),
                        end: moment(v.AppointmentEndTime),
                        description: v.Id,
                        backgroundColor: "#9501fc",
                        borderColor: "#fc0101"  
                    });
                })

                Appointments.GenerateCalender(events);
            },
            error: function (error) {
                alert('failed');
            }
        })
    },
    //Generate calender and clicking an appointment get all details
    GenerateCalender: function (events) {
        $('#calender').fullCalendar('destroy');
        $('#calender').fullCalendar({
                contentHeight: 400,
                defaultDate: new Date(),
                timeFormat: 'h(:mm)a',
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,basicWeek,basicDay,agenda'
                },
        eventLimit: true,
        eventColor: '#378006',
        events: events,
            eventClick: function (calEvent, jsEvent, view) {
                $('#myModal #eventTitle').text(calEvent.title);
                $('#appointId').val(calEvent.description);
                var $description = $('<div/>');
                $description.append($('<p/>').html('<b>Start:</b>' + calEvent.start.format("DD-MMM-YYYY HH:mm a")));
                    
                if (calEvent.end != null) {
                    $description.append($('<p/>').html('<b>End:</b>' + calEvent.end.format("DD-MMM-YYYY HH:mm a")));
                }
                $description.append($('<p/>').html('<b>Description:</b>' + calEvent.description));
                $('#myModal #pDetails').empty().html($description);

                $('#myModal').modal();
            }
        })
    },
    //Function for delete an appointment
    DeleteAppointment: function () {
        var url = "/Appointment/Delete/";
        $.ajax({

            url: url,
            data: { appointmentId: parseInt($("#appointId").val()) },
            cache: false,
            type: "POST",

            success: function (data) {
                
                if (confirm("Are you sure you want to delete this Appointment?")) {
                    alert("Deleted Successfully!!");
                    window.location.href = "/Appointment/Index/";
                }
                else {
                    return false;
                }

            },
            error: function () {
                alert("Not Successful!!")
            }
        });

    }

}