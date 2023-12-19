using Delivery.Common;
using Delivery.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.EnterpriseServices.CompensatingResourceManager;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using System.Xml.Linq;

namespace Delivery.Controllers
{
    public class ProfileController : BaseController
    {
        // GET: Profile
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ProfileView()
        {

            var nguoidung = Session[CommonConstants.NGUOI_DUNG] as Account_Session_Result;

            int id = nguoidung.MaNhanVien;
            var ListProduct = database.Profile_Get(id).SingleOrDefault();


            Session.Add(CommonConstants.Hinh_anh, ListProduct);
            if (ListProduct == null)
            {

                return HttpNotFound();
            }
            ViewBag.sua = ListProduct;

            return View();
        }


        [HttpPost]
        public ActionResult ProfileView(HttpPostedFileBase anhdaidien, DateTime ngaysinh)
        {
            var id = int.Parse(Request.Form["id"]);
            var name = Request.Form["tennhanvien"];
            var email = Request.Form["email"];
            string sdt = (string)Request.Form["sodienthoai"];

            var ImageExtension = Request.Form["ImageExtension"];
            byte[] buffer = null;
            if (anhdaidien != null)
            {
                if (string.IsNullOrEmpty(ImageExtension))
                {
                    ModelState.AddModelError("ImageExtension", "Đuôi ảnh không được để trống");
                }
                else
                {
                    MemoryStream memoryStream = new MemoryStream();
                    anhdaidien.InputStream.CopyTo(memoryStream);
                    buffer = memoryStream.ToArray();
                }

            }

            // Kiểm tra các ô input không được để trống
            if (string.IsNullOrEmpty(name))
            {
                ModelState.AddModelError("tennhanvien", "Tên nhân viên không được để trống.");
            }

            if (ngaysinh == null)
            {
                ModelState.AddModelError("ngaysinh", "Ngày sinh không được để trống.");
            }

            if (string.IsNullOrEmpty(email))
            {
                ModelState.AddModelError("email", "Email không được để trống.");
            }
            else
            {
                // Kiểm tra mật khẩu có đủ điều kiện
                string pattern = "^[A-Za-z0-9]+[A-Za-z0-9]*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)+$";
                Regex regex = new Regex(pattern);
                if (!regex.IsMatch(email))
                {
                    ModelState.AddModelError("email", "Email không hợp lệ.");
                }
            }


            if (string.IsNullOrEmpty(sdt))
            {
                ModelState.AddModelError("sodienthoai", "Số điện thoại không được để trống.");
            }
            else
            {
                // Kiểm tra mật khẩu có đủ điều kiện
                string pattern = "^[0-9]{9,11}$";
                Regex regex = new Regex(pattern);
                if (!regex.IsMatch(sdt))
                {
                    ModelState.AddModelError("sodienthoai", "Số điện thoại phải có độ dài từ 9 đến 11 số");
                }
            }


            // Kiểm tra xem có lỗi hay không
            if (ModelState.IsValid)
            {
                // Tiến hành lưu thông tin
                var result = database.Profile_Sua(id, name, ngaysinh, email, sdt, buffer, ImageExtension);

                // Kiểm tra kết quả lưu thành công
                if (result != null)
                {
                    TempData["SuccessMessage"] = "Lưu thành công.";
                    //TempData["SuccessMessage"] = "success";
                }


                return RedirectToAction("ProfileView", new { id = id });
            }

            // Nếu có lỗi, gán giá trị lại vào ViewBag.sua và hiển thị lại View
            var nguoidung = Session[CommonConstants.NGUOI_DUNG] as Account_Session_Result;
            ViewBag.sua = database.Profile_Get(nguoidung.MaNhanVien).SingleOrDefault();
            return View();
        }

        public ActionResult DoiMk()
        {
            var nguoidung = Session[CommonConstants.NGUOI_DUNG] as Account_Session_Result;
            int id = nguoidung.MaNhanVien;
            var ListProduct = database.Profile_Get(id).SingleOrDefault();
            if (ListProduct == null)
            {
                return HttpNotFound();
            }
            ViewBag.sua = ListProduct;

            return View();
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DoiMk(int id, string MatKhau, string OldMatKhau)
        {
            var hashPass = database.Profile_Password(id).FirstOrDefault();
            if (PasswordOption.Validation(OldMatKhau, hashPass))
            {
                if (string.IsNullOrEmpty(MatKhau))
                {
                    ModelState.AddModelError("MatKhau", "Vui lòng nhập mật khẩu mới.");
                }
                else
                {
                    // Kiểm tra mật khẩu có đủ điều kiện
                    string pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
                    Regex regex = new Regex(pattern);
                    if (!regex.IsMatch(MatKhau))
                    {
                        ModelState.AddModelError("MatKhau", "Mật khẩu phải chứa ít nhất một chữ hoa, một chữ thường, một ký tự đặc biệt và một số. Độ dài tối thiểu là 8 ký tự.");
                    }
                }

                if (ModelState.IsValid)
                {
                    var result = database.TaiKhoan_DoiMK(id, PasswordOption.Encrypt(MatKhau)).Single();
                    if (result != null)
                    {
                        TempData["SuccessMessage"] = "Đổi mật khẩu thành công";
                    }
                    return Redirect("~/Profile/ProfileView/" + id);
                }
            }
            else
            {
                ModelState.AddModelError("OldMatKhau", "Vui lòng kiểm tra lại mật khẩu.");
            }

            var nguoidung = Session[CommonConstants.NGUOI_DUNG] as Account_Session_Result;
            ViewBag.sua = database.Profile_Get(nguoidung.MaNhanVien).SingleOrDefault();
            return View();
        }
    }
}