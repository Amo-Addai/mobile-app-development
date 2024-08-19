using System;

namespace travel_record_app.Models
{
	public class Post
	{
		[PrimaryKey, AutoIncrement]
		public int Id { get; set; }

		[MaxLength(250)]
		public string Experience { get; set; }

		public Post()
		{
		}
	}
}

