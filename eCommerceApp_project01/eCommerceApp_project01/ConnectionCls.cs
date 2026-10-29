using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace eCommerceApp_project01
{
    public class ConnectionCls
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;

        public ConnectionCls()
        {
            con = new SqlConnection(@"server=localhost\SQLEXPRESS;database=eCommerceApp_project01;Integrated Security = True;");
        }

        public int executeNonQuery(string qry)
        {
            if(con.State == ConnectionState.Open)
            {
                con.Close();
            }

            cmd = new SqlCommand(qry,con);

            con.Open();
            int res = cmd.ExecuteNonQuery();
            con.Close();

            return res;
        }

        public string executeScalar(string qry)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            cmd = new SqlCommand(qry,con);

            con.Open();
            string res = cmd.ExecuteScalar().ToString();
            con.Close();

            return res;
        }

        public SqlDataReader executeReader(string qry)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            cmd = new SqlCommand(qry, con);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            return dr;
        }

        public DataSet executeDataSet(string qry)
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

            da = new SqlDataAdapter(qry, con);
            DataSet ds = new DataSet();

            da.Fill(ds);

            return ds;
        }

        public DataTable executeDataTable(string qry)
        {
            if(con.State == ConnectionState.Open)
            {
                con.Close();
            }

            da = new SqlDataAdapter(qry,con);
            DataTable dt = new DataTable();

            da.Fill(dt);

            return dt;
        }
    }
}