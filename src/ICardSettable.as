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
		function removeFrom(card:Card):void; // 自分の上に乗っていたカードが取り除かれたときの処理
	}
	
}