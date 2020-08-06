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
    public partial class add_credit_card : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void addCreditCard_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("AddCreditCard", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string credit_card_number_input = credit_card_number.Text;
            DateTime expiry_date_input = Calendar1.SelectedDate;
            string cvv_input = cvv.Text;
            string username = (string)(Session["username"]);

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@creditcardnumber", credit_card_number_input));
            cmd.Parameters.Add(new SqlParameter("@expirydate", expiry_date_input));
            cmd.Parameters.Add(new SqlParameter("@cvv", cvv_input));
            cmd.Parameters.Add(new SqlParameter("@customername", username));

            //check credit_card_number
            SqlCommand cmd2 = new SqlCommand("checkCreditCard", conn);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.Add(new SqlParameter("@creditcardnumber", credit_card_number_input));
            cmd2.Parameters.Add(new SqlParameter("@customername", username));
            //Save the output from the procedure
            SqlParameter flag = cmd2.Parameters.Add("@flag", SqlDbType.Bit);
            flag.Direction = ParameterDirection.Output;

            conn.Open();
            cmd2.ExecuteNonQuery();
            conn.Close();
            Boolean creditCardExists = (Boolean) flag.Value;

            //Executing the SQLCommand
            if (credit_card_number_input == "" || expiry_date_input==null || cvv_input=="")
            {
                errorMessage.Text = "Fields cannot be left empty";
            }
            else if (creditCardExists)
            {
                errorMessage.Text = "Credit Card number already added";
            }
            else
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                errorMessage.Text = "Credit Card number added successfully";
            }
        }
    }
}