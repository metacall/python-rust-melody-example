from metacall import metacall, metacall_load_from_package
import regex

if __name__ == "__main__":
    metacall_load_from_package(
        "rs", "./melody_wrapper/target/debug/libmelody.rlib")
    print("Load: ./melody_wrapper/target/debug/libmelody.rlib")

    regex_string = r"""
option of "v";
capture major { some of <digit>; }
".";
capture minor {   some of <digit>; }
".";
capture patch { some of <digit>; }
"""

    ret = metacall("compile", regex_string)
    print(f"regex: {ret}")
    # print: regex: v?(?<major>\d+)\.(?<minor>\d+)\.(?<patch>\d+)
    pattern = regex.compile(ret)
    search_result = pattern.search("The version is v320.1123.202 !")
    print(search_result)
    # print: <regex.Match object; span=(15, 24), match='v0.13.202'>
