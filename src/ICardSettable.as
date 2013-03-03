package  
{
	
	/**
	 * ...
	 * @author satetsu888
	 */
	public interface ICardSettable 
	{
		function canSetOn(card:Card):Boolean; // プレイヤーがカードを上に重ねることができるか判定する
		function setOn(card:Card):void; // 実際にカードを動かすための処理
	}
	
}