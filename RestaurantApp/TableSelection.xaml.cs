using Newtonsoft.Json;
using RestaurantApp.Constants;
using RestaurantApp.Models;
using RestaurantApp.Utilities;
using RestaurantApp.ViewModels;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Threading.Tasks;
using Windows.Foundation;
using Windows.UI.Popups;
using Windows.UI.ViewManagement;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;

// The Blank Page item template is documented at https://go.microsoft.com/fwlink/?LinkId=234238

namespace RestaurantApp
{
    /// <summary>
    /// An empty page that can be used on its own or navigated to within a Frame.
    /// </summary>
    public sealed partial class TableSelection : Page
    {
        private List<Table> _tables = null;
        private int _waiterId = 0;

        public TableSelection()
        {
            this.InitializeComponent();

            ApplicationView.PreferredLaunchViewSize = new Windows.Foundation.Size(1000, 1000);
            ApplicationView.PreferredLaunchWindowingMode = ApplicationViewWindowingMode.PreferredLaunchViewSize;

            // if you want not to have any window smaller than this size...
            ApplicationView.GetForCurrentView().SetPreferredMinSize(new Windows.Foundation.Size(1000, 1000));
        }

        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
            base.OnNavigatedTo(e);

            if (e.Parameter != null)
            {
                _waiterId = (int)e.Parameter; 
            }

            GetWaiterTables();
            AddTableButtons();
        }

        private async void GetWaiterTables()
        {
            ApiResponse<List<Table>> apiResponse = new ApiResponse<List<Table>>();

            try
            {
                string url = String.Format("{0}api/table/getwaitertables/{1}", ApiSettings.BaseApiUrl, _waiterId);

                var response = RestClient.Get(url);

                if (response.IsSuccessStatusCode)
                {
                    apiResponse = JsonConvert.DeserializeObject<ApiResponse<List<Table>>>(response.Content.ReadAsStringAsync().Result);

                    if(apiResponse.Successful)
                    {
                        _tables = apiResponse.Response;
                    }
                    else
                    {
                        MessageDialog messageDialog = new MessageDialog(apiResponse.Error.ErrorMessage, "Error");
                        await messageDialog.ShowAsync();
                    }
                }
                else
                {
                    MessageDialog message = new MessageDialog(String.Format("Api call was unsuccessful. Status Code: {0}", response.StatusCode), "Error");
                    await message.ShowAsync();
                }
            }
            catch (Exception)
            {
                MessageDialog message = new MessageDialog("An unexpected error has occurred while trying to get the waiter's tables.", "Error");
                await message.ShowAsync();
            }
        }

        private void AddTableButtons()
        {

            for (int y = 0; y < _tables.Count; y++)
            {
                Button button = new Button();
                button.Content = String.Format("Table {0}\r\n{1}", _tables[y].TableNumber, _tables[y].IsOpen ? "Opened" : "");
                button.Width = 145;
                button.Height = 90;
                button.HorizontalAlignment = HorizontalAlignment.Left;
                button.VerticalAlignment = VerticalAlignment.Top;
                button.Click += Button_Click;
                button.Tag = _tables[y].TableId.ToString();
                button.Margin = new Thickness(10, 10, 0, 0);


                stkPanelContent.Children.Add(button);
            }
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Button clickedButton = (Button)sender;

            string tableIdString = clickedButton.Tag.ToString();

            int tableId = Convert.ToInt32(tableIdString);

            OpenTable(tableId);
        }

        private void BtnLogout_Click(object sender, RoutedEventArgs e)
        {
            this.Frame.Navigate(typeof(MainPage));
        }

        private async void OpenTable(int tableId)
        {
            Table selectedTable = _tables.Where(table => table.TableId == tableId).FirstOrDefault();

            if (selectedTable != null && !selectedTable.IsOpen)
            {
                try
                {
                    selectedTable.IsOpen = true;
                    selectedTable.WaiterId = _waiterId;

                    string url = String.Format("{0}api/table/updatetable", ApiSettings.BaseApiUrl);

                    var restResponse = RestClient.Put(url, selectedTable);

                    if (restResponse.IsSuccessStatusCode)
                    {

                        var apiResponse = JsonConvert.DeserializeObject<ApiResponse<object>>(restResponse.Content.ReadAsStringAsync().Result);

                        if (apiResponse.Successful)
                        {
                            MenuViewModel menuViewModel = new MenuViewModel();
                            menuViewModel.TableId = tableId;
                            menuViewModel.WaiterId = _waiterId;

                            this.Frame.Navigate(typeof(MenuPage), menuViewModel);
                        }
                        else
                        {
                            MessageDialog messageDialog = new MessageDialog(apiResponse.Error.ErrorMessage, "Error Opening Table");
                            await messageDialog.ShowAsync();
                        }
                    }
                    else
                    {
                        MessageDialog message = new MessageDialog(String.Format("Api call was unsuccessful. Status Code: {0}", restResponse.StatusCode), "Error");
                        await message.ShowAsync();
                    }
                }
                catch (Exception)
                {
                    MessageDialog message = new MessageDialog("An unexpected error has occurred while trying to open a table", "Error");
                    await message.ShowAsync();
                }
            }
            else
            {
                MenuViewModel menuViewModel = new MenuViewModel();
                menuViewModel.TableId = tableId;
                menuViewModel.WaiterId = _waiterId;

                this.Frame.Navigate(typeof(MenuPage), menuViewModel);
            }
        }

        private void BtnReservations_Click(object sender, RoutedEventArgs e)
        {
            this.Frame.Navigate(typeof(CreateReservations), _waiterId);
        }
    }
}
