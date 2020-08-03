var Validation = {
    Init: function () {
        Appointments.GetAllAppointments();
        $("#btnDelete").click(Appointments.DeleteAppointment);
    },
    CreateValidation: function () {
        $('#appointmentForm').validate({ 
            rules: {
                Name: {
                    required: true
                    
                },
                Email: { required: true },
                AppointmentTime: { required: true },
                AppointmentTitle: { required: true }
            },
            messages: {
                Name: "Please Enter your Name",
                Email: "Please enter your Email Id", 
                AppointmentTime: "Please enter  Appointment Time",
                AppointmentTitle: "Please enter Appointment Title"
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
    }
}