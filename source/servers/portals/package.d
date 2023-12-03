module servers.portals;

@safe:
mixin ImportPhobos;
mixin ImportDubs;
mixin ImportUim;

public import colored;

// Additional imports
public import uim.systems;
public import uim.jsonbase;
public import uim.models;
public import uim.entitybase;

public import uim.portals;

public { // Required models 
  import models.systems;
  import models.applications;
  import models.portals;
}

public import layouts.tabler;

public { // server-portals packages
  import servers.portals.actions;
  import servers.portals.apis;
  import servers.portals.pages;
}
// public import servers.portals.settings;

DServer thisServer;
string[size_t] errorMessages;
static this() {
  thisServer = Server
    .rootPath("/")
    .layout(new DLayout);

  debug writeln("------------------------");  
  debug writeln("Registered entities");  
  debug writeln(EntityRegistry.paths.sort);  
  debug writeln("------------------------");  
  EntityRegistry.paths.each!(path => ControllerRegistry.register(
    EntityRegistry[path].className~"_RestController", DataController.entity(EntityRegistry[path])
  ));  
  debug writeln("------------------------");  
  debug writeln("Registered controllers");  
  debug writeln(ControllerRegistry.paths.sort);  
  debug writeln("------------------------");  
  EntityRegistry.paths.each!(path => Server
    .addRoute(
      Route(
        "/"~EntityRegistry[path].className.toLower~"*", 
        HTTPMethod.GET, 
        ControllerRegistry[EntityRegistry[path].className~"_RestController"])
    )
    /* .addRoute(
      Route(
        "/"~EntityRegistry[path].className.toLower~"*", 
        HTTPMethod.POST, 
        ControllerRegistry[EntityRegistry[path].className~"_RestController"])
    )
    .addRoute(
      Route(
        "/"~EntityRegistry[path].className.toLower~"*", 
        HTTPMethod.PUT, 
        ControllerRegistry[EntityRegistry[path].className~"_RestController"])
    ) */
  );   
   

  debug writeln(Server.routesPaths.sort);  
}

