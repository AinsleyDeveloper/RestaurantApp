using System;
using Windows.Foundation;
using Windows.UI.ViewManagement;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using RestaurantApp.Utilities;
using RestaurantApp.Models;
using Newtonsoft.Json;
using Windows.UI.Popups;
using RestaurantApp.Constants;

// The Blank Page item template is documented at https://go.microsoft.com/fwlink/?LinkId=402352&clcid=0x409

namespace RestaurantApp
{
    /// <summary>
    /// An empty page that can be used on its own or navigated to within a Frame.
    /// </summary>
    public sealed partial class MainPage : Page
    {
        public MainPage()
        {
            this.InitializeComponent();

            ApplicationView.PreferredLaunchViewSize = new Size(1200, 900);
            ApplicationView.PreferredLaunchWindowingMode = ApplicationViewWindowingMode.PreferredLaunchViewSize;
        }

        private void BtnLogin_Click(object sender, RoutedEventArgs e)
        {
            LoginFunction();
        }

        public async void LoginFunction()
        {
            try
            {
                LoginRequest request = new LoginRequest();

                request.Username = TBoxUserName.Text;
                request.Password = PBoxPassword.Password;

                string url = String.Format("{0}api/waiter/waiterlogin", ApiSettings.BaseApiUrl);


                var restResponse = RestClient.Post(url, request);

                if (restResponse.IsSuccessStatusCode)
                {
                    var waiterJsonString = restResponse.Content.ReadAsStringAsync().Result;

                    ApiResponse<Waiter> response = JsonConvert.DeserializeObject<ApiResponse<Waiter>>(waiterJsonString);

                    if (response.Successful)
                    {
                        if (response.Response != null)
                        {
                            this.Frame.Navigate(typeof(TableSelection), response.Response.WaiterId);
                        }
                        else
                        {
                            MessageDialog messageDialog = new MessageDialog(string.Format("User for username: {0} does not exist. Please ensure that username and password is correct and try again.", request.Username), "User Not Found.");
                            await messageDialog.ShowAsync();
                        } 
                    }
                    else
                    {
                        MessageDialog messageDialog = new MessageDialog(response.Error.ErrorMessage, "Error");
                        await messageDialog.ShowAsync();
                    }

                    this.Frame.Navigate(typeof(TableSelection), 2); 
                }
                else
                {
                    MessageDialog message = new MessageDialog(String.Format("Api call was unsuccessful. Status Code: {0}", restResponse.StatusCode), "Error");
                    await message.ShowAsync();
                }
            }
            catch (Exception ex)
            {
                MessageDialog messageDialog = new MessageDialog("An unexpected error has occurred while trying to Login.", "Error.");
                await messageDialog.ShowAsync();
            }
        }
    }

   
}
