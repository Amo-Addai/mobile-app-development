using System;

using Xamarin.Forms;

namespace sample.Pages
{
	public class SamplePage : ContentPage
	{
		public SamplePage ()
		{
			Content = new StackLayout { 
				Children = {
					new Label { Text = "Hello ContentPage" }
				}
			};
		}
	}
}


