# NBA Mod for Powerpipe

Analyze teams, players and games data using SQLite and Powerpipe.

![image](https://github.com/turbot/powerpipe-mod-nba/blob/nba/docs/nba_dashboard_screenshot.png)

## Overview

Dashboards can help answer questions like:

- How many active players are there in the NBA?
- What is the total number of NBA teams?
- How many rookie players are currently in the NBA?
- How do home wins compare to away wins across NBA teams?
- Which teams score more points at home versus away, and what are these scores?

## Documentation

- **[Dashboards →](https://hub.powerpipe.io/mods/turbot/nba/dashboards)**

## Getting Started

### Installation

Download and install Powerpipe (https://powerpipe.io/downloads). Or use Brew:

```sh
brew install turbot/tap/powerpipe
```

Clone:

```sh
git clone https://github.com/turbot/powerpipe-mod-nba.git
cd powerpipe-mod-nba
```

Download the [NBA Database](https://www.kaggle.com/datasets/wyattowalsh/basketball/data) (requires signup with [Kaggle](https://www.kaggle.com/))

Extract the downloaded file in the current directory:

```sh
unzip ~/Downloads/archive.zip
```

## Usage

Run the dashboard and specify the DB connection string:

```sh
powerpipe server --database sqlite:nba.sqlite
```

## Open Source & Contributing

This repository is published under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0). Please see our [code of conduct](https://github.com/turbot/.github/blob/main/CODE_OF_CONDUCT.md). We look forward to collaborating with you!

[Powerpipe](https://powerpipe.io) is a product produced from this open source software, exclusively by [Turbot HQ, Inc](https://turbot.com). It is distributed under our commercial terms. Others are allowed to make their own distribution of the software, but cannot use any of the Turbot trademarks, cloud services, etc. You can learn more in our [Open Source FAQ](https://turbot.com/open-source).

## Get Involved

**[Join #powerpipe on Slack →](https://powerpipe.io/community/join)**

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Powerpipe](https://github.com/turbot/powerpipe/labels/help%20wanted)
- [NBA Mod](https://github.com/turbot/powerpipe-mod-nba/labels/help%20wanted)
