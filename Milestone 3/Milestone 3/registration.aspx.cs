using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone_3
{
    public partial class registration1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void vendor_button_Click(object sender, EventArgs e)
        {
            Response.Redirect("vendor_registration.aspx");
        }

        protected void customer_button_Click(object sender, EventArgs e)
        {
            Response.Redirect("customer_registration.aspx");
        }
    }
}