using System;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

using travel_record_app.Pages;

namespace travel_record_app
{
    public partial class App : Application
    {
        public static string DatabaseLocation = string.Empty;

        public App ()
        {
            InitializeComponent();

            // MainPage = new MainPage(); // default 'this.'MainPage assignment

            MainPage = new NavigationPage(new LoginPage()); // NavigationPage() allows all page navigation
        }

        // constructor override can be used instead, in Android / iOS entry point
        public App(string dbLocation) // path to .sqlite db file
        {
            InitializeComponent();

            MainPage = new NavigationPage(new LoginPage());

            DatabaseLocation = dbLocation;
        }

        protected override void OnStart ()
        {
        }

        protected override void OnSleep ()
        {
        }

        protected override void OnResume ()
        {
        }
    }
}

