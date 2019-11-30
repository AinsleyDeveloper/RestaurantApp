using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantApp.Models
{
    public class ReservationDisplayModel
    {
        public string Name { get; set; }
        public string CellNumber { get; set; }
        public string DateTime { get; set; }
        public string TableNumber { get; set; }
    }
}
