package  
{
	import org.flixel.*
	/**
	 * ...
	 * @author Faded
	 */
	public class LevelsCompleted 
	{
		private static var _save:FlxSave;
		private static var _temp:int = 0;
		private static var _loaded:Boolean = false;
		
		public static function get levels():int
		{
			if (_loaded)
			{
				return _save.data.levels;
			}
			else
			{
				return _temp;
			}
		}
		
		public static function set levels(value:int):void
		{
			if (_loaded)
			{
				_save.data.levels = value;
			}
			else
			{
				_temp = value;
			}
		}
		
		public static function  load():void 
		{
			_save = new FlxSave();
			_loaded = _save.bind("myLevelData");
			if (_loaded && _save.data.levels == null)
			{
				_save.data.levels = 0;
			}
		}
	}
}