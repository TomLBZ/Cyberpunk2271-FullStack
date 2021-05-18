using System;
using System.Collections.Generic;
using System.Text;
using Xamarin.Forms;

namespace Cyberpunk2271.CustomControls
{
    public class JoystickControl : View
    {
        public static readonly BindableProperty XpositionProperty =
            BindableProperty.Create(
                propertyName: "Xposition",
                returnType: typeof(int),
                declaringType: typeof(int),
                defaultValue: 0
            );

        public int Xposition
        {
            get { return (int)GetValue(XpositionProperty); }
            set { SetValue(XpositionProperty, value); }
        }

        public static readonly BindableProperty YpositionProperty =
            BindableProperty.Create(
                propertyName: "Yposition",
                returnType: typeof(int),
                declaringType: typeof(int),
                defaultValue: 0
            );

        public int Yposition
        {
            get { return (int)GetValue(YpositionProperty); }
            set { SetValue(YpositionProperty, value); }
        }

        public static readonly BindableProperty DistanceProperty =
            BindableProperty.Create(
                propertyName: "Distance",
                returnType: typeof(int),
                declaringType: typeof(int),
                defaultValue: 0
            );

        public int Distance
        {
            get { return (int)GetValue(DistanceProperty); }
            set { SetValue(DistanceProperty, value); }
        }

        public static readonly BindableProperty AngleProperty =
            BindableProperty.Create(
                propertyName: "Angle",
                returnType: typeof(int),
                declaringType: typeof(int),
                defaultValue: 0
            );

        public int Angle
        {
            get { return (int)GetValue(AngleProperty); }
            set { SetValue(AngleProperty, value); }
        }
    }
}
