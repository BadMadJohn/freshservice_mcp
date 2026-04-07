import os
import uvicorn
from freshservice_mcp.server import mcp

app = mcp.streamable_http_app()

host = os.environ.get("FASTMCP_HOST", "0.0.0.0")
port = int(os.environ.get("FASTMCP_PORT", "8012"))

uvicorn.run(app, host=host, port=port)
