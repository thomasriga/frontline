class BaseMissile {
		private var base:MovieClip;
		private var base_width:Number = 18;
		private var base_height:Number = 8;
		private var damage:Number = 300;
		private static var pi:Number = Math.PI;
	
		public function BaseMissile(id:Number, x:Number, y:Number) {
			var depth:Number;
			depth = _root.app.actors.getNextDepth(Type.type_Missiles);
			this.base = _root.attachMovie(
							   "ai_guided_missile", 
							   "guided_missile" + depth, 
							   depth,
							   {_width:this.base_width, _height:this.base_height}
							   );
			this.base._x = x;
			this.base._y = y;
			this.base.id = id;
			this.base.mdepth = _root.app.monsters[id].getDepth();
			this.base.onEnterFrame = function() {
				var exp:MovieClip;
				var tx:Number;
				var ty:Number;
				var depth:Number;
				
				if(not _root.attack_mode) {
						this.removeMovieClip();
						return;
				}
				
				if(
				   (_root.app.monsters.length > this.id) and 
				   _root.app.monsters[this.id].isAlive() and
				   (this.mdepth == _root.app.monsters[this.id].getDepth())
				   ) {
					tx = this._x - _root.app.monsters[this.id].getX();
					ty = this._y - _root.app.monsters[this.id].getY();
					this.dir = Math.atan2(ty, tx);
					this._x -= 3* Math.cos(this.dir);
					this._y -= 3* Math.sin(this.dir);
					this._rotation = (Math.atan2(
								(_root.app.monsters[this.id].getY() - this._y), 
								(_root.app.monsters[this.id].getX() - this._x)
								) * 180 / pi);

							
					if ((this._x<0) or (this._y<0) or (this._y>400) or (this._x>500)) {
								this.removeMovieClip();
								return;
					}
					if(
						   _root.app.monsters[this.id].doHitTest(this._x, this._y, false) and
						   _root.app.monsters[this.id].doHitTest(this._x - 2, this._y - 2, false) and
						   _root.app.monsters[this.id].doHitTest(this._x + 2, this._y - 2, false) and
						   _root.app.monsters[this.id].doHitTest(this._x + 2, this._y + 2, false) and
						   _root.app.monsters[this.id].doHitTest(this._x - 2, this._y + 2, false) 
						   ) {
							_root.app.addMoney(
											_root.app.monsters[this.id].addDamage(50)
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
									};
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

	public function getWidth():Number {
		return this.base_width;
	}

	public function getHeight():Number {
		return this.base_height;
	}

	public function doHitTest(mouse_x:Number,mouse_y:Number, flagB:Boolean):Boolean { 	
		return this.base.hitTest(mouse_x, mouse_y, flagB);
	}
	
   public function destroy():Void {
	   	this.base.removeMovieClip();
   }
}