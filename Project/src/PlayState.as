package  
{
	
	import mx.core.FlexSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxRect;
	import org.flixel.FlxObject;
	import org.flixel.system.FlxAnim;
	import org.flixel.FlxCamera;



	public class PlayState extends FlxState
	{
		public var Player:FlxSprite;
		public var Floor:FlxSprite;
		public var ChaoPlayerShadow:FlxSprite;
		public var SombraPlayer:FlxSprite;
		public var group:FlxGroup;
		public var ene:Array = new Array;
		public var PodePular:Boolean;
		public var ModCam:FlxCamera;
		public var VelPerso:int;
		public var Pisca:Boolean;
		public var Timer:int;
		public var segundosRespiro:int;
	
		
		private var Cryst:FlxSprite;
		//public var Sqr:FlxMovieClip;
		[Embed(source = "../Sprites/crystal.png")] private var CrystalS:Class;
		[Embed(source = "../Sprites/SJohn2.png")] private var PlayerS:Class;
		[Embed(source = "../Sprites/SombraS.png")] private var SombraS:Class;
		

		
		//public function loadGraphic(Graphic:Class,Animated:Boolean=false,Reverse:Boolean=false,Width:uint=0,Height:uint=0,Unique:Boolean=false):FlxSprite
		
		public function Hittou(player:FlxSprite, Hitu:FlxSprite):void
		{
			//var fmc:FlxMovieClip = new FlxMovieClip(x,y);
			//fmc.loadMovieClip(movieclip, width, height);
			//add(fmc);
			//fmc.isPlaying = true;
			
			//super();
			//Player.acceleration.x = 0;
			//ChaoPlayerShadow.acceleration.x = 0;
			Player.velocity.x = 0;
			PodePular = true;
		}
		
		override public function create():void
		{
			super.create();
			
			PodePular = false;
			Pisca = false;
			Timer = 0;
			segundosRespiro = 5;
			
			Player = new FlxSprite(10, 10);
			Player.loadGraphic(PlayerS, true, true, 100, 100);
			Player.addAnimation("playerAndando", [0, 1, 2, 3, 4, 5], 7, false);
			Player.addAnimation("playerPulando", [6, 7, 8, 9, 10, 11], 7, false);
			Player.addAnimation("playerParado", [12, 13, 14, 15, 16, 17], 7, false);
			Player.play("playerParado");
			Player.drag.x = 500;
			Player.acceleration.y = 600;
			Player.maxVelocity.x = 400;
			
			Floor = new FlxSprite(20, 210);
			Floor.makeGraphic(1000, 300, 0xffff0000, true);
			Floor.immovable = true;
			Floor.solid = false;
			
			ChaoPlayerShadow = new FlxSprite((10), (150+(Player.height)));
			ChaoPlayerShadow.makeGraphic(Player.width, 50, 0x00ff00ff, true);
			ChaoPlayerShadow.immovable = true;
			ChaoPlayerShadow.drag.x = 500;
			ChaoPlayerShadow.maxVelocity.x = 400;
			
			SombraPlayer = new FlxSprite(ChaoPlayerShadow.x+20, (ChaoPlayerShadow.y-25));
			SombraPlayer.loadGraphic(SombraS, true, true, 50, 50);
			SombraPlayer.addAnimation("SombraPulo", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], 11, false);
			SombraPlayer.immovable = true;
			SombraPlayer.solid = false;
			SombraPlayer.drag.x = 500;
			SombraPlayer.maxVelocity.x = 400;
			
			
			
			Cryst = new FlxSprite((10+(Player.width/2)), 10);
			Cryst.loadGraphic(CrystalS, true, false, 20, 27);
			Cryst.addAnimation("anim", [0, 1, 2, 3, 4, 5], 10, true);
			Cryst.play("anim");
			add(Cryst);
			Cryst.maxVelocity.x = 400;
			Cryst.drag.x = 500;
			
			
						group = new FlxGroup;
			//group.add(Player);
			group.add(Floor);
			/*for (var b:int = 0; b < 207; b++ )
			{
				group.add(ene[b]);
			}*/
			group.add(ChaoPlayerShadow);
			add(group);
			add(SombraPlayer);
			add(Player);
			ModCam = new FlxCamera(0, 0, 840, 680);
			FlxG.resetCameras(ModCam);
			
			ModCam.follow(Cryst, FlxCamera.STYLE_TOPDOWN);
			FlxG.worldBounds = new FlxRect(Player.x, Player.y, (840 * 2), (680 * 2));
			ModCam.deadzone.x = 165;
			ModCam.deadzone.width = 500;
			
			
			//Sqr = new FlxMovieClip(10, 30);
			//Sqr.loadMovieClip(Square, 50, 50);
			//add(Sqr);
			//Sqr.isPlaying = true;
			
			//Square.x = 0;
			

			
			
			/*for (var a:int = 0; a < 207; a++ )
			{
				ene[a] = new FlxSprite(30*a, (210+(30*a)));
				ene[a].makeGraphic(30, 30, 0xff0000ff, true);
				ene[a].immovable = true;
				ene[a].solid = true;
			}*/
			
			

		}
		
		override public function update():void
		{
			super.update()
			
			//ChaoPlayerShadow.x = Player.x;
			
			if (PodePular)	{	VelPerso = 0;	}
			else { VelPerso = 150; }
			
			//if (Player.velocity.x == 0 && ChaoPlayerShadow.velocity.x == 0 && Player.velocity.y == 0) 
			//{
			//	Player.play("playerParado");
			//}
			
			if (FlxG.keys.justReleased ("LEFT")
            || FlxG.keys.justReleased ("RIGHT")
            || FlxG.keys.justReleased ("UP")
            || FlxG.keys.justReleased ("DOWN"))
            {
				if (PodePular)
				{
					Player.play("playerParado");
				}
            }
			
			if (PodePular && Pisca)
				{
					Player.play("playerParado");
					Pisca = false;
					Timer = 0;
				}
			
			if (!Pisca) 
			{
				Timer++;
				if (Timer % ((segundosRespiro*100)/2) == 0)
				{
					Pisca = true;
				}
			}
			//if(!FlxG.keys.any){Player.play("playerParado");}
			
			if (ChaoPlayerShadow.x < (Floor.x+Floor.width)) 
			{
				
				if (FlxG.keys.RIGHT) 
				{
					if (PodePular)
					{
						Player.play("playerAndando");
					}
				Player.facing = FlxObject.RIGHT;
				ChaoPlayerShadow.velocity.x = 150;
				Player.velocity.x = VelPerso;
				SombraPlayer.velocity.x = 150;
				Cryst.velocity.x = 150;
				}
				
				
			
			}
			
			
			if (ChaoPlayerShadow.x > Floor.x) 
			{
			
				if (FlxG.keys.LEFT) 
				{
					if (PodePular)
					{
						Player.play("playerAndando");
					}
				Player.facing = FlxObject.LEFT;
				Player.velocity.x = -VelPerso;
				ChaoPlayerShadow.velocity.x = -150;
				SombraPlayer.velocity.x = -150;
				Cryst.velocity.x = -150;
				//Cryst.velocity.x -= 20;
				}
			}
			
			//if (FlxG.keys.justReleased("LEFT") || FlxG.keys.justReleased("RIGHT")) {
			//	Player.play("playerParado");
			//}
			
			if(ChaoPlayerShadow.y > Floor.y){
			
				if (FlxG.keys.UP)
				{
					if (PodePular)
					{
						Player.play("playerAndando");
					}
					SombraPlayer.y -= 3;
					ChaoPlayerShadow.y -= 3;
					Player.y -= 3;
				}
			}
			
			if(ChaoPlayerShadow.y < (Floor.y+Floor.height)){
			
				if (FlxG.keys.DOWN) 
				{
					if (PodePular)
					{
						Player.play("playerAndando");
					}
					ChaoPlayerShadow.y += 3;
					Player.y += 3;
					SombraPlayer.y += 3;
				}
			}
			
			if (FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("Z")) 
			{
				if (PodePular)
				{
					Pisca = true;
					Player.play("playerPulando");
					SombraPlayer.play("SombraPulo")
					Player.velocity.y -= 400;
					Player.y -= 1;
					PodePular = false;
				}
			}
			
			
			
			
			
			//FlxG.overlap(Player, sprite1);
			
			
			FlxG.collide(group, Player, Hittou);
			
			
			
			//group.sort("y", ASCENDING);
			
		}
		
	}

}