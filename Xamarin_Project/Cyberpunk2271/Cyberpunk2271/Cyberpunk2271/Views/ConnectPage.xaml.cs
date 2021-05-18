using System;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;
using Plugin.BluetoothClassic.Abstractions;
using System.Threading.Tasks;

namespace Cyberpunk2271.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class ConnectPage : ContentPage
    {
        readonly IBluetoothAdapter adapter;
        BluetoothDeviceModel BTDevice;
        readonly AppShell MyShell;
        const byte HAND_SHAKE_T = 0b11100000;
        const byte HAND_SHAKE_R = 0b00011100;
        const byte NO_OP = 0b00000000;
        bool isConnecting = false;

        public ConnectPage()
        {
            InitializeComponent();
            adapter = DependencyService.Resolve<IBluetoothAdapter>();
            MyShell = (AppShell)Shell.Current;

            DevicesList.ItemsSource = null;
            DevicesList.RefreshCommand = new Command(Search_device);
            InitBluetooth();
        }

        private async void InitBluetooth()
        {
            if (!adapter.BluetoothSupported)
            {
                await DisplayAlert("Critical Error!", "Bluetooth is not supported on your device. Please use another device. You cannot use any functionalities of this app.", "OK");
                lblConnected.Text = "Bluetooth not supported on your device!";
                ButtonScan.IsEnabled = false;
                return;
            }
            if (!adapter.Enabled)
            {
                var result = await DisplayAlert("Info", "Bluetooth is off. Do you want to enable it?", "OK", "Cancel");
                if (result) adapter.Enable();
            }
        }

        private void ListBondedDevices(object sender, EventArgs e)
        {
            Search_device();
        }

        private async void Search_device()
        {
            if (!adapter.Enabled)
            {
                await DisplayAlert("Error!", "Bluetooth is off. Please enable it manually and try again.", "OK");
                return;
            }
            DevicesList.ItemsSource = null;
            DevicesList.ItemsSource = adapter.BondedDevices;
            DevicesList.IsRefreshing = false;
        }

        private void DisconnectDevice()
        {
            if (MyShell.MyConnection != null)
            {
                IBluetoothManagedConnection tmp_dispose = MyShell.MyConnection;
                IBluetoothManagedConnection tmp_null = null;
                MyShell.MyConnection = tmp_null;
                tmp_dispose.Dispose();
            }
            BTDevice = null;
            lblConnected.Text = "You are not connected.";
            if (!MyShell.Errors.Contains("NOT_CONNECTED")) MyShell.Errors.Add("NOT_CONNECTED");
            DevicesList.SelectedItem = null;
        }

        private async void DevicesList_ItemTapped(object sender, ItemTappedEventArgs e)
        {
            if (BTDevice != null && BTDevice == DevicesList.SelectedItem)
            {
                var isDisconnect = await DisplayAlert("Info", "This device is already connected or is connecting. Do you want to disconnect?", "Yes", "Cancel");
                if (isDisconnect) DisconnectDevice();
                return;
            }
            var isConnect = await DisplayAlert("Info", "Do you want to connect to this device?", "Yes", "Cancel");
            if (isConnect && !isConnecting)
            {
                isConnecting = true;
                BTDevice = (BluetoothDeviceModel)e.Item;
                string deviceName = BTDevice.Name + " (" + BTDevice.Address + ")";
                try
                {
                    MyShell.MyConnection = adapter.CreateManagedConnection(BTDevice);
                    MyShell.MyConnection.OnStateChanged += MyConnection_OnStateChanged;
                    MyShell.MyConnection.OnTransmitted += MyConnection_OnTransmitted;
                    MyShell.MyConnection.OnRecived += MyConnection_OnRecived;
                    MyShell.MyConnection.OnError += MyConnection_OnError;
                    MyShell.MyConnection.Connect();
                    lblConnected.Text = "Trying to connect to: " + deviceName + ", please wait...";
                    var _discard = await Task.Run(WaitTillInitialized);
                }
                catch (Exception ex_c)
                {
                    await DisplayAlert("Error", "Failed to connect to the specified device because: " + ex_c.Message, "OK");
                    DisconnectDevice();
                    return;
                }
                try
                {
                    lblConnected.Text = "Trying to send handshake data to: " + deviceName + ", please wait...";
                    MyShell.MyConnection.Transmit(new byte[] { HAND_SHAKE_T });
                    Device.StartTimer(TimeSpan.FromMilliseconds(150), Tick);
                }
                catch (Exception ex_t)
                {
                    await DisplayAlert("Error", "Failed to send data to the specified device because: " + ex_t.Message, "OK");
                    DisconnectDevice();
                    return;
                }
                lblConnected.Text = "Trying to receive handshake data from: " + deviceName + ", please wait...";
            }
            else DisconnectDevice();
            isConnecting = false;
        }

        private bool Tick()
        {
            Device.BeginInvokeOnMainThread(() =>
            {
                ((AppShell)Shell.Current).MyConnection.Transmit(new byte[] { NO_OP });
            });
            return false;
        }

        private int WaitTillInitialized()
        {
            while (MyShell.MyConnection.ConnectionState != ConnectionState.Connected);
            return 1;
        }

        private async void MyConnection_OnError(object sender, System.Threading.ThreadExceptionEventArgs errEventArgs)
        {
            await DisplayAlert("Error", "An error occured in your managed bluetooth connection: " + errEventArgs.ToString(), "OK");
            DisconnectDevice();
        }

        private void MyConnection_OnRecived(object sender, RecivedEventArgs recivedEventArgs)
        {
            for (int index = 0; index < recivedEventArgs.Buffer.Length; index++)
            {
                byte value = recivedEventArgs.Buffer.ToArray()[index];
                if (value != HAND_SHAKE_T)
                {
                    Device.BeginInvokeOnMainThread(async () =>
                    {
                        if (value == HAND_SHAKE_R)
                        {
                            string deviceName = BTDevice.Name + " (" + BTDevice.Address + ")";
                            lblConnected.Text = "You are connect to: " + deviceName;
                            await DisplayAlert("Info", "Handshake succeeded: " + value, "OK");
                            MyShell.Errors.Clear();
                        }
                        else // handle other cases on the MAIN thread
                        {
                            HandleValue(value);
                        }
                    });
                }
            }
        }

        private void HandleValue(byte value)
        {
            // do something
        }

        private void MyConnection_OnTransmitted(object sender, TransmittedEventArgs transmittedEventArgs)
        {
            // do something
        }

        private void MyConnection_OnStateChanged(object sender, StateChangedEventArgs stateChangedEventArgs)
        {
            if (stateChangedEventArgs.ConnectionState == ConnectionState.Disconnected)
            {
                MyShell.MyConnection.Connect();
            }
        }
    }
}