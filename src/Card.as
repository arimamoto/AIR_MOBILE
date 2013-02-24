package  
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
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
		public var suit:Suit;　　　　//マーク
		
		public var sides:int = 0; // 裏:0 表：1
		
		private var canMove:int = 1; //ドラッグできるかどうか
		private var canTurnOut:int = 1; //ひっくり返せるかどうか
		
		private var startX;
		private var startY;
		
		public function Card(number:int, suit:int) 
		{
				this.number = number;
				this.suit = new Suit(suit);
				
				this.drawImage();
				
				this.setHandler();
		}
		
		/**
		 * ひっくり返して再描画する
		 */
		public function turnOut() {
			this.sides = Math.abs(this.sides-1);
			
			this.drawImage();
		}
		
		/**
		 * このカードの上におけるカードかどうか判定する
		 * @param	card　上に置きたいカード
		 * @param	setType　配置タイプ　0:フィールド上で重ねるやつ　1:上で重ねるやつ　を想定
		 * @return　boolean
		 */
		public function canSetOn(card:Card, setType:int = 0):Boolean {
			if (card.number == this.number - 1 && card.suit.getColor() != this.suit.getColor()) {
				return true;	
			}
			
			return false;
		}
		
		/**
		 * 別のカードの上に移動する
		 * @param	card　別のカード
		 * @param	setType　配置タイプ　0:フィールド上で重ねるやつ　1:上で重ねるやつ　を想定
		 */
		public function setOn(card:Card, setType:int = 0) {
			this.x = card.x;
			this.y = card.y + 10;
		}
		
		/**
		 * ドラッグを始める前の場所に戻す
		 */
		public function getBack() {
			// TODO: アニメーションつける
			x = startX;
			y = startY;	
		}
		
		/**
		 * このカードのマークと数字をStringで返す
		 */
		public override function toString():String {
			return this.suit.toString() + " : " + this.number;
		}
		
		private function drawImage() {
			var g:Graphics = this.graphics;
			
			//暫定
			var bmd:BitmapData = new BitmapData(WIDTH, HEIGHT,true, 0x00111111);
			
			g.lineStyle(2, 0x000000);
			
			switch(this.sides) {
				case 0:
					g.beginFill(0x33EE33);
					break;
				case 1:
					g.beginFill(0xEE3333);
					break;
			}
			
			//暫定２
			var tf:TextField = new TextField();
			tf.text = this.toString();
			bmd.draw(tf);
			g.beginBitmapFill(bmd);
			
			g.drawRoundRect(0, 0, WIDTH, HEIGHT, ELIPS);			
		}
		
		private function setHandler() {
			this.addEventListener(MouseEvent.MOUSE_DOWN, function(e) {
				if (e.target.canMove) {
					with (e.target) {
						startX = x;
						startY = y;
						startDrag();
					}
				}
			});
			
			this.addEventListener(MouseEvent.MOUSE_UP, function(e) {
				dispatchEvent(new Event("cardMoved"));
				with (e.target) {
					stopDrag();
					// TODO: 重ね順をいい感じに変更する
					//this.parent.addChild(this);
				}
			});
			
			this.addEventListener(TouchEvent.TOUCH_TAP, function(e) {
				if (e.target.canTurnOut) {
					e.target.turnOut();
				}
			});
		}
	}

}