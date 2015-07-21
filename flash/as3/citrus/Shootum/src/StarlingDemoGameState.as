package
{
	
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.MovingPlatform;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.box2d.Box2D;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	import vehicle.HeroShip;
	
	
	public class StarlingDemoGameState extends StarlingState
	{

		
		
		public var w:uint = 2000;
		public var h:uint = 2000;
		private var physics:Box2D;
		private var hero:HeroShip;
		
		
		public function StarlingDemoGameState()
		{
			super();
		}
		
		override public function initialize():void 
		{
			
			super.initialize();
			physics = new Box2D("box2D");
			
			
			//physics.scale
			
			physics.visible = true;
			physics.gravity = new b2Vec2( 0, 0 );
			add(physics);
			
			//add(new Platform("left", {x:( w / 2 ) * -1, y:( h / 2) * -1, width:20, height:h}));
			add(new Platform("left", {x:0, y:h / 2, height:h}));
			add(new Platform("right", {x:w, y:h / 2, height:h}));
			add(new Platform("bottom", {x:w / 2, y:h, width:w}));
			add(new Platform("top", {x:w / 2, y:0, width:w}));
			add(new Platform("cloud", {x:250, y:250, width:170, oneWay:true}));
			
			var coin:Coin = new Coin("coin", {x:360, y:200});
			add(coin);
			
			hero = new HeroShip("hero", {x:100, y:350, width:60, height:135});
			add(hero);
			
			//var enemy:Enemy = new Enemy("enemy", {x:w - 50, y:350, width:46, height:68, leftBound:20, rightBound:w - 20});
			//add(enemy);
			
			
			view.camera.setUp( hero, new Rectangle(0, 0, w, h), new Point(w / 2, h / 2), new Point(.05, .05));
			//view.camera.setUp( hero, new MathVector(stage.stageWidth / 2, stage.stageHeight / 2), new Rectangle(0, 0, 1550, 450), new MathVector(.25, .05));
			
			
			//addEventListener(Event.ENTER_FRAME, doUpdate);
			
			
		}
		
		
		
		public function doUpdate(e:Event):void 
		{
			
			trace("doUpdate");
			//set_motor_speed();
			//world.Step(1/30,10,10);
			
			//physics			
			/*
			
			var pos_x:Number = ( hero.getBody() as b2Body ).GetWorldCenter().x * physics.scale;
			var pos_y:Number = ( hero.getBody() as b2Body ).GetWorldCenter().y * physics.scale;
			
			
			trace(pos_x);
			trace(w/2-pos_x);
			
			
			x = w/2-pos_x;
			y = h/2-pos_y;
			*/
			
			
			x++;
			y++;
			trace(x);
			
			physics.world.ClearForces();
			physics.world.DrawDebugData();
			
			
			
			
			
			
			
			//world.ClearForces();
			//world.DrawDebugData();
			
		}
		
		
		
		
			
	}
			
}