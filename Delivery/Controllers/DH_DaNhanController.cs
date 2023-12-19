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
    public class DH_DaNhanController : BaseController
    {
        private GiaoHangEntities db = new GiaoHangEntities();

        private readonly Dhs_DaNhanManager _dHs_DaNhanManager;
        public DH_DaNhanController()
        {
            _dHs_DaNhanManager = new Dhs_DaNhanManager();
        }
        // GET: hiển thị danh sách đơn hàng đã nhận
        public ActionResult Index()
        {
            var dH_DaNhan = _dHs_DaNhanManager.GetAllDhs_DaNhan();
 
            return View(dH_DaNhan.ToList());
        }

        // GET: chi tiết đơn hàng đã nhận
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var dH = _dHs_DaNhanManager.GetDhs_DaNhanById((int)id);
            if (dH == null)
            {
                return HttpNotFound();
            }
            return View(dH);
        }

        //// : Chi tiết đơn hàng cần phân phối
        public ActionResult PhanPhoi(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var dH_PhanPhoi = _dHs_DaNhanManager.GetDhs_DaNhanById((int)id);
            ViewBag.MaNhanVien = new SelectList(db.DonHang_PhanPhoiSelectList_KhuVuc_NhanVien(dH_PhanPhoi.DiaChiQuan),"MaNhanVien", "TenNhanVien");
            if (dH_PhanPhoi == null)
            {
                return HttpNotFound();
            }
            return View(dH_PhanPhoi);
        }

        //// POST: Xử lý phân phối đơn hàng đã nhận
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult PhanPhoi(int id,int MaNhanVien)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var login_Session = (Account_Session_Result)Session[Common.CommonConstants.NGUOI_DUNG];
                    if (login_Session != null)
                    {
                        _dHs_DaNhanManager.ConfirmDhs_DaNhan(id, login_Session.MaNhanVien, MaNhanVien);
                        TempData["SuccessMessage"] = "Phân phối thành công";
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
        //list phân phối
        public ActionResult DanhSachPhanPhoiDonHang()
        {
            var ListDonHangPhanPhoi = db.DonHang_GetListDonHang(3);
            return View(ListDonHangPhanPhoi.ToList());
        }
        // chi tiết phân phối
        public ActionResult Details_PhanPhoi(int ? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DonHang_Find_detail_Result dH = db.DonHang_Find_detail(id).SingleOrDefault();
            if (dH == null)
            {
                return HttpNotFound();
            }
            return View(dH);
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
