import Tower;
import Monster;
import flash.geom.Rectangle;
import flash.geom.Point;


// TODO GLOBAL: SET X,Y,ROT,ALPHA ON MOVIECLIPS ONLY IF THE VALUE CHANGES
class Main {
	private var delay:Number;
	private var new_monster:Number;
	private var monsters_placed:Number;
	private var towers:Array;
	private var monsters:Array;
	private var levels:Array;
	private var gain:Number;
	private var life:Number;
	private var actors:Type;
	private var current_level:Number;
	private var pos_range:MovieClip;
	private var width:Number;
	private var height:Number;
	
	public function Main() {
		this.width = 500;
		this.height = 400;
		this.actors = new Type();
	}
	
	public function getWidth():Number {
		return this.width;
	}
	
	public function getHeight():Number {
		return this.height;
	}
	
	public function newGame():Void {
		var x:Number;
		this.gain = 500;
		this.life = 10;
		this.levels = new Array();
		for(x in this.levels)
			if(this.levels[x].isActive())
				this.levels[x].disactivate();
		this.levels[0] = new LevelOne();
		this.levels[1] = new LevelTwo();
		this.levels[2] = new LevelThree();
		this.levels[3] = new LevelFour();
		this.levels[4] = new LevelFive();
		this.levels[0].activate();
		this.initPosRange();
		this.current_level = 0;
		this.delay = 75;
		this.new_monster = 0;
		this.monsters_placed = 0;
		this.resetActors();
	}
	
	public function destroyMonsters():Void {
		var x:Number;
		for(x in this.monsters) {
			this.monsters[x].destroy();
			this.monsters[x] = null;
		}
	}
	
	public function destroyTowers():Void {
		var x:Number;
		for(x in this.towers) { 
			if(this.towers[x].isAlive())
				this.towers[x].destroy();
			this.towers[x] = null;
		}
	}
	
	public function resetActors():Void {
		this.destroyMonsters();
		this.destroyTowers();
		this.towers = new Array();
		this.monsters = new Array();
	}
	
	public function nextLevel() {
		this.resetActors();
		this.hidePosRange();
		this.levels[this.current_level].disactivate();
		this.current_level++;
		this.levels[this.current_level].activate();
		this.gain += (200 * this.current_level);
		this.initPosRange();
	}
	
	public function nextSweep() {
		this.destroyMonsters();
		this.monsters = this.levels[this.current_level].newMonsters();
	}
	
	public function tryToSellTower(mouse_x:Number, mouse_y:Number) {
		var x:Number;
		for(x in this.towers) {
			if(this.towers[x].isAlive() and this.towers[x].doHitTest(mouse_x, mouse_y, true)) {
				this.gain += int(
					_root.app.actors.getCostByThisType(
							_root.app.actors.getTowerTypeOfInstance(
									this.towers[x]
									)
							) * 0.8);
				this.towers[x].destroy();
				this.towers.splice(x, 1);
				return;
			}
		}
	}
	
	public function tryToBuildTower(mouse_x:Number, mouse_y:Number):Void {
		var p:Point;
		if(this.actors.typeIsSet() and 
		   (this.gain >= this.actors.getCostByType())) {
			p = this.actors.getAnchorByType(mouse_x, mouse_y);
			//if(not this.occupied(mouse_x, mouse_y))
			if(not this.occupied(p.x, p.y))
				this.newTower(p.x, p.y);				
		}
	}

	public function inViewport(mouse_x:Number, mouse_y:Number):Boolean {
		return (
				((mouse_x + (this.actors.getWidthByType() / 2)) <= this.width)
			and
				((mouse_y + (this.actors.getHeightByType() / 2)) <= this.height)
			);
	}

	public function onTower(mouse_x:Number, mouse_y:Number):Boolean {
		var x:Number;
		for(x in this.towers) {
			if(
			   this.towers[x].isAlive() and
			   this.towers[x].doHitTest(mouse_x, mouse_y, true)
			)
				return true;
		}
		return false;
	}

	public function occupied(mouse_x:Number, mouse_y:Number):Boolean {
		if(not inViewport(mouse_x, mouse_y))
			return true;
		if(onTower(mouse_x, mouse_y))
			return true;
		return not this.levels[this.current_level].canBuild(
														mouse_x, 
														mouse_y, 
														((this.actors.getWidthByType() / 2) - 4)
														);
	}
	
	public function addMoney(amount:Number):Void {
		this.gain += amount;
		_root.updateLabel();
	}
	
	public function action(mouse_x:Number, mouse_y:Number, actionActors:Boolean):Number {
		//var start:Number = new Date().getTime();
		//trace("start: " + start);
		var p:Point = null;
		var res:Number = Type.type_Running;
		var found:Boolean = false;
		var bodyCount:Number = this.monsters.length;
		var x:Number;
		var resetP:Boolean;

		if(this.actors.typeIsSet())
			p = this.actors.getAnchorByType(mouse_x, mouse_y);
		if(this.life <= 0)
			return res;
		//var stop:Number = new Date().getTime();
		//trace("phase 1 : " + (stop - start));
		//start = new Date().getTime();
		for(x in this.towers) {
			if(not this.towers[x].isAlive()) {
				continue;
			}
			if(actionActors) {
				this.towers[x].action();
			}
			resetP = false;
			if(p == null) {
				p = this.actors.getAnchorOfType(this.towers[x], mouse_x, mouse_y);
				// button unselected TODO
				resetP = true;
			}
			if(this.towers[x].doHitTest(p.x, p.y, true)) {
				this.towers[x].activateRange(true);
				found = true;
			}
			else {
				this.towers[x].activateRange(false);
			}
			if(resetP)
				p = null;
		}
		//stop = new Date().getTime();
		//trace("phase 2: " + (stop - start));
		

		//start = new Date().getTime();
		if(actionActors) {
			for(x in this.monsters) {
				if(this.monsters[x].isAlive()) {
					if(this.monsters[x].min._y > (this.height - 10)) {
						res = Type.type_Kill;
						if(this.monsters.length == 1) {
							res = Type.type_FinalKill;
							trace("final kill " + x + " l " + this.monsters.length);
							//break;
						}
						else 
							trace("kill " + x + " l " + this.monsters.length); 
						this.monsters[x].destroy();
						this.monsters.splice(x, 1);
						this.life--;
						trace("life " + this.life); 
					
						if(this.life == 0) {
							//trace("out fo life");
							return Type.type_YouLoose;
							//break;
						}
						if(res == Type.type_FinalKill)
							break;
					}
					//if(actionActors) 
						this.monsters[x].action();
				}
				else
					bodyCount--;
			} 
			//trace("bc:" + bodyCount + " hsw: " + this.levels[this.current_level].hasSweep());
			//trace("bc:" + bodyCount + " res " + res + " l " + this.monsters.length + " a " + actionActors);
			if(
			   (res == Type.type_FinalKill) or 
			   (bodyCount == 0)
			   ) { 
				//if(this.monsters.length == 0)
					//return Type.type_EndOfLevel;
				res = Type.type_EndOfSweep;
				for(x in this.towers) 
					this.towers[x].shoot(false);
				if(!this.levels[this.current_level].hasSweep()) {
					if(this.current_level < (levels.length - 1)) {
						res = Type.type_EndOfLevel;
						//nextLevel();
					}
					else {
						//trace("end of game you won");
						res = Type.type_YouWin;
					}
				}
				_root.updateLabel();
	
			}
		}
		//else
			//trace("attack mode false");
		//stop = new Date().getTime();
		//trace("phase 3: " + (stop - start));
		//start = new Date().getTime();

		if(this.actors.typeIsSet() and (!found) and (_root._xmouse < this.width))
			this.showPosRange(_root._xmouse, _root._ymouse);
		else  
			this.hidePosRange();
		//stop = new Date().getTime();
		//trace("phase 4: " + (stop - start));
		//trace("stop: " + stop);
		return res;
	}

	private function initPosRange():Void {
		var depth = _root.app.actors.getNextDepth(Type.type_Max);
		this.pos_range = _root.attachMovie(
							"range", 
							"range" + depth, 
							depth, 
							{_width:40, _height:40}
							);
		this.pos_range.alpha = 0;
	}
	
	private function showPosRange(x:Number, y:Number):Void {
		var rw = this.actors.getRangeByType();
		if(
		   (this.pos_range._alpha == 100) and
		   (this.pos_range._x == x) and
		   (this.pos_range._y == y) and
		   (this.pos_range._width == rw)
		   ) return;
		this.pos_range._alpha = 100;
		this.pos_range._x = x;
		this.pos_range._y = y;
		this.pos_range._width = this.actors.getRangeByType();
		this.pos_range._height = this.actors.getRangeByType();
	}
	
	private function hidePosRange():Void {
		this.pos_range._alpha = 0;
	}	
	
	public function newTower(x:Number, y:Number):Void {
		this.towers[towers.length] = this.actors.getTowerByType(x, y);
		//var i = this.towers[towers.length - 1].getCategory();
		//trace((i == Type.type_Towers) + " " + i + " " + this.towers[towers.length - 1]);

		this.gain -= this.actors.getCostByType();
	}
	
	public function unsetTowerType():Void {
		this.pos_range._alpha = 0;
		this.actors.unsetType();
	}
	
	public function setTowerType(a:Number):Void {
		this.actors.setType(a);
	}
	
	public function getCurrentLevelForDisplay():Number {
		return this.current_level + 1;
	}
	
	public function getCurrentSweepForDisplay():Number {
		return this.levels[this.current_level].getCurrentSweep() + 1
	}
	
	public function getMoneyForDisplay():Number {
		return this.gain;
	}

	public function getLifeForDisplay():Number {
		return this.life;
	}
	
	public function isOnRoad(mousex:Number, mousey:Number, size:Number):Boolean {
		//trace("isOnRoad" + this.current_level);
		return this.levels[this.current_level].isOnRoad(mousex, mousey, size);
	}
	
	public function getLead(id:Number, x:Number, y:Number):Array {
		//trace("level " + this.current_level);
		return this.levels[this.current_level].getLead(id, x, y);
	}
	
	public function getScoreForDisplay():String {
			var l = this.current_level + 1;
			return 	"Money: " + Math.round(this.gain) + "\n" +
						"Lifes: " + this.life + " X 1000: " + (this.life * 1000) + "\n" +
						"Levels: " + l + " X 1000: " + (l * 1000) + "\n" +
						"Total: " + (Math.round(this.gain) + (this.life * 1000) + (l * 1000));
	}
}

