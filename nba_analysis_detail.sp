dashboard "nba_analysis_detail" {
  title = "NBA Analysis Detail"

  input "team_id" {
    title = "Select a Team:"
    query = query.team_input
    width = 4
  }

  container {

    card {
      query = query.team_foundation_year
      width = 3
      args  = [self.input.team_id.value]
    }

    card {
      query = query.team_arena_capacity
      width = 3
      args  = [self.input.team_id.value]
    }

    card {
      query = query.team_total_wins
      width = 3
      args  = [self.input.team_id.value]
    }

    card {
      query = query.team_points_per_game
      width = 3
      args  = [self.input.team_id.value]
    }

  }

  container {

    container {
      width = 12

      chart {
        title = "Team Performance Over Time"
        width = 6
        query = query.team_performance_over_time
        args  = [self.input.team_id.value]
        axes {
          x {
            title {
              value = "Years"
            }
          }
          y {
            title {
              value = "Wins"
            }
          }
        }
      }

      table {
        title = "Team Overview"
        width = 6
        type  = "line"
        query = query.team_overview
        args  = [self.input.team_id.value]
      }


    }

    container {
      width = 12

      table {
        title = "Top 10 experienced Player"
        width = 6
        query = query.players_experience_in_team
        args  = [self.input.team_id.value]
      }


      chart {
        title = "Player Nationalities in the Team"
        width = 6
        type  = "pie"
        query = query.player_nationalities_in_team
        args  = [self.input.team_id.value]
      }
    }

  }

}

# Input query

query "team_input" {
  sql = <<-EOQ
    select
      full_name as label,
      id as value
    from
      team
    order by
      full_name;
  EOQ
}

# Card queries

query "team_foundation_year" {
  sql = <<-EOQ
    select
      'Foundation Year' as label,
      year_founded as value
    from
      team
    where
      id = $1;
  EOQ
}

query "team_arena_capacity" {
  sql = <<-EOQ
    select
      'Arena Capacity' as label,
      arenacapacity as value
    from
      team_details
    where
      team_id = $1;
  EOQ
}

query "team_total_wins" {
  sql = <<-EOQ
    select
      'Total Wins' as label,
      sum(case when wl_home = 'W' then 1 else 0 end + case when wl_away = 'W' then 1 else 0 end) as value
    from
      game
    where
      team_id_home = $1 or team_id_away = $1;
  EOQ
}

query "team_points_per_game" {
  sql = <<-EOQ
    with total_points as (
      select
        team_id_home as team_id,
        sum(pts_home) as points
      from
        game
      where
        team_id_home = $1
      group by
        team_id_home
      union all
      select
        team_id_away,
        sum(pts_away)
      from
        game
      where
        team_id_away = $1
      group by
        team_id_away
    ),
    game_counts as (
      select
        team_id,
        count(*) as games_played
      from (
        select team_id_home as team_id from game
        where team_id_home = $1
        union all
        select team_id_away from game
        where team_id_away = $1
      )
      group by team_id
    ),
    avg_points as (
      select
        tp.team_id,
        sum(tp.points) / gc.games_played as avg_points_per_game
      from
        total_points tp
      join
        game_counts gc ON tp.team_id = gc.team_id
      group by
        tp.team_id
      order by
        avg_points_per_game DESC
    )
    select
      'Average Points Per Game' as label,
      ap.avg_points_per_game as value
    from
      avg_points ap
    where
      ap.team_id = $1;
  EOQ
}

# Other detail page queries

query "team_performance_over_time" {
  sql = <<-EOQ
    select
      gs.season,
      sum(case when g.wl_home = 'W' then 1 else 0 end + case when g.wl_away = 'W' then 1 else 0 end) as total_wins
    from
      game g
      join game_summary gs on g.game_id = gs.game_id
    where
      g.team_id_home = $1 or g.team_id_away = $1
    group by
      gs.season
    order by
      gs.season;
  EOQ
}

query "player_experience_distribution_by_team_detail" {
  sql = <<-EOQ
    select
      season_exp,
      count(*) as num_players
    from
      common_player_info
    where
      team_id = $1
    group by
      season_exp
    order by
      season_exp;
  EOQ
}

query "team_overview" {
  sql = <<-EOQ
    select
      full_name as 'Team Name',
      city as 'City',
      state as 'State',
      nickname as 'Nickname',
      count(*) as 'Number of Players'
    from
      team as t
      join common_player_info as cpi on t.id = cpi.team_id
    where
      id = $1;
  EOQ
}


query "player_nationalities_in_team" {
  sql = <<-EOQ
    select
      country as label,
      count(*) as value
    from
      common_player_info
    where
      team_id = $1
    group by
      country
    order by
      value DESC
    limit 5;
  EOQ
}

query "players_experience_in_team" {
  sql = <<-EOQ
    select
      display_first_last as "Player Name",
      season_exp as "Experience (Years)"
    from
      common_player_info
    where
      team_id = $1
    order by
      season_exp desc
    limit 10;
  EOQ
}