using Plugin.BluetoothClassic.Abstractions;
using System;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace Cyberpunk2271.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class ControlPage : ContentPage
    {
        const int FOUR_BIT_COLOR = 15;
        const byte CMD_MUS = 2;
        const byte CMD_LED = 1;
        const byte CMD_OTH = 0;
        bool isSyncingLED = false;

        public ControlPage()
        {
            InitializeComponent();
        }

        private void UpdateColor()
        {
            double R = chkboxR.IsChecked ? sliderR.Value : 0;
            double G = chkboxG.IsChecked ? sliderG.Value : 0;
            double B = chkboxB.IsChecked ? sliderB.Value : 0;
            vColorPreview.BackgroundColor = Color.FromRgb(R, G, B);
        }

        private void OnIndividualSliderValueChanged(object sender, ValueChangedEventArgs args)
        {
            UpdateColor();
        }

        private void OnMasterSliderValueChanged(object sender, ValueChangedEventArgs args)
        {   
            double increment = sliderM.Value - (sliderR.Value + sliderG.Value + sliderB.Value) / 3;
            sliderR.Value = Math.Max(sliderR.Minimum, Math.Min(sliderR.Maximum, sliderR.Value + increment));
            sliderG.Value = Math.Max(sliderG.Minimum, Math.Min(sliderG.Maximum, sliderG.Value + increment));
            sliderB.Value = Math.Max(sliderB.Minimum, Math.Min(sliderB.Maximum, sliderB.Value + increment));
        }

        private void ChkboxM_CheckedChanged(object sender, CheckedChangedEventArgs e)
        {
            chkboxR.IsChecked = chkboxG.IsChecked = chkboxB.IsChecked = chkboxM.IsChecked;
        }

        private void Chkboxes_CheckedChanged(object sender, CheckedChangedEventArgs e)
        {
            UpdateColor();
        }

        private void ButtonSyncLED_Clicked(object sender, EventArgs e)
        {
            isSyncingLED = true;
            Device.StartTimer(TimeSpan.FromMilliseconds(50), Tick);
        }

        private bool Tick()
        {
            Device.BeginInvokeOnMainThread(() =>
            {
                byte r = sliderR.IsEnabled ? (byte)(sliderR.Value * FOUR_BIT_COLOR / sliderR.Maximum) : (byte)0;
                byte g = sliderG.IsEnabled ? (byte)(sliderG.Value * FOUR_BIT_COLOR / sliderG.Maximum) : (byte)0;
                byte b = sliderB.IsEnabled ? (byte)(sliderB.Value * FOUR_BIT_COLOR / sliderB.Maximum) : (byte)0;
                byte b1 = (byte)((r << 4) + ((g >> 2) << 2) + CMD_OTH); // rrrrggcc
                byte b2 = (byte)((g << 6) + (b << 2) + CMD_LED); // ggbbbbcc
                byte[] cmd = { b1, b2 };
                ((AppShell)Shell.Current).MyConnection.Transmit(cmd, 0, cmd.Length);
            });
            return isSyncingLED;
        }

        private void BtnUnsyncLED_Clicked(object sender, EventArgs e)
        {
            isSyncingLED = false;
        }

        private void btnUpdateMusic_Clicked(object sender, EventArgs e)
        {
            byte pow = (byte)((byte)(sliderVol.Value * 16) << 4);
            byte b1 = CMD_OTH; // 000000cc
            byte b2 = (byte)(pow + CMD_MUS); // pppprrcc
            if (rad1.IsChecked) b2 += 1 << 2;
            else if (rad2.IsChecked) b2 += 2 << 2;
            else if (rad3.IsChecked) b2 += 3 << 2;
            byte[] cmd = { b1, b2 };
            ((AppShell)Shell.Current).MyConnection.Transmit(cmd, 0, cmd.Length);
        }

        private void chkboxMUS_CheckedChanged(object sender, CheckedChangedEventArgs e)
        {
            rad1.IsChecked = rad2.IsChecked = rad3.IsChecked = chkboxMUS.IsChecked;
        }
    }
}