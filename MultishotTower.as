import Tower;
import BaseTower;

class MultishotTower extends BaseTower {
	
	public static var st_width:Number = 30;
	public static var st_height:Number = 30;
	public static var st_range:Number = 200;
	public static var st_cost:Number = 300;
	public static var st_name:String = "4 Shot Cannon";
	public static var st_desc:String = "Ground Targets";
 
	public function MultishotTower(x:Number, y:Number) {
		var depth:Number;
		this.base_range = st_range;
		this.base_width = st_width;
		this.base_height = st_height;
		this.shotgun_width = 30;
		this.shotgun_height = 30;
		this.shot_width = 38;
		this.shot_delay = 10;
		this.shot_height = 30;
		this.rotation_speed = 7;
		this.damage = 20;
		this.cost = st_cost;
		
		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.base = _root.attachMovie(
						   "multishot_base", 
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
							);
		this.range._x = x;
		this.range._y = y;
		this.range._alpha = 0;

		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.shot = _root.attachMovie(
							"multishot_shot", 
							"shot" + depth, 
							depth,
							{_width:this.shot_width, _height:this.shot_height}
							)
		this.shot._x = x;
		this.shot._y = y;
		this.shot._alpha = 0;
		
		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.shotgun = _root.attachMovie(
							"multishot", 
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
		var tx:Number;
		var ty:Number;
		var x:Number = -1;
		var depth:Number = -1;
		var shootTheMF:Boolean;
		var bullet:MovieClip;
		var ba:Array;

		id = this.getFirstGroundMonsterInRange();
		if(id >= 0) {
			shootTheMF = this.aimAt(id);
			if(this.shot_delayC >= this.shot_delay) {
				this.shot_delayC = 0;
				this.shoot(shootTheMF);
				if(shootTheMF) {
					tx = this.base._x - _root.app.monsters[id].getX();
					ty = this.base._y - _root.app.monsters[id].getY();
 					ba = new Array();
					while(++x < 4) {
						depth = _root.app.actors.getNextDepth(Type.type_Bullets);
						ba[x] = _root.attachMovie("black_bullet", "bullet"+depth, depth, {_x:this.base._x, _y:this.base._y,_width:6,_height:6});
						ba[x].dir = atan2(ty, tx) + (pi * x / 2);
						ba[x].counter = 0;
						ba[x].damage = this.damage;
						ba[x].cos = Math.cos;
						ba[x].sin = Math.sin;
						ba[x].onEnterFrame = function() {
							var x:Number;
							this._x -= 8*cos(this.dir);
							this._y -= 8*sin(this.dir);
							if ((this._x<0) or (this._y<0) or (this._y>400) or (this._x>500)) {
								this.removeMovieClip();
							}
							if (this.counter > 10) {
								this.removeMovieClip();
							}
							this.counter++;
							for(x in _root.app.monsters) {
								if(_root.app.monsters[x].doHitTest(this._x, this._y, true)) {
									_root.app.addMoney(
											_root.app.monsters[x].addDamage(this.damage)
											);		
									if(not _root.app.monsters[x].isAlive())
										_root.app.monsters.splice(x, 1);
									this.removeMovieClip();
									break;
								}
							}
						};
					}
				}
			}
			else {
				if(this.shot_delayC > 5)
					this.shoot(false);
				this.shot_delayC++;
			}
		}
		else {
			if(this.shot_delayC > 5)
				this.shoot(false);
			this.shot_delayC++;
		}
   }
}