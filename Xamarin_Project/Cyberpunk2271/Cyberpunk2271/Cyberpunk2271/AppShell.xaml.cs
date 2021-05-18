using Cyberpunk2271.ViewModels;
using Cyberpunk2271.Views;
using Plugin.BluetoothClassic.Abstractions;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Runtime.CompilerServices;
using Xamarin.Forms;

namespace Cyberpunk2271
{
    public partial class AppShell : Xamarin.Forms.Shell
    {
        const int IS_DEBUG = 1;

        public ObservableCollection<string> Errors;
        public IBluetoothManagedConnection MyConnection { get; set; }

        public AppShell()
        {
            InitializeComponent();
            Errors = new ObservableCollection<string>
            {
                "NO_BLUETOOTH_DEVICE_CONNECTED"
            };
        }

        protected override async void OnNavigating(ShellNavigatingEventArgs args)
        {
            if (IS_DEBUG == 1 || Errors == null)
            {
                base.OnNavigating(args);
                return;
            }
            if (Errors.Count > 0)
            {
                args.Cancel();
                await DisplayAlert("Operation Canceled!", "You are currently not allowed to use other functionalities of this app because:\n" + Errors[0], "OK");
            }
            else
            {
                base.OnNavigating(args);
            }
        }
    }

}
