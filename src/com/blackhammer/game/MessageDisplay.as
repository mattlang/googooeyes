﻿package com.blackhammer.game{		import flash.display.*;	import flash.geom.*;	import flash.media.*;	import flash.events.*;	import flash.text.*;	import fl.motion.*	import com.greensock.*;	//import com.greensock.easing.*;	//import com.greensock.OverwriteManager;		public class MessageDisplay extends Sprite{				private var _myDaddy:Object;		private var _gSprite:Sprite = new Sprite();		private var _g:Graphics;		private var _messageW:Number = 140;		private var _messageH:Number = 100;		public var _displayField:TextField  = new TextField();		private var _format:TextFormat = new TextFormat("Comic");		//private var _displayTween:TweenLite;		private var _inProgress:Boolean;		private var _messageTimeline:TimelineMax;		private var _clickToKill:Boolean = false;		private var _messageID:int; //0:none, 1:instruction, 2:bonus, 3:Starting over						public function MessageDisplay(myDaddy:Object):void{			OverwriteManager.init(OverwriteManager.PREEXISTING);			//Font.registerFont(Comic_embed); //didn't work in CS4, might be CS5.			_myDaddy = myDaddy;			_inProgress = false			_g = _gSprite.graphics;			_g.beginFill(0x333333,0.90);			_g.drawRoundRect(0,0,_messageW,_messageH,10);			_gSprite.transform.matrix = new Matrix(1, 0, 0, 1, -_messageW/2, -_messageH/2);			addChild(_gSprite);						_displayField.width = _messageW -10;			_displayField.height = _messageH -30;			_displayField.multiline = _displayField.wordWrap = true;			_displayField.autoSize = TextFieldAutoSize.CENTER;			_displayField.type = TextFieldType.DYNAMIC;			_displayField.selectable =false;						_displayField.transform.matrix = new Matrix(1, 0, 0, 1, -(_displayField.width)/2, -(_displayField.height)/2);			//_displayField.background = true;			//_displayField.backgroundColor = 0x777777;						///use border for placement testing			//_displayField.border = true;			//_displayField.borderColor = 0x990000;						var customFont:Font = new Comic_embed();  			_format.font = customFont.fontName;			//_format.bold = true;            _format.color = 0x66FF33;            _format.size = 24;            _format.underline = false;			_format.align = TextFormatAlign.CENTER;            _displayField.defaultTextFormat = _format;			_displayField.text = ".";			_displayField.embedFonts = true; 			_gSprite.addChild(_displayField);			//_displayField.rotation = 10; //for testing			this.visible = false;			//this.alpha = 0.0;			//this.x = 320/2;			//this.y = 480/2;			//this.scaleX = .05;			//this.scaleY = .05;			//this.transform.matrix = new Matrix(1, 0, 0, 1,  -_messageW,  -_messageH);			this.setRegistrationPoint(this.width >> 1, this.height >> 1, false);			this.addEventListener(Event.ADDED_TO_STAGE, OnTheStage, false, 0, true);		}				private function OnTheStage(e:Event):void{			this.removeEventListener(Event.ADDED_TO_STAGE, OnTheStage);			this.alpha = 0.0;			this.x = (stage.stageWidth)/2;			this.y = 236;			////this.scaleX = .05;			////this.scaleY = .05;		}			public function Display(daText:String,fontSize:Number, readDelay:Number, bold:Boolean = false, clickToKill:Boolean = false,messageID:int = 0, mH:Number = 100):void{			SetUpStuff(mH);			_format.size = fontSize;			//_format.bold = bold;			_displayField.text = daText;			_displayField.setTextFormat(_format); //added insted of using default			var textH = _displayField.height;			var textW = _displayField.width;			_displayField.x = (_messageW - textW)/2 			_displayField.y = (_messageH - textH)/2			_clickToKill = clickToKill;			_messageID = messageID;			this.visible = true;			_inProgress = true;			this.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDown, false, 0, true);			//_displayTween = TweenLite.to(this, 1, {scaleX:1.0, scaleY:1.0, alpha:1.0,onComplete:ReverseTween});			//_displayTween.play();			//var messageTimeline:TimelineLite = new TimelineLite();			_messageTimeline = new TimelineMax();			//messageTimeline.append( new TweenLite(this, 1, {scaleX:1.0, scaleY:1.0, alpha:1.0}) );			//messageTimeline.append( new TweenLite(this, 1, {scaleX:2.0, scaleY:2.0, alpha:0.0,delay:readDelay,onComplete:FinishTween}) );						_messageTimeline.append( new TweenLite(this, .7, {alpha:1.0,delay:.1}) );			_messageTimeline.append( new TweenLite(this, .7, {alpha:0.0,delay:readDelay,onComplete:FinishTween}) );			//messageTimeline.stop();			//messageTimeline.append( new TweenLite(mc, 1, {y:200}) );			//messageTimeline.append( new TweenMax(mc, 1, {tint:0xFF0000}) );			//var tweenOne:TweenLite = TweenLite.to(this, 1.5, {scaleX:1.0, scaleY:1.0, alpha:1.0});			//tweenOne.play();		}			/*		private function ReverseTween():void{		_displayTween = TweenLite.to(this, 1, {scaleX:2.0, scaleY:2.0, alpha:0.0});		_displayTween.play();		//_displayTween.reverse();	}	*/		private function FinishTween():void{			this.visible = false;			this.alpha = 0.0;			_inProgress = false;			_messageTimeline = null;			//this.x = 320/2			//this.y = 480/2			////this.scaleX = .05;			////this.scaleY = .05;			_myDaddy.MessageDone(_messageID);	}		private function OnMouseDown(e:Event):void{		if(_inProgress && _clickToKill){			_messageTimeline.complete(); //this is screwing up formatting on next display?		}		this.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDown);	}			private function SetUpStuff(mH:Number):void{		_messageH = mH;		_messageW = 1.4 * mH;		_g.clear();		_g.beginFill(0x333333,0.90);		_g.drawRoundRect(0,0,_messageW,_messageH,10);		_gSprite.transform.matrix = new Matrix(1, 0, 0, 1, -_messageW/2, -_messageH/2);		addChild(_gSprite);					_displayField.width = _messageW -10;		_displayField.height = _messageH -30;		_displayField.transform.matrix = new Matrix(1, 0, 0, 1, -(_displayField.width)/2, -(_displayField.height)/2);	}		public function setRegistrationPoint(regx:Number, regy:Number, showRegistration:Boolean )	{  	  //translate movieclip    		 this.transform.matrix = new Matrix(1, 0, 0, 1, -regx, -regy);       	 //registration point.   	 if (showRegistration)   	 	{       		var mark:Sprite = new Sprite();        	mark.graphics.lineStyle(1, 0xFF0000);        	mark.graphics.moveTo(-5, -5);        	mark.graphics.lineTo(5, 5);        	mark.graphics.moveTo(-5, 5);        	mark.graphics.lineTo(5, -5);        	addChild(mark);    	}	}	public function Hide():void{			_displayField.text = "";			this.visible = false;	}		public function Kill():void{		_displayField.text = "";					}			}}