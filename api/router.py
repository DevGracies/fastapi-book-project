from fastapi import APIRouter

from api.routes import books

api_router = APIRouter()
api_router.include_router(books.router, prefix="/books", tags=["books"])
class Stage2Info(BaseModel):
    content: str

# Simulate a database (replace with actual DB logic)
fake_db = {"stage2": "Stage 2 content"}

@app.get("/stage2", response_model=Stage2Info, status_code=status.HTTP_200_OK)
async def get_stage2():
    # Here you can replace with actual database query logic
    stage2_content = fake_db.get("stage2")
    if not stage2_content:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, 
            detail="Stage 2 content not found"
        )
    return Stage2Info(content=stage2_content)