using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RestaurantApp.Models
{
   public class ApiResponse<T>
    {
        public ApiResponse()
        {

        }

        public ApiResponse(string message, string exceptionMessage, T response)
        {
            Response = response;
        }

        public Error Error { get; set; }
        public T Response { get; set; }
        public bool Successful { get { return Error == null; } }
    }
}
