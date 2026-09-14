from pathlib import Path
from dotenv import dotenv_values

def get_variables():
    env = dotenv_values(Path(__file__).resolve().parent.parent / "resources" / ".env")
    return dict(env)