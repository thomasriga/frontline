import Tower;
import BaseTower;

class BulletTower extends BaseTower {
	
	public static var st_width:Number = 30;
	public static var st_height:Number = 30;
	public static var st_range:Number = 200;
	public static var st_cost:Number = 100;
	public static var st_name:String = "AAA Gun";
	public static var st_desc:String = "Flying Targets";
 
	public function BulletTower(x, y) {
		this.base_range = st_range;
		this.base_width = st_width;
		this.base_height = st_height;
		this.shotgun_width = 20;
		this.shotgun_height = 20;
		this.shot_width = 32;
		this.shot_delay = 30;
		this.shot_height = 20;
		this.rotation_speed = 7;
		this.damage = 10;
		this.cost = st_cost;

		//trace("TowerClass");		
		this.base = _root.attachMovie(
						   "antiair_base", 
						   "base" + _root.getNextHighestDepth(), 
						   _root.getNextHighestDepth(),
						   {_width:this.base_width, _height:this.base_height}
						   );
		this.base._x = x;
		this.base._y = y;

		this.range = _root.attachMovie(
							"range", 
							"range" + _root.getNextHighestDepth(), 
							_root.getNextHighestDepth(), 
							{_width:this.base_range, _height:this.base_range}
							);
		this.range._x = x;
		this.range._y = y;
		this.range._alpha = 0;

		this.shot = _root.attachMovie(
							"antiair_shot", 
							"shot" + _root.getNextHighestDepth(), 
							_root.getNextHighestDepth(), 
							{_width:this.shot_width, _height:this.shot_height}
							)
		this.shot._x = x;
		this.shot._y = y;
		this.shot._alpha = 0;
		
		this.shotgun = _root.attachMovie(
							"antiair", 
							"shotgun" + _root.getNextHighestDepth(), 
							_root.getNextHighestDepth(), 
							{_width:this.shotgun_width, _height:this.shotgun_height}
							)
		this.shotgun._x = x;
		this.shotgun._y = y;
		this.shotgun._alpha = 100;
		this.fart();
		this.prr2();
	}
	
	public function action():Void {
		var id:Number;
		id = this.getFirstFlyingMonsterInRange();
		if(id >= 0) {
			var shootTheMF = this.aimAt(id);
			if(this.shot_delayC >= this.shot_delay) {
				this.shot_delayC = 0;
				this.shoot(shootTheMF);
				if(shootTheMF) {
					var distance_from_turret_x = this.base._x - _root.app.monsters[id].getX();
					var distance_from_turret_y = this.base._y - _root.app.monsters[id].getY();
					for(var x = 0; x < 3; x++) {
						var bullet = _root.attachMovie("red_bullet", "bullet"+_root.getNextHighestDepth(), _root.getNextHighestDepth(), {_x:this.base._x, _y:this.base._y,_width:10,_height:4});
						bullet.dir = Math.atan2(distance_from_turret_y, distance_from_turret_x) + (x / 6) - (1 / 6);
						bullet.counter = 0;
						bullet.damage = this.damage;
						bullet.onEnterFrame = function() {
							this._x -= 3*Math.cos(this.dir);
							this._y -= 3*Math.sin(this.dir);
							var target = (this.dir * 180 / Math.PI);
							//trace("target: " + target);
							this._rotation = target;
								//this._x += (x);
							//this._y += (x);
							if ((this._x<0) or (this._y<0) or (this._y>400) or (this._x>500)) {
								this.removeMovieClip();
							}
							if (this.counter > 30) {
								this.removeMovieClip();
							}
							this.counter++;
							for(var x = 0; x < _root.app.monsters.length; x++) {
								if(_root.app.monsters[x].doHitTest(this._x, this._y, true)) {
									_root.app.addMoney(
									  		_root.app.monsters[x].addDamage(this.damage)
									  		);		
									this.removeMovieClip();
									break;
								}
							}
						};
					}
				}
			}
			else {
				if(this.shot_delayC > 10)
					this.shoot(false);
				this.shot_delayC++;
			}
		}
		else {
			this.shoot(false);
			this.shot_delayC++;
		}
   }
}
/*
import Tower;
import BaseTower;

class BulletTower extends BaseTower {
	
	public static var st_width:Number = 30;
	public static var st_height:Number = 30;
	public static var st_range:Number = 200;
	public static var st_cost:Number = 50;
	public static var st_name:String = "Light Cannon";
	public static var st_desc:String = "Ground Targets";
 
	public function BulletTower(x, y) {
		this.base_range = st_range;
		this.base_width = st_width;
		this.base_height = st_height;
		this.shotgun_width = 20;
		this.shotgun_height = 20;
		this.shot_width = 28;
		this.shot_delay = 20;
		this.shot_height = 20;
		this.rotation_speed = 7;
		this.damage = 10;
		this.cost = st_cost;
		var typeM = new Type();
		
		this.base = _root.attachMovie(
						   "sniper_base", 
						   "base" + _root.getNextHighestDepth(), 
						   typeM.getNextDepth(Type.type_Towers),
						   //_root.getNextHighestDepth(),
						   {_width:this.base_width, _height:this.base_height}
						   );
		this.base._x = x;
		this.base._y = y;

		this.range = _root.attachMovie(
							"range", 
							"range" + _root.getNextHighestDepth(),
							typeM.getNextDepth(Type.type_Towers),
							//_root.getNextHighestDepth(), 
							{_width:this.base_range, _height:this.base_range}
							);
		this.range._x = x;
		this.range._y = y;
		this.range._alpha = 0;

		this.shot = _root.attachMovie(
							"shot", 
							"shot" + _root.getNextHighestDepth(), 
							//_root.getNextHighestDepth(), 
							typeM.getNextDepth(Type.type_Towers),
							{_width:this.shot_width, _height:this.shot_height}
							)
		this.shot._x = x;
		this.shot._y = y;
		this.shot._alpha = 0;
		
		this.shotgun = _root.attachMovie(
							"shotgun", 
							"shotgun" + _root.getNextHighestDepth(), 
							//_root.getNextHighestDepth(), 
							typeM.getNextDepth(Type.type_Towers),
							{_width:this.shotgun_width, _height:this.shotgun_height}
							)
		this.shotgun._x = x;
		this.shotgun._y = y;
		this.shotgun._alpha = 100;
		this.fart();
		this.prr2();
		trace("finish");

	}
	
	public function action():Void {
		var id:Number;
		id = this.getFirstGroundMonsterInRange();
		trace("BUlletTower test start");
		this.prr2();
		this.fart();
		trace("BUlletTower test stop");
		if(id >= 0) {
			var shootTheMF = this.aimAt(id);
			trace("BUlletTower action aimAt ok");
			if(this.shot_delayC >= this.shot_delay) {
				this.shot_delayC = 0;
				this.shoot(shootTheMF);
				if(shootTheMF) {
					var distance_from_turret_x = this.base._x - _root.app.monsters[id].getX();
					var distance_from_turret_y = this.base._y - _root.app.monsters[id].getY();
					var bullet = _root.attachMovie("black_bullet", "bullet"+_root.getNextHighestDepth(), _root.getNextHighestDepth(), {_x:this.base._x, _y:this.base._y,_width:6,_height:6});
					bullet.dir = Math.atan2(distance_from_turret_y, distance_from_turret_x);
					bullet.counter = 0;
					bullet.damage = this.damage;
					bullet.onEnterFrame = function() {
						this._x -= 8*Math.cos(bullet.dir);
						this._y -= 8*Math.sin(bullet.dir);
						if ((this._x<0) or (this._y<0) or (this._y>400) or (this._x>500)) {
							this.removeMovieClip();
						}
						if (bullet.counter > 30) {
							this.removeMovieClip();
						}
						bullet.counter++;
						for(var x = 0; x < _root.app.monsters.length; x++) {
							if(_root.app.monsters[x].doHitTest(this._x, this._y, true)) {
								_root.app.addMoney(
									  	_root.app.monsters[x].addDamage(bullet.damage)
									  	);		
								this.removeMovieClip();
								break;
							}
						}
					};

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
*/