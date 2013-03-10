package  
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	/**
	 * ...
	 * @author satetsu888
	 */
	public class Suffler 
	{
		private var cards:Cards;
		private var fields:Stage;
		
		private var homeCardSpots:/*CardSpot*/Array = new Array();
		private var tableCardSpots:/*CardSpot*/Array = new Array();
		
		
		public function Suffler(cards:Cards, fields:Stage) 
		{
			this.cards = cards;
			this.fields = fields;
			//trace("W: "+fields.fullScreenWidth+" H: "+fields.fullScreenWidth);
		}
		
		private function randomShuffle(data:Cards):Cards
		{
			for (var i:int = 0; i < 100; i++ )
			{
				var index:int = Math.random() * data.length;
				data.push(data.splice(index, 1)[0]);				
			}
			return data;
		}

		/**
		 *  トランプをゲーム開始時の配置にする
		 */
		public function initShffle():Cards {
			
			//全部右上
			for each(var card:Card in cards) {
				setPos(card, rightMargin(20), topMargin(20));
				card.area = new Area(Area.PILE);
			}
			
			//TODO: ランダムシャッフル的なアニメーション
			
			//ランダムシャッフル
			this.cards = randomShuffle(cards);
			
			//初期配置
			var count = 0;
			for (var i:int = 0; i < 7; i++) {
				setPos(tableCardSpots[i], leftMargin(20) + xInterval(7, 20) * i, topMargin(180));
				var parent:ICardSettable = tableCardSpots[i];
				for (var j:int = 0; j <= i; j++) {
					parent.setOn(cards[count]);
					cards[count].area = new Area(Area.TABLE);
					if (i == j) {
						cards[count].canMove = 1;
						cards[count].sides = 1;
					}
					parent = cards[count];
					count++;
				}
			}
			return this.cards;
		}
		
		/**
		 *  カードスポットを配置する
		 * 　一番最初に一度だけ呼ばれるはず
		 */
		public function setCardSpot():Array {
			// ホームカードスポット
			for each(var suitNum:int in Suit.All()) {
				var cs:CardSpot = new CardSpot(new Array(new Suit(suitNum)), 1);
				setPos(cs, leftMargin(20) + (Card.WIDTH + 15) * suitNum, topMargin(20));
				homeCardSpots.push(cs);
			}
			
			var ALL_OBJ_ARRAY:Array = new Array();
			for each (var suitNum:int in Suit.All()) {
				ALL_OBJ_ARRAY.push(new Suit(suitNum));
			}
			
			//　テーブルカードスポット
			for (var i = 0; i < 7; i++) {
				var cs:CardSpot = new CardSpot(ALL_OBJ_ARRAY, 13);
				setPos(cs, leftMargin(20) + xInterval(7, 20) * i, topMargin(180));
				tableCardSpots.push(cs);
			}
			
			return homeCardSpots.concat(tableCardSpots);
		}
		
		public function pileShuffle() {
			
		}
		
		private function setPos(card:MovieClip, x:int, y:int) {
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