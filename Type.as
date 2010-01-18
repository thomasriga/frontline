import flash.geom.Point;

class Type {
	public static var 	type_YouLoose:Number = 1,
						type_EndOfLevel:Number = 2,
						type_Running:Number = 3,
						type_EndOfSweep:Number = 4,
						type_YouWin:Number = 5,
						type_Splash:Number = 6,
						type_Kill:Number = 7,
						type_FinalKill:Number = 8,
						type_BootSplash:Number = 9,
						type_WrongSite:Number = 10;

	public static var 	type_BulletTower:Number = 1,
						type_GuidedMissileTower:Number = 2,
						type_AIMissileTower:Number = 3,
						type_PhaserTower:Number = 4,
						type_AntiAirTower:Number = 5,
						type_IR_PointerTower:Number = 6,
						type_FlameThrowerTower:Number = 7,
						type_MultishotTower:Number = 8,
						type_ScramblerTower:Number = 9,
						type_NotYetImplemented:Number = type_BulletTower;
						
	 public static var 	type_SlowSmallCar:Number = 51,
	 					type_FastSmallCar:Number = 53,
	 					type_SlowBigCar:Number = 55,
	 					type_FastBigCar:Number = 57,
						type_SlowSmallPlane:Number = 52,
						type_FastSmallPlane:Number = 54,
						type_SlowBigPlane:Number = 56,
						type_FastBigPlane:Number = 58;
						
						
	public static var 	type_Background:Number = 0,
						type_Towers:Number = 1,
						type_Cars:Number = 2,
						type_Planes:Number = 3,
						type_Bullets:Number = 4,
						type_Missiles:Number = 5,
						type_Explosions:Number = 6,
						type_Max:Number = 7,
						type_Limit:Number = 8;
						
	private var testF:Number;
	private var minDepth:Array;
	
	public function Type() {
		var 	depth_Background:Number = 500,
				depth_Towers:Number = 1000,
				depth_Cars:Number = 1500,
				depth_Planes:Number = 2000,
				depth_Bullets:Number = 2500,
				depth_Missiles:Number = 3000,
				depth_Explosions:Number = 3500,
				depth_Max:Number = 4000,
				depth_Limit:Number = 5000;
		this.testF = -1;
		this.minDepth = new Array();
		this.minDepth[type_Background] = depth_Background;
		this.minDepth[type_Towers] = depth_Towers;
		this.minDepth[type_Cars] = depth_Cars;
		this.minDepth[type_Planes] = depth_Planes;
		this.minDepth[type_Bullets] = depth_Bullets;
		this.minDepth[type_Missiles] = depth_Missiles;
		this.minDepth[type_Explosions] = depth_Explosions;		
		this.minDepth[type_Max] = depth_Max;		
		this.minDepth[type_Limit] = depth_Limit;		
	}
	
	public function setType(a:Number) {
		this.testF = a;
	}
	
	public function unsetType() {
		this.testF = -1;
	}
	
	public function getType():Number {
		return this.testF;
	}
	
	public function typeIsSet():Boolean {
		return (this.testF > 0);
	}
	
	public function getTowerTypeOfInstance(tower:Tower):Number {
		if(tower instanceof BulletTower) 
			return type_BulletTower;
		else if(tower instanceof GuidedMissileTower) 
			return type_GuidedMissileTower;
		else if(tower instanceof AIMissileTower) 
			return type_AIMissileTower;
		else if(tower instanceof PhaserTower) 
			return type_PhaserTower;
		else if(tower instanceof AntiAirTower) 
			return type_AntiAirTower;
		else if(tower instanceof IR_PointerTower) 
			return type_IR_PointerTower;
		else if(tower instanceof  FlameThrowerTower) 
			return type_FlameThrowerTower;
		else if(tower instanceof MultishotTower) 
			return type_MultishotTower;
		else if(tower instanceof ScramblerTower) 
			return type_ScramblerTower;
		else 
			return type_BulletTower;
	}
	
	public function getCostByType():Number {
		return this.getCostByThisType(this.testF);
		/*
		if(this.testF == type_BulletTower)
			return BulletTower.st_cost;
		else if(this.testF == type_GuidedMissileTower)
			return GuidedMissileTower.st_cost;
		else if(this.testF == type_AIMissileTower)
			return AIMissileTower.st_cost;
		else if(this.testF == type_PhaserTower)
			return PhaserTower.st_cost;
		else if(this.testF == type_AntiAirTower)
			return AntiAirTower.st_cost;
		else if(this.testF == type_IR_PointerTower)
			return IR_PointerTower.st_cost;
		else if(this.testF == type_FlameThrowerTower)
			return FlameThrowerTower.st_cost;
		else if(this.testF == type_MultishotTower)
			return MultishotTower.st_cost;
		else if(this.testF == type_ScramblerTower)
			return ScramblerTower.st_cost;
		else 
			return BulletTower.st_cost;
			*/
	}
	
	public function getCostByThisType(val:Number):Number {
		if(val == type_BulletTower)
			return BulletTower.st_cost;
		else if(val == type_GuidedMissileTower)
			return GuidedMissileTower.st_cost;
		else if(val == type_AIMissileTower)
			return AIMissileTower.st_cost;
		else if(val == type_PhaserTower)
			return PhaserTower.st_cost;
		else if(val == type_AntiAirTower)
			return AntiAirTower.st_cost;
		else if(val == type_IR_PointerTower)
			return IR_PointerTower.st_cost;
		else if(val == type_FlameThrowerTower)
			return FlameThrowerTower.st_cost;
		else if(val == type_MultishotTower)
			return MultishotTower.st_cost;
		else if(val == type_ScramblerTower)
			return ScramblerTower.st_cost;
		else 
			return BulletTower.st_cost;
	}
	
	public function getWidthByType():Number {
		return internalGetWidthByType(this.testF);
	}
	
	public function internalGetWidthByType(testF:Number):Number {	
		if(this.testF == type_BulletTower)
			return BulletTower.st_width;
		else if(this.testF == type_GuidedMissileTower)
			return GuidedMissileTower.st_width;
		else if(this.testF == type_AIMissileTower)
			return AIMissileTower.st_width;
		else if(this.testF == type_PhaserTower)
			return PhaserTower.st_width;
		else if(this.testF == type_AntiAirTower)
			return AntiAirTower.st_width;
		else if(this.testF == type_IR_PointerTower)
			return IR_PointerTower.st_width;
		else if(this.testF == type_FlameThrowerTower)
			return FlameThrowerTower.st_width;
		else if(this.testF == type_MultishotTower)
			return MultishotTower.st_width;
		else if(this.testF == type_ScramblerTower)
			return ScramblerTower.st_width;
		else 
			return BulletTower.st_width;
	}
	
	public function getHeightByType():Number {
		return internalGetHeightByType(this.testF);
	}
	
	public function internalGetHeightByType(testF:Number):Number {
		if(this.testF == type_BulletTower)
			return BulletTower.st_height;
		else if(this.testF == type_GuidedMissileTower)
			return GuidedMissileTower.st_height;
		else if(this.testF == type_AIMissileTower)
			return AIMissileTower.st_height;
		else if(this.testF == type_PhaserTower)
			return PhaserTower.st_height;
		else if(this.testF == type_AntiAirTower)
			return AntiAirTower.st_height;
		else if(this.testF == type_IR_PointerTower)
			return IR_PointerTower.st_height;
		else if(this.testF == type_FlameThrowerTower)
			return FlameThrowerTower.st_width;
		else if(this.testF == type_MultishotTower)
			return MultishotTower.st_height;
		else if(this.testF == type_ScramblerTower)
			return ScramblerTower.st_width;
		else 
			return BulletTower.st_width;
	}
	
	public function getRangeByType():Number {
		if(this.testF == type_BulletTower)
			return BulletTower.st_range;
		else if(this.testF == type_GuidedMissileTower)
			return GuidedMissileTower.st_range;
		else if(this.testF == type_AIMissileTower)
			return AIMissileTower.st_range;
		else if(this.testF == type_PhaserTower)
			return PhaserTower.st_range;
		else if(this.testF == type_AntiAirTower)
			return AntiAirTower.st_range;
		else if(this.testF == type_IR_PointerTower)
			return IR_PointerTower.st_range;
		else if(this.testF == type_FlameThrowerTower)
			return FlameThrowerTower.st_range;
		else if(this.testF == type_MultishotTower)
			return MultishotTower.st_range;
		else if(this.testF == type_ScramblerTower)
			return ScramblerTower.st_range;
		else 
			return BulletTower.st_range;
	}
	
	public function getAnchorByType(x:Number, y:Number):Point {
			var w:Number = this.getWidthByType();
			var h:Number = this.getHeightByType();
			var point:Point = new Point(); 
			point.x = (((x - (x % w)) / w) * w) + (w / 2);
			point.y = (((y - (y % h)) / h) * h) + (h / 2);
			return point;
	}

	public function getAnchorOfType(obj:Tower, x:Number, y:Number):Point {
		var type:Number = getTowerTypeOfInstance(obj);
		var w:Number = this.internalGetWidthByType(type);
		var h:Number = this.internalGetHeightByType(type);
		var point:Point = new Point(); 
		point.x = (((x - (x % w)) / w) * w) + (w / 2);
		point.y = (((y - (y % h)) / h) * h) + (h / 2);
		return point;
	}	
	
	public function getTowerByType(x:Number, y:Number):Tower {
		if(this.testF == type_BulletTower) 
			return new BulletTower(x, y);
		else if(this.testF == Type.type_GuidedMissileTower) 
			return new GuidedMissileTower(x, y);
		else if(this.testF == Type.type_AIMissileTower) 
			return new AIMissileTower(x, y);
		else if(this.testF == Type.type_PhaserTower) 
			return new PhaserTower(x, y);
		else if(this.testF == Type.type_AntiAirTower) 
			return new AntiAirTower(x, y);
		else if(this.testF == Type.type_IR_PointerTower) 
			return new IR_PointerTower(x, y);
		else if(this.testF == Type.type_FlameThrowerTower) 
			return new FlameThrowerTower(x, y);
		else if(this.testF == Type.type_MultishotTower) 
			return new MultishotTower(x, y);
		else if(this.testF == Type.type_ScramblerTower) 
			return new ScramblerTower(x, y);
		else 
			return new BulletTower(x, y);
	}
	
	public function getNextDepth(id:Number):Number {
		//trace(id + " " + minDepth[id] + " " + minDepth[id + 1]);
		var m:MovieClip;
		var x:Number;
		
		for(x = this.minDepth[id]; x < this.minDepth[id + 1]; x++) {
			//trace(x);
			m = _root.getInstanceAtDepth(x);
			if(m == null) {
				//trace("depth " + x + "[" + minDepth[id] + "-" + minDepth[id + 1]);
				return x;
			}
		}
		trace("error wrong depth " + id);
		return this.minDepth[id];
	}
}