using System;
using System.Collections.Generic;
// using .. SQLiteConnection

using Xamarin.Forms;

using travel_record_app.Models;

namespace travel_record_app.Pages
{	
	public partial class HistoryPage : ContentPage
	{	
		public HistoryPage ()
		{
			InitializeComponent ();
		}

		protected override void OnAppearing()
		{
			base.OnAppearing();

			using
			(
				SqliteConnection conn =
				new SqliteConnection
				(
					App.DatabaseLocation
				)
			)
			{
                conn.CreateTable<Post>(); // todo: will only create-table if it doesn't already exist

                var posts = conn.Table<Post>()
								.ToList();
				// conn.Close(); // * conn is closed by default after using-scope

				PostListView.ItemsSource = posts; // set ListView's data-context (data-binding for its ItemTemplate > DataTemplate)
            }
		}

	}
}

