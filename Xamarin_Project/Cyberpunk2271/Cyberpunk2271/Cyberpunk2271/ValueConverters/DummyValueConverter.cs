using System;
using System.Collections.Generic;
using System.Text;
using System.Globalization;

namespace Cyberpunk2271.ValueConverters
{
    class DummyValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return value;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return value;
        }
    }
}
