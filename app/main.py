from typing import Union
import os

from fastapi import FastAPI


app = FastAPI()


@app.get("/")
async def read_root():
    return {"Hello": "World from automatic!"}

@app.get("/env")
async def read_info():
    custom_env_var = os.getenv("CUSTOM_ENV_VAR", "Not Set")
    return {"app_name": "My FastAPI Application", "version": "1.0.0", "custom_env_var": custom_env_var}


@app.get("/health")
async def health_check():
    return {"status": "ok"}