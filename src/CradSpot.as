package  
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author ...
	 */
	public class CradSpot extends MovieClip implements ICardSettable
	{
		var canSetOnSuits:/*Suite*/ Array;
		var canSetOnNumber:int;
		
		public function CradSpot() 
		{
			
		}
		
		/**
		 * オブジェクトのパラメータをStringにして返します
		 */
		public override function toString():String {
			var rText:String = "";
			for each (var suite:Suit in canSetOnSuits) {
				rText += "canSet: " + suite.toString()+ "\n";
			}
			rText += "canSetNumber: " + canSetOnNumber;
		}
		
		private function drawImage() {
			var g:Graphics = this.graphics;
			
			//暫定
			var bmd:BitmapData = new BitmapData(WIDTH, HEIGHT,true, 0x00111111);
			
			g.lineStyle(2, 0x000000);	
			g.beginFill(0x33EE33);
			
			//暫定２
			var tf:TextField = new TextField();
			tf.text = this.toString();
			bmd.draw(tf);
			g.beginBitmapFill(bmd);
			
			g.drawRoundRect(0, 0, WIDTH, HEIGHT, ELIPS);			
		}
		
	}

}