using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Delivery.Models
{
    public class Dhs_DaNhanManager
    {
        private readonly Repository<DonHang> _dhs_daNhanRepository;
        public Dhs_DaNhanManager()
        {
            _dhs_daNhanRepository = new Repository<DonHang>();
        }

        public IEnumerable<DonHang> GetAllDhs_DaNhan()
        {
            return _dhs_daNhanRepository.GetAll().Where(dh => dh.TrangThai == 2);
        }

        public DonHang GetDhs_DaNhanById(int id)
        {
            return _dhs_daNhanRepository.GetById(id);
        }

        public void ConfirmDhs_DaNhan(int id, int nhanVienPhanPhoi,int nhanVienGiaoHang)
        {
            var dh = _dhs_daNhanRepository.GetById(id);
            if (dh != null)
            {
                dh.TrangThai = 3;
                dh.NhanVienPhanPhoi = nhanVienPhanPhoi;
                dh.NhanVienGiao = nhanVienGiaoHang;
                dh.ThoiGianPhanPhoi = DateTime.Now;
                _dhs_daNhanRepository.SaveChange();
            }
        }
    }
}