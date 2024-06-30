#!/bin/bash

#If you can install dtrx on your system, you should use it. It's build for your problem and available through the package manager on most systems.

#Otherwise, this would be my proposal:

#!/bin/bash

extract()
{
    for plik in "$@"; do
        tar -xvaf "$plik" 2>/dev/null && 
            return 0
        case $(file "$plik") in
            *bzip2*)    bzip2 -dk "$plik"        ;;
            *gzip*)     gunzip "$plik"           ;;
            *'7-zip'*)  7z x "$plik"             ;;
            *zip*)                               ;&
            *Zip*)      unzip "$plik"            ;;
            *xz*)                                ;&
            *XZ*)       unxz  "$plik"            ;;
            *)          1>&2 echo "Unknown archive '$plik'"; return 1 ;;
        esac
    done
}