using System;
using System.Data;
using System.Configuration;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Serialization;

using Stiig;

/// <summary>
/// Summary description for Settings
/// </summary>

namespace Stiig
{
    public static class Settings
    {
        //public static T GetSetting<T>(string key)
        //{
        //    T setting = default(T);
        //    DataAccessLayer dal = new DataAccessLayer();

        //    dal.AddParameter("@Key", key, DbType.String);
        //    int count = (int)dal.ExecuteScalar("SELECT COUNT(*) FROM Settings WHERE [Key] = @Key");
        //    dal.ClearParameters();

        //    if (count != 0)
        //    {
        //        XmlSerializer serializer = new XmlSerializer(typeof(T));
        //        dal.AddParameter("@Key", key, DbType.String);
        //        setting = (T)serializer.Deserialize(new MemoryStream((byte[])dal.ExecuteScalar("SELECT Setting FROM Settings WHERE [Key] = @Key").ToString().ToCharArray()));
        //        dal.ClearParameters();
        //    }

        //    return setting;
        //}
        //public static void CreateSetting(string key)
        //{
        //    DataAccessLayer dal = new DataAccessLayer();

        //    dal.AddParameter("@Key", key, DbType.String);
        //    dal.ExecuteScalar("SELECT COUNT(*) FROM Settings WHERE [Key] = @Key");
        //    dal.ClearParameters();
        //}
    }
}