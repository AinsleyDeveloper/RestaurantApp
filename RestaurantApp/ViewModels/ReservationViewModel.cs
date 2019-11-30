using RestaurantApp.Models;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantApp.ViewModels
{
    public class ReservationViewModel
    {
        public ReservationViewModel()
        {
            Tables = new List<Table>();
            Reservations = new ObservableCollection<ReservationDisplayModel>();
        }
        public int WaiterId { get; set; }
        public List<Table> Tables { get; set; }
        public ObservableCollection<ReservationDisplayModel> Reservations { get; set; }
    }
}
