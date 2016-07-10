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
    public partial class frmQLSanPham : Form
    {

        readonly QLSACH_VPPEntities2 db = new QLSACH_VPPEntities2();

        public frmQLSanPham()
        {
            InitializeComponent();
        }

        private void frmQLSanPham_Load(object sender, EventArgs e)
        {
            LoadGrid();
        }

        //Load dữ liệu từ database lên datagridview
        private void LoadGrid()
        {
            //Load dữ liệu từ database dùng entity framework đưa vào list
            var lstSanPham = from sanpham in db.SanPhams
                             select new
                             {
                                 sanpham.MaSanPham,
                                 sanpham.TenSanPham,
                                 sanpham.NhaSanXuat,
                                 sanpham.TacGia,
                                 sanpham.SoLuong,
                                 sanpham.GiaBan,
                                 sanpham.DanhMuc.TenDanhMuc
                             };
            dtgvSanPham.DataSource = lstSanPham.ToList();

            //Set tiêu đề và kích thước cho các cột trong datagridview
            dtgvSanPham.Columns[0].HeaderText = "Mã sản phẩm";
            dtgvSanPham.Columns[1].HeaderText = "Tên sản phẩm";
            dtgvSanPham.Columns[2].HeaderText = "Nhà sản xuất";
            dtgvSanPham.Columns[3].HeaderText = "Tác giả";
            dtgvSanPham.Columns[4].HeaderText = "Số lượng";
            dtgvSanPham.Columns[5].HeaderText = "Giá bán";
            dtgvSanPham.Columns[6].HeaderText = "Danh mục";

            cbxDanhMuc.DataSource = (from danhmuc in db.DanhMucs
                                     select danhmuc.TenDanhMuc).ToList();

        }

        //Kiểm tra dữ liệu rỗng trước khi thêm
        private new string Validate()
        {
            int Gia;
            bool isSoLuong = int.TryParse(txtGia.Text.Trim(), out Gia);
            if (string.IsNullOrEmpty(txtMaSanPham.Text.Trim()))
                return "Mã sản phẩm không được trống";
            if (string.IsNullOrEmpty(txtTenSanPham.Text.Trim()))
                return "Tên sản phẩm không được trống";
            if (string.IsNullOrEmpty(txtSoLuong.Text.Trim()))
                return "Số lượng không được trống";
            if (string.IsNullOrEmpty(txtGia.Text.Trim()))
                return "Giá sản phẩm không được để trống";
            return "";
        }

        //Chỉ cho nhập số trong textbox
        private void txtSoLuong_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar) &&
                (e.KeyChar != '.'))
            {
                e.Handled = true;
            }

            if ((e.KeyChar == '.') && ((sender as TextBox).Text.IndexOf('.') > -1))
            {
                e.Handled = true;
            }
        }

        //Chỉ cho nhập số trong textbox
        private void txtGia_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar) &&
                (e.KeyChar != '.'))
            {
                e.Handled = true;
            }

            if ((e.KeyChar == '.') && ((sender as TextBox).Text.IndexOf('.') > -1))
            {
                e.Handled = true;
            }
        }

        //Khi click vào một ô của dataGridView thì sẽ load dữ liệu lên textbox
        private void dtgvSanPham_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int id = e.RowIndex;
            if (id < 0)
                return;
            txtMaSanPham.Text = Convert.ToString(dtgvSanPham[0, id].Value);
            txtTenSanPham.Text = Convert.ToString(dtgvSanPham[1, id].Value);
            txtNhaSanXuat.Text = Convert.ToString(dtgvSanPham[2, id].Value);
            txtTacGia.Text = Convert.ToString(dtgvSanPham[3, id].Value);
            txtGia.Text = Convert.ToString(dtgvSanPham[5, id].Value);
            txtSoLuong.Text = Convert.ToString(dtgvSanPham[4, id].Value);
            cbxDanhMuc.Text = Convert.ToString(dtgvSanPham[6, id].Value);
        }

        //Thêm sản phẩm
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
                int wMaSanPham = 0;
                Boolean wResult = Int32.TryParse(txtMaSanPham.Text, out wMaSanPham);
                if(wResult)
                {
                    var sanpham = new SanPham
                    {
                        MaSanPham = wMaSanPham,
                        TenSanPham = txtTenSanPham.Text,
                        NhaSanXuat = txtNhaSanXuat.Text,
                        TacGia = txtTacGia.Text,
                        SoLuong = int.Parse(txtSoLuong.Text),
                        GiaBan = int.Parse(txtGia.Text)
    ,
                        MaDanhMuc = (from danhmuc in db.DanhMucs
                                     where danhmuc.TenDanhMuc == cbxDanhMuc.Text
                                     select danhmuc.MaDanhMuc).SingleOrDefault()
                    };

                    //Kiểm tra trong database đã có dữ liệu chưa, nếu chưa có thì thêm vào
                    if (db.SanPhams.Find(sanpham.MaSanPham) == null)
                    {
                        db.SanPhams.Add(sanpham);
                        db.SaveChanges();
                        MessageBox.Show("Thêm thành công", "Thông báo",
    MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    else
                    {
                        MessageBox.Show("Sản phẩm đã tồn tại", "Thông báo",
                            MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            };
            LoadGrid();

        }

        //Cập nhật sản phẩm
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
                int wMaSanPham = 0;
                Boolean wResult = Int32.TryParse(txtMaSanPham.Text, out wMaSanPham);
                if (wResult)
                {
                    if(wMaSanPham == 0)
                    {
                        return;
                    }
                    var sanpham = db.SanPhams.Find(wMaSanPham);
                    if (sanpham != null)
                    {
                        sanpham.TenSanPham = txtTenSanPham.Text;
                        sanpham.NhaSanXuat = txtNhaSanXuat.Text;
                        sanpham.TacGia = txtTacGia.Text;
                        sanpham.SoLuong = int.Parse(txtSoLuong.Text);
                        sanpham.GiaBan = float.Parse(txtGia.Text);
                        sanpham.MaDanhMuc = (from danhmuc in db.DanhMucs
                                             where danhmuc.TenDanhMuc == cbxDanhMuc.Text
                                             select danhmuc.MaDanhMuc).SingleOrDefault();
                        db.SaveChanges();
                        MessageBox.Show("Cập nhật thành công", "Thông báo",
    MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    else
                    {
                        MessageBox.Show("Không cập nhật được!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            LoadGrid();
        }

        //Xóa sản phẩm
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
                int wMaSanPham = 0;
                Boolean wResult = Int32.TryParse(txtMaSanPham.Text, out wMaSanPham);
                if (wResult)
                {
                    if (wMaSanPham == 0)
                    {
                        return;
                    }
                    var sanpham = db.SanPhams.Find(wMaSanPham);
                    if (sanpham != null)
                    {
                        db.SanPhams.Remove(sanpham);
                        db.SaveChanges();
                        MessageBox.Show("Xóa sản phẩm thành công", "Thông báo",
                            MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                    else
                        MessageBox.Show("Không xóa được, vui lòng thử lại!!",
                            "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            LoadGrid();
        }

        //Filter sản phẩm theo tên danh mục
        private void btnTimKiem_Click(object sender, EventArgs e)
        {
            try
            {
                var lstSanPham = db.SanPhams
                    .Where(sanpham => sanpham.DanhMuc.TenDanhMuc == cbxDanhMuc.Text.ToString())
                    .ToList();

                if(lstSanPham != null)
                {
                    dtgvSanPham.DataSource = lstSanPham;
                }
                else
                    MessageBox.Show("Không tìm thấy!!",
                        "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
