# Alfred 2 Source Tree Workflow

Alfred 2 Workflow to list, search, and open [Source Tree](http://www.sourcetreeapp.com/ "SourceTree") repositories in [Alfred](http://www.alfredapp.com/ "Alfred App - Productivity App for Mac OS X").

![workflow](https://raw.github.com/zhaocai/alfred2-sourcetree-workflow/master/screenshots/workflow.png)

## Usage

### A. Keywords:

1. `st`: List and query source tree repositories.

    Feedbacks are cached. use `st ! {query}` to refresh.

2. `stbookmark`: Open query to source bookmark window.


### B. Modifier Key

1. `⌘` : Reveal in Finder
1. `alt` : Browser in Alfred


![query](https://raw.github.com/zhaocai/alfred2-sourcetree-workflow/master/screenshots/query.png)

## Installation

Two ways are provided:

1. You can download the [Source Tree.alfredworkflow](https://github.com/zhaocai/alfred2-sourcetree-workflow/raw/master/Source%20Tree.alfredworkflow) and import to Alfred 2. This method is suitable for **regular users**.

2. You can `git clone` or `fork` this repository and use `rake install` and `rake uninstall` to install. Check `rake -T` for available tasks.
This method create a symlink to the alfred workflow directory: "~/Library/Application Support/Alfred 2/Alfred.alfredpreferences/workflows". This method is suitable for **developers**.


## Copyright

Copyright (c) 2013 Zhao Cai <caizhaoff@gmail.com>

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option)
any later version.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <http://www.gnu.org/licenses/>.

