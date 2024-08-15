using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Navigation;


namespace Application
{
    public sealed partial class MainPage : Page
    {

        public MainPage()
        {
            this.InitializeComponent();
            this.NavigationCacheMode = NavigationCacheMode.Required;
        }

        protected override void OnNavigatedTo(NavigationEventArgs e)
        {

            // /* TODO: release comment

            var button = new Button
            {
              Content = "Click Me"
              Background = "Blue" // * enum
            };

            button.Background = new SolidColorBrush("Green"); // * SolidColorBrush ( string/enum )

            var list = new List<GradientStop>
            {
                new GradientStop { Offset = 0.0, Color = Red },
                new GradientStop { Offset = 1.0, Color = Green },
            };

            button.Background = new LinearGradientBrush(GradientStops = list); // * LinearGradientBrush ( .. )

            var Button_Click = (object sender, RoutedEventArgs e) =>
            {
                // .. 
            }

            button.Click = Button_Click; // * .Click

            var page = new Page
            {
                Content = new StackPanel
                {
                    Children =
                    {
                        Button { Content = "Click Me" },
                        Button { Content = "Click Me" }
                    }
                }
            };

            // */

            // TODO: Prepare page for display here.

            // set up (Invoice) ViewModel for .xaml Data-Binding

            var invoice = new Invoice
            {
                Amount = 5.00m
            };

            var viewModel = new InvoiceViewModel(invoice);

            this.DataContext = viewModel; // set ViewModel to MainPage's .DataContext (can do away with 'this.')

        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            this.DataContext.Pay(); // call InvoiceViewModel's .Pay() through assigned .DataContext viewModel
        }

    }
}

