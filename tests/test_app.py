from python_template.app import app  # Flask instance of the API


def test_index_route() -> None:
    response = app.test_client().get("/")

    assert response.status_code == 200


def test_cov_index() -> None:
    response = app.test_client().get("/cov/d_3c81f8c100ef58ff_app_py.html")

    assert response.status_code == 200


def test_cov_app() -> None:
    response = app.test_client().get("/cov/")

    assert response.status_code == 200


def test_docs_index() -> None:
    response = app.test_client().get("/docs/")

    assert response.status_code == 200


def test_docs_tutorials() -> None:
    response = app.test_client().get("/docs/tutorials/")

    assert response.status_code == 200
