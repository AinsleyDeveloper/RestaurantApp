using System;
using System.Collections.Generic;
using Windows.Foundation;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Navigation;
using RestaurantApp.Utilities;
using RestaurantApp.Models;
using Newtonsoft.Json;
using Windows.UI.Popups;
using Windows.UI.ViewManagement;
using RestaurantApp.ViewModels;
using System.Linq;
using RestaurantApp.Constants;

// The Blank Page item template is documented at https://go.microsoft.com/fwlink/?LinkId=234238

namespace RestaurantApp
{
    /// <summary>
    /// An empty page that can be used on its own or navigated to within a Frame.
    /// </summary>
    public sealed partial class CreateReservations : Page
    {
        private List<Table> _tables = new List<Table>();
        private List<Reservation> _reservations = new List<Reservation>();


        public ReservationViewModel ViewModel { get; } = new ReservationViewModel();

        public CreateReservations()
        {
            this.InitializeComponent();

            ApplicationView.PreferredLaunchViewSize = new Size(1200, 900);
            ApplicationView.PreferredLaunchWindowingMode = ApplicationViewWindowingMode.PreferredLaunchViewSize;
        }

        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
            base.OnNavigatedTo(e);

            ViewModel.WaiterId = (int)e.Parameter;

            PopulateTables();
            LoadReservations();

        }

        private void BtnCreate_Click(object sender, RoutedEventArgs e)
        {
            CreateReservation();

        }

        public async void CreateReservation()
        {
            try
            {
                var selectedTableIndex = cmbBoxTable.SelectedIndex;

                if(selectedTableIndex != -1 && selectedTableIndex < _tables.Count)
                {
                    Reservation reservation = new Reservation();

                    Table selectedTable = _tables[selectedTableIndex];

                    reservation.CustomerFirstName = TBoxFName.Text;
                    reservation.CustomerLastName = TBoxLName.Text;
                    reservation.CellNumber = TBoxCellNumber.Text;
                    reservation.DateTime = dpDate.Date.DateTime;
                    reservation.TableId = selectedTable.TableId;

                    var restResponse = RestClient.Post(String.Format("{0}api/reservation/insertreservation", ApiSettings.BaseApiUrl), reservation);

                    if(restResponse.IsSuccessStatusCode)
                    {
                        var reservationJsonString = restResponse.Content.ReadAsStringAsync().Result;
                        ApiResponse<Reservation> response = JsonConvert.DeserializeObject<ApiResponse<Reservation>>(reservationJsonString);

                        if(response.Successful)
                        {
                            MessageDialog message = new MessageDialog("Reservation successfully created", "Information");
                            await message.ShowAsync();

                            ViewModel.Reservations.Add(new ReservationDisplayModel()
                            {
                                Name = $"{reservation.CustomerFirstName[0]}. {reservation.CustomerLastName}",
                                CellNumber = reservation.CellNumber,
                                DateTime = reservation.DateTime.ToString("dd/MM/yyyy HH:mm"),
                                TableNumber = $"Table {selectedTable.TableNumber}"
                            });

                            lstViewReservations.ItemsSource = ViewModel.Reservations;

                            TBoxFName.Text = "";
                            TBoxLName.Text = "";
                            TBoxCellNumber.Text = "";
                            dpDate.SelectedDate = DateTime.Now;
                            cmbBoxTable.SelectedIndex = 0;
                        }
                        else
                        {
                            MessageDialog message = new MessageDialog(response.Error.ErrorMessage, "Error");
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
            catch (Exception ex)
            {
                MessageDialog messageDialog = new MessageDialog("An unexpected error has occurred while trying to create a rescervation.", "Error");
                await messageDialog.ShowAsync();
            }
        }

        public async void LoadReservations()
        {
            ApiResponse<List<Reservation>> apiResponse = null;
            try
            {
                var restResponse = RestClient.Get(String.Format("{0}api/reservation/getallreservations", ApiSettings.BaseApiUrl));

                if (restResponse.IsSuccessStatusCode)
                {
                    apiResponse = JsonConvert.DeserializeObject<ApiResponse<List<Reservation>>>(restResponse.Content.ReadAsStringAsync().Result);

                    if (apiResponse.Successful && apiResponse.Response != null)
                    {
                        _reservations = apiResponse.Response;

                        foreach (var reservation in _reservations)
                        {
                            Table reservationTable = _tables.Where(table => table.TableId == reservation.TableId).FirstOrDefault();

                            if (reservationTable != null)
                            {

                                ViewModel.Reservations.Add(new ReservationDisplayModel()
                                {
                                    Name = $"{reservation.CustomerFirstName[0]}. {reservation.CustomerLastName}",
                                    CellNumber = reservation.CellNumber,
                                    TableNumber = $"Table {reservationTable.TableNumber}",
                                    DateTime = reservation.DateTime.ToString("dd/MM/yyyy HH:mm")
                                });
                            }
                        }

                        if (lstViewReservations.Items.Count > 0)
                        {
                            lstViewReservations.SelectedIndex = 0;
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
                MessageDialog message = new MessageDialog("An unexpected error has occurred while trying to retrieve the reservations.", "Error");
                await message.ShowAsync();
            }
        }

        public async void PopulateTables()
        {

            ApiResponse<List<Table>> apiResponse = null;
            try
            {
                var restResponse = RestClient.Get(String.Format("{0}api/table/getalltables", ApiSettings.BaseApiUrl));

                if (restResponse.IsSuccessStatusCode)
                {

                    apiResponse = JsonConvert.DeserializeObject<ApiResponse<List<Table>>>(restResponse.Content.ReadAsStringAsync().Result);


                    if (apiResponse.Successful && apiResponse.Response != null)
                    {
                        _tables = apiResponse.Response;

                        foreach (Table table in _tables)
                        {
                            cmbBoxTable.Items.Add(String.Format("Table {0}", table.TableNumber));
                        }

                        if(cmbBoxTable.Items.Count > 0)
                        {
                            cmbBoxTable.SelectedIndex = 0;
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
                MessageDialog message = new MessageDialog("An unexpected error has occurred while trying to retrieve the tables.", "Error");
                await message.ShowAsync();
            }

        }

        private void BtnBack_Click(object sender, RoutedEventArgs e)
        {
            this.Frame.Navigate(typeof(TableSelection), ViewModel.WaiterId);
        }
    }
}
