#makefile for helloc.exe and hellos.exe
#link refers to the linker
#conflags refers to flags for console applications
#conlibs refers to libraries for console applications

!include <ntwin32.mak>
 
all : helloc hellos
 
# Make the client side application helloc
helloc : helloc.exe
helloc.exe : helloc.obj hello_c.obj
	$(link) $(linkdebug) $(conflags) -out:helloc.exe \
        helloc.obj hello_c.obj \
        rpcrt4.lib $(conlibs)
 
# helloc main program
helloc.obj : helloc.cpp hello.h
	$(cc) $(cdebug) $(cflags) $(cvars) $*.cpp
 
# helloc stub
hello_c.obj : hello_c.cpp hello.h
	$(cc) $(cdebug) $(cflags) $(cvars) $*.cpp
 
# Make the server side application
hellos : hellos.exe
hellos.exe : hellos.obj hellop.obj hello_s.obj
    $(link) $(linkdebug) $(conflags) -out:hellos.exe \
        hellos.obj hello_s.obj hellop.obj \
        rpcrt4.lib $(conlibsmt)
 
# hello server main program
hellos.obj : hellos.cpp hello.h
	$(cc) $(cdebug) $(cflags) $(cvarsmt) $*.cpp
 
# remote procedures
hellop.obj : hellop.cpp hello.h
	$(cc) $(cdebug) $(cflags) $(cvarsmt) $*.cpp
 
# hellos stub file
hello_s.obj : hello_s.c hello.h
	$(cc) $(cdebug) $(cflags) $(cvarsmt) $*.cpp
 
# Stubs and header file from the IDL file
hello.h hello_c.cpp hello_s.cpp : hello.idl hello.acf
	midl hello.idl