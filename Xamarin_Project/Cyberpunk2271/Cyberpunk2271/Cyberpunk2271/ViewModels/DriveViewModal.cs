using Cyberpunk2271.Models;
using Cyberpunk2271.Views;
using System;
using System.ComponentModel;
using System.Windows.Input;
using Xamarin.Essentials;
using Xamarin.Forms;

namespace Cyberpunk2271.ViewModels
{
    public class DriveViewModal : BaseViewModel
    {
        public DriveViewModal()
        {
            Title = "Drive";
        }

        private int _joystickXposition;
        public int JoystickXposition
        {
            get { return _joystickXposition; }
            set { _joystickXposition = value; OnPropertyChanged(nameof(JoystickXposition)); }
        }

        private int _joystickYposition;
        public int JoystickYposition
        {
            get { return _joystickYposition; }
            set { _joystickYposition = value; OnPropertyChanged(nameof(JoystickYposition)); }
        }

        private int _joystickDistance;
        public int JoystickDistance
        {
            get { return _joystickDistance; }
            set { _joystickDistance = value; OnPropertyChanged(nameof(JoystickDistance)); }
        }

        private int _joystickAngle;

        public int JoystickAngle
        {
            get { return _joystickAngle; }
            set { _joystickAngle = value; OnPropertyChanged(nameof(JoystickAngle)); }
        }

    }
}