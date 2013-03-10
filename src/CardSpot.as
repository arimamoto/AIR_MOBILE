package  
{
	import flash.display.MovieClip;
	import flash.display.Graphics;
	import flash.display.BitmapData;
	import flash.text.TextField;
	/**
	 * ...
	 * @author ...
	 */
	public class CardSpot extends MovieClip implements ICardSettable
	{
		var canSetOnSuits:/*Suite*/ Array;
		var canSetOnNumber:int;
		
		var childCard:Card;
		
		public static var WIDTH = 80;
		public static var HEIGHT = 140;
		public static var ELIPS = 10; //角のまるさ
		
		public function CardSpot(suites:/*Suit*/Array, number:int) 
		{
			this.canSetOnSuits = suites;
			this.canSetOnNumber = number;

			this.drawImage();	
		}
		
		public function canSetOn(card:Card):Boolean {
			if (isContainSuit(card.suit) && canSetOnNumber == card.number) {
				return true;
			} else {
				return false;
			}
		}
		
		private function isContainSuit(suit:Suit):Boolean {
            for each( var containSuit:Suit in this.canSetOnSuits) {
				if (containSuit.equalTo(suit)) {
					return true;
				}
			}
			return false;
        }
		
		public function setOn(card:Card):void {
			card.x = this.x;
			card.y = this.y;
			
			this.childCard　 = card;
			
			if (this.childCard.childCard != null) {
				this.childCard.setOn(this.childCard.childCard);
			}
		}
		
		public function removeFrom(card:Card):void {
			
		}
		
		/**
		 * オブジェクトのパラメータをStringにして返します
		 */
		public override function toString():String {
			var rText:String = "";
			for each (var suite:Suit in canSetOnSuits) {
				rText += "Suit: " + suite.toString()+ "\n";
			}
			rText += "Number: " + canSetOnNumber;
			
			return rText;
		}
		
		private function drawImage() {
			var g:Graphics = this.graphics;
			
			//暫定
			var bmd:BitmapData = new BitmapData(WIDTH, HEIGHT,true, 0x00111111);
			
			g.lineStyle(2, 0x000000);	
			g.beginFill(0x33EE33);
			
			//暫定２
			var tf:TextField = new TextField();
			//tf.text = this.toString();
			//bmd.draw(tf);
			g.beginBitmapFill(bmd);
			
			g.drawRoundRect(0, 0, WIDTH, HEIGHT, ELIPS);			
		}
		
	}

}