package com.fidku 
{
	import com.google.PlusMobile;
	import com.google.resources.*;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	
	/**
	 * Example Google+ AS3 API
	 * @author Patricio Cornejo
	 * @link http://as3resources.com
	 */
	public class Example extends Sprite 
	{
		static private const scopes:Array = ["https://www.googleapis.com/auth/plus.me", "https://www.googleapis.com/auth/plus.login"]; // Scopes, permissions for the login.
		static private const clientId:String = ""; //Clien ID from Google Project
		static private const redirectUri:String = ""; // Redirect URL from Google Project
		
		private var swv:StageWebView;
		
		public function Example():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			header.width = stage.fullScreenWidth;
			header.height = header.width * (120 / 480);
			header.google.addEventListener(MouseEvent.CLICK, clickGoogle);
		}
		
		private function clickGoogle(e:MouseEvent):void 
		{
			if (header.currentFrame == 1) {
				header.google.gotoAndStop(2);
				
				//Authorization Method
				PlusMobile.authorize(plusReady, getSWV(), clientId, redirectUri, scopes);
			}
		}
		
		private function plusReady(response:Object):void
		{
			
			//If response.sucess is true, everything ok ;)
			if (response.success) {
				header.google.gotoAndStop(3);
				
				//Get a People by ID
				People.get(peopleReady, 'me');
				
				//Get a Comment by ID
				//Comments.get(comReady, '');
				
				//Search from people on Google+
				//People.search(searchReady, 'Patricio+Cornejo');
				
				//Get Moments list from user 'me'
				//Moments.list(momentsReady, 'me', Moments.COLLECTION_VAULT);
			} else {
				trace(JSON.stringify(response));
				header.google.gotoAndStop(1);
			}
		}
		
		private function momentsReady(response:Object):void 
		{
			trace(JSON.stringify(response));
		}
		
		private function searchReady(response:Object):void 
		{
			trace(JSON.stringify(response));
		}
		
		private function peopleReady(response:Object):void 
		{
			trace(JSON.stringify(response));
		}
		
		private function getSWV():StageWebView
		{
			if (!swv) swv = new StageWebView();
			swv.stage = stage;
			swv.viewPort = new Rectangle(0, header.height, stage.fullScreenWidth, stage.fullScreenHeight - header.height);
			
			return swv;
		}
		
	}

}