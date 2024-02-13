dashboard "nba_analysis_dashboard" {
  title = "NBA Analysis Dashboard"

  # Container: Overview
  container {
    title = "Overview"

    # Card: Total Players
    card {
      query = query.total_active_players
      width = 4
      type  = "info"
    }

    # Card: Total Teams
    card {
      query = query.total_teams
      width = 4
      type  = "info"
    }

    # Card: Rookie Players
    card {
      query = query.total_rookie_players
      width = 4
      type  = "info"
    }
  }

  container {
    title = "Team Analysis"

    chart {
      type  = "column"
      title = "Home vs. Away Wins by Team"
      query = query.home_away_wins_by_team
      width = 6

      legend {
        display  = "auto"
        position = "top"
      }

      series "home_wins" {
        title = "Home Wins"
        color = "blue"
      }
      series "away_wins" {
        title = "Away Wins"
        color = "orange"
      }

      axes {
        y {
          title {
            value = "Number of Wins"
          }
          labels {
            display = "show"
          }
          min = 0
        }
      }
    }

    chart {
      type  = "column"
      title = "Total Points Scored at Home vs. Away by Team"
      query = query.home_away_top_points_by_team
      width = 6

      legend {
        display  = "auto"
        position = "top"
      }

      series "home_points" {
        title = "Home Points"
        color = "green"
      }
      series "away_points" {
        title = "Away Points"
        color = "purple"
      }

      axes {
        y {
          title {
            value = "Total Points"
          }
          labels {
            display = "show"
          }
          min = 0
        }
      }
    }

  }

  container {
    chart {
      type  = "line"
      title = "Top 10 Teams by Total Wins"
      query = query.top_10_team_by_total_wins
      width = 6

      legend {
        display  = "auto"
        position = "top"
      }

      series "total_wins" {
        title = "Total Wins"
        color = "green"
      }

      axes {
        y {
          title {
            value = "Number of Wins"
          }
          labels {
            display = "show"
          }
          min = 0
        }
      }
    }

    chart {
      query = query.team_arena_capacities
      title = "Team Arena Capacities"
      width = 6
      type  = "column"

      series "arenacapacity" {
        title = "Capacity"
        color = "green"
      }

      axes {
        y {
          title {
            value = "Capacity"
          }
          labels {
            display = "show"
          }
          min = 0
        }
      }
    }

    chart {
      type  = "column"
      title = "Teams by Points Per Game"
      query = query.top_teams_by_points_per_game
      width = 6

      legend {
        display  = "auto"
        position = "bottom"
      }

      series "AvgPointsPerGame" {
        title = "Average Points Per Game"
        color = "blue"
      }

      axes {
        y {
          title {
            value = "Average Points Per Game"
          }
          labels {
            display = "show"
          }
          min = 0
        }
      }
    }

    chart {
      type  = "column"
      title = "Player Experience Distribution by Team"
      query = query.player_experience_distribution_by_team
      width = 6

      legend {
        display  = "auto"
        position = "top"
      }

      series "Rookies" {
        title = "Rookies"
        color = "lightblue"
      }
      series "1_to_3_years" {
        title = "1 to 3 Years"
        color = "green"
      }
      series "4_to_6_years" {
        title = "4 to 6 Years"
        color = "orange"
      }
      series "7_years_plus" {
        title = "7 Years Plus"
        color = "red"
      }

      axes {
        y {
          title {
            value = "Number of Players"
          }
          labels {
            display = "show"
          }
          min = 0
        }
      }
    }
  }

  container {
    title = "Defensive Team Performance"
    width = 6

    chart {
      query = query.team_average_points_allowed
      title = "Team Average Points Allowed Per Game"
      type  = "column"

      series "Average Points Allowed" {
        title = "Average Points Allowed"
        color = "green"
      }

    }
  }

  container {
    title = "Global Influence in the NBA"
    width = 6

    chart {
      query = query.player_birth_countries_all
      title = "International Representation in the NBA"
      type  = "donut"
    }
  }
}

query "player_experience_distribution_by_team" {
  sql = <<-EOQ
    select
      team_name,
      sum(case when season_exp = 0 then 1 else 0 end) as Rookies,
      sum(case when season_exp between 1 and 3 then 1 else 0 end) as "1_to_3_years",
      sum(case when season_exp between 4 and 6 then 1 else 0 end) as "4_to_6_years",
      sum(case when season_exp >= 7 then 1 else 0 end) as "7_years_plus"
    from
      common_player_info
    group by
      team_name
    order by
      team_name;
  EOQ
}

query "top_teams_by_points_per_game" {
  sql = <<-EOQ
    with total_points as (
      select
        team_id_home as team_id,
        sum(pts_home) as points
      from
        game
      group by
        team_id_home
      union all
      select
        team_id_away,
        sum(pts_away)
      from
        game
      group by
        team_id_away
    ),
    game_counts as (
      select
        team_id,
        COUNT(*) as games_played
      from (
        select team_id_home as team_id from game
        union all
        select team_id_away from game
      )
      group by team_id
    ),
    avg_points as (
      select
        tp.team_id,
        sum(tp.points) / gc.games_played as avg_points_per_game
      from
        total_points tp
      join game_counts gc on tp.team_id = gc.team_id
      group by
        tp.team_id
      order by
        avg_points_per_game DESC
    )
    select
      t.full_name,
      ap.avg_points_per_game
    from
      avg_points ap
    join team t on ap.team_id = t.id;
  EOQ
}

query "top_10_team_by_total_wins" {
  sql = <<-EOQ
    select
      team_name_home,
      sum(case when wl_home = 'W' then 1 else 0 end + case when wl_away = 'W' then 1 else 0 end) as total_wins
    from
      game
    group by
      team_name_home
    order by
      total_wins desc
    limit 10;
    EOQ
}

query "home_away_top_points_by_team" {
  sql = <<-EOQ
    with home_points as (
      select
        team_id_home as team_id,
        sum(pts_home) as home_points
      from
        game
      group by
        team_id_home
    ),
    away_points as (
      select
        team_id_away as team_id,
        sum(pts_away) as away_points
      from
        game
      group by
        team_id_away
    )
    select
      t.full_name,
      h.home_points,
      a.away_points
    from
      home_points h
      join away_points a on h.team_id = a.team_id
      left join team t on h.team_id = t.id;
  EOQ
}

query "home_away_wins_by_team" {
  sql = <<-EOQ
    with home_wins as (
      select
        team_id_home as team_id,
        count(*) as home_wins
      from
        game
      where
        wl_home = 'W'
      group by
        team_id_home
    ),
    away_wins as (
      select
        team_id_away as team_id,
        count(*) as away_wins
      from
        game
      where
        wl_away = 'W'
      group by
        team_id_away
    )
    select
      t.full_name,
      h.home_wins,
      a.away_wins
    from
      home_wins h
      join away_wins a on h.team_id = a.team_id
      left join team t on h.team_id = t.id;
    EOQ
}

query "total_active_players" {
  sql = <<-EOQ
    select
      count(*) as "Total Active Players"
    from
      player
    where
      is_active = 1;
  EOQ
}

query "total_teams" {
  sql = <<-EOQ
    select
      count(*) as "Total Teams"
    from
      team;
  EOQ
}

query "total_rookie_players" {
  sql = <<-EOQ
    select
      count(*) as "Rookie Players"
    from
      common_player_info
    where
      season_exp = 0;
  EOQ
}

query "team_foundation_years" {
  sql = <<-EOQ
    select
      city,
      nickname,
      year_founded
    from
      team
    order by
      year_founded;
  EOQ
}

query "team_arena_capacities" {
  sql = <<-EOQ
    select
      nickname,
      arenacapacity
    from
      team_details;
  EOQ
}

query "team_average_points_allowed" {
  sql = <<-EOQ
    select
      team_name,
      avg(pts_allowed) as "Average Points Allowed"
    from (
      select
        team_id_away as team_id,
        team_name_away as team_name,
        pts_home as pts_allowed
      from game
      union all
      select
        team_id_home,
        team_name_home,
        pts_away
      from game
    ) as combined
    group by
      team_id
    order by
      "Average Points Allowed";
  EOQ
}

query "player_birth_countries_all" {
  sql = <<-EOQ
    select
      country,
      count(*) as "Number of Players"
    from
      common_player_info
    where
      country is not null and trim(country) <> ''
    group by
      country
    order by
      "Number of Players" desc;
  EOQ
}

