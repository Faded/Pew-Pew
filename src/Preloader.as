package  
{
	import org.flixel.FlxG;
	import org.flixel.system.FlxPreloader;
	import flash.events.AsyncErrorEvent;
	import flash.net.NetConnection; 
    import flash.net.NetStream; 
    import flash.events.NetStatusEvent; 
    import flash.media.Video; 
	/**
	 * ...
	 * @author Faded
	 */
	public class Preloader extends org.flixel.system.FlxPreloader
	{
		
		public function Preloader():void 
		{			
			className = "Main";
			super();
		}	
	}
}