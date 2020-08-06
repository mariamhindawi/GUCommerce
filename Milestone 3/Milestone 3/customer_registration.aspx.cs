using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace Milestone_3
{
    public partial class registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void register_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("customerRegister", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username_input = username.Text;
            string password_input = password.Text;
            string first_name_input = first_name.Text;
            string last_name_input = last_name.Text;
            string email_input = email.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", username_input));
            cmd.Parameters.Add(new SqlParameter("@password", password_input));
            cmd.Parameters.Add(new SqlParameter("@first_name", first_name_input));
            cmd.Parameters.Add(new SqlParameter("@last_name", last_name_input));
            cmd.Parameters.Add(new SqlParameter("@email", email_input));

            //check username
            SqlCommand cmd2 = new SqlCommand("checkUsername", conn);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.Add(new SqlParameter("@username", username_input));
            //Save the output from the procedure
            SqlParameter flag = cmd2.Parameters.Add("@flag", SqlDbType.Bit);
            flag.Direction = ParameterDirection.Output;

            conn.Open();
            cmd2.ExecuteNonQuery();
            conn.Close();
            Boolean userExists = (Boolean) flag.Value;

            //Executing the SQLCommand
            if (username_input=="" || password_input=="" || first_name_input=="" || last_name_input=="" || email_input=="")
            {
                //Response.Write("Cannot leave any field blank");
                errorMessage.Text = "Cannot leave any field blank";
            }
            else if(userExists)
            {
                //Response.Write("Username already exists");
                errorMessage.Text = "Username already exists";
            }
            else
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                Response.Redirect("login.aspx");
            }

        }
    }
}