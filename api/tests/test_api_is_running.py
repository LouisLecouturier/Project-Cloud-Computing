from unittest.mock import MagicMock, patch

# Mock Database Connection
mock_connection = MagicMock()
mock_cursor = MagicMock()
mock_connection.cursor.return_value = mock_cursor

with patch("psycopg2.connect", return_value=mock_connection):
    from fastapi.testclient import TestClient
    from main import app

    client = TestClient(app)


def test_is_api_running():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello World"}


def test_non_existent_endpoint():
    response = client.get("/non-existent")
    assert response.status_code == 404


def test_post_request():
    response = client.post("/", json={"key": "value"})
    assert response.status_code == 405


def test_health_check():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}
