# AlertBot 🚨

AlertBot is a Linux-based system monitoring tool that:

- Checks CPU, RAM, and Disk usage
- Sends real-time alerts via Email and Telegram
- Logs all alerts into a file
- Displays logs on a Flask-based web dashboard
- Runs automatically using cron

## Features
✅ Bash-based health checks 
✅ Telegram Bot API integration 
✅ Email notifications via mailutils 
✅ Flask UI for live log view 
✅ Cron automation for scheduled runs 

## Files
- `alertbot.sh` — Main monitoring script
- `alertbot-cron.log` — Alert logs
- `app.py` — Flask dashboard app

## How to run
```bash
chmod +x alertbot.sh
./alertbot.sh
python3 app.py  # for dashboard
