package com.aaronhardy.rlgl
{
	public class Config
	{
		public static const REMOTING_CHANNEL_ID:String = 'my-amf';
		//public static const REMOTING_CHANNEL_URI:String = 'http://localhost:8888/messagebroker/amf';
		public static const REMOTING_CHANNEL_URI:String = 'http://redlitegreenliteapp.appspot.com/messagebroker/amf';
		public static const REMOTING_DESTINATION:String = 'groupservice';
		
		public static const MESSAGE_CHANNEL_ID:String = 'my-polling-amf';
		//public static const MESSAGE_CHANNEL_URI:String = 'http://localhost:8888/messagebroker/amfpolling';
		public static const MESSAGE_CHANNEL_URI:String = 'http://redlitegreenliteapp.appspot.com/messagebroker/amfpolling';
		public static const MESSAGE_DESTINATION:String = 'litepost';
		public static const MESSAGE_SUBTOPIC_DELIMITER:String = '.';
		
		public static const GREEN:String = 'green';
		public static const RED:String = 'red';
	}
}