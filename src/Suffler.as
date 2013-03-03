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
		
		private function randomShuffle(data:Array):Cards
		{
			var tempCopy:Array = data.slice();
			var resultArray:Cards = new Cards();
			while (tempCopy.length > 0)
			{
				var index:int = Math.random() * tempCopy.length;
				resultArray.push(tempCopy[index]);
				tempCopy.splice(index, 1);
			}
			return resultArray;
		}

		/**
		 *  トランプをゲーム開始時の配置にする
		 */
		public function initShffle():Cards {
			
			//全部右上
			for each(var card:Card in cards) {
				setPos(card, rightMargin(20), topMargin(20));
			}
			
			//TODO: ランダムシャッフル的なアニメーション
			
			//ランダムシャッフル
			this.cards = randomShuffle(cards);
			
			//初期配置
			var count = 0;
			for (var i:int = 0; i < 7; i++) {
				for (var j:int = 0; j <= i; j++) {
					setPos(cards[count], leftMargin(20) + xInterval(7, 20) * i, topMargin(180) + j * Card.SLIDE_HEIGHT);
					if (i == j) {
						cards[count].canMove = 1;
					}
					count++;
				}
			}
			return this.cards;
		}
		
		/**
		 *  カードスポットを配置する
		 * 　一番最初に一度だけ呼ばれるはず
		 */
		public function setCardSpot() {
			
		}
		
		public function pileShuffle() {
			
		}
		
		private function setPos(card:Card, x:int, y:int) {
			card.x = x;
			card.y = y;
		}
		
		private function leftMargin(x:int) {
			return x;
		}
		private function rightMargin(x:int) {
			return fields.fullScreenWidth - x - Card.WIDTH;
		}
		private function topMargin(y:int) {
			return y;
		}
		private function bottomMargin(y:int) {
			return fields.fullScreenHeight - y - Card.HEIGHT;
		}
		
		private function xInterval(numOfObjects:int, margin:int) {
			return (fields.fullScreenWidth - margin * 2) / numOfObjects;			
		}
		
	}

}