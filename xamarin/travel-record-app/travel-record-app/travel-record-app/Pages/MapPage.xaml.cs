using System;
using System.Collections.Generic;

using Xamarin.Forms;
using Xamarin.Forms.Maps;

namespace travel_record_app.Pages
{	
	public partial class MapPage : ContentPage
	{	
		public MapPage ()
		{
			InitializeComponent ();
		}

		protected override async void OnAppearing()
		{
			base.OnAppearing();

			var locator = CrossGeolocator.Current;

			// relocate map to user-center when user-location changes
			locator.PositionChanged += Locator_PositionChanged;

			// listen for location changes (draws more battery-power)
			await locator.StartListeningAsync
			(
				0, // minTime
				100.0, // minDistance
				true, // includeHeading
            );

            var position = await locator.GetPositionAsync();

            this.MoveToPosition(position);
				
		}

		private void Locator_PositionChanged
		(
			object sender,
			Plugin.Geolocator.Abstractions.PositionEventArgs
			e
		)
		{
			this.MoveToPosition(e.Position);
		}

		private void MoveToPosition(Maps.Position position)
		{
			var center = new Maps.Position
			(
				position.Latitute,
				position.Longitude
			);

			var span = new Maps.MapSpan
			(
				center,
				2,
				2
			);

            LocationsMap.MoveToRegion(span);
        }


    }
}

