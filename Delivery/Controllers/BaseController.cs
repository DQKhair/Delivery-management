using Delivery.Common;
using Delivery.Models;
using System.Web.Mvc;


namespace Delivery.Controllers
{
    public class BaseController : Controller
    {
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            //Kiểm tra phiên đăng nhập trách trường hợp người dùng tự ghi đường dẫn mà chưa đăng nhập
            var session = Session[CommonConstants.TEN_NGUOI_DUNG];
            if (session == null)
            {
                filterContext.Result = new RedirectResult("~/Account/Login");
            }

            base.OnActionExecuting(filterContext);
        }
        protected GiaoHangEntities database = new GiaoHangEntities();


    }
}