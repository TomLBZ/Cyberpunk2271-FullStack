using Plugin.BluetoothClassic.Abstractions;
using System;
using System.Collections;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace Cyberpunk2271.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class DrivePage : ContentPage
    {
        const byte CMD_MOT = 0b11;
        const byte CMD_OTH = 0b0;

        bool isDriving = false;
        bool isMcNum = false;

        public DrivePage()
        {
            InitializeComponent();
        }

        private void BtnStartStop_Clicked(object sender, System.EventArgs e)
        {
            isDriving = !isDriving;
            btnStartStop.Text = isDriving ? "STOP SYNC" : "START SYNC";
            if (isDriving) Device.StartTimer(TimeSpan.FromMilliseconds(20), Tick);
        }

        private int ThirdRootRemap(int input, int maxValue)
        {
            double fraction = Math.Abs((double)input / maxValue);
            double thirdPower = Math.Pow(fraction, (double)1 / 3);
            int output = (int)(thirdPower * maxValue);
            if (output > maxValue) output = maxValue;
            double compressed_output = Math.Sign(input) * ((double)output * 155 / maxValue + (maxValue - 155)); // compress data in range of 150: 100 ~ 255
            return (int)compressed_output;
        }

        private bool Tick()
        {
            Device.BeginInvokeOnMainThread(() =>
            {
                int forwardPower = JoystickControl.Yposition; //ThirdRootRemap(JoystickControl.Yposition, 255);
                int rightwardPower = -JoystickControl.Xposition; //ThirdRootRemap(JoystickControl.Xposition, 255);
                byte lf, lb, rf, rb;
                byte lf_cmd1, lf_cmd2, lb_cmd1, lb_cmd2, rf_cmd1, rf_cmd2, rb_cmd1, rb_cmd2;

                if (isMcNum) // omnidirectional mode
                {
                    int lfrb_power = ThirdRootRemap(forwardPower + rightwardPower, 255);
                    int lbrf_power = ThirdRootRemap(forwardPower - rightwardPower, 255);
                    lf = lfrb_power < 0 ? (byte)(-lfrb_power) : (byte)lfrb_power;
                    rb = lf;
                    lb= lbrf_power < 0 ? (byte)(-lbrf_power) : (byte)lbrf_power;
                    rf = lb;
                    byte isLfrbNeg = lfrb_power < 0 ? (byte)(1 << 5) : (byte)0;
                    byte isLbrfNeg = lbrf_power < 0 ? (byte)(1 << 5) : (byte)0;

                    lf_cmd1 = (byte)((00 << 6) + isLfrbNeg + ((lf >> 6) << 2) + CMD_OTH);
                    lf_cmd2 = (byte)((lf << 2) + CMD_MOT);

                    lb_cmd1 = (byte)((01 << 6) + isLbrfNeg + ((lb >> 6) << 2) + CMD_OTH);
                    lb_cmd2 = (byte)((lb << 2) + CMD_MOT);

                    rf_cmd1 = (byte)((10 << 6) + isLbrfNeg + ((rf >> 6) << 2) + CMD_OTH);
                    rf_cmd2 = (byte)((rf << 2) + CMD_MOT);

                    rb_cmd1 = (byte)((11 << 6) + isLfrbNeg + ((rb >> 6) << 2) + CMD_OTH);
                    rb_cmd2 = (byte)((rb << 2) + CMD_MOT);
                }
                else // normal mode
                {
                    int leftPower = ThirdRootRemap(forwardPower + rightwardPower, 255); // -255 to 255
                    int rightPower = ThirdRootRemap(forwardPower - rightwardPower, 255); // -255 to 255
                    lf = leftPower < 0 ? (byte)(-leftPower) : (byte)leftPower;
                    lb = lf;
                    rf = rightPower < 0 ? (byte)(-rightPower) : (byte)rightPower;
                    rb = rf;
                    byte isLNeg = leftPower < 0 ? (byte)(1 << 5) : (byte)0;
                    byte isRNeg = rightPower < 0 ? (byte)(1 << 5) : (byte)0;

                    lf_cmd1 = (byte)((00 << 6) + isLNeg + ((lf >> 6) << 2) + CMD_OTH);
                    lf_cmd2 = (byte)((lf << 2) + CMD_MOT);

                    lb_cmd1 = (byte)((01 << 6) + isLNeg + ((lb >> 6) << 2) + CMD_OTH);
                    lb_cmd2 = (byte)((lb << 2) + CMD_MOT);

                    rf_cmd1 = (byte)((10 << 6) + isRNeg + ((rf >> 6) << 2) + CMD_OTH);
                    rf_cmd2 = (byte)((rf << 2) + CMD_MOT);

                    rb_cmd1 = (byte)((11 << 6) + isRNeg + ((rb >> 6) << 2) + CMD_OTH);
                    rb_cmd2 = (byte)((rb << 2) + CMD_MOT);
                }
                // command format: [mm][n][0][dd][TT] - [dddddd][TT], extended command.
                // [mm]: 00 => LF; 01 => LB; 10 => RF; 11 => RB;
                // [n]: 0 => negative; 1 => positive
                // [TT]: CMD TYPES
                // [d...d]: data bits
                int isAuto = 0;
                if (rad1.IsChecked) isAuto = 1;
                else if (rad2.IsChecked) isAuto = 2;
                else if (rad3.IsChecked) isAuto = 3;
                else if (rad4.IsChecked) isAuto = 4;
                byte[] cmd = new byte[] { lf_cmd1, lf_cmd2, lb_cmd1, lb_cmd2, rf_cmd1, rf_cmd2, rb_cmd1, rb_cmd2, 0};
                int length = isAuto > 0 ? 9 : 8;
                if (isAuto > 0)
                {
                    cmd[8] = (byte)(CMD_OTH + (isAuto << 2));
                    isAuto = 0;
                }
                var connection = ((AppShell)Shell.Current).MyConnection;
                if (!(connection is null)) connection.Transmit(cmd, 0, length);
            });
            return isDriving;
        }

        private void btnModeChange_Clicked(object sender, EventArgs e)
        {
            isMcNum = !isMcNum;
            btnModeChange.Text = isMcNum ? "OMNIDIRECTIONAL" : "NORMAL";
        }

    }
}