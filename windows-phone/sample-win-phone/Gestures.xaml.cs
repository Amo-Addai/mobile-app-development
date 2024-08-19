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
    public sealed partial class Gestures : Page
    {

        private Brush _stationaryBrush;
        private Brush _movingBrush = new SolidColorBrush(Colors.Yellow);

        private TranslateTransform _moveTransform = new TranslateTransform();
        private ScaleTransform _scaleTransform = new ScaleTransform();

        private TransformGroup _transformGroup = new TransformGroup();

        public Gestures()
        {
            this.InitializeComponent();
            this.NavigationCacheMode = NavigationCacheMode.Required;

            // extra setups

            this.HandleGestures();
        }

        protected override void OnNavigatedTo(NavigationEventArgs e)
        {
            // TODO: Prepare page for display here.
        }

        private void HandleGestures()
        {

            MyRectangle.ManipulationStarted += (sender, args) => // set ('append') event handler
            {
                this._stationaryBrush = MyRectangle.Fill;
                MyRectangle.Fill = this._movingBrush;
            };

            // track Rectangle's motion with transform on delta-change events
            MyRectangle.ManipulationDelta += (sender, args) =>
            {
                this._moveTransform.X += args.Delta.Translation.X;
                this._moveTransform.Y += args.Delta.Translation.Y;
            };

            MyRectangle.ManipulationCompleted += (sender, args) =>
            {
                MyRectangle.Fill = this._stationaryBrush;
            };

            // set Rectangle's transform - for draggability

            // MyRectangle.RenderTransform = this._moveTransform;

            // * but, can only set 1 Transform prop at a time - or use a TransformGroup for multiple

            MyRectangle.Tapped += (sender, args) =>
            {
                this._scaleTransform.Scale.X += .25;
                this._scaleTransform.Scale.Y += .25;
            };

            this._transformGroup.Children.Add(this._moveTransform);
            this._transformGroup.Children.Add(this._scaleTransform);

            /* // or .AddRange
            this._transformGroup.Children.AddRange
            {
                this._moveTransform,
                this._scaleTransform
            };
            */

            MyRectangle.RenderTransform = this._transformGroup;

        }

    }
}

