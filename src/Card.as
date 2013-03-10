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
	public class Card extends MovieClip implements ICardSettable
	{
		public static var WIDTH = 80;
		public static var HEIGHT = 140;
		public static var ELIPS = 10; //角のまるさ
		
		public static var SLIDE_HEIGHT = 20; //カードを重ねたときずらす高さ
		
		public var number:int;  //数字
		public var suit:Suit;　　　　//マーク
		
		public var sides:int = 0; // 裏:0 表：1
		public var area:Area;
		
		public var parentCard:Card; // 自分の下にあるカード
		public var childCard:Card; // 自分の上にのっているカード
		
		public var canMove:int = 0; //ドラッグできるかどうか
		private var isDragging:Boolean = false;
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
		 * @return　boolean
		 */
		public function canSetOn(card:Card):Boolean {
			// 裏を向いているときはなにも配置できない
			if (this.sides == 0){
					return false;
			}
			//　表を向いているときは、自分の場所によってかわる
			else {
				switch(this.area.toNum()){
					case Area.HOME:
						// 数字がひとつ上かつ同じマークのみ
						if (card.number == this.number +1 && card.suit == this.suit) {
							return true;
						} else {
							return false;
						}
						break;
					case Area.TABLE:
						// 数字がひとつ下かつ色違いのみ
						if (card.number == this.number - 1 && card.suit.getColor() != this.suit.getColor()) {
							return true;	
						} else {
							return false;
						}
						break;
					case Area.PILE:
						return false;
						break;
					case Area.CAT:
						// ねこは一枚しかもてない
						return false;
						break;
				}
			}
			return false;
		}
		
		/**
		 * 別のカードをこのカードの上に移動する
		 * @param	card　別のカード
		 */
		public function setOn(card:Card):void {
			//カードの表示位置関連
			// TODO: 上の片付けるエリアにおいた場合の処理も書く
			card.x = this.x;
			card.y = this.y + Card.SLIDE_HEIGHT;
			
			this.childCard　 = card;
			card.parentCard = this;
			this.addEventListener("dragging", followChilds);
			if (this.childCard.childCard != null) {
				this.childCard.setOn(this.childCard.childCard);
			}
		}
		
		/**
		 * このカードの上に載っていたカードを取り除いたときの処理
		 * @param	card
		 */
		public function removeFrom(card:Card):void {
			if (this.sides == 0) {
				this.sides = 1;	
			}
			if (this.canMove == 0) {
					this.canMove = 1;
			}
			
			this.removeEventListener("dragging", followChilds);
			card.parentCard = null;
			this.childCard = null;
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
		
		public function followChilds(e:MouseEvent) {
			if (this.childCard) {
			trace(this.toString());	
				this.childCard.x = this.x;
				this.childCard.y = this.y + Card.SLIDE_HEIGHT;
				this.childCard.dispatchEvent(e);
			}
		}
		
		private function setHandler() {
			this.addEventListener(MouseEvent.MOUSE_DOWN, function(e) {
				if (e.target.canMove) {
					with (e.target) {
						startX = x;
						startY = y;
						startDrag();
						isDragging = true;
					}
				}
			});
			this.addEventListener(MouseEvent.MOUSE_MOVE, function(e) {
				if(e.target.isDragging){
					dispatchEvent(new MouseEvent("dragging"));
				}
			});
			
			this.addEventListener(MouseEvent.MOUSE_UP, function(e) {
				dispatchEvent(new Event("cardMoved"));
				with (e.target) {
					stopDrag();
					isDragging = false;
				}
					// 重ね順をいい感じに変更する
					e.target.parent.addChild(e.target);
			});
			
			this.addEventListener(TouchEvent.TOUCH_TAP, function(e) {
				if (e.target.canTurnOut) {
					e.target.turnOut();
				}
			});
		}
	}

}