import subprocess
import os



def get_token():
    home = os.path.expanduser("~")
    return subprocess.run([f"{home}/.config/aerc/mutt_oauth2.py", f"{home}/.config/aerc/oauth2_token_file"], capture_output=True, text=True).stdout
