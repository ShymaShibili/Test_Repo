using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using AppointmentSystem.Models;
using System.Configuration;
using System.Data;

namespace AppointmentSystem.DAL
{
    public class AppointmentDal
    {
        /// <summary>
        /// Function for Create appointment
        /// </summary>
        /// <param name="appointments"></param>
        /// <returns></returns>
        public string InsertUser(Appointments appointments)
        {
            string successVal = "";
           
            try
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString());
                SqlCommand cmd = new SqlCommand("InsertAppointments", con);
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
             
                cmd.Parameters.AddWithValue("@Name",appointments.Name);
                cmd.Parameters.AddWithValue("@Email",appointments.Email );
                cmd.Parameters.AddWithValue("@AppointmentTime", appointments.AppointmentTime);
                cmd.Parameters.AddWithValue("@Title",appointments.AppointmentTitle );

                successVal = cmd.ExecuteNonQuery().ToString();
                con.Close();
            }
            catch (Exception exception)
            {
                var error = exception.Message;
                return successVal;

            }
            finally
            {
            }

            return successVal;

        }
        /// <summary>
        /// Function for List all Appointments
        /// </summary>
        /// <returns></returns>
        public List<Appointments> SelectAllAppointments()
        {
            var appointmentsList = new List<Appointments>();

            try
            {
                string strcon = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                SqlConnection sqlcon = new SqlConnection(strcon);
                SqlCommand sqlcmd = new SqlCommand("SelectAllAppointments", sqlcon);
                sqlcon.Open();
                sqlcmd.Connection = sqlcon;
                sqlcmd.CommandType = CommandType.StoredProcedure;
                
                SqlDataReader sqldr = sqlcmd.ExecuteReader();
                while (sqldr.Read())
                {
                    appointmentsList.Add(new Appointments
                    {
                        Id = Convert.ToInt32(sqldr["AppointmentId"]),
                        Name = sqldr["Name"].ToString(),
                        Email = sqldr["Email"].ToString(),
                        AppointmentTitle = sqldr["Title"].ToString(),
                        AppointmentTime = sqldr["AppointmentStartTime"].ToString(),
                        AppointmentEndTime = sqldr["AppointmentEndTime"].ToString()

                    });
                }
            }
            catch (Exception exception)
            {
                var error = exception.Message;

            }
            finally
            {
            }

            return appointmentsList;
        }
        /// <summary>
        /// Function for delete an appointment
        /// </summary>
        /// <param name="appointmentId"></param>
        /// <returns></returns>
        public string DeleteAppointment(int appointmentId)
        {
            string successVal = "";
            try
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ToString());
                SqlCommand cmd = new SqlCommand("DeleteAppointment", con);
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@AppointmentId", appointmentId);

                successVal = cmd.ExecuteNonQuery().ToString();
                con.Close();
            }
            catch (Exception exception)
            {
                var error = exception.Message;
                return successVal;

            }
            finally
            {
            }

            return successVal;

        }
        /// <summary>
        /// Function to get an appointment details
        /// </summary>
        /// <param name="appointmentId"></param>
        /// <returns></returns>
        public Appointments ReadAppointments(int appointmentId)
        {
            var appointments = new Appointments();
            try
            {
                string strcon = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                SqlConnection sqlcon = new SqlConnection(strcon);
                SqlCommand sqlcmd = new SqlCommand("ReadAppointmentDetails", sqlcon);
                sqlcon.Open();
                sqlcmd.Connection = sqlcon;
                sqlcmd.CommandType = CommandType.StoredProcedure;
                sqlcmd.Parameters.AddWithValue("@AppointmentId", appointmentId);
               
                SqlDataReader sqldr = sqlcmd.ExecuteReader();
                if (sqldr.Read())
                {

                    appointments = new Appointments()
                    {
                        Id = Convert.ToInt32(sqldr["AppointmentId"]),
                        Name = sqldr["Name"].ToString(),
                        Email = sqldr["Email"].ToString(),
                        AppointmentTitle = sqldr["Title"].ToString(),
                        AppointmentTime = sqldr["AppointmentStartTime"].ToString(),
                        AppointmentEndTime = sqldr["AppointmentEndTime"].ToString()
                    };

                }
                sqlcon.Close();
            }
            catch (Exception exception)
            {
                var error = exception.Message;

            }
            finally
            {
            }

            return appointments;
        }
    }
}