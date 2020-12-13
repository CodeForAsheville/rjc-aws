# RjcActionNetwork

Welcome to the RJC CLI! This interacts directly with our AWS API proxy. Copy `.env.example` to `.env.local` and fill in the two requisite fields:
```
export RJC_API_KEY=FILL_ME_IN
export RJC_API_URL=FILL_ME_IN
```

## Installation

Run `./script/setup.sh` and this should install the right version of ruby and any requisite libraries needed to interact with the RJC API.

To get a list of possible commands:

    $ bundle exec exe/rjc

To print out a CSV of activists and the forms they've taken action against:

    $ bundle exec exe/rjc build
