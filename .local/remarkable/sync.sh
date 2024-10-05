#!/bin/bash

for f in "$@"
do
	/Users/colin.torney/.local/go/bin/rmapi put "$f" "3. RESOURCES/Papers"
done
