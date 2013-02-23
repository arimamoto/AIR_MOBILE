package  
{
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	/**
	 * ...
	 * @author satetsu888
	 */
	public class Card extends MovieClip
	{
		public static var WIDTH = 90;
		public static var HEIGHT = 150;
		public static var ELIPS = 10;
		
		public var number:int;  //数字
		public var suit:int;　　　　//マーク
		
		public var sides:int = 0; // 裏:0 表：1
		
		private var canMove:int = 1; //ドラッグできるかどうか
		private var canTurnOut:int = 1; //ひっくり返せるかどうか
		
		public function Card(number:int, suit:int) 
		{
				this.number = number;
				this.suit = suit;
				
				this.drawImage();
				
				this.setHandler();
		}
		
		public function turnOut() {
			this.sides = Math.abs(this.sides-1);
			
			this.drawImage();
		}
		
		private function drawImage() {
			var g:Graphics = this.graphics;
			
			switch(this.sides) {
				case 0:
					g.beginFill(0x00FF00);
					break;
				case 1:
					g.beginFill(0xff0000);

					break;
			}
			g.drawRoundRect(0, 0, WIDTH, HEIGHT, ELIPS);

		}
		
		private function setHandler() {
			this.addEventListener(MouseEvent.MOUSE_DOWN, function(e) {
				if(e.target.canMove){
					e.target.startDrag();
				}
			});
			
			this.addEventListener(MouseEvent.MOUSE_UP, function(e) {
				e.target.stopDrag()
			});
			
			this.addEventListener(TouchEvent.TOUCH_TAP, function(e) {
				if (e.target.canTurnOut) {
					e.target.turnOut();
				}
			});
		}
		
	}

}