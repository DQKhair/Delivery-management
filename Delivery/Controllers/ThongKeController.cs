using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Delivery.Models;

namespace Delivery.Controllers
{
    public class ThongKeController : BaseController
    {
        GiaoHangEntities db = new GiaoHangEntities();

        //GET: ThongKe
        public ActionResult Index() 
        {
            return View(); 
        }

        // GET: ThongKe/ThongKe
        //Đơn đã nhận
        public ActionResult ThongKe()
        {
            ViewBag.Year = new SelectList(db.ThongKe_LayNam1(), "Nam");
            ViewBag.Month = new SelectList(db.ThongKe_LayThang1(), "Thang");
            return View();
        }

        public JsonResult GetChart(int year, int month)
        {
            var result = db.ThongKe_DaNhan1(year, month).ToList();
            return Json(result, JsonRequestBehavior.AllowGet);
        }

        // GET: ThongKe/DonDaGiao
        //Đơn đã giao
        public ActionResult ThongKeDonDaGiao()
        {
            ViewBag.Year = new SelectList(db.ThongKeDonDaGiao_LayNam(), "Nam");
            ViewBag.Month = new SelectList(db.ThongKeDonDaGiao_LayThang(), "Thang");
            return View();
        }

        public JsonResult Chart(int year, int month)
        {
            var result = db.ThongKeDonDaGiao(year, month).ToList();
            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}