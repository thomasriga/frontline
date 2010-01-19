/*
Frontline Copyright (C) 2010 Thomas Riga

This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

Contact the author at thomasriga@gmail.com (http://www.thomasriga.com)
*/
import Tower;

class BaseTower implements Tower {
	private var base:MovieClip;
	private var range:MovieClip;
	private var shot:MovieClip;
	private var shotgun:MovieClip;
	private var base_range:Number = 100;
	private var base_width:Number = 20;
	private var base_height:Number = 20;
	private var shotgun_width:Number = 20;
	private var shotgun_height:Number = 20;
	private var shot_delay:Number = 0;
	private var shot_delayC:Number = 0;
	private var shot_width:Number = 28;
	private var shot_height:Number = 20;
	private var rotation_speed:Number = 5;
	private var damage:Number = 2;
	public var cost:Number = 200;
	private var lastTarget:Number = -1;
	public var is_alive:Boolean = true;
	private static var pi:Number = Math.PI;
	private var atan2 = Math.atan2;
	private var cos = Math.cos;
	private var sin = Math.sin;
	private var ceil = Math.ceil;
	private var sqrt = Math.sqrt;

	public function BaseTower() {

	}
	
	public function isAlive():Boolean {
		return this.is_alive;
	}

	public function getWidth():Number {
		return this.base_width;
	}

	public function getHeight():Number {
		return this.base_height;
	}
	public function getTarget():Number {
		return this.lastTarget;
	}

	public function doHitTest(mouse_x:Number,mouse_y:Number, flagB:Boolean):Boolean { 	
		return this.base.hitTest(mouse_x, mouse_y, flagB);
	}

	public function getFirstMonsterInRange():Number {
		var x:Number;
		if(this.lastTarget >= 0) {
			if(
			   this.isInRange(
							  _root.app.monsters[this.lastTarget].getX(), 
							  _root.app.monsters[this.lastTarget].getY()
							  ) and
			   _root.app.monsters[this.lastTarget].isAlive()
			   ) {
				//trace("from cache: " + this.lastTarget);
				return this.lastTarget;
			}
		}
		for(x in _root.app.monsters) {
			if(
			   this.isInRange(
							  _root.app.monsters[x].getX(), 
							  _root.app.monsters[x].getY()
							  ) and
			   _root.app.monsters[x].isAlive()
			   ) {
				this.lastTarget = x;
				return x;
			}
		}
		this.lastTarget = -1;
		return -1;
	}
	
	public function getFirstFlyingMonsterInRange():Number {
		var x:Number;
		if(this.lastTarget >= 0) {
			if(
			   _root.app.monsters[this.lastTarget].isFlying() and
			   this.isInRange(
							  _root.app.monsters[this.lastTarget].getX(), 
							  _root.app.monsters[this.lastTarget].getY()
							  ) and
			   _root.app.monsters[this.lastTarget].isAlive()
			   ) {
				//trace("from cache flying: " + this.lastTarget);
				return this.lastTarget;
			}
		}
		for(x in _root.app.monsters) {
			//trace("tower range " + _root.monsters[x].getX() + "," + _root.monsters[x].getY());
			if(
			   _root.app.monsters[x].isFlying() and
			   this.isInRange(
							  _root.app.monsters[x].getX(), 
							  _root.app.monsters[x].getY()
							  ) and
			   _root.app.monsters[x].isAlive()
			   ) {
				//trace("fresh flying: " + x);
				this.lastTarget = x;
				return x;
			}
		}
		this.lastTarget = -1;
		return -1;
	}
	
	public function getFirstMonsterWithIRGuidance():Number {
		var x:Number;
		var i:Number;
		for(x in _root.app.towers) {
			if(_root.app.towers[x] instanceof IR_PointerTower) {
				i = _root.app.towers[x].getTargetId();
				if(i >= 0) 
					return i;
			}
		}
		return -1;
	}

	public function hasIRGuidance(id:Number):Boolean {
		var x:Number;
		var i:Number;
		for(x in _root.app.towers) {
			if(_root.app.towers[x] instanceof IR_PointerTower) {
				i = _root.app.towers[x].getTargetId();
				if(i == id) 
					return true;
			}
		}
		return false;
	}
	
	
	public function getFirstFreeGroundMonsterInRange():Number {
		var x:Number;
		if(this.lastTarget >= 0) {
			if(
			   (not _root.app.monsters[this.lastTarget].isFlying()) and
			   (
			   		this.isInRange(
							  _root.app.monsters[this.lastTarget].getX(), 
							  _root.app.monsters[this.lastTarget].getY()
							  ) or this.hasIRGuidance(this.lastTarget)
			   
			   ) and
			   _root.app.monsters[this.lastTarget].isAlive() and
			   this.isFreeTarget(this.lastTarget)
			   ) {
				//trace("free from cache ground: " + this.lastTarget + " " + this);
				return this.lastTarget;
			}
		}
		for(x in _root.app.monsters) {
			//trace("tower range " + _root.monsters[x].getX() + "," + _root.monsters[x].getY());
			if(x == this.lastTarget)
				continue;
			if(
			   (not _root.app.monsters[x].isFlying()) and
			   (
			   		this.isInRange(
							  _root.app.monsters[x].getX(), 
							  _root.app.monsters[x].getY()
							  ) or this.hasIRGuidance(x)
				) and
			   _root.app.monsters[x].isAlive() and
			   this.isFreeTarget(x)
			   ) {
				//trace("free fresh: " + x + " " + this);
				this.lastTarget = x;
				return x;
			}
		}
		//this.lastTarget = -1;
		return -1;
	}

	public function getFirstFreeGroundMonsterInRangeForIR():Number {
		//trace("ffgmirfir " + this.lastTarget);
		var x:Number;
		if(this.lastTarget >= 0) {
			if(
			   (not _root.app.monsters[this.lastTarget].isFlying()) and
			   	this.isInRange(
					  _root.app.monsters[this.lastTarget].getX(), 
					  _root.app.monsters[this.lastTarget].getY()
					  ) and
			   _root.app.monsters[this.lastTarget].isAlive() and
			   this.isFreeIRTarget(this.lastTarget)
			   ) {
				//trace("IR free from cache ground: " + this.lastTarget);
				return this.lastTarget;
			}
		}
		for(x in _root.app.monsters) {
			//trace("tower range " + _root.monsters[x].getX() + "," + _root.monsters[x].getY());
			//if(x == this.lastTarget)
				//continue;
			if(
			   (not _root.app.monsters[x].isFlying()) and
			   this.isInRange(
							  _root.app.monsters[x].getX(), 
							  _root.app.monsters[x].getY()
							  ) and
			   _root.app.monsters[x].isAlive() and
			   this.isFreeIRTarget(x)
			   ) {
				//trace("IR free fresh: " + x);
				this.lastTarget = x;
				return x;
			}
		}
		//this.lastTarget = -1;
		return -1;
	}
	
	public function getFirstGroundMonsterInRange():Number {
		var x:Number;
		if(this.lastTarget >= 0) {
			if(
			   (not _root.app.monsters[this.lastTarget].isFlying()) and
			   (
			   		this.isInRange(
							  _root.app.monsters[this.lastTarget].getX(), 
							  _root.app.monsters[this.lastTarget].getY()
							  ) or this.hasIRGuidance(this.lastTarget)
			   
			   ) and
			   _root.app.monsters[this.lastTarget].isAlive()
			   ) {
				//trace("from cache ground: " + this.lastTarget);
				return this.lastTarget;
			}
		}
		for(x in _root.app.monsters) {
			//trace("tower range " + _root.monsters[x].getX() + "," + _root.monsters[x].getY());
			if(
			   (not _root.app.monsters[x].isFlying()) and
			   this.isInRange(
							  _root.app.monsters[x].getX(), 
							  _root.app.monsters[x].getY()
							  ) and
			   _root.app.monsters[x].isAlive()
			   ) {
				//trace("fresh: " + x);
				this.lastTarget = x;
				return x;
			}
		}
		this.lastTarget = -1;
		return -1;
	}
	
	public function isFreeTarget(id:Number):Boolean {
		var x:Number;
		if(id == this.lastTarget)
			return true;
		for(x in _root.app.towers.length) {
			if(
			   (_root.app.towers[x] instanceof GuidedMissileTower) and 
			   _root.app.towers[x].isAlive() and
				(_root.app.towers[x]. getTargetId() == id)
				)
				return false;
		}
		return true;
	}
	
	public function isFreeIRTarget(id:Number):Boolean {
		var x:Number;
		if(id == this.lastTarget)
			return true;
		for(x in _root.app.towers) {
			if(
			   (_root.app.towers[x] instanceof IR_PointerTower) and 
			   _root.app.towers[x].isAlive() and
				(_root.app.towers[x]. getTargetId() == id)
				)
				return false;
		}
		return true;
	}
	
	public function isMonsterAlive(id:Number):Boolean {
		if(id < _root.app.monsters.length)
			return _root.app.monsters[id].isAlive();
		else
			return false;
	}
	public function getTargetId():Number {
		return this.lastTarget;
	}
	
    public function action():Void {
		var id:Number;
		var shootTheMF:Boolean;
		id = this.getFirstMonsterInRange();
		if(id >= 0) {
			shootTheMF = this.aimAt(id);
			if(this.shot_delayC >= this.shot_delay) {
				this.shot_delayC = -1;
				this.shoot(shootTheMF);
				if(shootTheMF) {
					_root.app.addMoney(
								  _root.app.monsters[id].addDamage(this.damage)
								  );
					if(not _root.app.monsters[id].isAlive())
						_root.app.monsters.splice(id, 1);
				}
			}
			else {
				this.shoot(false);
			}
		}
		else {
				this.shoot(false);
		}
		this.shot_delayC++;
   }
   
	public function aimAt(id:Number):Boolean {
		var target:Number;
		var new_rot:Number;
		var diff:Number;
		
		if(id < 0)
			return false;
		else {
			target = (Math.atan2(
				(_root.app.monsters[id].getY() - this.shot._y), 
				(_root.app.monsters[id].getX() - this.shot._x)
				) * 180 / pi);
			new_rot = this.shot._rotation;
			diff = target - new_rot;
			var diffM = diff;
			if(diffM < 0)
				diffM *= -1;
				
			if((diff > 180) or (diff < -180)) {
				diff *=-1;
				diff %= 180;
			}

			if(diff > 0) 
				new_rot += this.rotation_speed;
			else if(diff < 0) 
				new_rot -= this.rotation_speed;
	
			if(diffM < this.rotation_speed) {
				new_rot = target;
			}
			if(this.shot._rotation != new_rot)
				this.shot._rotation = this.shotgun._rotation = new_rot;
			return (new_rot == target);
		}
   }
   
	public function shoot(doIt) {
		if(doIt) {
			if(this.shotgun._alpha != 0) {
				this.shotgun._alpha = 0;
				this.shot._alpha = 100;
			}
		}
		else {
			if(this.shotgun._alpha != 100) {
				this.shotgun._alpha = 100;
				this.shot._alpha = 0;
			}
		}
		//trace("shoot");
	}
	
   public function isInRange(x:Number, y:Number):Boolean {
		//trace("isInRange params: x " + x + " y " + y);
		var tx:Number = this.base._x - x;
		var ty:Number = this.base._y - y;
		//trace("dist: x " + distance_from_turret_x + " y " + distance_from_turret_y);
	   	return (		   
			sqrt(
				tx * tx +
				ty * ty
				) < 
			(this.base_range / 2)
		);
	}
   
   public function isRangeActivated():Boolean {
	   return (this.range._alpha == 100);
   }
   
   public function activateRange(enable:Boolean):Void {
	   if(enable) {
		    if(this.range._alpha == 100)
				return;
	   		this.range._alpha = 100;
	   }
		else {
		    if(this.range._alpha == 0)
				return;
			this.range._alpha = 0;
		}
   }
   
   public function destroy():Void {
	   	this.base.removeMovieClip();
	   	this.shot.removeMovieClip();
	   	this.shotgun.removeMovieClip();
	   	this.range.removeMovieClip();
		this.is_alive = false;
   }
   
	public function getCategory():Number {
		return Type.type_Towers;
	}
}