using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Delivery
{
    public class CreateNhanVien
    {
        
        public string TenNhanVien { get; set; }
        public Nullable<DateTime> NgaySinh { get; set; }
        public string SoDienThoai { get; set; }
        public int ChucVu { get; set; }
        public string Email { get; set; }
        public byte[] AnhDaiDien { get; set; }
    }
}