using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantApp.Models
{
    public class Error
    {
        public Error()
        {

        }

        public Error(string errorMessage, string exceptionMessage)
        {
            ErrorMessage = errorMessage;
            ExceptionMessage = exceptionMessage;
        }

        public string ErrorMessage { get; set; }
        public string ExceptionMessage { get; set; }
    }
}
