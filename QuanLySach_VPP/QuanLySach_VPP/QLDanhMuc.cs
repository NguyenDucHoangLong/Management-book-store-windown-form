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
    public partial class frmQLDanhMuc : Form
    {
        readonly QLSACH_VPPEntities2 db = new QLSACH_VPPEntities2();

        public frmQLDanhMuc()
        {
            InitializeComponent();
        }

        private void frmQLDanhMuc_Load(object sender, EventArgs e)
        {
            //Load dữ liệu lên dataGridView
            LoadGrid();
        }

        //Load dữ liệu từ database lên datagridview
        private void LoadGrid()
        {
            //Load dữ liệu từ database dùng entity framework đưa vào list
            var lstDanhMuc = from danhmuc in db.DanhMucs
                             select new
                             {
                                 danhmuc.MaDanhMuc,
                                 danhmuc.TenDanhMuc,
                                 danhmuc.MoTa
                             };
            dtgvDanhMuc.DataSource = lstDanhMuc.ToList();

            //Set tiêu đề và kích thước cho các cột trong datagridview
            dtgvDanhMuc.Columns[0].AutoSizeMode = DataGridViewAutoSizeColumnMode.DisplayedCells;
            dtgvDanhMuc.Columns[0].HeaderText = "Mã danh mục";
            dtgvDanhMuc.Columns[1].AutoSizeMode = DataGridViewAutoSizeColumnMode.DisplayedCells;
            dtgvDanhMuc.Columns[1].HeaderText = "Tên danh mục";
            dtgvDanhMuc.Columns[2].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dtgvDanhMuc.Columns[2].HeaderText = "Mô tả danh mục";
        }

        //Kiểm tra dữ liệu rỗng trước khi thêm
        private new string Validate()
        {
            if (string.IsNullOrEmpty(txtMaDanhMuc.Text.Trim()))
                return "Mã danh mục không được trống";
            if (string.IsNullOrEmpty(txtTenDanhMuc.Text.Trim()))
                return "Tên danh mục không được trống";
            if (string.IsNullOrEmpty(txtMoTaDanhMuc.Text.Trim()))
                return "Mô tả danh mục không được trống";
            return "";
        }

        //Thêm danh mục
        private void btnThem_Click(object sender, EventArgs e)
        {
            string result = Validate();

            if (!string.IsNullOrEmpty(result))
            {
                MessageBox.Show(result, "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            try
            {
                int wMaDanhMuc = 0;
                Boolean wResult = Int32.TryParse(txtMaDanhMuc.Text.ToString(), out wMaDanhMuc);
                if(wResult == true)
                {
                    var danhmuc = new DanhMuc
                    {
                        MaDanhMuc = wMaDanhMuc,
                        TenDanhMuc = txtTenDanhMuc.Text.ToString(),
                        MoTa = txtMoTaDanhMuc.Text.ToString()
                    };

                    //Kiêm tra đã có Tên danh mục trong dữ liệu chưa, nếu chưa có thì thêm vào database
                    if (db.DanhMucs.Where(dm => dm.MaDanhMuc == danhmuc.MaDanhMuc || dm.TenDanhMuc == danhmuc.TenDanhMuc).ToList().Count == 0)
                    {
                        db.DanhMucs.Add(danhmuc);
                        db.SaveChanges();
                        MessageBox.Show("Thêm thành công", "Thông báo",
    MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    else
                    {
                        MessageBox.Show("Danh mục đã tồn tại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }

                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            };
            LoadGrid();
        }

        //Khi click vào một ô của dataGridView thì sẽ load dữ liệu lên textbox
        private void dtgvDanhMuc_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int id = e.RowIndex;
            if (id < 0)
                return;
            txtMaDanhMuc.Text = Convert.ToString(dtgvDanhMuc[0, id].Value);
            txtTenDanhMuc.Text = Convert.ToString(dtgvDanhMuc[1, id].Value);
            txtMoTaDanhMuc.Text = Convert.ToString(dtgvDanhMuc[2, id].Value);
        }

        //Cập nhập thông tin danh mục
        private void btnCapNhat_Click(object sender, EventArgs e)
        {
            string result = Validate();
            if (!string.IsNullOrEmpty(result))
            {
                MessageBox.Show(result, "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            try
            {
                int wMaDanhMuc = 0;
                Boolean wResult = Int32.TryParse(txtMaDanhMuc.Text.ToString(), out wMaDanhMuc);
                if (wResult == true)
                {
                    if (wMaDanhMuc == 0)
                        return;

                    var danhmuc = db.DanhMucs.Find(wMaDanhMuc);
                    if (danhmuc != null)
                    {
                        danhmuc.TenDanhMuc = txtTenDanhMuc.Text;
                        danhmuc.MoTa = txtMoTaDanhMuc.Text;
                        db.SaveChanges();
                        MessageBox.Show("Cập nhật thành công", "Thông báo",
                            MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    else
                    {
                        MessageBox.Show("Không cập nhật được!", "Thông báo",
                            MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            LoadGrid();
        }

        //Xóa danh mục
        private void btnXoa_Click(object sender, EventArgs e)
        {
            string result = Validate();
            if (!string.IsNullOrEmpty(result))
            {
                MessageBox.Show(result, "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            try
            {
                int wMaDanhMuc = 0;
                Boolean wResult = Int32.TryParse(txtMaDanhMuc.Text, out wMaDanhMuc);

                if(wResult)
                {
                    if (wMaDanhMuc == 0)
                        return;
                    var danhmuc = db.DanhMucs.Find(wMaDanhMuc);
                    var sanpham = db.SanPhams.Where(dm => dm.MaDanhMuc == wMaDanhMuc).ToList();
                    if (danhmuc != null && sanpham.Count == 0)
                    {
                        db.DanhMucs.Remove(danhmuc);
                        db.SaveChanges();
                        MessageBox.Show("Xóa danh mục thành công", "Thông báo",
                            MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    else
                        MessageBox.Show("Vui lòng xóa sản phẩm trong danh mục trước khi xóa danh mục",
                            "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            LoadGrid();
        }
    }
}
