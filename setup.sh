sed "s|/Users/mohamed/workspace/stm32_projects/tests/libopencm3_empty_setup|$(pwd)|g" compile_commands.json > tmp.json
mv tmp.json compile_commands.json
git submodule update --init --recursive
cd external/libopencm3 && make TARGETS='stm32/f4'
