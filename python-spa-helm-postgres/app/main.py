import os
from fastapi import FastAPI, Request, HTTPException
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker

DATABASE_URL = os.getenv("DATABASE_URL", "")
if not DATABASE_URL:
    raise RuntimeError("DATABASE_URL is required (e.g., postgresql://user:pass@host:5432/db)")

engine = create_engine(DATABASE_URL, pool_pre_ping=True)
SessionLocal = sessionmaker(bind=engine, autoflush=False, autocommit=False)

app = FastAPI(title="Python SPA Demo (FastAPI + Postgres)")

app.mount("/static", StaticFiles(directory="static"), name="static")
templates = Jinja2Templates(directory="templates")

SCHEMA_SQL = '''
CREATE TABLE IF NOT EXISTS notes (
  id SERIAL PRIMARY KEY,
  text TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
'''

@app.on_event("startup")
def init_db():
    with engine.begin() as conn:
        conn.execute(text(SCHEMA_SQL))

@app.get("/", response_class=HTMLResponse)
def home(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})

@app.get("/api/notes")
def list_notes():
    with SessionLocal() as db:
        rows = db.execute(text("SELECT id, text, created_at FROM notes ORDER BY id DESC LIMIT 100")).mappings().all()
        return [{"id": r["id"], "text": r["text"], "created_at": r["created_at"].isoformat()} for r in rows]

@app.post("/api/notes")
def create_note(payload: dict):
    note_text = (payload or {}).get("text", "").strip()
    if not note_text:
        raise HTTPException(status_code=400, detail="text is required")

    with SessionLocal() as db:
        row = db.execute(
            text("INSERT INTO notes(text) VALUES(:t) RETURNING id, text, created_at"),
            {"t": note_text},
        ).mappings().first()
        db.commit()
        return {"id": row["id"], "text": row["text"], "created_at": row["created_at"].isoformat()}
