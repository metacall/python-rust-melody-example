use melody_compiler::compiler;

pub fn compile(s: String) -> String {
    return compiler(&s).unwrap_or_else(|x| format!("Compiler error {:?}", x));
}
