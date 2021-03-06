package com.aaronhardy.rlgl.enums
{
	public class Color
	{
		public static const BLACK:String = 'black';
		public static const GREEN:String = 'green';
		public static const RED:String = 'red';
		
		public static function getLabel(color:String):String
		{
			switch (color)
			{
				case Color.GREEN:
					return 'Green';
				case Color.RED:
					return 'Red';
				case Color.BLACK:
					return 'Black';
				default:
					return 'N/A';
			}
		}
		
		public static function getUint(color:String):uint
		{
			switch (color)
			{
				case Color.GREEN:
					return 0x00ff00;
				case Color.RED:
					return 0xff0000;
				case Color.BLACK:
					return 0x000000;
				default:
					return 0xffffff;
			}
		}
	}
}