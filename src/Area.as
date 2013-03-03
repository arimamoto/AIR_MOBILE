package  
{
	/**
	 * ...
	 * @author satetsu888
	 */
	public class Area 
	{
		public static var HOME:int = 0;
		public static var TABLE:int = 1;
		public static var PILE:int = 2;
		public static var CAT:int = 3;
		
		public static var ALL = new Array( HOME, TABLE, CAT );

		private var area:int;
		
		public function Area(num:int)
		{
			this.area = ALL[num];
		}
		
		
		
	}

}