package 
{
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	[SWF(width="840", height="680", backgroundColor="#ffffff")] //Set the size and color of the Flash file
 
	public class HelloWorld extends FlxGame
	{
		public function HelloWorld()
		{
			super((840 * 2), (680 * 2), PlayState, 1); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
		}
	}
}