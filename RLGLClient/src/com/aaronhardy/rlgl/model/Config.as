package com.aaronhardy.rlgl.model
{
	public class Config
	{
		public const REMOTING_CHANNEL_ID:String = 'my-amf';
		//public static const REMOTING_CHANNEL_URI:String = 'http://localhost:8888/messagebroker/amf';
		public const REMOTING_CHANNEL_URI:String = 'http://redlitegreenliteapp.appspot.com/messagebroker/amf';
		public const REMOTING_DESTINATION:String = 'groupservice';
		
		public const MESSAGE_CHANNEL_ID:String = 'my-polling-amf';
		//public static const MESSAGE_CHANNEL_URI:String = 'http://localhost:8888/messagebroker/amfpolling';
		public const MESSAGE_CHANNEL_URI:String = 'http://redlitegreenliteapp.appspot.com/messagebroker/amfpolling';
		public const MESSAGE_DESTINATION:String = 'litepost';
		public const MESSAGE_SUBTOPIC_DELIMITER:String = '.';
	}
}