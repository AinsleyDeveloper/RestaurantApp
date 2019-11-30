using RestaurantApp.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantApp.ViewModels
{
    public class MenuViewModel
    {
        public MenuViewModel()
        {
            MenuItems = new ObservableCollection<ItemDisplayModel>();
            BillItems = new ObservableCollection<ItemDisplayModel>();
        }

        public int TableId { get; set; }
        public int WaiterId { get; set; }
        public ObservableCollection<ItemDisplayModel> MenuItems { get; set; }
        public ObservableCollection<ItemDisplayModel> BillItems { get; set; }
    }
}
