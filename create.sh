#!/bin/bash
ProjectName="demo"
if [ $# -ne 0 ]
then
	ProjectName=$1
fi
function init {
	mkdir $ProjectName
	mkdir  $ProjectName/lib $ProjectName/src $ProjectName/test $ProjectName/build $ProjectName/include
	touch $ProjectName/CMakeLists.txt $ProjectName/src/CMakeLists.txt $ProjectName/test/CMakeLists.txt $ProjectName/lib/CMakeLists.txt $ProjectName/build/build.sh 
	chmod u+x $ProjectName/build/build.sh
}	

function cmake_init {
	cat > $ProjectName/CMakeLists.txt <<EOF 
	cmake_minimum_required(VERSION 3.30)
	project($ProjectName  LANGUAGES CXX)
	
	set(CXX_STANDARD 20)
	set(CXX_STANdARF_REQUIRED OFF)
	set(CXX_EXTENTIONS OFF)
	add_subdirectory(lib)
	add_subdirectory(src)
	add_subdirectory(test)
	enable_testing()
EOF

}

function cmake_test {
	cat > $ProjectName/test/CMakeLists.txt <<EOF
	include(FetchContent)

	FetchContent_Declare(
	  googletest
	  GIT_REPOSITORY https://github.com/google/googletest.git
	  GIT_TAG v1.15.2
	)
	FetchContent_GetProperties(googletest)
EOF
}

function init_src {
	cat > $ProjectName/src/CMakeLists.txt<<EOF
	add_executable($ProjectName main.cpp)
EOF

touch $ProjectName/src/main.cpp

cat > $ProjectName/src/main.cpp<<EOF
	#include <iostream>
	int main(){
		std::cout<<"Hello World\n";
		return 0;
	}
EOF
}
function run_script {
	touch $ProjectName/build/build.sh
	cat > $ProjectName/build/build.sh<<EOF
	cmake ..
	cmake --build .
	./src/$ProjectName
EOF
}
init
init_src
cmake_init
cmake_test
run_script
