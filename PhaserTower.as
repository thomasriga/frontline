/*
Frontline Copyright (C) 2010 Thomas Riga

This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

Contact the author at thomasriga@gmail.com (http://www.thomasriga.com)
*/
import Tower;
import BaseTower;

class PhaserTower extends BaseTower {
	
	public static var st_width:Number = 30;
	public static var st_height:Number = 30;
	public static var st_range:Number = 150;
	public static var st_cost:Number = 150;
	public static var st_name:String = "Phaser";
	public static var st_desc:String = "Slow Ground\nTargets Down";
 
	public function PhaserTower(x:Number, y:Number) {
		var depth:Number;
		this.base_range = st_range;
		this.base_width = st_width;
		this.base_height = st_height;
		this.shotgun_width = 20;
		this.shotgun_height = 20;
		this.shot_width = 40;
		this.shot_delay = 30;
		this.shot_height = 20;
		this.rotation_speed = 7;
		this.damage = 10;
		this.cost = st_cost;

		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.base = _root.attachMovie(
						   "sniper_base", 
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
							"phaser_shot", 
							"shot" + depth, 
							depth,
							{_width:this.shot_width, _height:this.shot_height}
							)
		this.shot._x = x;
		this.shot._y = y;
		this.shot._alpha = 0;
		
		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.shotgun = _root.attachMovie(
							"phaser", 
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

		id = this.getFirstGroundMonsterInRange();
		if(id >= 0) {
			shootTheMF = this.aimAt(id);
			if(this.shot_delayC >= this.shot_delay) {
				this.shot_delayC = 0;
				this.shoot(shootTheMF);
				if(shootTheMF) {
					_root.app.monsters[id].speedMultiplier *= 0.6;
					if(_root.app.monsters[id].speedMultiplier < 0.3)
						_root.app.monsters[id].speedMultiplier = 0.3;
				}
				/*
				if(_root.app.monsters[id].speedMultiplier > 1) {
					_root.app.monsters[id].recoveryC = 30;
					_root.app.monsters[id].speedMultiplier = 0;
				}
				*/
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