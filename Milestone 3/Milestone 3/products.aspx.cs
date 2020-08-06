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
    public partial class product : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("ShowProductsbyPrice", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //
            string username = (string)(Session["username"]);


            //Executing the SQLCommand
            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr.Read())
            {
                string temp = "<br/>";
                temp += "   Product Name:  ";
                temp += rdr.GetString(rdr.GetOrdinal("Product_name"));
                temp += ",   Description:  ";
                temp += rdr.GetString(rdr.GetOrdinal("product_description"));
                temp += ",   Price:  ";
                temp += rdr.GetDecimal(rdr.GetOrdinal("price"));
                temp += ",   Color:  ";
                temp += rdr.GetString(rdr.GetOrdinal("color"));
                temp += "<br/>";

                int x = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                string serial_no = x.ToString();

                Label l1 = new Label();
                l1.Text = temp;

                Button b1 = new Button();
                b1.Text = "Add to cart";
                b1.ID = "1" + serial_no;
                b1.Click += new EventHandler(addToCart_clicked);

                Button b2 = new Button();
                b2.Text = "Remove from cart";
                b2.ID = "2" + serial_no;
                b2.Click += new EventHandler(removeFromCart_clicked);

                Button b3 = new Button();
                b3.Text = "Add to wishlist";
                b3.ID = "3" + serial_no;
                b3.Click += new EventHandler(addToWishlist_clicked);

                Button b4 = new Button();
                b4.Text = "Remove from wishlist";
                b4.ID = "4" + serial_no;
                b4.Click += new EventHandler(removeFromWishlist_clicked);

                TextBox wishlistName = new TextBox();
                wishlistName.ID = "w" + serial_no;

                Label line = new Label();
                line.Text = "<br/>";

                //Label w1 = new Label();
                //line.Text = "Wishlist:";

                Label space1 = new Label();
                space1.Text = "   ";
                Label space2 = new Label();
                space2.Text = "   ";
                Label space3 = new Label();
                space3.Text = "   ";
                Label space4 = new Label();
                space4.Text = "   ";
                Label space5 = new Label();
                space5.Text = "   ";

                form1.Controls.Add(l1);
                form1.Controls.Add(b1);
                form1.Controls.Add(space1);
                form1.Controls.Add(b2);
                form1.Controls.Add(space2);
                //form1.Controls.Add(w1);
                form1.Controls.Add(wishlistName);
                form1.Controls.Add(space3);
                form1.Controls.Add(b3);
                form1.Controls.Add(space4);
                form1.Controls.Add(b4);
                form1.Controls.Add(line);
            }

            conn.Close();
        }


        protected void addToCart_clicked(object sender, EventArgs e)
        {
            Button b = (Button)sender;
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string username = (string)(Session["username"]);
            string serial_no = (string)b.ID;
            serial_no = serial_no.Substring(1);

            SqlCommand cmd = new SqlCommand("addToCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@customername", username));
            cmd.Parameters.Add(new SqlParameter("@serial", serial_no));

            //check
            SqlCommand cmd2 = new SqlCommand("checkInCart", conn);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.Add(new SqlParameter("@customername", username));
            cmd2.Parameters.Add(new SqlParameter("@serial", serial_no));

            //Save the output from the procedure
            SqlParameter flag = cmd2.Parameters.Add("@flag", SqlDbType.Bit);
            flag.Direction = ParameterDirection.Output;
            conn.Open();
            cmd2.ExecuteNonQuery();
            conn.Close();
            Boolean alreadyAdded = (Boolean)flag.Value;

            //Executing the SQLCommand
            if (alreadyAdded)
            {
                message.Text = "Product already in cart";
            }
            else
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                message.Text = "Product added to cart";
            }
        }

        protected void removeFromCart_clicked(object sender, EventArgs e)
        {
            Button b = (Button)sender;
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string username = (string)(Session["username"]);
            string serial_no = (string)b.ID;
            serial_no = serial_no.Substring(1);

            SqlCommand cmd = new SqlCommand("removefromCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@customername", username));
            cmd.Parameters.Add(new SqlParameter("@serial", serial_no));

            //check
            SqlCommand cmd2 = new SqlCommand("checkInCart", conn);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.Add(new SqlParameter("@customername", username));
            cmd2.Parameters.Add(new SqlParameter("@serial", serial_no));

            //Save the output from the procedure
            SqlParameter flag = cmd2.Parameters.Add("@flag", SqlDbType.Bit);
            flag.Direction = ParameterDirection.Output;
            conn.Open();
            cmd2.ExecuteNonQuery();
            conn.Close();
            Boolean alreadyAdded = (Boolean)flag.Value;

            //Executing the SQLCommand
            if (!alreadyAdded)
            {
                message.Text = "Product is not in cart";
            }
            else
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                message.Text = "Product removed from cart";
            }
        }

        protected void addToWishlist_clicked(object sender, EventArgs e)
        {
            Button b = (Button)sender;
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string username = (string)(Session["username"]);
            string serial_no = (string)b.ID;
            serial_no = serial_no.Substring(1);
            string ser = "w" + serial_no;
            string wishlistName = ((TextBox)form1.FindControl(ser)).Text;

            SqlCommand cmd = new SqlCommand("AddtoWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@customername", username));
            cmd.Parameters.Add(new SqlParameter("@wishlistname", wishlistName));
            cmd.Parameters.Add(new SqlParameter("@serial", serial_no));

            //check
            SqlCommand cmd3 = new SqlCommand("checkWishlist", conn);
            cmd3.CommandType = CommandType.StoredProcedure;
            cmd3.Parameters.Add(new SqlParameter("@customername", username));
            cmd3.Parameters.Add(new SqlParameter("@wishlistname", wishlistName));

            //Save the output from the procedure
            SqlParameter flag1 = cmd3.Parameters.Add("@flag", SqlDbType.Bit);
            flag1.Direction = ParameterDirection.Output;
            conn.Open();
            cmd3.ExecuteNonQuery();
            conn.Close();
            Boolean wishlistExists = (Boolean)flag1.Value;

            SqlCommand cmd2 = new SqlCommand("checkInWishlist", conn);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.Add(new SqlParameter("@customername", username));
            cmd2.Parameters.Add(new SqlParameter("@wishlistname", wishlistName));
            cmd2.Parameters.Add(new SqlParameter("@serial", serial_no));

            //Save the output from the procedure
            SqlParameter flag = cmd2.Parameters.Add("@flag", SqlDbType.Bit);
            flag.Direction = ParameterDirection.Output;
            Boolean alreadyAdded = false;

            if (wishlistExists)
            {
                conn.Open();
                cmd2.ExecuteNonQuery();
                conn.Close();
                alreadyAdded = (Boolean)flag.Value;
            }

            //Executing the SQLCommand
            if (!wishlistExists)
            {
                message.Text = "Wishlist does not exist";
            }
            else if (alreadyAdded)
            {
                message.Text = "Product already in wishlist";
            }
            else
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                message.Text = "Product added to wishlist";
            }
        }

        protected void removeFromWishlist_clicked(object sender, EventArgs e)
        {
            Button b = (Button)sender;
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            string username = (string)(Session["username"]);
            string serial_no = (string)b.ID;
            serial_no = serial_no.Substring(1);
            string ser = "w" + serial_no;
            string wishlistName = ((TextBox)form1.FindControl(ser)).Text;

            SqlCommand cmd = new SqlCommand("removefromWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@customername", username));
            cmd.Parameters.Add(new SqlParameter("@wishlistname", wishlistName));
            cmd.Parameters.Add(new SqlParameter("@serial", serial_no));

            //check
            SqlCommand cmd3 = new SqlCommand("checkWishlist", conn);
            cmd3.CommandType = CommandType.StoredProcedure;
            cmd3.Parameters.Add(new SqlParameter("@customername", username));
            cmd3.Parameters.Add(new SqlParameter("@wishlistname", wishlistName));

            //Save the output from the procedure
            SqlParameter flag1 = cmd3.Parameters.Add("@flag", SqlDbType.Bit);
            flag1.Direction = ParameterDirection.Output;
            conn.Open();
            cmd3.ExecuteNonQuery();
            conn.Close();
            Boolean wishlistExists = (Boolean)flag1.Value;

            SqlCommand cmd2 = new SqlCommand("checkInWishlist", conn);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.Add(new SqlParameter("@customername", username));
            cmd2.Parameters.Add(new SqlParameter("@wishlistname", wishlistName));
            cmd2.Parameters.Add(new SqlParameter("@serial", serial_no));

            //Save the output from the procedure
            SqlParameter flag = cmd2.Parameters.Add("@flag", SqlDbType.Bit);
            flag.Direction = ParameterDirection.Output;
            Boolean alreadyAdded = false;

            if (wishlistExists)
            {
                conn.Open();
                cmd2.ExecuteNonQuery();
                conn.Close();
                alreadyAdded = (Boolean)flag.Value;
                if (!alreadyAdded)
                {
                    message.Text = "Product not in wishlist";
                }
                else
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    message.Text = "Product removed from wishlist";
                }
            }

            else
            {
                message.Text = "Wishlist does not exist";
            }
        

        }
    }
}