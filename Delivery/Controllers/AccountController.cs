using Delivery.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.InteropServices;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using Delivery.Models;
using Delivery.Entities;

namespace Delivery.Controllers
{
    public class AccountController : Controller
    {
        GiaoHangEntities db = new GiaoHangEntities();

        //Đăng nhập
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(AccountLogin taiKhoan)
        {
            string username = taiKhoan.TenTaiKhoan;
            string password = taiKhoan.MatKhau;
            //LOGIN: PROCESSING...
            if (ModelState.IsValid && username != null && password != null)
            {
                var hashPass = db.Account_Password(username).FirstOrDefault();
                if (PasswordOption.Validation(password, hashPass))
                {
                    var check = db.Account_Session(username).Single();
                    var layChucNang = db.MenuOf(check.MaNhanVien).ToList();
                    Session.Add(CommonConstants.TEN_NGUOI_DUNG, db.TaiKhoan_LayTen(check.MaNhanVien).SingleOrDefault());
                    Session.Add(CommonConstants.Hinh_anh, db.Profile_Get(check.MaNhanVien).SingleOrDefault());
                    Session.Add(CommonConstants.NGUOI_DUNG, check);
                    Session.Add(CommonConstants.CHUC_NANG, layChucNang);

                    return RedirectToAction("Index", "Home");

                }
                else
                {
                    ModelState.AddModelError("", "Tài khoản hoặc mật khẩu không đúng !");
                    return View("Login");
                }
            }
            else
            {
                ModelState.AddModelError("", "Chưa nhập tài khoản hoặc mật khẩu !");
                return View("Login");
            }
        }
        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Login");
        }
    }
}