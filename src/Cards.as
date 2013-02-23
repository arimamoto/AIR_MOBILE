package  
{
	/**
	 * ...
	 * @author satetsu888
	 */
	public dynamic class Cards extends Array
	{
		public function Cards()
		{

		}
		
		public function createCards() {
			for each(var suit in Suit.All()){ 
				for (var num = 1; num <= 13;num++){
					this.push(new Card(num,suit));
				}
			}
			
			return this;
		}
	}

}