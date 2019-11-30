using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantApp.Models
{
    public class Table
    {
        public Table()
        {
        }

        public Table(int tableId, int tableNumber, int waiterId, bool isOpen)
        {
            TableId = tableId;
            TableNumber = tableNumber;
            WaiterId = waiterId;
            IsOpen = isOpen;
        }

        public int TableId { get; set; }
        public int TableNumber { get; set; }
        public int? WaiterId { get; set; }
        public bool IsOpen { get; set; }
    }
}
