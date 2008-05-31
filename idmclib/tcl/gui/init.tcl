cd ..
switch $::tcl_platform(platform) {
    unix {load ./tclidmclib.so}
    windows {load ./tclidmclib.dll}
}
cd gui

