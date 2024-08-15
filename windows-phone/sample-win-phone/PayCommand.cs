using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Application.Commands
{
	public class PayCommand
		: ICommand
	{
		private Action _execute;
		private Func<bool> _canExecute;

		// instantiated with an Action delegate method

		public PayCommand
		(
            Action execute, // execute this delegate cb
			Func<bool> canExecute // based on this cb<bool>
		)
		{
			this._execute = execute;
			this._canExecute = canExecute;
		}


		// both _execute & _canExecute methods for implementing ..
        // INotifyPropertyChanged interface props / methods / event handlers

        public event EventHandler CanExecuteChanged;

		public bool CanExecute(object paramer)
		{
			return this._canExecute();
		}

		public void Execute(object parameter)
		{
			this._execute();

            // after executing, trigger .CanExecute()'s re-evaluation
			// in-case this implementation cannot be executed anymore

            this.CanExecuteChanged(
				this,
				new EventArgs()
			)

            // if this triggers .CanExecute()'s re-evaluation to false ..
            // .xaml UI element's Command property (with Data-Binding to PayCommand action) will auto-trigger the element's disability
            // eg. <Button's 'disabled' property />

            // NB: in this case, MainPage.xaml's Data-Binding to PayCommand is handled through its .cs's .DataContext's (Invoice) ViewModel
        }

    }
}

