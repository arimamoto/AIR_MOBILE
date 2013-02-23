package  
{
	/**
	 * ...
	 * @author satetsu888
	 */
	public class Suit 
	{
		public static var SPADES:int   = 0;
		public static var DIAMONDS:int = 1;
		public static var CLUBS:int    = 2;
		public static var HEARTS:int   = 3;
		
		public function Suit() 
		{
			
		}
		
		public static function All():Array {
				return new Array( SPADES, DIAMONDS, CLUBS, HEARTS );
		
		}
		
	}

}