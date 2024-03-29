﻿<cfcomponent extends="coldbox.system.testing.BaseTestCase" output="false">
<cfscript>
	function setup(){
		flash = getMockBox().createMock("coldbox.system.web.flash.AbstractFlashScope");
		mockController = getMockBox().createMock(className="coldbox.system.web.Controller",clearMethods=true);
		mockRService = getMockBox().createMock(className="coldbox.system.web.services.RequestService",clearMethods=true);
		mockEvent = getMockBox().createMock(className="coldbox.system.web.context.RequestContext",clearMethods=true);
		mockController.$("getRequestService",mockRService);
		mockRService.$("getContext",mockEvent);
		
		
		flash.init(mockController);
		
		testScope = { name={content="luis majano",keep=true,inflateToRC=true,inflateToPRC=false,autoPurge=true}, 
					  date={content=now(),keep=true,inflateToRC=true,inflateToPRC=false,autoPurge=true} };
	}	
	function teardown(){ 
		structClear(request);
	}
	function testInflateFlash(){
		mockEvent.$("setValue");
		flash.$("getFlash",testScope).$("clearFlash");
		
		flash.inflateFlash();
		assertEquals( flash.size(), 2);
		debug(arrayLen(mockEvent.$callLog().setValue));
		//assertEquals( arrayLen(mockEvent.$callLog().setValue), 2 );
	}
	
	function testScopeMethods(){
		assertEquals( flash.size(), 0);
		assertEquals( flash.isEmpty(), true);
		
		flash.put("name","luis majano");
		flash.put("obj",this);
		
		assertEquals( flash.exists("name"), true);
		assertEquals( flash.exists("obj2"), false);
		assertEquals( flash.isEmpty(), false);
		
		flash.clear();
		assertEquals( flash.size(), 0);
		
		testMap = {name="luis majano", date=now()};
		
		flash.putAll(testMap);
		assertEquals( flash.size(), 2);
		assertEquals( flash.get("name"),"luis majano");
		flash.remove("name");
		assertEquals( flash.get("name",""),"");
		
	}
	
	function testPersistRC(){
		mockEvent.$("getCollection",testScope);
		
		flash.persistRC();
		assertEquals( flash.size(), 0);
		
		flash.persistRC(include="name");
		assertEquals( flash.size(), 1);
		
		flash.clear();
		
		flash.persistRC(include="name,date");
		assertEquals( flash.size(), 2);
		
		flash.clear();
		
		flash.persistRC(exclude="name");
		assertEquals( flash.size(), 1);		
	}
	
	function testClearFlash(){
		flash.$("flashExists",true);
		testScope = {
			t1 = {content=createUUID(),keep=true,autoPurge=true},
			t2 = {content=createUUID(),keep=true,autoPurge=true},
			t3 = {content=createUUID(),keep=true,autoPurge=false},
			t4 = {content=createUUID(),keep=true,autoPurge=true},
			t5 = {content=createUUID(),keep=true,autoPurge=false}
		};
		flash.$("getFlash",testScope);
		
		flash.clearFlash();
		
		assertTrue( structKeyExists(testScope,"t3") );
		assertTrue( structKeyExists(testScope,"t5") );
	}
	
</cfscript>
</cfcomponent>