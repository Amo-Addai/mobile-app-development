using System;
using System.Collections.Generic;

using Xamarin.Forms;
// using Xamarin.Forms.Xaml; // todo: is namespace default-required
// using .. CrossGeolocator, SQLiteConnection

using travel_record_app.Models;
using travel_record_app.Logic;

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

        protected override async void OnAppearing()
        {
            base.OnAppearing();
			var locator = CrossGeolocator.Current;
			var position = await locator.GetPositionAsync();

			var venues = await VenueLogic.GetVenues
				(
					position.Latitude,
					position.Longitude
				);
			VenueListView.ItemsSource = venues;
        }

        private void ToolbarItem_Clicked(object sender, EventArgs e)
		{
			try
			{
				var selectedVenue =
					VenueListView.SelectedItem
								 as Venue;

				var firstCategory =
					selectedVenue.categories
								 .FirstOrDefault(); // todo: check exists in IList

				Post post = new Post()
				{
					Experience = ExperienceEntry.Text,
					CategoryId = firstCategory.id,
					CategoryName = firstCategory.name,
					Address = selectedVenue.location.address,
					Distance = selectedVenue.location.distance,
					Latitude = selectedVenue.location.lat,
					Longitude = selectedVenue.location.lng,
					VenueName = selectedVenue.name
				};

				using
					(
						SQLiteConnection conn =
							new SQLiteConnection
							(
								App.DatabaseLocation
							)
					)
				{
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
			catch (NullReferenceException ex)
			{

			}
			catch (Exception ex)
			{

			}

		}

    }
}

