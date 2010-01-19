/*
Frontline Copyright (C) 2010 Thomas Riga

This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

Contact the author at thomasriga@gmail.com (http://www.thomasriga.com)
*/
class FastSmallCar extends BaseMonster {
	
	public function FastSmallCar(x:Number, y:Number) {		
		var depth:Number;

		this.speedMultiplier = 2.0;
		this.life = 100;
		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.min = _root.attachMovie(
									 "minion", 
									 "minion"+depth, 
									depth,
									 {_x: x, _y: y, _width: 10, _height: 15}
									 );
		this.setup(x, y);
	}
}