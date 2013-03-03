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
		
		public static var ALL = new Array( SPADES, DIAMONDS, CLUBS, HEARTS );

		public static var suitStringMap:Object = {
				0: "spades",
				1: "diamonds",
				2: "clubs",
				3: "hearts"
		};
		
		private var suit:int;
		
		public function Suit(num:int) 
		{
			this.suit = ALL[num];
		}
		
		public static function All():Array {
				return ALL;
		}
		
		public function toString():String {
			return suitStringMap[this.suit];	
		}
		
		public function equalTo(suit:Suit) {
			if (this.suit == suit.suit) {
				return true;
			} else {
				return false;
			}
		}
		
		public function getColor():String {
			var color:String;
			switch(this.suit) {
				case SPADES:
				case CLUBS:
					color = "black";
					break;
				case DIAMONDS:
				case HEARTS:
					color = "red";
					break;
			}
			return color;
		}
	}

}