/*
Frontline Copyright (C) 2010 Thomas Riga

This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

Contact the author at thomasriga@gmail.com (http://www.thomasriga.com)
*/
interface Level {	
	public function getMonsterType(id:Number):Number;
	public function hasSweep():Boolean;
	public function nextSweep():Number;
	public function resetSweep():Number;
	public function getCurrentSweep():Number;
	public function activate():Void;
	public function disactivate():Void;
	public function isOnRoad(mousex:Number, mousey:Number, size:Number):Boolean;
	public function getLead(id:Number, x:Number, y:Number):Array;
	public function hasReached(id:Number, x:Number, y:Number):Boolean;
}