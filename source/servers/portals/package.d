module servers.portals;

@safe:
mixin ImportPhobos;
mixin ImportDubs;
mixin ImportUim;

public import colored;

// Additional imports
public import uim.systems;
public import uim.jsonbase;
public import uim.entities;
public import uim.entitybase;

public import models.systems;
public import models.portals;
public import uim.portals;


public import layouts.tabler;

// server-portals packages
public import servers.portals.actions;
public import servers.portals.apis;
public import servers.portals.pages;
// public import servers.portals.settings;

DAPPApplication serverPortals;
string[size_t] errorMessages;
static this() {
  serverPortals = new class DAPPApplication {
    this() { super(); 
      this
      .layout(UIMLayout)
      .scripts.addLinks(
        "/js/apps/portals/app.js");
    }
  };
}