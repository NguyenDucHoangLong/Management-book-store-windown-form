using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLySach_VPP
{
    public partial class frmDangNhap : Form
    {
        QLSACH_VPPEntities1 db = new QLSACH_VPPEntities1();
        public frmDangNhap()
        {
            InitializeComponent();
        }

        private new string Validate()
        {
            if (string.IsNullOrEmpty(txtTenDangNhap.Text.Trim()))
                return "Tên đăng nhập không để trống.";
            if (string.IsNullOrEmpty(txtMatKhau.Text.Trim()))
                return "Mật khẩu không được để trống.";
            return "";
        }

        //Đăng nhập
        private void btnDangNhap_Click(object sender, EventArgs e)
        {
            string result = Validate();

            if (!string.IsNullOrEmpty(result))
            {
                MessageBox.Show(result, "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            try
            {
                var user = db.NguoiDungs.Where(nd => nd.TenDangNhap == txtTenDangNhap.Text
                && nd.MatKhau == txtMatKhau.Text).SingleOrDefault();

                if(user != null)
                {
                    this.Hide();
                    frmMain frmmain = new frmMain();
                    frmmain.ShowDialog();
                    this.Close();
                }
                else
                    MessageBox.Show("Tên đăng nhập hoặc mật khẩu không chính xác!!",
                        "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);


            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void txtMatKhau_KeyPress(object sender, KeyPressEventArgs e)
        {
            txtMatKhau.PasswordChar = '*';
        }
    }
}
