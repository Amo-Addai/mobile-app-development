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
    public sealed partial class Notificatons : Page
    {

        public Notificatons()
        {
            this.InitializeComponent();
            this.NavigationCacheMode = NavigationCacheMode.Required;
        }

        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
            // TODO: Prepare page for display here.
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            var toastTemplate = ToastTemplateType.ToastText02;
            var toastXml = ToastNotificationManager.GetTemplateContent(toastTemplate);

            var toastTextElements = toastXml.GetElementsByTagName("text");
            toastTextElements[0].AppendChild(toastXml.CreateTextNode("Hello, World."));
            toastTextElements[1].AppendChild(toastXml.CreateTextNode("This is a sample toast"));

            var toast = new ToastNotification(toastXml);
            toast.ExpirationTime = DateTimeOffset.UtcNow.AddSeconds(3600);
            toast.SuppressPopup = true; // suppress duplicate toasts

            toast.Tag = "winphone";
            toast.Group = "tuts+";

            ToastNotificationManager.CreateToastNotifier().Show(toast);

            ToastNotificationManager.History.Remove("winphone", "tuts+");
        }

    }
}

