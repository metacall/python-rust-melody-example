from metacall import metacall, metacall_load_from_file

if __name__ == "__main__":
    metacall_load_from_file("rs", ["./basic.rs"])
    print("Load: ./basic.rs")

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
