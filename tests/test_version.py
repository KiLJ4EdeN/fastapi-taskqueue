from pathlib import Path

import toml

from python_template import __version__


def test_version() -> None:
    path = Path(__file__).resolve().parents[1] / "pyproject.toml"
    pyproject = toml.loads(open(str(path)).read())
    assert __version__ == pyproject["tool"]["poetry"]["version"]
