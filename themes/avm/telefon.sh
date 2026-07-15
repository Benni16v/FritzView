#!/bin/bash

theme_telefon()
{

theme_begin

theme_title "Telefonie"

theme_value "Anrufe" "$CALL_COUNT"

theme_value "Heute" "$CALLS_TODAY"

theme_value "Verpasst" "$MISSED"

theme_end

}
