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
    public sealed partial class SystemApps : Page
    {

        public SystemApps()
        {
            this.InitializeComponent();
            this.NavigationCacheMode = NavigationCacheMode.Required;
        }

        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
            // TODO: Prepare page for display here.
        }

        // Launchers - launch other windows phone apps
        // Choosers - use features of other windows phone apps

        private async void buttonChat_Click(object sender, RoutedEventArgs e)
        {
            var chat = new ChatMessage();
            chat.Body = "Hello there";
            chat.Recipients.Add("123456789");

            await ChatMessageManager.ShowComposeSmsMessageAsync(chat);
        }

        private void buttonCall_Click(object sender, RoutedEventArgs e)
        {
            PhoneCallManager.ShowPhoneCallUI("123456789", "John Doe");
        }

        private void buttonImages_Click(object sender, RoutedEventArgs e)
        {
            var picker = new FileOpenPicker();
            picker.ViewMode = PickerViewMode.Thumbnail;
            picker.SuggestedStartLocation = PickerLocationId.PicturesLibrary;
            picker.FileTypeFilter.Add(".jpg");
            picker.FileTypeFilter.Add(".jpeg");
            picker.FileTypeFilter.Add(".png");

            picker.PickSingleFileAndContinue();
        }

    }
}

