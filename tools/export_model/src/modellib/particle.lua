
local cdef = [[
	HANDLE CreateParticle();
	HANDLE CopyParticle(HANDLE particlehandle);
	void CloseParticle(HANDLE particlehandle, bool del);
	HANDLE GetParticleByModel(HANDLE modelhandle, int index);



	const char* GetParticleName(HANDLE  particlehandle);
	void SetParticleName(HANDLE  particlehandle, const char* name);
	int GetParticleObjectId(HANDLE  particlehandle);
	void SetParticleObjectId(HANDLE  particlehandle, int value);
	int GetParticleParentId(HANDLE  particlehandle);
	void SetParticleParentId(HANDLE  particlehandle, int value);
	INTERPOLATOR_HANDLE GetParticleTranslation(HANDLE  particlehandle);
	void SetParticleTranslation(HANDLE camhandle, INTERPOLATOR_HANDLE particlehandle);
	INTERPOLATOR_HANDLE GetParticleRotation(HANDLE  particlehandle);
	void SetParticleRotation(HANDLE camhandle, INTERPOLATOR_HANDLE particlehandle);
	INTERPOLATOR_HANDLE GetParticleScaling(HANDLE  particlehandle);
	void SetParticleScaling(HANDLE camhandle, INTERPOLATOR_HANDLE particlehandle);
	bool GetParticleDontInheritTranslation(HANDLE  particlehandle);
	void SetParticleDontInheritTranslation(HANDLE  particlehandle, bool value);
	bool GetParticleDontInheritRotation(HANDLE  particlehandle);
	void SetParticleDontInheritRotation(HANDLE  particlehandle, bool value);
	bool GetParticleDontInheritScaling(HANDLE  particlehandle);
	void SetParticleDontInheritScaling(HANDLE  particlehandle, bool value);
	bool GetParticleBillboarded(HANDLE  particlehandle);
	void SetParticleBillboarded(HANDLE  particlehandle, bool value);
	bool GetParticleBillboardedLockX(HANDLE  particlehandle);
	void SetParticleBillboardedLockX(HANDLE  particlehandle, bool value);
	bool GetParticleBillboardedLockY(HANDLE  particlehandle);
	void SetParticleBillboardedLockY(HANDLE  particlehandle, bool value);
	bool GetParticleBillboardedLockZ(HANDLE  particlehandle);
	void SetParticleBillboardedLockZ(HANDLE  particlehandle, bool value);
	bool GetParticleCameraAnchored(HANDLE  particlehandle);
	void SetParticleCameraAnchored(HANDLE  particlehandle, bool value);
	VECTOR3* GetParticlePivotPoint(HANDLE  particlehandle);
	void SetParticlePivotPoint(HANDLE  particlehandle, VECTOR3* value);
	int GetParticleType(HANDLE  particlehandle);
	void SetParticleType(HANDLE  particlehandle, int value);

	INTERPOLATOR_HANDLE GetParticleEmissionRate(HANDLE  particlehandle);
	void SetParticleEmissionRate(HANDLE  particlehandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticleGravity(HANDLE  particlehandle);
	void SetParticleGravity(HANDLE  particlehandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticleLongitude(HANDLE  particlehandle);
	void SetParticleLongitude(HANDLE  particlehandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticleLatitude(HANDLE  particlehandle);
	void SetParticleLatitude(HANDLE  particlehandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticleVisibility(HANDLE  particlehandle);
	void SetParticleVisibility(HANDLE  particlehandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticleParticleLifeSpan(HANDLE  particlehandle);
	void SetParticleParticleLifeSpan(HANDLE  particlehandle, INTERPOLATOR_HANDLE interpolatorhandle);
	INTERPOLATOR_HANDLE GetParticleParticleInitialVelocity(HANDLE  particlehandle);
	void SetParticleParticleInitialVelocity(HANDLE  particlehandle, INTERPOLATOR_HANDLE interpolatorhandle);
	const char* GetParticleParticleFileName(HANDLE  particlehandle);
	void SetParticleParticleFileName(HANDLE  particlehandle, const char* name);
	bool GetParticleEmitterUsesMdl(HANDLE  particlehandle);
	void SetParticleEmitterUsesMdl(HANDLE  particlehandle, bool value);
	bool GetParticleEmitterUsesTga(HANDLE  particlehandle);
	void SetParticleEmitterUsesTga(HANDLE  particlehandle, bool value);

	bool GetParticleHasBug(HANDLE  particlehandle);
	void SetParticleHasBug(HANDLE  particlehandle, bool value);
]]

local modellib = require 'modellib.modellib'


return modellib.register_class('particle', cdef)