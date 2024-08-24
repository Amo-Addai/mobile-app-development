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

			locator.PositionChanged += Locator_PositionChanged;

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
            ),
            LocationsMap.MoveToRegion
            (
                new Maps.MapSpan
                (
                    center,
                    2,
                    2
                )

            );
        }


    }
}

