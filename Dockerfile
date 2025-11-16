{{- if eq component "Dockerfile" -}}
FROM python:3.9-slim-buster

WORKDIR /app

COPY . /app

RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi
{{- else if eq component "mlflow.yaml" -}}
tracking_uri: mlflow-artifacts
{{- else if eq component "Tests" -}}
import pytest
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent.parent))

def test_main_script_can_be_imported():
    import main
    assert isinstance(main, type(sys))
{{- end -}}