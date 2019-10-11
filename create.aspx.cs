using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Stiig;

public partial class create : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {
            DataAccessLayer dal = new DataAccessLayer();

            FileInfo file = new FileInfo(FileUpload1.FileName);

            FileUpload1.SaveAs(Server.MapPath(@".\images\users\") + TextBox1.Text + file.Extension.ToLower());
            dal.AddParameter("@personName", TextBox1.Text, System.Data.DbType.String);
            dal.AddParameter("@personIsFemale", RadioButtonList1.SelectedValue, System.Data.DbType.Boolean);
            dal.AddParameter("@personPicName", TextBox1.Text + file.Extension.ToLower(), System.Data.DbType.String);
            dal.ExecuteScalar("INSERT INTO persons (personName, personIsFemale, personNumberShown, personPoint, personPicName, personNumberFairShows) VALUES(@personName, @personIsFemale, 0, 0, @personPicName, 0)");
            dal.ClearParameters();

            TextBox1.Text = "";
            RadioButtonList1.ClearSelection();
            Response.Write("Personen blev oprettet");
        }
        else
        {
            Response.Write("Der var ingen fil!");
        }
    }
}