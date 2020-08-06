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
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("userLogin", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username_input = username.Text;
            string password_input = password.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", username_input));
            cmd.Parameters.Add(new SqlParameter("@password", password_input));
            
            //Save the output from the procedure
            SqlParameter success_output = cmd.Parameters.Add("@success", SqlDbType.Bit);
            success_output.Direction = ParameterDirection.Output;
            
            SqlParameter type_output = cmd.Parameters.Add("@type", SqlDbType.Int);
            type_output.Direction = ParameterDirection.Output;

            //Executing the SQLCommand
            if (username_input == "" || password_input == "")
            {
                errorMessage.Text = "Cannot leave any field blank";
            }
            else
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                Boolean success = (Boolean)success_output.Value;
                int type = (int)type_output.Value;

                if (!success)
                {
                    errorMessage.Text = "Wrong credentials";
                }
                else
                {
                    Session["username"] = username_input;
                    if (type == 0)
                    {
                        Response.Redirect("customer_home.aspx");
                    }
                    else if (type == 1)
                    {
                        Response.Redirect("vendor_home.aspx");
                    }
                    else if (type == 2)
                    {
                        Response.Redirect("admin_home.aspx");
                    }
                    else if (type == 3)
                    {
                        Response.Redirect("delivery_home.aspx");
                    }
                    
                }
            }
        }
    }
}