using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace travel_record_app.Pages
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class NewTravelTabbedPage : TabbedPage
    {
        public NewTravelTabbedPage ()
        {
            InitializeComponent();
        }

        private void ToolbarItem_Clicked(object sender, EventArgs e)
        {
            Navigation.PushAsync(new NewTravelPage());
        }
    }
}
