from hello_world.main import hello_world


def test_hello_world() -> None:
    assert hello_world() == "hello_world"
