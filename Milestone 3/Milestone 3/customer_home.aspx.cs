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
    public partial class customer_home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void viewProducts_Click(object sender, EventArgs e)
        {
            Response.Redirect("products.aspx");
        }

        protected void addMobile_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addMobile", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string mobile_number_input = mobile_number.Text;
            string username = (string) (Session["username"]);

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@mobile_number", mobile_number_input));

            //check mobile_number
            SqlCommand cmd2 = new SqlCommand("checkMobile", conn);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.Add(new SqlParameter("@username", username));
            cmd2.Parameters.Add(new SqlParameter("@mobile_number", mobile_number_input));
            //Save the output from the procedure
            SqlParameter flag = cmd2.Parameters.Add("@flag", SqlDbType.Bit);
            flag.Direction = ParameterDirection.Output;

            conn.Open();
            cmd2.ExecuteNonQuery();
            conn.Close();
            Boolean mobileExists = (Boolean) flag.Value;

            //Executing the SQLCommand
            if (mobile_number_input=="")
            {
                mobileMessage.Text = "Mobile number cannot be left empty";
            }
            else if (mobileExists)
            {
                mobileMessage.Text = "Mobile number already added";
            }
            else
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                mobileMessage.Text = "Mobile number added successfully";
            }

        }


        protected void addCreditCard_Click(object sender, EventArgs e)
        {
            Response.Redirect("add_credit_card.aspx");
        }

        protected void createWishlist_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("createWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string wishlist_name_input = wishlist_name.Text;
            string username = (string)(Session["username"]);

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@customername", username));
            cmd.Parameters.Add(new SqlParameter("@name", wishlist_name_input));

            //check
            SqlCommand cmd2 = new SqlCommand("checkWishlist", conn);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.Add(new SqlParameter("@customername", username));
            cmd2.Parameters.Add(new SqlParameter("@wishlistname", wishlist_name_input));
            //Save the output from the procedure
            SqlParameter flag = cmd2.Parameters.Add("@flag", SqlDbType.Bit);
            flag.Direction = ParameterDirection.Output;

            conn.Open();
            cmd2.ExecuteNonQuery();
            conn.Close();
            Boolean wishlistExists = (Boolean)flag.Value;

            //Executing the SQLCommand
            if (wishlist_name_input == "")
            {
                wishlistMesage.Text = "Wishlist name cannot be left empty";
            }
            else if (wishlistExists)
            {
                wishlistMesage.Text = "Wishlist name already added";
            }
            else
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                wishlistMesage.Text = "Wishlist name added successfully";
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            Response.Redirect("");
        }
    }
}