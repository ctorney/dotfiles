import subprocess
import os


def get_token():
    return subprocess.run(
        [
            "/Users/colin.torney/.config/aerc/mutt_oauth2.py",
            "/Users/colin.torney/.config/aerc/oauth2_token_file",
        ],
        capture_output=True,
        text=True,
    ).stdout
