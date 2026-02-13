# serve data/manifest.json over HTTP
from http.server import SimpleHTTPRequestHandler, HTTPServer
import os
PORT = 8005
class ManifestHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/manifest.json':
            self.path = '/data/manifest.json'
        return super().do_GET()
os.chdir(os.path.dirname(os.path.abspath(__file__)))
httpd = HTTPServer(('', PORT), ManifestHandler)
print(f'Serving manifest.json on port {PORT}...')
httpd.serve_forever()