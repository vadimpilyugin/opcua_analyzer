// Generated by binpac_quickstart

#include "opcua.h"

#include "analyzer/protocol/tcp/TCP_Reassembler.h"
#include "zeek/util.h"

#include "Reporter.h"

#include "events.bif.h"

using namespace zeek::analyzer::Demo_opcua;

opcua_Analyzer::opcua_Analyzer(Connection* c)

: tcp::TCP_ApplicationAnalyzer("opcua", c)

	{
	interp = new binpac::opcua::opcua_Conn(this);
	
	had_gap = false;
	
	}

opcua_Analyzer::~opcua_Analyzer()
	{
	delete interp;
	}

void opcua_Analyzer::Done()
	{
	
	tcp::TCP_ApplicationAnalyzer::Done();

	interp->FlowEOF(true);
	interp->FlowEOF(false);
	
	}

void opcua_Analyzer::EndpointEOF(bool is_orig)
	{
	tcp::TCP_ApplicationAnalyzer::EndpointEOF(is_orig);
	interp->FlowEOF(is_orig);
	}

void opcua_Analyzer::DeliverStream(int len, const u_char* data, bool orig)
	{
	tcp::TCP_ApplicationAnalyzer::DeliverStream(len, data, orig);

	assert(TCP());
	if ( TCP()->IsPartial() )
		return;

	if ( had_gap )
		// If only one side had a content gap, we could still try to
		// deliver data to the other side if the script layer can handle this.
		return;

	try
		{
		interp->NewData(orig, data, data + len);
		}
	catch ( const binpac::Exception& e )
		{
		ProtocolViolation(zeek::util::fmt("Binpac exception: %s", e.c_msg()));
		}
	}

void opcua_Analyzer::Undelivered(uint64_t seq, int len, bool orig)
	{
	tcp::TCP_ApplicationAnalyzer::Undelivered(seq, len, orig);
	had_gap = true;
	interp->NewGap(orig, len);
	}

