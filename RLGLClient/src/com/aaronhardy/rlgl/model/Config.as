package com.aaronhardy.rlgl.model
{
	public class Config
	{
		//public const URI_BASE:String = 'http://localhost:8888';
		public const URI_BASE:String = 'http://redlitegreenliteapp.appspot.com';
		
		public const REMOTING_CHANNEL_ID:String = 'my-amf';
		//public static const REMOTING_CHANNEL_URI:String = 'http://localhost:8888/messagebroker/amf';
		public const REMOTING_CHANNEL_URI:String = URI_BASE + '/messagebroker/amf';
		public const REMOTING_DESTINATION:String = 'groupservice';
		
		// Short poll
		public const SHORT_POLL_MESSAGE_CHANNEL_ID:String = 'my-polling-amf';
		public const SHORT_POLL_MESSAGE_CHANNEL_URI:String = URI_BASE + '/messagebroker/amfpolling';
		
		// Long poll
		public const LONG_POLL_MESSAGE_CHANNEL_ID:String = 'my-amf-longpoll';
		public const LONG_POLL_MESSAGE_CHANNEL_URI:String = URI_BASE + '/messagebroker/myamflongpoll';
		
		// Streaming
		public const STREAM_MESSAGE_CHANNEL_ID:String = 'my-amf-stream';
		public const STREAM_MESSAGE_CHANNEL_URI:String = URI_BASE + '/messagebroker/streamingamf';
		
		//public static const MESSAGE_CHANNEL_URI:String = 'http://localhost:8888/messagebroker/amfpolling';
		public const MESSAGE_DESTINATION:String = 'litepost';
		public const MESSAGE_SUBTOPIC_DELIMITER:String = '.';
	}
}