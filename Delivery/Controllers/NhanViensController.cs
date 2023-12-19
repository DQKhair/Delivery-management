using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Drawing.Printing;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Delivery.Common;
using Delivery.Models;
using PagedList;

namespace Delivery.Controllers
{
    public class NhanViensController : BaseController
    {
        private GiaoHangEntities db = new GiaoHangEntities();
        // GET: NhanViens
        public ActionResult Index(string sortOrder, string MaNV, string tenNV, string khuvuc)
        {
            if (!String.IsNullOrEmpty(MaNV))
            {
                int maNV = Convert.ToInt32(MaNV);
                var listNVSearch = db.NhanVien_TimKiem(maNV, null, null);
                return View(listNVSearch.ToList());
            }
            else if (!String.IsNullOrEmpty(tenNV))
            {
                var listNVSearch = db.NhanVien_TimKiem(null, tenNV, null);
                return View(listNVSearch.ToList());
            }
            else if (!String.IsNullOrEmpty(khuvuc))
            {
                var listNVSearch = db.NhanVien_TimKiem(null, null, khuvuc);
                return View(listNVSearch.ToList());
            }

            var ListNV = db.NhanVien_TimKiem(null, null, null);
            return View(ListNV.ToList());
        }


        //GET: NhanViens/Create
        public ActionResult Create()
        {
            ViewBag.MaKhuVuc = new SelectList(db.NhanVien_KhuVuc(), "MaKhuVuc", "TenKhuVuc");
            return View();
        }

        // POST: NhanViens/Create
        [HttpPost]
        [ValidateAntiForgeryToken]

        public ActionResult Create(NhanVien_ChuaTK_Result nhanVien)
        {
            if (ModelState.IsValid)
            {
                var test = db.NhanVien_Add(nhanVien.TenNhanVien, nhanVien.NgaySinh, nhanVien.Email, nhanVien.SoDienThoai, nhanVien.MaKhuVuc).SingleOrDefault();
                if (test != "Hợp lệ")
                {
                    ModelState.AddModelError("CreateFailed", test);
                }
                else
                {
                    TempData["SuccessMessage"] = "Thêm thành công";
                    return RedirectToAction("Index");
                }
            }
            ViewBag.MaKhuVuc = new SelectList(db.NhanVien_KhuVuc(), "MaKhuVuc", "TenKhuVuc", nhanVien.MaKhuVuc);
            return View(nhanVien);
        }

        // GET: NhanViens/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == 1)
            {
                return new HttpStatusCodeResult(HttpStatusCode.Forbidden);
            }
            else
            {
                var nhanVien = db.NhanVien_Xoa_ChiTiet(id).Single();
                ViewBag.XoaNhanVien = nhanVien;
                return View();
            }
        }

        // POST: NhanViens/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id)
        {
            var result = db.NhanVien_Xoa(id).SingleOrDefault();
            if (result > 0)
            {
                TempData["SuccessMessage"] = "Xóa thành công";
            }
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                database.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
