using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Text;
using System.Threading.Tasks;
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
    public sealed partial class LocalStorage : Page
    {

        public LocalStorage()
        {
            this.InitializeComponent();
            this.NavigationCacheMode = NavigationCacheMode.Required;
        }

        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
            // TODO: Prepare page for display here.
        }

        private async void buttonWrite_Click(object sender, RoutedEventArgs e)
        {
            // call write method
            await this.WriteToFileAsync();

            buttonWrite.IsEnabled = false;
            buttonRead.IsEnabled = true;
        }

        private async void buttonRead_Click(object sender, RoutedEventArgs e)
        {
            // call read method
            await this.ReadFromFileAsync();

            buttonWrite.IsEnabled = true;
            buttonRead.IsEnabled = false;
        }

        private async Task WriteToFileAsync()
        {
            var fileBytes = Encoding.UTF8.GetBytes(textBoxEntry.Text.ToCharArray());
            var localStorage = Windows.Storage.ApplicationData.Current.LocalFolder;
            var dataFolder = await localStorage.CreateFolderAsync("DataFolder", CreationCollisionOption.OpenIfExists);
            var file = await dataFolder.CreateFileAsync("DataFile.txt", CreationCollisionOption.ReplaceExisting);

            using (var s = await file.OpenStreamForWriteAsync())
            {
                s.Write(fileBytes, 0, fileBytes.Length);
            }
        }

        private async Task ReadFromFileAsync()
        {
            var localStorage = Windows.Storage.ApplicationData.Current.LocalFolder;
            if (localStorage != null)
            {
                var dataFolder = await localStorage.GetFolderAsync("DataFolder");
                var file = await dataFolder.OpenStreamForReadAsync("DataFile.txt");

                using (var streamReader = new StreamReader(file))
                {
                    textBlockRead.Text = streamReader.ReadToEnd();
                }
            }
        }

    }
}

