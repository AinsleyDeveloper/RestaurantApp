using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantApp.Models
{
   public class Reservation
    {
        public int ReservationId { get; set; }
        public string CustomerFirstName { get; set; }
        public string CustomerLastName { get; set; }
        public string CellNumber { get; set; }
        public DateTime DateTime { get; set; }
        public int TableId { get; set; }
    }
}
