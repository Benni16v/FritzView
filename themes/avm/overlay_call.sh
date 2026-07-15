#!/bin/bash

theme_overlay_call()
{

theme_begin

theme_title "Anruf"

display_empty

display_center "$CALL_NAME"

display_center "$CALL_NUMBER"

display_empty

display_center "Klingelt..."

theme_end

}
