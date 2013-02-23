package  
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	/**
	 * ...
	 * @author satetsu888
	 */
	public class Suffler 
	{
		private var cards:Cards;
		private var fields:Stage;
		
		private var piles;
		
		public function Suffler(cards:Cards, fields:Stage) 
		{
			this.cards = cards;
			this.fields = fields;
			//trace("W: "+fields.fullScreenWidth+" H: "+fields.fullScreenWidth);
		}
		
		public function shuffle() {
			
		}
		
		public function initShffle() {
			
			//全部右上
			for each(var card:Card in cards) {
				setPos(card, leftMargin(20), topMargin(20));
			}
			
			//初期配置
			for (var i:int = 7; i >0; i--) {
				for (var j:int = i; j > i; j--) {
					
				}
			}
		}
		
		public function pileShuffle() {
			
		}
		
		private function setPos(card:Card, x:int, y:int) {
			card.x = x;
			card.y = y;
		}
		
		private function rightMargin(x:int) {
			return x;
		}
		private function leftMargin(x:int) {
			return fields.fullScreenWidth - x - Card.WIDTH;
		}
		private function topMargin(y:int) {
			return y;
		}
		private function bottomMargin(y:int) {
			return fields.fullScreenHeight - y - Card.HEIGHT;
		}
		
	}

}