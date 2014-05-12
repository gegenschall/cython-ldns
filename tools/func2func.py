import sys
from pycparser import c_parser, c_ast, parse_file


# A simple visitor for FuncDef nodes that prints the names and
# locations of function definitions.
#
class FuncDefVisitor(c_ast.NodeVisitor):
    def visit_FuncDef(self, node):
        print('%s at %s' % (node.decl.name, node.decl.coord))


def show_func_defs(filename):
    # Note that cpp is used. Provide a path to your own cpp or
    # make sure one exists in PATH.
    #
    ast = parse_file(filename, use_cpp=True)

    v = FuncDefVisitor()
    v.visit(ast)


if __name__ == "__main__":
    if len(sys.argv) > 1:
        filename  = sys.argv[1]
    else:
        filename = 'c_files/memmgr.c'

    show_func_defs(filename)
