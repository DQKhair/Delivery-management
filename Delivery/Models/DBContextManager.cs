using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Delivery.Models
{
    public sealed class DBContextManager
    {
        private static DBContextManager _instance;
        private GiaoHangEntities _dbContext;
        private static readonly object _lock = new object();

        private  DBContextManager() 
        {
                _dbContext = new GiaoHangEntities();
        }

        public static DBContextManager Instance
        {
            get { 

                if(_instance == null)
                {
                    lock(_lock)
                    {
                        if(_instance == null)
                        {
                            _instance = new DBContextManager();
                        }
                    }
                }    
                return _instance;
            }
        }

        public GiaoHangEntities GetDbContext()
        {
            return _dbContext;
        }
    }
}