using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantApp.Models
{
    public class ItemDisplayModel
    {
        public string Name { get; set; }
        public string PriceString { get; set; }
        public decimal Price { get; set; }
    }
}
