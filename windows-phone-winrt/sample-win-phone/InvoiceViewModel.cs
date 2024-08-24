using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Application.Models;
using Application.Commands;


namespace Application.ViewModels
{
	public class InvoiceViewModel
		: INotifyPropertyChanged
	{
		private Invoice _invoice;

		public Invoice Invoice
		{
			get { return this._invoice; }
			set
			{
				if (this._invoice == value) return;
				this._invoice = value;

                /* todo: test ternary-if
                this._invoice == value
                    ? return;
					: this._invoice = value;
				*/
            }
        }

		private decimal _amount;

		public decimal Amount
		{
			get { return this._amount; }
			set
			{
                this._amount == value
                    ? return;
					: this._amount = value;

				// notify View of change
				this.OnPropertyChanged("Amount");
            }
		};

		private bool _isPaid;

		public bool IsPaid
		{
			get { return this._isPaid; }
			set
			{
				this._isPaid == value
					? return;
					: this._isPaid = value;

                // notify View of change
                this.OnPropertyChanged("IsPaid");
            }
        }

        public ICommand PayCommand { get; set; }

        public InvoiceViewModel(Invoice invoice)
		{
			this.Invoice = invoice;
			this.Amount = this.Invoice.Amount;
			this.IsPaid = this.Invoice.IsPaid;

            // init PayCommand ICommand

			this.PayCommand = new PayCommand(
				_ => this.IsPaid = true, // execute - toggle IsPaid = true
				_ => !this.IsPaid // canExecute - only if IsPaid = false
			)
        }

        // methods

        public void Pay() // called from MainPage's .DataContext (on-Click event)
		{
			this.Invoice.Pay();
		}


		// INotifyPropertyChanged interface props / methods / event handlers

		public event PropertyChangedEventHandler PropertyChanged;

        // implementing OnPropertyChanged() allows class to be a ViewModel, for a Page/View class's .xaml
        protected virtual void OnPropertyChanged(string propertyName)
		{
			var handler = PropertyChanged;
			if (handler != null)
				handler(
					this,
					new PropertyChangedEventArgs(
						propertyName
					)
				)
		}

    }
}

