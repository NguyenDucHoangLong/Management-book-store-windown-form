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
    public partial class frmMain : Form
    {
        public frmMain()
        {
            InitializeComponent();
        }

        private void quảnLýDanhMụcToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmQLDanhMuc frmqlDanhMuc = new frmQLDanhMuc();
            frmqlDanhMuc.MdiParent = this;
            frmqlDanhMuc.Show();
        }

        private void quảnLýSảnPhẩmToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmQLSanPham frmqlSanPham = new frmQLSanPham();
            frmqlSanPham.MdiParent = this;
            frmqlSanPham.Show();
        }

        private void đăngXuấtToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Hide();
            frmDangNhap frmDnhap = new frmDangNhap();
            frmDnhap.ShowDialog();
            this.Close();
        }

        private void quảnLýHóaĐơnToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmQLHoaDon frmQLHoaDon = new frmQLHoaDon();
            frmQLHoaDon.MdiParent = this;
            frmQLHoaDon.Show();
        }
    }
}
