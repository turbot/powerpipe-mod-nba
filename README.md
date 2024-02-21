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

## Install the Dataset

- Visit the [NBA Database](https://www.kaggle.com/datasets/wyattowalsh/basketball/data).

- Click on `Download` (Free signup to Kaggle is required).

- Unzip the Downloaded File:

  - For Mac/Linux:
    - Use the command `unzip ~/Downloads/archive.zip` to extract the file.

  - For Windows:
    - Navigate to the folder containing the downloaded ZIP file, usually the Downloads folder.
    - Right-click on the ZIP file and choose `Extract All...` or `Extract Here` depending on your preference. Follow the on-screen instructions to complete the extraction.

## Usage

Run the dashboard and specify the DB connection string:

```sh
powerpipe server --database sqlite:nba.sqlite
```

If you have extracted the file in any other location then you need to provide the full path like below:

```sh
powerpipe server --database sqlite:///path/to/the/file/file.sqlite
```

## Open Source & Contributing

This repository is published under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0). Please see our [code of conduct](https://github.com/turbot/.github/blob/main/CODE_OF_CONDUCT.md). We look forward to collaborating with you!

[Powerpipe](https://powerpipe.io) is a product produced from this open source software, exclusively by [Turbot HQ, Inc](https://turbot.com). It is distributed under our commercial terms. Others are allowed to make their own distribution of the software, but cannot use any of the Turbot trademarks, cloud services, etc. You can learn more in our [Open Source FAQ](https://turbot.com/open-source).

## Get Involved

**[Join #powerpipe on Slack →](https://powerpipe.io/community/join)**

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Powerpipe](https://github.com/turbot/powerpipe/labels/help%20wanted)
- [NBA Mod](https://github.com/turbot/powerpipe-mod-nba/labels/help%20wanted)
