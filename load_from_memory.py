from metacall import metacall, metacall_load_from_memory

if __name__ == "__main__":
    with open("./basic.rs", "r") as f:
        content = f.read()
    metacall_load_from_memory("rs", content)
    print("load successfully")

    assert metacall("add", 1, 3) == 4

    assert metacall("add_float_vec", [1, 2, 3, 4]) == 10

    assert metacall("add_map", {
        "1": 1,
        "2": 2,
        "3": 3,
        "4": 4
    }) == 10

    ret = metacall("new_string", 123)
    print(f"get string: {ret}")
    print(metacall("string_len", ret) == 14)
