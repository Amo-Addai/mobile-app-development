using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Application.Models
{
	public class Invoice
	{
		private decimal _amount;

		public decimal Amount
		{
			get { return this._amount; }
			set
			{
				if (this._amount != value)
					this._amount = value;
			}
		}

		private bool _isPaid

		public bool IsPaid
		{
			get { return this._isPaid; }
			private set
			{
				if (this._isPaid != value)
					this._isPaid = value
			}
		}

		public Invoice()
		{
			this.IsPaid = false;
		}

		public void Pay()
		{
			this.IsPaid = true; // private prop-setters can be called from in-class methods only
		}

	}
}

