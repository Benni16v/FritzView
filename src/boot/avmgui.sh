#!/bin/bash
############################################################
# Animierter AVM-Login-Bootscreen (Bildsequenz)
############################################################
boot_avm_login_show()
{
    local boot_dir="$BASE/src/boot/avm"
    local frame

    for frame in 01 02 03 04 05 06 07 08 09 10 11 12
    do
        local img="$boot_dir/boot_${frame}.png"
        if [ -f "$img" ]; then
            driver_render_image "$img"
            sleep 0.3
        fi
    done
}
