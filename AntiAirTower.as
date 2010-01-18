﻿import Tower;
import BaseTower;

class AntiAirTower extends BaseTower {
	
	public static var st_width:Number = 30;
	public static var st_height:Number = 30;
	public static var st_range:Number = 200;
	public static var st_cost:Number = 100;
	public static var st_name:String = "AAA Gun";
	public static var st_desc:String = "Flying Targets";
 
	public function AntiAirTower(x:Number, y:Number) {
		var depth:Number;
		this.base_range = st_range;
		this.base_width = st_width;
		this.base_height = st_height;
		this.shotgun_width = 20;
		this.shotgun_height = 20;
		this.shot_width = 32;
		this.shot_delay = 20;
		this.shot_height = 20;
		this.rotation_speed = 7;
		this.damage = 10;
		this.cost = st_cost;

		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.base = _root.attachMovie(
						   "antiair_base", 
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
							"antiair_shot", 
							"shot" + depth, 
							depth,
							{_width:this.shot_width, _height:this.shot_height}
							)
		this.shot._x = x;
		this.shot._y = y;
		this.shot._alpha = 0;
		
		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.shotgun = _root.attachMovie(
							"antiair", 
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
		var shootTheMF:Boolean;
		var bullet:MovieClip;
		
		id = this.getFirstFlyingMonsterInRange();
		if(id >= 0) {
			shootTheMF = this.aimAt(id);
			if(this.shot_delayC >= this.shot_delay) {
				this.shot_delayC = 0;
				this.shoot(shootTheMF);
				if(shootTheMF) {
					tx = this.base._x - _root.app.monsters[id].getX();
					ty = this.base._y - _root.app.monsters[id].getY();
					while(++x < 3) {
						bullet = _root.attachMovie("red_bullet", "bullet"+_root.getNextHighestDepth(), _root.app.actors.getNextDepth(Type.type_Missiles), {_x:this.base._x, _y:this.base._y,_width:10,_height:4});
						bullet.dir = atan2(ty, tx) + (x / 6) - (1 / 6);
						bullet.counter = 0;
						bullet.damage = this.damage;
						bullet.pi = Math.PI;
						bullet.cos = Math.cos;
						bullet.sin = Math.sin;
						bullet.onEnterFrame = function() {
							var target:Number;
							this._x -= 3*cos(this.dir);
							this._y -= 3*sin(this.dir);
							var target = (this.dir * 180 / this.pi);
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