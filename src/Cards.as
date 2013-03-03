package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author satetsu888
	 */
	public dynamic class Cards extends/*Card*/Array
	{
		private var cardSpots:/*CardSpot*/Array;
		
		public function Cards()
		{

		}
		
		/**
		 * トランプ一セットのカードを生成する
		 * ジョーカーとかは必要になったら対応する
		 */
		public function createCards() {
			for each(var suit in Suit.All()){ 
				for (var num = 1; num <= 13;num++){
					var card:Card = new Card(num, suit); 
					card.addEventListener("cardMoved", cardMovedEventHandler);
					this.push(card);
				}
			}
			
			return this;
		}
		
		/**
		 * このオブジェクトに含まれるカードを配置できるオブジェクトの配列をセットする
		 * @param	spots　CardSpotの配列
		 */
		public function setSpots(spots:/*CardSpots*/Array) {
			this.cardSpots = spots;
		}
		
		/**
		 * このオブジェクトに含まれるカードがプレイヤーによって動かされたときに呼ばれるイベントハンドラ
		 * 　動かせるかどうか判断して、カードを動かす、戻す、操作を行う
		 * @param	e
		 */
		public function cardMovedEventHandler(e:Event) {
			var movedCard:Card = Card(e.target);
			
			trace(movedCard.toString()+ " is moved");
			
			var moveOnTo:ICardSettable = null;
			for each(var card:Card in this) {
				if (movedCard.hitTestObject(card)) {
					if (card.canSetOn(movedCard)) {
						moveOnTo = card;
					}
				}
			}
			for each(var cs:CardSpot in this.cardSpots) {
				if (movedCard.hitTestObject(cs)) {
					if (cs.canSetOn(movedCard)) {
						moveOnTo = cs;
					}
				}				
			}
			if (moveOnTo == null) {
				// デバッグ用にとりあえずどこでもおけるようにしとく
				//movedCard.getBack();
			} else {
				moveOnTo.setOn(movedCard);
			}
		}
	}

}