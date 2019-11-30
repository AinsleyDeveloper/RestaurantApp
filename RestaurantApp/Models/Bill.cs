using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantApp.Models
{
    public class Bill
    {
        public Bill()
        {
        }

        public Bill(int billId, int itemId, int tableId, int waiterId, DateTime purchaseDate, bool settled)
        {
            BillId = billId;
            ItemId = itemId;
            TableId = tableId;
            WaiterId = waiterId;
            PurchaseDate = purchaseDate;
            Settled = settled;
        }

        public int BillId { get; set; }
        public int ItemId { get; set; }
        public int TableId { get; set; }
        public int WaiterId { get; set; }
        public DateTime PurchaseDate { get; set; }
        public bool Settled { get; set; }
    }
}
