package objects{		import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
		public class Square extends Sprite	{				private var _w:uint = 10;		private var _h:uint = 10;				public function Square()		{						super();									var s:Sprite = new Sprite;			s.graphics.beginFill( 0xff0000, 1 );			s.graphics.drawRect( _w/2*-1, _h/2*-1, _w, _h );			s.graphics.endFill();			addChild( s );						/*			var b:Bitmap = new Bitmap( new BitmapData( _w, _h ) );			addChild( b );			*/																				}					}	}