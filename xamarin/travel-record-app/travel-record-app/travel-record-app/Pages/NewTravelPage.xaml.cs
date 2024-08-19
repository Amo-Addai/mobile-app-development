using System;
using System.Collections.Generic;

using Xamarin.Forms;

using travel_record_app.Models;

namespace travel_record_app.Pages
{	
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

			SQLiteConnection conn = new SQLiteConnection(
				App.DatabaseLocation
			);
			conn.CreateTable<Post>();

			int rows = conn.Insert(post);
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

            conn.Close();
		}

    }
}

