from fastapi import FastAPI, Request
from fastapi.templating import Jinja2Templates

app = FastAPI()

templates = Jinja2Templates(directory="/code")


@app.get("/")
def form_post(request: Request):
    return templates.TemplateResponse(
        request=request,
        name="portfolio.html"
    )


@app.get("/new")
def form_post(request: Request):
    return templates.TemplateResponse(
        request=request,
        name="new.html"
    )
