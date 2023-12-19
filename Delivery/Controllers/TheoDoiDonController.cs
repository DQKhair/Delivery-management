using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using System.Net;
using Delivery.Models;
using PagedList;

namespace Delivery.Controllers
{
    public class TheoDoiDonController : BaseController
    {
        GiaoHangEntities db = new GiaoHangEntities();
        // GET: TheoDoiDon
        public ActionResult Index(string searchString,int? page)
        {
            if (page == null) page = 1;
            var listDH = db.DonHang_TimKiemTheoTenNG(null).OrderBy(s => s.MaDonHang).ToList();
            int pageSize = 10;
            //Toán tử ?? trong C# mô tả nếu page khác null thì lấy giá trị page, còn
            // nếu page = null thì lấy giá trị 1 cho biến pageNumber.
            int pageNumber = (page ?? 1);
            if (!String.IsNullOrEmpty(searchString))
            {
                searchString = searchString.ToLower();
                var listDHSearch = db.DonHang_TimKiemTheoTenNG(searchString).OrderBy(s => s.MaDonHang).ToList();
                return View(listDHSearch.ToPagedList(pageNumber, pageSize));
            }
            return View(listDH.ToPagedList(pageNumber, pageSize));
        }
        public ActionResult Details(int? id)
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
    }
}