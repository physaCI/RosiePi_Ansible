# arm_gcc_update_path.awk
# --- update the PATH to include /opt/arm-none-eabi-gcc/bin
#     in .bashrc, if it isn't already included

function readfile(file, tmp, save_rs)
{

    save_rs = RS
    RS = "^$"
    getline tmp < file
    close(file)
    RS = save_rs

    return tmp
}

BEGIN {

    if (!filepath) {
        print "Filepath not set. Use '-v filepath=<path>'"
        exit 1
    }

    contents = readfile(filepath)
    if (length(contents) > 0) {
        pattern = "export PATH=\\$PATH:\\/opt\\/arm-none-eabi-gcc\\/bin"
        if (match(contents, pattern) <= 0) {
            comment = "# add arm-none-eabi-gcc to PATH (added by RosiePi_Ansible)"
            path = "export PATH=$PATH:/opt/arm-none-eabi-gcc-test/bin"
            printf("%s\n%s\n\n", comment, path) >> filepath
        }
    }
}
