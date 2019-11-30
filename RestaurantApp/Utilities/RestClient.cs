using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Net.Http;


namespace RestaurantApp.Utilities
{
    public static class RestClient
    {
        public static HttpResponseMessage Post<T>(string url, T request)
        {
            HttpResponseMessage response = null;

            try
            {
                HttpClient httpClient = new HttpClient();
                httpClient.DefaultRequestHeaders.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/Json"));

                response = httpClient.PostAsJsonAsync<T>(url, request).Result;
            }
            catch(Exception ex)
            {
                throw;
            }

            return response;
        }

        public static HttpResponseMessage Put<T>(string url, T request)
        {
            HttpResponseMessage response = null;

            try
            {
                HttpClient httpClient = new HttpClient();
                httpClient.DefaultRequestHeaders.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/Json"));

                response = httpClient.PutAsJsonAsync<T>(url, request).Result;
            }
            catch (Exception ex)
            {
                throw;
            }

            return response;
        }

        public static HttpResponseMessage Get(string url)
        {
            HttpResponseMessage response = null;

            try
            {

                HttpClient httpClient = new HttpClient();

                httpClient.DefaultRequestHeaders.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/Json"));

                response = httpClient.GetAsync(url).Result;

            }
            catch (Exception ex)
            {

                throw;
            }

            return response;
        }

        public static HttpResponseMessage Delete(string url)
        {
            HttpResponseMessage response = null;

            try
            {

                HttpClient httpClient = new HttpClient();

                httpClient.DefaultRequestHeaders.Clear();
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/Json"));

                response = httpClient.DeleteAsync(url).Result;

            }
            catch (Exception ex)
            {

                throw;
            }

            return response;
        }
    }

           
}
