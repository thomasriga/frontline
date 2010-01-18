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