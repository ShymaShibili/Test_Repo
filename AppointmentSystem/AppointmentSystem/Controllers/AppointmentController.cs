using AppointmentSystem.DAL;
using AppointmentSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AppointmentSystem.Controllers
{
    public class AppointmentController : Controller
    {
        /// <summary>
        /// Get all appointments
        /// </summary>
        /// <returns></returns>
        // GET: Appointment
        public ActionResult Index()
        {
            return View();
        }
        /// <summary>
        /// Get action for Appointment Creation
        /// </summary>
        /// <returns></returns>
        public ActionResult CreateAppointment()
        {
            return View();
        }
        /// <summary>
        /// Post action for Appointment Creation
        /// </summary>
        /// <param name="appointments"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult CreateAppointment(Appointments appointments)
        {
            var appointmentDal = new AppointmentDal();
            var appointment = appointmentDal.InsertUser(appointments);
            return RedirectToAction("Index");
        }
        /// <summary>
        /// Post action of index..create appointment in modal
        /// </summary>
        /// <param name="appointments"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Index(Appointments appointments)
        {
            
            var appointmentDal = new AppointmentDal();
            var appointment = appointmentDal.InsertUser(appointments);
            if (appointment == "-1")
            {
                TempData["sErrMsg"] = "This Time Slot not Available";
                return View();
            }
            else
            {
                return View();
            }
            
        }
        /// <summary>
        /// Jsonaction to get all appointments showing in calendar
        /// </summary>
        /// <returns></returns>
        public JsonResult GetAppointments()
        {
            return Json(new AppointmentDal().SelectAllAppointments(), JsonRequestBehavior.AllowGet);

        }
        /// <summary>
        /// Json action for delete anappointment
        /// </summary>
        /// <param name="appointmentId"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult Delete(int appointmentId)
        {
            return Json(new AppointmentDal().DeleteAppointment(appointmentId), JsonRequestBehavior.AllowGet);

        }
    }
}