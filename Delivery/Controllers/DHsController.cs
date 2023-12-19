using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Delivery.Models;
namespace Delivery.Controllers
{
    public class DHsController : BaseController
    {
        private GiaoHangEntities db = new GiaoHangEntities();

        private readonly DHsManager _dHsManager;
        public DHsController()
        {
            _dHsManager = new DHsManager();
        }
        // Hiển thị danh sách đơn hàng chưa nhận
        public ActionResult Index()
        {
            var dhs = _dHsManager.GetAllDhs();
            return View(dhs);
        }

        // : Hiển thị chi tiết đơn hàng chưa nhận
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            //DonHang_Find_detail_Result dH = db.DonHang_Find_detail(id).SingleOrDefault();
            var dH = _dHsManager.GetDhsById((int)id);
            if (dH == null)
            {
                return HttpNotFound();
            }
            return View(dH);
        }

        // : Hiển thị chi tiết nhận đơn hàng
        public ActionResult NhanDon(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var dH = _dHsManager.GetDhsById((int)id);
            if (dH == null)
            {
                return HttpNotFound();
            }
            return View(dH);
        }

        // : Xử lý chi tiết nhận đơn hàng
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult NhanDon(int id)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var login_Session = (Account_Session_Result)Session[Common.CommonConstants.NGUOI_DUNG];
                    if(login_Session != null)
                    {
                        _dHsManager.ConfirmDhs(id, login_Session.MaNhanVien);
                        TempData["SuccessMessage"] = "Nhận đơn thành công";
                        return RedirectToAction("index");
                    }
                }
                return RedirectToAction("index");
            }
            catch
            {
                return HttpNotFound();
            }
            
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
