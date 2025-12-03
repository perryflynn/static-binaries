#!/usr/bin/env bats

@test "ensure exists" {
    [ -f "$BINARY" ]
    [ -x "$BINARY" ]
}

@test "ensure static" {
    file "$BINARY" | grep -q -F ", statically linked"
}

@test "ensure stripped" {
    file "$BINARY" | grep -q -F ", stripped"
}

@test "ensure version" {
    cat "$VERSIONINFO" | grep -q "$VERSION"
}
