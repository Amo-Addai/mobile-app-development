using System;
using System.Collections.Generic;

using Xamarin.Forms;
// using Xamarin.Forms.Xaml; // todo: is namespace default-required

using travel_record_app.Models;

namespace travel_record_app.Pages
{
	// [XamlCompilation(XamlCompilationOptions.Compile)]
	// * already imported in AssemblyInfo.cs
	public partial class NewTravelPage : ContentPage
	{	
		public NewTravelPage ()
		{
			InitializeComponent ();
		}

		private void ToolbarItem_Clicked(object sender, EventArgs e)
		{
			Post post = new Post()
			{
				Experience = ExperienceEntry.Text
			};

			SQLiteConnection conn =
				new SQLiteConnection
				(
					App.DatabaseLocation
				);
			conn.CreateTable<Post>();

			int rows = conn.Insert(post);
            conn.Close(); // * faster runtime to close connection before working with return data

            if (rows > 0)
				DisplayAlert(
					"Success",
					"Experience successfully inserted",
					"Ok"
				);
            else
                DisplayAlert(
                    "Failure",
                    "Experience failed to be inserted",
                    "Ok"
                );

		}

    }
}

