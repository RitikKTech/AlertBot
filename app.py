from flask import Flask, render_template_string

app = Flask(__name__)

@app.route("/report")
def show_report():
    try:
        with open("/home/ritik/alertbot-cron.log", "r") as f:
             content = f.read()
    except Exception as e:
        content = f"Error: {e}"
    return render_template_string("""
       <html>
       <head>
           <title>AlertBot Log</title>
       </head>
       <body>
	<4h2>AlertBot Cron Log></h2>
       <pre>{{ content }}</pre>
       </body>
       </html>
""", content=content)

if __name__ == "__main__":
     app.run(host="0.0.0.0", port=5000)
