using Newtonsoft.Json;
using RestaurantApp.Constants;
using RestaurantApp.Models;
using RestaurantApp.Utilities;
using RestaurantApp.ViewModels;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Text;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI.Popups;
using Windows.UI.ViewManagement;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;

// The Blank Page item template is documented at https://go.microsoft.com/fwlink/?LinkId=234238

namespace RestaurantApp
{
    /// <summary>
    /// An empty page that can be used on its own or navigated to within a Frame.
    /// </summary>
    public sealed partial class MenuPage : Page
    {
        private List<Item> _items = null;

        public MenuViewModel ViewModel { get; } = new MenuViewModel();

        public MenuPage()
        {
            this.InitializeComponent();
            ApplicationView.PreferredLaunchViewSize = new Size(1200, 900);
            ApplicationView.PreferredLaunchWindowingMode = ApplicationViewWindowingMode.PreferredLaunchViewSize;
        }

        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
            base.OnNavigatedTo(e);
            var menuViewModel = (MenuViewModel)e.Parameter;

            ViewModel.TableId = menuViewModel.TableId;
            ViewModel.WaiterId = menuViewModel.WaiterId;

            GetAllMenuItems();
            GetTableOrder();
        }

        private async void GetAllMenuItems()
        {
            var url = String.Format("{0}/api/item/getallitems", ApiSettings.BaseApiUrl);
            ApiResponse<List<Item>> apiResponse = null;
            try
            {
                var restResponse = RestClient.Get(url);

                if (restResponse.IsSuccessStatusCode)
                {
  
                    apiResponse = JsonConvert.DeserializeObject<ApiResponse<List<Item>>>(restResponse.Content.ReadAsStringAsync().Result);
                    
                    if(apiResponse.Successful && apiResponse.Response != null)
                    {
                        _items = apiResponse.Response;

                        foreach (var item in _items)
                        {
                            ViewModel.MenuItems.Add(new ItemDisplayModel()
                            {
                                Name = item.Name,
                                PriceString = item.Price.ToString("C"),
                                Price = item.Price
                            });
                        }
                    }
                    else
                    {
                        MessageDialog message = new MessageDialog(apiResponse.Error.ErrorMessage, "Error");
                        await message.ShowAsync();
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
                MessageDialog message = new MessageDialog("An unexpected error has occurred while trying to retrieve the menu items.", "Error");
                await message.ShowAsync();
            }
        }

        private async void GetTableOrder()
        {
            var url = String.Format("{0}api/item/gettableitems/tableId/{1}/waiterId/{2}", ApiSettings.BaseApiUrl, ViewModel.TableId, ViewModel.WaiterId);
            ApiResponse<List<Item>> apiResponse = null;
            try
            {
                var restResponse = RestClient.Get(url);

                if (restResponse.IsSuccessStatusCode)
                {

                    apiResponse = JsonConvert.DeserializeObject<ApiResponse<List<Item>>>(restResponse.Content.ReadAsStringAsync().Result);

                    if (apiResponse.Successful && apiResponse.Response != null)
                    {
                        foreach (var item in apiResponse.Response)
                        {
                            ViewModel.BillItems.Add(new ItemDisplayModel()
                            {
                                Name = item.Name,
                                PriceString = item.Price.ToString("C"),
                                Price = item.Price
                            });
                        }
                    }
                    else
                    {
                        MessageDialog message = new MessageDialog(apiResponse.Error.ErrorMessage, "Error");
                        await message.ShowAsync();
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
                MessageDialog message = new MessageDialog("An unexpected error has occurred while trying to retrieve the ordered items.", "Error");
                await message.ShowAsync();
            }
        }

        private async void SettleBill()
        {
            var url = String.Format("{0}api/bill/settlebill/tableId/{1}/waiterId/{2}", ApiSettings.BaseApiUrl, ViewModel.TableId, ViewModel.WaiterId);
            ApiResponse<Reservation> apiResponse = null;
            try
            {
                var restResponse = RestClient.Get(url);

                if (restResponse.IsSuccessStatusCode)
                {
                    apiResponse = JsonConvert.DeserializeObject<ApiResponse<Reservation>>(restResponse.Content.ReadAsStringAsync().Result);

                    if(apiResponse.Successful)
                    {
                        CloseTable();
                    }
                    else
                    {
                        MessageDialog message = new MessageDialog(apiResponse.Error.ErrorMessage, "Error");
                        await message.ShowAsync();
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
                MessageDialog message = new MessageDialog("An unexpected error has occurred while trying to close the table.", "Error");
                await message.ShowAsync();
            }
        }

        private async void CloseTable()
        {
            var url = String.Format("{0}api/table/gettablebyid/{1}", ApiSettings.BaseApiUrl, ViewModel.TableId);
            ApiResponse<Table> apiResponse = null;

            try
            {
                var restResponse = RestClient.Get(url);

                if (restResponse.IsSuccessStatusCode)
                {
                    apiResponse = JsonConvert.DeserializeObject<ApiResponse<Table>>(restResponse.Content.ReadAsStringAsync().Result);
                    Table table = apiResponse.Response;

                    if (apiResponse.Successful && table != null)
                    {

                        var updateTableUrl = String.Format("{0}api/table/updatetable", ApiSettings.BaseApiUrl);

                        table.IsOpen = false;
                        table.WaiterId = null;

                        var updateRestResponse = RestClient.Put(updateTableUrl, table);

                        if (updateRestResponse.IsSuccessStatusCode)
                        {
                            decimal billTotal = 0;
                            StringBuilder billString = new StringBuilder();

                            foreach (var item in ViewModel.BillItems)
                            {
                                billTotal += item.Price;
                                billString.Append($"{item.Name}: {item.Price.ToString("C")}\r\n");
                            }
                            billString.Append("\r\n");
                            billString.Append($"Total:\t\t{billTotal.ToString("C")}\r\nTable Closed");

                            MessageDialog messageDialog = new MessageDialog(billString.ToString(), "Bill Total");
                            await messageDialog.ShowAsync();

                            this.Frame.Navigate(typeof(TableSelection), ViewModel.WaiterId);
                        }
                        else
                        {
                            MessageDialog message = new MessageDialog(String.Format("Api call was unsuccessful. Status Code: {0}", restResponse.StatusCode), "Error");
                            await message.ShowAsync();
                        }
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
                MessageDialog message = new MessageDialog("An unexpected error has occurred while trying to close a table.", "Error");
                await message.ShowAsync();
            }
        }

        private async void BtnAddItem_Click(object sender, RoutedEventArgs e)
        {
            if(lstViewMenu.SelectedIndex != -1)
            {
                AddItemToBill();
            }
            else
            {
                MessageDialog message = new MessageDialog("No menu item selected. Please select a menu item and try again.", "Warning");
                await message.ShowAsync();
            }
            
        }

        private void BtnCancelM_Click(object sender, RoutedEventArgs e)
        {
            this.Frame.Navigate(typeof(TableSelection), ViewModel.WaiterId);
        }

        private async void AddItemToBill()
        {
            Bill bill = new Bill();
            Item item = null;

            int selectedIndex = lstViewMenu.SelectedIndex;

            try
            {
                if (selectedIndex != -1 && selectedIndex < _items.Count)
                {
                    item = _items[selectedIndex];
                    bill.ItemId = item.ItemId;
                    bill.TableId = ViewModel.TableId;
                    bill.WaiterId = ViewModel.WaiterId;
                    bill.PurchaseDate = DateTime.Now;

                    var url = String.Format("{0}/api/bill/insertbill", ApiSettings.BaseApiUrl);

                    var restResponse = RestClient.Post(url, bill);

                    if (restResponse.IsSuccessStatusCode)
                    {
                        var apiResponse = JsonConvert.DeserializeObject<ApiResponse<string>>(restResponse.Content.ReadAsStringAsync().Result);

                        if (apiResponse.Successful)
                        {
                            ViewModel.BillItems.Add(new ItemDisplayModel() { Name = item.Name, Price = item.Price, PriceString = item.Price.ToString("C") });
                        }
                        else
                        {
                            MessageDialog message = new MessageDialog(apiResponse.Error.ErrorMessage, "Error");
                            await message.ShowAsync();
                        }
                    }
                    else
                    {
                        MessageDialog message = new MessageDialog(String.Format("Api call was unsuccessful. Status Code: {0}", restResponse.StatusCode), "Error");
                        await message.ShowAsync();
                    }
                }
            }
            catch (Exception)
            {
                MessageDialog message = new MessageDialog("An unexpected error has occurred while trying to add a menu item to the bill.", "Error");
                await message.ShowAsync();
            }
        }

        private void BtnCheckout_Click(object sender, RoutedEventArgs e)
        {
            SettleBill();
        }
    }
}
