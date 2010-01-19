/*
Frontline Copyright (C) 2010 Thomas Riga

This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

Contact the author at thomasriga@gmail.com (http://www.thomasriga.com)
*/
class BaseActor {
	
	public function BaseActor() {		
	}
	
	public function getCategory() {
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
		else if(
		   	(this instanceof BulletTower) or
			(this instanceof AntiAirTower) or
			(this instanceof PhaserTower) or
			(this instanceof GuidedMissileTower) or
			(this instanceof AIMissileTower) or
			(this instanceof IR_PointerTower)
			)
			return Type.type_Towers;
		else if(this instanceof BaseMissile)
			return Type.type_Missiles;
		else return -1;
	}
}