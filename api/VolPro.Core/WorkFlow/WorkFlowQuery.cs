using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VolPro.Entity.DomainModels;

namespace VolPro.Core.WorkFlow
{
    public static class WorkFlowQuery
    {
        public static IQueryable<Detail> FlowQuery<Detail>(this IQueryable<Detail> query) where Detail : class
        {
            if (typeof(Detail) == typeof(Demo_OrderList))
            { 
                return ((IQueryable<Demo_OrderList>)query).OrderByDescending(x => x.CreateDate) as IQueryable<Detail>;
            }
            return query;
        }
    }
}
