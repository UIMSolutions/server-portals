import vibe.vibe;
import servers.portals;

mixin DefaultConfig!("server-portals");
//mixin ReadConfig;
void main(string[] args) {
	debug writeln("readConfig()");
  // readConfig();

	debug writeln("mixin GetoptConfig");
  //mixin GetoptConfig;
  
	auto router = new URLRouter;	
	debug writeln("SetRouterDefault!()");
  mixin(SetRouterDefault!());

/* debug writeln("Setting router");
router // Pages
		.get("/portals", &uimportalsPage); */

/* 	mixin(AddRoutes!("router", "/portals/apis", "uimApis"));
	mixin(AddRoutes!("router", "/portals/apps", "uimApps"));
	mixin(AddRoutes!("router", "/portals/attributes", "uimAttributes"));
	mixin(AddRoutes!("router", "/portals/classes", "uimClasses"));
	mixin(AddRoutes!("router", "/portals/components", "uimComponents"));
	mixin(AddRoutes!("router", "/portals/entities", "uimEntities"));
	// mixin(AddRoutes!("router", "/portals/functions", "uimFunctions"));
	mixin(AddRoutes!("router", "/portals/interfaces", "uimInterfaces"));
	mixin(AddRoutes!("router", "/portals/libraries", "uimLibraries"));
	mixin(AddRoutes!("router", "/portals/methods", "uimMethods"));
	mixin(AddRoutes!("router", "/portals/models", "uimModels"));
	mixin(AddRoutes!("router", "/portals/modules", "uimModules"));
	mixin(AddRoutes!("router", "/portals/packages", "uimPackages")); */

/* 	router
		.get("/", &uimIndex)
		.get("/login", &uimLoginPage)
		.get("/login2", &uimLogin2Page)
		.get("/register", &uimRegister)
		.get("/logout", &uimLogout)
		.get("/server", &uimServer)
		.get("/sites", &uimSites); */

/* 	router // actions
		.post("/login_action", &uimLoginAction)
		.post("/login2_action", &uimLogin2Action)
		.post("/sites/select", &uimSiteSelectAction); */

	debug writeln("Create Database");
	auto database = ETBBase.importDatabase(JSBFileBase("../../DATABASES/uim"));
	debug writeln("Found Tenants:", database.count);

	debug writeln("auto dbTentant = database[system]");
	if (auto dbTentant = database["systems"]) {
		debug writeln("Found tentant");

		foreach(name; dbTentant.collectionNames) {
			debug writeln("uimEntityRegistry name:", name, " path:", name);
		
			if (auto entityTemplate = EntityRegistry[name]) {
				debug writeln("entityid = ", EntityRegistry[name].id);
		
				dbTentant[name].entityTemplate(entityTemplate);
	}}}

	debug writeln("auto dbTentant = database[uim]");
	if (auto dbTentant = database["uim"]) {
		debug writeln("Found tentant");

		foreach(name; dbTentant.collectionNames) {
			debug writeln("uimEntityRegistry name:", name, " path:", name);

			if (auto entityTemplate = EntityRegistry[name]) {
				debug writeln("entityid = ", EntityRegistry[name].id);
	
				dbTentant[name].entityTemplate(entityTemplate);
	}}}

	debug writeln("database.tenantNames -> ", database.tenantNames);
	database.tenantNames.each!(tenantName => debug writeln(tenantName, " with ", database[tenantName].collectionNames));

	debug writeln("server.database(database)");
  thisServer.database(database);
		// server.rootPath(rootPath).registerApp(router); 

  mixin(SetHTTP!());
	runApplication();
}
