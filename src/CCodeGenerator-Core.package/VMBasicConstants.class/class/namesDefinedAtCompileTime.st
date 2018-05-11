C translation
namesDefinedAtCompileTime
	"Answer the set of names for variables that should be defined at compile time.
	 Some of these get default values during simulation, and hence get defaulted in
	 the various initializeMiscConstants methods.  But that they have values should
	 /not/ cause the code generator to do dead code elimination based on their
	 default values.  In particular, methods marked with <option: ANameDefinedAtCompileTime>
	 will be emitted within #if defined(ANameDefinedAtCompileTime)...#endif."
	^#(	VMBIGENDIAN
		IMMUTABILITY
		STACKVM COGVM COGMTVM SPURVM
		PharoVM								"Pharo vs Squeak"
		TerfVM									"Terf vs Squeak"
		EnforceAccessControl					"Newspeak"
		CheckRememberedInTrampoline		"IMMUTABILITY"
		LLDB									"As of lldb-370.0.42 Swift-3.1, passing funciton parameters to printOopsSuchThat fails with Internal error [IRForTarget]: Couldn't rewrite one of the arguments of a function call.  Turning off link time optimization with -fno-lto has no effect.  hence we define some debugging functions as being <option: LLDB>"

		"processor related"
		__ARM_ARCH__ __arm__ __arm32__ ARM32 __arm64__ ARM64
		_M_I386 _X86_ i386 i486 i586 i686 __i386__ __386__ X86 I386
		x86_64 __amd64 __x86_64 __amd64__ __x86_64__ _M_AMD64 _M_X64

		"os related"
		ACORN
		__GNUC__
		__linux__
		__MINGW32__
		__OpenBSD__
		__osf__
		UNIX
		WIN32 _WIN32 _WIN32_WCE
		WIN64 _WIN64 _WIN64_WCE)