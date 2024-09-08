using System;
using System.Collections.Generic;

using Xamarin.Forms;

namespace travel_record_app.Pages
{	
	public partial class LoginPage : ContentPage
	{	
		public LoginPage ()
		{
			InitializeComponent ();

            Type assembly = typeof(LoginPage);

            IconImage.Source =
                ImageSource.FromResource
                    (
                        "travel-record-app.Assets.Images.travel-bag.png",
                        assembly
                    );
        }

        void LoginButton_Clicked(object sender, EventArgs e)
        {
            bool isEmailEmpty = string.IsNullOrEmpty(EmailEntry.Text);
            bool isPasswordEmpty = string.IsNullOrEmpty(PasswordEntry.Text);

            if (isEmailEmpty || isPasswordEmpty)
            {

            }
            else
            {
                Navigation.PushAsync(new HomePage());
            }
        }

        void SignupButton_Clicked(object sender, EventArgs e)
        {
            
        }
    }
}

