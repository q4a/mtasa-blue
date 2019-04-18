project "cryptopp"
	language "C++"
	kind "StaticLib"
	targetname "cryptopp"
	
	vpaths { 
		["Headers/*"] = "**.h",
		["Sources"] = "**.cpp",
		["Assembly"] = "**.asm",
		["*"] = "premake5.lua"
	}
		
	defines {
		"_WINSOCK_DEPRECATED_NO_WARNINGS",
		"CRYPTOPP_DISABLE_CLMUL", -- sse 4.1 required for this
		"_LIB"
	}
	
	files {
		"premake5.lua",
		"*.h",
		"3way.cpp",
		"adler32.cpp",
		"algebra.cpp",
		"algparam.cpp",
		"arc4.cpp",
		"asn.cpp",
		"authenc.cpp",
		"base32.cpp",
		"base64.cpp",
		"basecode.cpp",
		"bfinit.cpp",
		"blowfish.cpp",
		"blumshub.cpp",
		"cast.cpp",
		"casts.cpp",
		"cbcmac.cpp",
		"ccm.cpp",
		"channels.cpp",
		"cmac.cpp",
		"cpu.cpp",
		"crc.cpp",
		"cryptlib.cpp",
		"default.cpp",
		"des.cpp",
		"dessp.cpp",
		"dh.cpp",
		"dh2.cpp",
		"dll.cpp",
		"dsa.cpp",
		"eax.cpp",
		"ec2n.cpp",
		"eccrypto.cpp",
		"ecp.cpp",
		"elgamal.cpp",
		"emsa2.cpp",
		"eprecomp.cpp",
		"esign.cpp",
		"files.cpp",
		"filters.cpp",
		"fips140.cpp",
		"gcm.cpp",
		"gf256.cpp",
		"gf2n.cpp",
		"gf2_32.cpp",
		"gfpcrypt.cpp",
		"gost.cpp",
		"gzip.cpp",
		"hex.cpp",
		"hmac.cpp",
		"hrtimer.cpp",
		"ida.cpp",
		"idea.cpp",
		"integer.cpp",
		"iterhash.cpp",
		"luc.cpp",
		"mars.cpp",
		"marss.cpp",
		"md2.cpp",
		"md4.cpp",
		"md5.cpp",
		"misc.cpp",
		"modes.cpp",
		"mqueue.cpp",
		"mqv.cpp",
		"nbtheory.cpp",
		"oaep.cpp",
		"osrng.cpp",
		"panama.cpp",
		"pch.cpp",
		"pkcspad.cpp",
		"polynomi.cpp",
		"pssr.cpp",
		"pubkey.cpp",
		"queue.cpp",
		"rabin.cpp",
		"randpool.cpp",
		"rc2.cpp",
		"rc5.cpp",
		"rc6.cpp",
		"rdtables.cpp",
		"rijndael.cpp",
		"ripemd.cpp",
		"rng.cpp",
		"rsa.cpp",
		"rw.cpp",
		"safer.cpp",
		"salsa.cpp",
		"seal.cpp",
		"sha_simd.cpp",
		"gf2n_simd.cpp",
		"sse_simd.cpp",
		"rijndael_simd.cpp",
		"seed.cpp",
		"serpent.cpp",
		"sha.cpp",
		"sha3.cpp",
		"shacal2.cpp",
		"shark.cpp",
		"sharkbox.cpp",
		"simple.cpp",
		"skipjack.cpp",
		"sosemanuk.cpp",
		"square.cpp",
		"squaretb.cpp",
		"strciphr.cpp",
		"tea.cpp",
		"tftables.cpp",
		"tiger.cpp",
		"tigertab.cpp",
		"ttmac.cpp",
		"twofish.cpp",
		"vmac.cpp",
		"wake.cpp",
		"whrlpool.cpp",
		"xtr.cpp",
		"xtrcrypt.cpp",
		"zdeflate.cpp",
		"zinflate.cpp",
		"zlib.cpp",
		"keccak_core.cpp"
	}
	
	filter "platforms:x64"
		files {
			"x64dll.asm",
			"x64masm.asm"
		}
	
	filter {"system:windows"}
		linkoptions { "/ignore:4221" }
		disablewarnings { "4005" }

	filter {"system:windows", "toolset:*_xp*"}
		defines { "USE_MS_CRYPTOAPI", "_WIN32_WINNT=0x502", "NTDDI_VERSION=0x05020300" }
