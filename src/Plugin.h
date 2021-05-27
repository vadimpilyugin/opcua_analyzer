#pragma once

#include <plugin/Plugin.h>

namespace plugin {
namespace Demo_opcua {

class Plugin : public zeek::plugin::Plugin
{
protected:
	// Overridden from zeek::plugin::Plugin.
	zeek::plugin::Configuration Configure() override;
};

extern Plugin plugin;

}
}
