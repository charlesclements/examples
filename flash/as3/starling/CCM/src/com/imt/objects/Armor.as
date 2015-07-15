package com.imt.objects
{
	
	
	import com.bedrock.extras.util.MathUtil;
	import com.imt.framework.display.button.AbstractButton;
	import com.imt.model.Storage;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import hype.extended.behavior.VariableVibration;
	import hype.extended.trigger.SeamlessPlacement;
	
	import starling.textures.Texture;
	
	
	public class Armor extends AbstractButton implements IParticle
	{
		
		
		
		//private var _behaviour:Array;
		public function Armor()
		{
			
			//trace( "Armor" );
			
			super( { id:"particle" }, Texture.fromBitmapData( new BitmapData( 25, 25, false, 0xff0000 ) ), "", Texture.fromBitmapData( new BitmapData( 25, 25, false, 0x00ff00 ) ) );
			
			// Stage 1.
			_behaviour.push( [] );
			
			var stage:uint = 0;
			_behaviour[ stage ].push( new VariableVibration( this, "x", 0.99, 0.05, 1.5 ) );
			_behaviour[ stage ].push( new VariableVibration( this, "y", 0.99, 0.05, 1.5 ) );
			_behaviour[ stage ].push( new VariableVibration( this, "rotation", 0.99, 0.05, 0.1 ) );
			_behaviour[ stage ].push( new SeamlessPlacement( this, new Rectangle( 0, 0, Storage.WIDTH, Storage.HEIGHT ) ) );
			
			// Random rotation.
			rotation = MathUtil.degreesToRadians( Math.random() * 360 );
			
		}

		
		// Runs behaviour
		public function startBehaviour():void
		{
			
			//trace( "Armor - startBehaviour" );
			
			// Kill running behaviours.
			stopBehaviour();
			
			for( var a:uint = 0; a < _behaviour[ _stage ].length; a++ )
			{
				
				_behaviour[ _stage ][ a ].start();
				
			}
			
		}
		
		
		// Stops behaviour
		public function stopBehaviour():void
		{
			
			//trace( "Armor - stopBehaviour" );
			
			var stagesLength:uint = _behaviour.length;
			
			for( var a:uint = 0; a < stagesLength; a++ )
			{
				
				for( var b:uint = 0; b < stagesLength; b++ )
				{
					
					_behaviour[ a ][ b ].stop();
					
				}
				
			}
			
		}
		
		
		public function reset():void
		{
			
			trace( "Armor - reset" );
			rotation = MathUtil.degreesToRadians( 0 );
			
		}
		
		
		public function removeMe():void
		{
			
			//trace( "Armor - removeMe" );
			parent.removeChild( this );
			
		}
		
		
		public function setup():void
		{
			
			trace( "Armor - setup" );
			
			
			
		}
		
		
	}
		
}