# NBA Database Mod for PowerPipe

Analyze teams, players and games data using SQLite and PowerPipe.

![nba-analysis-dashboard-image](https://github.com/turbot/powerpipe-mod-nba/assets/72413708/7ecc750f-a1f4-4661-8f5d-2035e663bec9)

## Installation

Download and install Powerpipe (https://powerpipe.io/downloads). Or use Brew:

```sh
brew install turbot/tap/powerpipe
```

## Clone the Mod Repository

```sh
git clone https://github.com/turbot/powerpipe-mod-nba.git
cd powerpipe-mod-nba
```

## Get the Dataset

Download the [NBA Database](https://www.kaggle.com/datasets/wyattowalsh/basketball/data).

Unzip the file to the cloned mod directory.

```sh
unzip /Users/username/Downloads/archive.zip
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
