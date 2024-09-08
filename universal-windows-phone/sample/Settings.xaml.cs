using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;


namespace Application
{
    public sealed partial class Settings : Page
    {

        public Settings()
        {
            this.InitializeComponent();
            this.NavigationCacheMode = NavigationCacheMode.Required;
        }

        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
            // TODO: Prepare page for display here.
        }

        private void buttonSave_Click(object sender, RoutedEventArgs e)
        {
            var settingName = textSettingName.Text;
            var settingValue = textSettingValue.Text;

            var localSettings = Windows.Storage.ApplicationData.Current.LocalSettings;
            localSettings.Values[settingName] = settingValue;

            textSettingName.Text = string.Empty;
            textSettingValue.Text = string.Empty;
        }

        private void buttonRead_Click(object sender, RoutedEventArgs e)
        {
            var localSettings = Windows.Storage.ApplicationData.Current.LocalSettings;
            var settingList = new List<string>();

            foreach (var key in localSettings.Values.Keys)
            {
                settingList.Add(string.Format("{0}: {1}", key, localSettings.Values[key]));
            }

            listSettings.ItemsSource = settingList;
        }

    }
}

