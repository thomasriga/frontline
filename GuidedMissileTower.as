import Tower;
import BaseTower;

class GuidedMissileTower extends BaseTower {
	public static var st_width:Number = 30;
	public static var st_height:Number = 30;
	public static var st_range:Number = 300;
	public static var st_cost:Number = 1500;
	public static var st_name:String = "Guided Missiles";
	public static var st_desc:String = "Ground Targets";
	
	public function GuidedMissileTower(x:Number, y:Number) {
		var depth:Number;
		this.base_range = st_range;
		this.base_width = st_width;
		this.base_height = st_height;
		this.shotgun_width = 25;
		this.shotgun_height = 25;
		this.shot_width = 35;
		this.shot_delay = 70;
		this.shot_height = 25;
		this.rotation_speed = 2;
		this.damage = 600;
		this.cost = st_cost;

		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.base = _root.attachMovie(
						   "gm_base", 
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
							"gm_shot", 
							"shot" + depth, 
							depth,
							{_width:this.shot_width, _height:this.shot_height}
							)
		this.shot._x = x;
		this.shot._y = y;
		this.shot._alpha = 0;
		
		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.shotgun = _root.attachMovie(
							"gm_shotgun", 
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
	var bullet:MovieClip;
	var tx:Number;
	var ty:Number;
	var target:Number;
	var depth:Number;
	
	id = this.getFirstFreeGroundMonsterInRange();	
	if(id < 0)
		id = this.getFirstMonsterWithIRGuidance();
	if(id < 0)
			id = this.getFirstGroundMonsterInRange();
	this.lastTarget = id;
	if(this.lastTarget >= 0) {
		shootTheMF = this.aimAt(id);
		if(this.shot_delayC >= this.shot_delay) {
			this.shot_delayC = 0;
			this.shoot(shootTheMF);
			if(shootTheMF) {
				tx = this.base._x - _root.app.monsters[id].getX();
				ty = this.base._y - _root.app.monsters[id].getY();
				bullet = _root.attachMovie("guided_missile", "bullet"+_root.getNextHighestDepth(), _root.app.actors.getNextDepth(Type.type_Missiles), {_x:this.base._x, _y:this.base._y,_width:24,_height:6});
				bullet.dir = atan2(ty, tx);
				bullet.id = id;
				bullet.mdepth = _root.app.monsters[id].getDepth();
				bullet.cos = Math.cos;
				bullet.atan2 = Math.atan2;
				bullet.sin = Math.sin;
				bullet.cos = Math.cos;
				bullet.damage = this.damage;
				bullet.onEnterFrame = function() {
					var exp:MovieClip;
					var dtx:Number;
					var dty:Number;
					var target:Number;
					var depth:Number;
					if(not _root.attack_mode) {
							this.removeMovieClip();
							return;
					}
					if(
					   (_root.app.monsters.length > this.id) and 
					   _root.app.monsters[this.id].isAlive() and 
					   (this.mdepth == _root.app.monsters[id].getDepth())
					   ) {
						dtx = this._x - _root.app.monsters[this.id].getX();
						dty = this._y - _root.app.monsters[this.id].getY();
						this.dir = atan2(dty, dtx);
						this._x -= 3* cos(this.dir);
						this._y -= 3* sin(this.dir);
						this._rotation = (atan2(
							(_root.app.monsters[bullet.id].getY() - this._y), 
							(_root.app.monsters[bullet.id].getX() - this._x)
							) * 180 / pi);
						//trace("target: " + target);
					
						if ((this._x<0) or (this._y<0) or (this._y>400) or (this._x>500)) {
							this.removeMovieClip();
							return;
						}
						if(
							   _root.app.monsters[this.id].doHitTest(this._x, this._y, false) and
							   _root.app.monsters[this.id].doHitTest(this._x - 2, this._y - 2, false) or
							   _root.app.monsters[this.id].doHitTest(this._x + 2, this._y - 2, false) or
							   _root.app.monsters[this.id].doHitTest(this._x + 2, this._y + 2, false) or
								_root.app.monsters[this.id].doHitTest(this._x - 2, this._y + 2, false)								   								   
							) {
								_root.app.addMoney(
									_root.app.monsters[this.id].addDamage(this.damage)
									);
								if(not _root.app.monsters[this.id].isAlive())
									_root.app.monsters.splice(this.id, 1);
								depth = _root.app.actors.getNextDepth(Type.type_Explosions);
								exp = _root.attachMovie(
									"explosion", 
									"explosion" + depth, 
									depth, 
									{_x:this._x,_y:this._y,_width:30, _height:30}
									);
								exp.onEnterFrame = function() {
									this.removeMovieClip();
								}
								this.removeMovieClip();
								return;
						}
					}
					else {
						this.removeMovieClip();
						return;
					}
				};	
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