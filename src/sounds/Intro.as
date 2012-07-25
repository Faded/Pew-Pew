package 
{ 
    import flash.net.NetConnection; 
    import flash.net.NetStream; 
    import flash.events.NetStatusEvent; 
    import flash.media.Video; 
    import flash.display.StageDisplayState; 
    import flash.display.Loader; 
    import flash.display.Sprite; 
    import flash.events.MouseEvent; 
	import org.flixel.FlxState;
	import org.flixel.*;
     
    public class Intro extends Sprite
    {     
        var video:Video = new Video(); 
         
        public function Intro():void 
        { 
            var videoConnection:NetConnection = new NetConnection(); 
            videoConnection.connect(null); 
             
            var videoStream:NetStream = new NetStream(videoConnection); 
            videoStream.client = this; 
             
            addChild(video); 
            video.x = 185; 
            video.y = 5; 
                     
            video.attachNetStream(videoStream); 
             
            videoStream.play("Nomsoftintro.mp4"); 
                         
            videoStream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler); 
        } 
                     
        public function onMetaData(infoObject:Object):void 
        { 
            for(var propName:String in infoObject) 
            { 
                metaDataOut.appendText(propName + "=" + infoObject[propName] + "\n"); 
            } 
        } 
         
        private function netStatusHandler(event:NetStatusEvent):void 
        { 
            if(event.info.code == "NetStream.Play.Stop") 
                stage.displayState = StageDisplayState.NORMAL; 
        } 
    } 
}