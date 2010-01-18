class BaseMonster implements Monster {
	private var min:MovieClip;
	private var damage_bg:MovieClip;
	private var damage_fg:MovieClip;
	private var dist_x:Number;
	private var dist_y:Number;
	private var angle:Number;
	private var speedMultiplier:Number;
	private var speed:Number;
	private var minSpeed:Number;
	private var maxSpeedMultiplier:Number;
	private var speedC:Number;
	private var life:Number;
	private var maxLife:Number;
	private var maxDamageWidth:Number;
	private var targetId:Number = 0;
	private var last_move_type:Number;
	private var recoveryC = 0;
	
	public function BaseMonster() {		
	}
	
	public function isFlying() {		
		return false;
	}
	
	public function setup(x, y) {
		this.minSpeed = speed;
		this.maxSpeedMultiplier = speedMultiplier;
		this.damage_bg = _root.attachMovie(
									 "damage_bg", 
									 "damage_bg"+_root.getNextHighestDepth(), 
									 _root.getNextHighestDepth()
									 );
		this.damage_bg._x = x - damage_bg._width / 2;
		this.damage_bg._y = y;
		this.damage_fg = _root.attachMovie(
									 "damage_fg", 
									 "damage_fg"+_root.getNextHighestDepth(), 
									 _root.getNextHighestDepth()
									 );
		this.damage_fg._x = x - damage_fg._width / 2;
		this.damage_fg._y = y;
		this.maxDamageWidth = damage_fg._width;
	}
	
	public function doHitTest(mouse_x:Number,mouse_y:Number, flagB:Boolean):Boolean { 	
		var tmp = this.min.hitTest(mouse_x, mouse_y, flagB);
		return tmp;
	}
	
	public function isFree(mousex, mousey) {
		return _root.app.isOnRoad(mousex, mousey, 10);
	}
	
	public function action():Void {
		if(speedC == speed) {
				speedC = 0;
				if(speedMultiplier < maxSpeedMultiplier) {
					if(recoveryC == 0) {
						speedMultiplier++;
						recoveryC = 30;
					}
					else
						recoveryC--;
				}
				var arr = _root.app.getLead(this.targetId, this.getX(),this.getY());
				var tx = arr[0];
				var ty = arr[1];
				this.targetId = arr[2];
				//trace("target " + tx + "x" + ty + " " + arr);
				var dist_from_turret_x = this.min._x - tx;
				var dist_from_turret_y = this.min._y - ty;
				var dir = Math.atan2(dist_from_turret_y, dist_from_turret_x);
				var target = (Math.atan2(
								(ty - this.min._y), 
								(tx - this.min._x)
								) * 180 / Math.PI);
				var tryX = Math.cos(dir);
				var tryY = Math.sin(dir);
				if(not this.isFree((this.min._x - 3* tryX), (this.min._y - 3* tryY), 20)) {
					var tt = target + 90.0;
					if(tt > 180)
						tt = tt - 360;
					//trace("try target " + target + " tt " + tt);
					if(tt >=-45 and tt < 45) {
						//trace("try y-3 " + target + " tt " + tt);
						if(this.isFree(this.min._x, (this.min._y - 3), 10)) {
							//trace("try y-3 1");
							this.min._y -= 3;
							this.damage_bg._y -= 3;
							this.damage_fg._y -= 3;
							this.min._rotation = 0;
						}
						else if(tt <= 0) {
							//trace("try x-3");
							if(this.isFree((this.min._x - 3), this.min._y, 10)) {
								this.min._x -= 3;
								this.damage_bg._x -= 3;
								this.damage_fg._x -= 3;
								this.min._rotation = -90;
							}
						}
						else {
							//trace("try x+3");
							if(this.isFree((this.min._x + 3), this.min._y, 10)) {
								this.min._x += 3;
								this.damage_bg._x += 3;
								this.damage_fg._x += 3;
								this.min._rotation = 90;
							}
						}
					}
					else if(tt >= 45 and tt < 135) {
						//trace("try x+3 " + target + " tt " + tt);
						if(this.isFree((this.min._x + 3), this.min._y, 10)) { 
							this.min._x += 3;
							this.damage_bg._x += 3;
							this.damage_fg._x += 3;
							this.min._rotation = 90;
						}
						else if(tt <= 90) {
							//trace("try y-3");
							if(this.isFree(this.min._x, (this.min._y - 3), 10)) {
								trace("try y-3 2");
								this.min._y -= 3;
								this.damage_bg._y -= 3;
								this.damage_fg._y -= 3;
								this.min._rotation = 0;
							}
						}
						else {
							//trace("try y+3");
							if(this.isFree(this.min._x, (this.min._y + 3), 10)) {
								this.min._y += 3;
								this.damage_bg._y += 3;
								this.damage_fg._y += 3;
								this.min._rotation = 180;
							}
						}
					}
					else if(tt >= 135 or tt < -135) {
						//trace("try y+3 " + target + " tt " + tt);
						if(this.isFree(this.min._x, (this.min._y + 3), 10)) { 
							this.min._y += 3;
							this.damage_bg._y += 3;
							this.damage_fg._y += 3;
							this.min._rotation = 180;
						}
						else if(tt >= 135) {
							//trace("try x+3");
							if(this.isFree((this.min._x + 3), this.min._y, 10)) {
								this.min._x += 3;
								this.damage_bg._x += 3;
								this.damage_fg._x += 3;
								this.min._rotation = 90;
							}
						}
						else {
							//trace("try x-3");
							if(this.isFree((this.min._x - 3), this.min._y, 10)) {
								this.min._x -= 3;
								this.damage_bg._x -= 3;
								this.damage_fg._x -= 3;
								this.min._rotation = -90;
							}
						}
					}
					else if(tt >= -135 and tt < -45) {
						//trace("try x-3 " + target + " tt " + tt);
						if(this.isFree((this.min._x - 3), this.min._y, 10)) { 
							this.min._x -= 3; 
							this.damage_bg._x -= 3;
							this.damage_fg._x -= 3;
							this.min._rotation = -90;
						}
						else if(tt <= -90) {
							//trace("try y+3");
							if(this.isFree(this.min._x, (this.min._y - 3), 10)) {
								this.min._y += 3;
								this.damage_bg._y += 3;
								this.damage_fg._y += 3;
								this.min._rotation = 180;
							}
						}
						else {
							
							if(this.isFree(this.min._x, (this.min._y + 3), 10)) {
								//trace("try y-3 3");
								this.min._y -= 3;
								this.damage_bg._y -= 3;
								this.damage_fg._y -= 3;
								this.min._rotation = 0;
							}
						}
					}
					//trace("touch pos " + this.min._x + "x" + this.min._y);
				}
				else {
					 
					this.min._x -= 3* tryX;
					this.min._y -= 3* tryY;
					this.damage_bg._x -= 3* tryX;
					this.damage_fg._x -= 3* tryX;
					this.damage_bg._y -= 3* tryY;
					this.damage_fg._y -= 3* tryY;
					var target = (Math.atan2(
								(ty - this.min._y), 
								(tx - this.min._x)
								) * 180 / Math.PI);
					target += 90;
					if(target > 180) 
						target -= 360;
					//trace("reg target " + target + " dest " + tx + "x" + ty + " coords " + this.min._x + "x" + this.min._y + " adjust " + (-3* tryX) + " " + (-3* tryY));
					this.min._rotation = target;
				} 
				
		}
		else
				speedC++;
}
	
	/*
	public function action():Void {
		if(speedC == speed) {
				speedC = 0;
				if(speedMultiplier < maxSpeedMultiplier) {
					if(recoveryC == 0) {
						speedMultiplier++;
						recoveryC = 30;
					}
					else
						recoveryC--;
				}
				var arr = _root.app.getLead(this.targetId, this.getX(),this.getY());
				var tx = arr[0];
				var ty = arr[1];
				this.targetId = arr[2];
				//trace("target " + tx + "x" + ty + " " + arr);
				var dist_from_turret_x = this.min._x - tx;
				var dist_from_turret_y = this.min._y - ty;
				var dir = Math.atan2(dist_from_turret_y, dist_from_turret_x);
				var target = (Math.atan2(
								(ty - this.min._y), 
								(tx - this.min._x)
								) * 180 / Math.PI);
				var tryX = Math.cos(dir);
				var tryY = Math.sin(dir);
				if(not this.isFree((this.min._x - 3* tryX), (this.min._y - 3* tryY), 20)) {
					var tt = target + 90;
					if(tt > 180)
						tt = tt - 360;
					trace("try target " + target + " tt " + tt);
					if(tt >=-45 and tt < 45) {
						trace("try y-3 " + target + " tt " + tt);
						if(this.isFree((this.min._y - 3), this.min._y, 10))
							this.min._y -= 3;
					}
					else if(tt >= 45 and tt < 135) {
						trace("try x+3 " + target + " tt " + tt);
						if(this.isFree((this.min._x + 3), this.min._y, 10)) 
							this.min._x += 3;
					}
					else if(tt >= 135 or tt < -135) {
						trace("try y+3 " + target + " tt " + tt);
						if(this.isFree(this.min._x, (this.min._y + 3), 10)) 
							this.min._y += 3;
					}
					else if(tt >= -135 and tt < -45) {
						trace("try x-3 " + target + " tt " + tt);
						if(this.isFree((this.min._x - 3), this.min._y, 10)) 
							this.min._x -= 3; 
					}

				}
				else {
					this.min._x -= 3* tryX;
					this.min._y -= 3* tryY;
					var target = (Math.atan2(
								(ty - this.min._y), 
								(tx - this.min._x)
								) * 180 / Math.PI);
	
					//this.min._rotation = target + 90;
				}+ 
				trace("pos " + this.min._x + "x" + this.min._y);
		}
		else
				speedC++;
}
	
	*/
	
	
	
	
	/*
	public function action():Void {
		var rnd;
		if(speedC == speed) {
				speedC = 0;
				if(speedMultiplier < maxSpeedMultiplier) {
					if(recoveryC == 0) {
						speedMultiplier++;
						recoveryC = 30;
					}
					else
						recoveryC--;
				}
				if(this.isFree(
							this.min._x, 
							this.min._y + speedMultiplier
							)
				   ) {
					this.min._y+=speedMultiplier;
					this.damage_bg._y+=speedMultiplier;
					this.damage_fg._y+=speedMultiplier;
					this.min._rotation = 180;
					last_move_type = 1;
					return;
				}
				if((last_move_type == 2) and this.isFree(
											this.min._x + speedMultiplier, 
											this.min._y
											)
				   ) {
					this.min._x+=speedMultiplier;
					this.damage_bg._x+=speedMultiplier;
					this.damage_fg._x+=speedMultiplier;
					this.min._rotation = 90;
					last_move_type = 2;
					return;
				}
				else if((last_move_type == 3) and this.isFree(
											this.min._x - speedMultiplier, 
											this.min._y
											)
				   ) {
					this.min._x-=speedMultiplier;
					this.damage_bg._x-=speedMultiplier;
					this.damage_fg._x-=speedMultiplier;
					this.min._rotation = -90;
					last_move_type = 3;
					return;
				}
				else if((last_move_type == 4) and this.isFree(
											this.min._x, 
											this.min._y - speedMultiplier
											)
				   ) {
					this.min._y-=speedMultiplier;
					this.damage_bg._y-=speedMultiplier;
					this.damage_fg._y-=speedMultiplier;
					this.min._rotation = 0;
					last_move_type = 4;
					return;
				}

				
				if(this.isFree(
							this.min._x, 
							this.min._y + speedMultiplier
							)
				   ) {
					this.min._y+=speedMultiplier;
					this.damage_bg._y+=speedMultiplier;
					this.damage_fg._y+=speedMultiplier;
					this.min._rotation = 180;
					last_move_type = 1;
					return;
				}
				rnd = this.getRandomNumber(2, 3);
				//trace("rnd: " + rnd);
				if(rnd == 2) {
					if(this.isFree(
								this.min._x + speedMultiplier, 
								this.min._y
								)
				   	) {
						//trace("right " + rnd);
						this.min._x+=speedMultiplier;
						this.damage_bg._x+=speedMultiplier;
						this.damage_fg._x+=speedMultiplier;
						this.min._rotation = 90;
						last_move_type = 2;
						return;
					}
				}	
				
					if(this.isFree(
								this.min._x - speedMultiplier, 
								this.min._y
								)
				   	) {
						//trace("left " + rnd);
						this.min._x-=speedMultiplier;
						this.damage_bg._x-=speedMultiplier;
						this.damage_fg._x-=speedMultiplier;
						this.min._rotation = -90;
						last_move_type = 3;
						return;
					}
					if(this.isFree(
								this.min._x + speedMultiplier, 
								this.min._y
								)
				   	) {
						//trace("right " + rnd);
						this.min._x+=speedMultiplier;
						this.damage_bg._x+=speedMultiplier;
						this.damage_fg._x+=speedMultiplier;
						this.min._rotation = 90;
						last_move_type = 2;
						return;
					}
				
				if(this.isFree(
							this.min._x, 
							this.min._y - speedMultiplier
							)
				   ) {
					this.min._y-=speedMultiplier;
					this.damage_bg._y-=speedMultiplier;
					this.damage_fg._y-=speedMultiplier;
					this.min._rotation = 0;
					last_move_type = 4;
					return;
				}
				
				
		}
		else
				speedC++;
	}
	*/
	
	public function addDamage(damage:Number):Number {
		//trace("damage " + damage + " life " + this.life);
		this.life -= damage;
		var d = this.maxLife / life;
		this.damage_fg._width = this.maxDamageWidth / d;
		this.damage_fg._x = this.damage_bg._x + 1
		if(this.life <= 0) {
			//trace("calling destroy ");
			var res = this.maxLife / 4;
			this.destroy();
			return res;
		}
		return 0;
	}
	
	public function destroy():Void {
		//trace("BaseMonster.destroy");
		
		this.life = 0;
		this.min.removeMovieClip();
		this.damage_bg.removeMovieClip();
		this.damage_fg.removeMovieClip();
	}
	
	public function isAlive():Boolean {
		return (this.life > 0);
	}
	public function getRandomNumber(minNum, maxNum) {
		return Math.ceil(Math.random() * (maxNum - minNum + 1)) + (minNum - 1);
	}
	
	public function getX():Number {
		return this.min._x;
	}
	public function getY():Number {
		return this.min._y;
	}

}