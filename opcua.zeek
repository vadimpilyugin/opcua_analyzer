@load base/protocols/conn
global opcua_ports: set[port] = { 12001/tcp } &redef;

event zeek_init()
    {
    print "Hello world!";
    Analyzer::register_for_ports(Analyzer::ANALYZER_OPCUA, opcua_ports);

    }

event opcua_event(c: connection, is_orig: bool, msgtyp: count, message_type: string, message_size: count)
{
  print "opcua event", message_type, "=", msgtyp, "size=", message_size, "is_orig=", is_orig;
}

# event opcua_hello_message(c: connection, proto_version: count, endpoint_url: string)
#   {
#     print "opcua hello message", "ver=", proto_version, "url=", endpoint_url;
#   }

# event opcua_error_message(c: connection, error: count, reason: string)
#   {
#     print "opcua error message", "error=", error, "reason given:", reason;
#   }

event opcua_request(c: connection, secure_channel_id: count)
  {
    print "opcua request", "secure_channel_id=", secure_channel_id;
  }

event opcua_response(c: connection, secure_channel_id: count)
  {
    print "opcua response", "secure_channel_id=", secure_channel_id;
  }

