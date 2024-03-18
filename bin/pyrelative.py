#!/bin/python3.12
"""
Modify absolute import generated from pyright to relative import

TEST INPUT
command: cat test_input | python3 main.py 

/home/alex/projects/pyrelative
file:///home/alex/projects/pyrelative/src/pyrelative/qqq/main.py
pyrelative.another_module.from_another_module
pyrelative.qqq.next_to
pyrelative.qqq.model_zzz.from_the_model_next_to

TEST OUTPUT

..another_module.from_another_module
.next_to
.model_zzz.from_the_model_next_to
"""
import sys
from dataclasses import dataclass, field


@dataclass(slots=True)
class Data:
    cwd: str = ""
    current_file_path: str = ""
    import_paths: list[str] = field(default_factory=list)


# structure:
#   [0]: cwd Ex: /home/XX/XX/
#   [1]: current file Ex: file://<filepath>/XXX.py
#   [...]: imports Ex: pyrelative.model.model_a
tmp: list[str] = []
for line in sys.stdin:
    line = line.strip()
    tmp.append(line)

# load data
data = Data(cwd=tmp[0], current_file_path=tmp[1], import_paths=tmp[2:])

# possible package dirs
package_dirs: list[str] = ["src"]

for dir in package_dirs:
    prefix = f"{data.cwd}/{dir}/"
    if prefix in data.current_file_path:
        data.current_file_path = data.current_file_path.split(prefix)[-1]
        break

current_file_path: list[str] = data.current_file_path.split("/")
# pyright used the package dir name regardless of pyproject.toml
package_name: str = current_file_path[0]

for import_path in data.import_paths:
    tmp_import_path: list[str] = import_path.split(".")

    # this import is not from our package
    if package_name != tmp_import_path[0]:
        print(import_path)
    # compaire depth of file path
    else:
        similarity: int = 0
        for f, i in zip(current_file_path, tmp_import_path):
            if f == i:
                similarity += 1

        diff: int = len(current_file_path) - similarity
        base_import_path: str = ".".join(tmp_import_path[similarity:])

        print(f"{'.'*diff}{base_import_path}")
