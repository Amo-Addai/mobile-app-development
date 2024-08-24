using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices.WindowsRuntime;
using Windows.ApplicationModel;
using Windows.ApplicationModel.Activation;
using Windows.Foundation;
using Windows.Foundation.Collections;
using Windows.UI.Xaml;
using Windows.UI.Xaml.Controls;
using Windows.UI.Xaml.Controls.Primitives;
using Windows.UI.Xaml.Data;
using Windows.UI.Xaml.Input;
using Windows.UI.Xaml.Media;
using Windows.UI.Xaml.Media.Animation;
using Windows.UI.Xaml.Navigation;


namespace Application
{
	public sealed partial class App
	{
		private TransitionCollection transitions;

		public App()
		{
			this.InitializeComponent();
			this.Suspending += this.OnSuspending;
		}

		protected override void OnLaunched(LaunchActivatedEventArgs e)
		{
#if DEBUG
			if (System.Diagnostics.Debugger.IsAttached)
			{
				this.DebugSettings.EnableFrameRateCounter = true;
			}
#endif
			Frame rootFrame = Window.Current.Content as rootFrame;
			if (rootFrame == null)
			{
				rootFrame = new Frame();
				// .. 
			}
		}
	}
}

