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
    public sealed partial class LiveTiles : Page
    {

        public LiveTiles()
        {
            this.InitializeComponent();
            this.NavigationCacheMode = NavigationCacheMode.Required;
        }

        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
            // TODO: Prepare page for display here.
        }

        private void buttonEnable_Click(object sender, RoutedEventArgs e)
        {
            var tileManager = TileUpdateManager.CreateTileUpdaterForApplication();
            tileManager.Clear();
            tileManager.EnableNotificationQueue(true);

            var tileXml = TileUpdateManager.GetTemplateContent(TileTemplateType.TileSquare150x150Image);
            var tileImage = tileXml.GetElementsByTagName("image")[0] as XmlElement; // todo: confirm any updates to tileImage will update tileXml data

            // todo: ensure / add image1.png & image2.png to Assets/
            tileImage.SetAttribute("src", "ms-appx:///Assets/image1.png");

            // todo: confirm setting tileImage's src attribute will also update its src in tileXml data (by reference)
            var tileNotification = new TileNotification(tileXml);
            tileManager.Update(tileNotification);

            // todo: confirm re-setting tileImage's src attribute will also update its src in tileXml data
            tileImage.SetAttribute("src", "ms-appx:///Assets/image2.png");
            tileNotification = new TileNotification(tileXml);
            tileManger.Update(tileNotification);
        }

    }
}

