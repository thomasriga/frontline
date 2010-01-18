class BaseMonster implements Monster {
	private var min:MovieClip;
	private var damage_bg:MovieClip;
	private var damage_fg:MovieClip;
	private var dist_x:Number;
	private var dist_y:Number;
	private var angle:Number;
	private var speedMultiplier:Number;
	private var maxSpeedMultiplier:Number;
	private var life:Number;
	private var maxLife:Number;
	private var maxDamageWidth:Number;
	private var targetId:Number = 0;
	private var recoveryC:Number = 0;
	private var atan2 = Math.atan2;
	private var cos = Math.cos;
	private var sin = Math.sin;
	private var ceil = Math.ceil;
	private var myrandom = Math.random;
	private static var pi:Number = Math.PI;
	
	public function BaseMonster() {		
	}
	
	public function isFlying():Boolean {		
		return false;
	}
	
	public function setup(x:Number, y:Number):Void {
		this.maxLife = this.life;
		this.maxSpeedMultiplier = speedMultiplier;
		this.damage_bg = _root.attachMovie(
									 "damage_bg", 
									 "damage_bg"+_root.getNextHighestDepth(), 
									 _root.getNextHighestDepth()
									 );
		this.damage_bg._x = x - this.damage_bg._width / 2;
		this.damage_bg._y = y;
		this.damage_fg = _root.attachMovie(
									 "damage_fg", 
									 "damage_fg"+_root.getNextHighestDepth(), 
									 _root.getNextHighestDepth()
									 );
		this.damage_fg._x = x - this.damage_fg._width / 2;
		this.damage_fg._y = y;
		this.maxDamageWidth = this.damage_fg._width;
	}
	
	public function doHitTest(mouse_x:Number,mouse_y:Number, flagB:Boolean):Boolean { 	
		return this.min.hitTest(mouse_x, mouse_y, flagB);
	}
	
	public function isFree(mousex:Number, mousey:Number):Boolean {
		return _root.app.isOnRoad(mousex, mousey, 10);
	}

	public function tryMove(valx:Number, valy:Number, size:Number, doMove:Boolean):Boolean {
		if(this.isFree(this.min._x + valx, this.min._y + valy, size)) {
			if(doMove) {
				this.min._y += valy;
				this.damage_bg._y += valy;
				this.damage_fg._y += valy;
				this.min._x += valx;
				this.damage_bg._x += valx;
				this.damage_fg._x += valx;
			}
			return true;
		}
		else
			return false;
	}
	
	public function checkSpeed():Void {
				if(this.speedMultiplier < this.maxSpeedMultiplier) {
				if(this.recoveryC == 0) {
					this.speedMultiplier += 0.1;
					if(this.speedMultiplier > this.maxSpeedMultiplier)
						this.speedMultiplier = this.maxSpeedMultiplier;
					this.recoveryC = 30;
				}
				else
					this.recoveryC--;
			}
	}
	
	public function action():Void {
		if(this.isFlying())
			fly_action();
		else
			ground_action();
	}
	
	public function fly_action():Void {
		this.min._y += this.speedMultiplier;
		this.damage_bg._y += this.speedMultiplier;
		this.damage_fg._y += this.speedMultiplier;
	}

	
	public function ground_action():Void {
			var arr:Array;
			var tx :Number;
			var ty:Number;
			var dir:Number;
			var tt:Number;
			
			this.checkSpeed();
			arr = _root.app.getLead(this.targetId, this.min._x,this.min._y);
			tx = arr[0];
			ty = arr[1];
			this.targetId = arr[2];
			dir = this.atan2(this.min._y - ty, this.min._x - tx);
			tt = (this.atan2(
							(ty - this.min._y), 
							(tx - this.min._x)
							) * 180 / pi) + 90;
			if(tt > 180)
					tt = tt - 360;
			if(not this.tryMove(-this.speedMultiplier * this.cos(dir), -this.speedMultiplier * this.sin(dir), 20, true)) {
				if(tt >=-45 and tt < 45) {
					if(this.tryMove(0, -this.speedMultiplier, 20, true)) {
						this.min._rotation = 0;
					}
					else if(tt <= 0) {
						if(this.tryMove(-this.speedMultiplier, 0, 20, true)) {
							this.min._rotation = -90;
						}
					}
					else {
						if(this.tryMove(this.speedMultiplier, 0, 20, true)) {
							this.min._rotation = 90;
						}
					}
				}
				else if(tt >= 45 and tt < 135) {
					if(this.tryMove(this.speedMultiplier, 0, 20, true)) {
						this.min._rotation = 90;
					}
					else if(tt <= 90) {
						if(this.tryMove(0, -this.speedMultiplier, 20, true)) {
							this.min._rotation = 0;
						}
					}
					else {
						if(this.tryMove(0, this.speedMultiplier, 20, true)) {
							this.min._rotation = 180;
						}
					}
				}
				else if(tt >= 135 or tt < -135) {
					if(this.tryMove(0, this.speedMultiplier, 20, true)) {
						this.min._rotation = 180;
					}
					else if(tt >= 135) {
						if(this.tryMove(this.speedMultiplier, 0, 20, true)) {
							this.min._rotation = 90;
						}
					}
					else {
						if(this.tryMove(-this.speedMultiplier, 0, 20, true)) {
							this.min._rotation = -90;
						}
					}
				}
				else if(tt >= -135 and tt < -45) {
					if(this.tryMove(-this.speedMultiplier, 0, 20, true)) {
						this.min._rotation = -90;
					}
					else if(tt <= -90) {
						if(this.tryMove(0, this.speedMultiplier, 20, true)) {
							this.min._rotation = 180;
						}
					}
					else {
						if(this.tryMove(0, -this.speedMultiplier, 20, true)) {
							this.min._rotation = 0;
						}
					}
				}
			}
			else
				this.min._rotation = tt; 
	}
	
	public function addDamage(damage:Number):Number {
		//trace("damage " + damage + " life " + this.life);
		this.life -= damage;
		this.damage_fg._width = this.maxDamageWidth / (this.maxLife / life);
		this.damage_fg._x = this.damage_bg._x + 1
		if(this.life <= 0) {
			this.destroy();
			return int(this.maxLife / 2);
		}
		return 0;
	}
	
	public function destroy():Void {
		//trace("BaseMonster.destroy");		
		this.life = 0;
		this.targetId = 0;
		this.min.removeMovieClip();
		this.damage_bg.removeMovieClip();
		this.damage_fg.removeMovieClip();
	}
	
	public function isAlive():Boolean {
		return (this.life > 0);
	}
	public function getRandomNumber(minNum:Number, maxNum:Number):Number {
		return this.ceil(myrandom() * (maxNum - minNum + 1)) + (minNum - 1);
	}
	
	public function getX():Number {
		return this.min._x;
	}
	public function getY():Number {
		return this.min._y;
	}
	public function getDepth():Number {
		return this.min.getDepth();
	}
	public function getCategory():Number {
		if(
		   	(this instanceof SlowSmallCar) or
			(this instanceof FastSmallCar) or
			(this instanceof SlowBigCar) or
			(this instanceof FastBigCar)
			)
			return Type.type_Cars;
		else if(
		   	(this instanceof SlowSmallPlane) or
			(this instanceof FastSmallPlane) or
			(this instanceof SlowBigPlane) or
			(this instanceof FastBigPlane)
			)
			return Type.type_Planes;
		else return -1;
	}
}