FROM python:3.5.1

# Bad practice (but it works so sue us)
COPY . .

RUN pip install -r requirements.txt

CMD python run.py