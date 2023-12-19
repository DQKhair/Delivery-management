using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Delivery.Models
{
    public class DHsManager
    {
        private readonly IRepository<DonHang> _dhRepository;

        public DHsManager()
        {
            _dhRepository = new Repository<DonHang>();
        }
        public IEnumerable<DonHang> GetAllDhs()
        {
            return _dhRepository.GetAll().Where(dh => dh.TrangThai == 1);
        }

        public DonHang GetDhsById(int id)
        {
            return _dhRepository.GetById(id);
        }

        public void ConfirmDhs(int id,int maNhanVien)
        {
            var dh = _dhRepository.GetById(id);
            if (dh != null)
            {
                dh.TrangThai = 2;
                dh.NhanVienNhan = maNhanVien;
                dh.ThoiGianNhan = DateTime.Now;
                _dhRepository.SaveChange();
            }
        }
    }
}