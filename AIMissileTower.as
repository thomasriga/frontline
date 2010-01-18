import Tower;
import BaseTower;

class AIMissileTower extends BaseTower {
	public static var st_width:Number = 30;
	public static var st_height:Number = 30;
	public static var st_range:Number = 250;
	public static var st_cost:Number = 1000;
	public static var st_name:String = "AI Missiles";
	public static var st_desc:String = "Flying Targets";

	public function AIMissileTower(x:Number, y:Number) {
		var depth:Number;
		
		this.base_range = st_range;
		this.base_width = st_width;
		this.base_height = st_height;
		this.shotgun_width = 20;
		this.shotgun_height = 20;
		this.shot_width = 24;
		this.shot_delay = 30;
		this.shot_height = 20;
		this.rotation_speed = 4;
		this.damage = 400;
		this.cost = st_cost;

		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.base = _root.attachMovie(
						   "ai_gm_base", 
						   "base" + depth, 
							depth,
						   {_width:this.base_width, _height:this.base_height}
						   );
		this.base._x = x;
		this.base._y = y;
		depth = _root.app.actors.getNextDepth(Type.type_Max);
		this.range = _root.attachMovie(
							"range", 
							"range" + depth, 
							depth,
							{_width:this.base_range, _height:this.base_range}
							)
		this.range._x = x;
		this.range._y = y;
		this.range._alpha = 0;

		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.shot = _root.attachMovie(
							"ai_gm_shot", 
							"shot" + depth, 
							depth,
							{_width:this.shot_width, _height:this.shot_height}
							)
		this.shot._x = x;
		this.shot._y = y;
		this.shot._alpha = 0;
		
		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.shotgun = _root.attachMovie(
							"ai_gm_shotgun", 
							"shotgun" + depth, 
							depth,
							{_width:this.shotgun_width, _height:this.shotgun_height}
							)
		this.shotgun._x = x;
		this.shotgun._y = y;
		this.shotgun._alpha = 100;
	}
	
	public function action():Void {
		var id:Number;
		var shootTheMF:Boolean;
		var bullet:BaseMissile;
		
		id = this.getFirstFlyingMonsterInRange();
		if(id >= 0) {
			shootTheMF = this.aimAt(id);
			if(this.shot_delayC >= this.shot_delay) {
				this.shot_delayC = 0;
				this.shoot(shootTheMF);
				if(shootTheMF) {
					bullet = new BaseMissile(id, this.base._x, this.base._y);
				}
			}
			else {
				this.shoot(false);
				this.shot_delayC++;
			}
		}
		else {
			if(this.shot_delayC > 10)
				this.shoot(false);
			this.shot_delayC++;
		}
   }
}