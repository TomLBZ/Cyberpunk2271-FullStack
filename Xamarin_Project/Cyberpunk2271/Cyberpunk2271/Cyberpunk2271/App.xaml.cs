using Cyberpunk2271.Services;
using Cyberpunk2271.Views;
using System;
using System.Collections.ObjectModel;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace Cyberpunk2271
{
    public partial class App : Application
    {
        public AppShell Shell;

        public App()
        {
            InitializeComponent();

            DependencyService.Register<MockDataStore>();

            Shell = new AppShell();
            MainPage = Shell;
        }

        protected override void OnStart()
        {
        }

        protected override void OnSleep()
        {
        }

        protected override void OnResume()
        {
        }
    }
}
