using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AppointmentSystem.Models
{
    public class Appointments
    {
        /// <summary>
        /// Get or Set Id of an Appointment
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// Get or Set Name of the User who need an appointment
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// Get or Set Email Id of the User who need an appointment
        /// </summary>
        public string Email { get; set; }

        /// <summary>
        /// Get or Set Id Convenient Appointment Time of the user
        /// </summary>
        public string AppointmentTime { get; set; }

        /// <summary>
        /// Get or Set Id Convenient Appointment Date of the user
        /// </summary>
        public string AppointmentEndTime { get; set; }

        /// <summary>
        /// Get or Set Title of an Appointment
        /// </summary>
        public string AppointmentTitle { get; set; }

        /// <summary>
        /// Get or Set all appointments
        /// </summary>
        public List<Appointments> AppointmentsList { get; set; }
    }
}