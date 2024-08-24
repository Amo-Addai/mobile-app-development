using System;
using System.IO;

using Android.App;
using Android.Content.PM;
using Android.Runtime;
using Android.OS;

namespace travel_record_app.Droid
{
    [Activity(Label = "travel_record_app", Icon = "@mipmap/icon", Theme = "@style/MainTheme", MainLauncher = true, ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation | ConfigChanges.UiMode | ConfigChanges.ScreenLayout | ConfigChanges.SmallestScreenSize )]
    public class MainActivity : global::Xamarin.Forms.Platform.Android.FormsAppCompatActivity
    {
        protected override void OnCreate(Bundle savedInstanceState)
        {
            base.OnCreate(savedInstanceState);

            Xamarin.Essentials.Platform.Init(this, savedInstanceState);
            global::Xamarin.Forms.Forms.Init(this, savedInstanceState);

            // todo: install Xamarin.Forms.Maps NuGet package
            // Xamarin.FormMaps.Init(this, savedInstanceState); // Maps Package

            // todo: can be used in App(string) override
            string dbPath = Path.Combine(
                System.Environment.GetFolderPath(
                    System.Environment.SpecialFolder.Personal
                ),
                "db_name.sqlite"
            );

            LoadApplication(new App());
        }
        public override void OnRequestPermissionsResult(int requestCode, string[] permissions, [GeneratedEnum] Android.Content.PM.Permission[] grantResults)
        {
            Xamarin.Essentials.Platform.OnRequestPermissionsResult(requestCode, permissions, grantResults);

            base.OnRequestPermissionsResult(requestCode, permissions, grantResults);
        }
    }
}
