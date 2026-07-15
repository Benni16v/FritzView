#!/bin/bash

theme_system()
{

theme_begin

theme_title "System"

theme_value "CPU" "$CPU"

theme_value "RAM" "$RAM"

theme_value "Load" "$LOAD"

theme_empty

theme_value "Uptime" "$UPTIME"

theme_value "Version" "$VERSION"

theme_end

}
