#!/usr/bin/env bats

@test "ensure parameters" {
    [ -n "$BINARY" ]
    [ -n "$VERSIONINFO" ]
    [ -n "$VERSION" ]
}

@test "ensure exists" {
    [ -f "$BINARY" ]
    [ -x "$BINARY" ]
}

@test "ensure static" {
    file "$BINARY" | grep -q -F ", statically linked"
}

@test "ensure stripped" {
    ( file "$BINARY" | grep -q -F ", stripped" ) || ( file "$BINARY" | grep -q -F ", no section header" )
}

@test "ensure version" {
    cat "$VERSIONINFO" | grep -q "$VERSION"
}
