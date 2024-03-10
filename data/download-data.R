beatles <- get_playlist_audio_features("", "5YPyQdiRzU0xolryQHqhNv") 
rhcp <- get_playlist_audio_features("", "04rfJgMUHRVg3d7iL3dLPU")
fela_kuti <- get_playlist_audio_features("", "7kdOWMLqjh2nfBPqvZ6zGd")
daft_punk <- get_playlist_audio_features("", "49In2rUl8PCWKC6yAETu9G")
bjork <- get_playlist_audio_features("", "19Ar68GhVwnuSNgw7CtF7y")
miles_davis <- get_playlist_audio_features("", "1qK5njkyEremnIBvPbw36O")
radiohead <- get_playlist_audio_features("", "0GedvaI33dOhxTaJTnh80p")
youssoundour <- get_playlist_audio_features("","23IgCQB3p9ZhJtD4wPwQAC")
caetanoveloso <- get_playlist_audio_features("", "6PEjftDLv1ro1R8y4GwUAn")
beatles$artist <- "Beatles"
rhcp$artist <- "RHCP"
fela_kuti$artist <- "Fela Kuti"
daft_punk$artist <- "Daft Punk"
bjork$artist <- "Bjork"
miles_davis$artist <- "Miles Davis"
radiohead$artist <- "Radiohead"
youssoundour$artist <- "Youssou N'Dour"
caetanoveloso$artist <- "Caetano Veloso"
corpus <- rbind(beatles, rhcp, fela_kuti, daft_punk, bjork, miles_davis, radiohead, youssoundour, caetanoveloso)

# Chroma data
low_track_id = "6Sj8Ew4L6zXJjFdS8uAEJr"
high_track_id = "4NDFxJrczMb3FBQxanKguk"

# Chromagram data
lowest_energy_valence <-
  get_tidy_audio_analysis(low_track_id) |>
  select(segments) |>
  unnest(segments) |>
  select(start, duration, pitches)


highest_energy_valence <-
  get_tidy_audio_analysis(high_track_id) |>
  select(segments) |>
  unnest(segments) |>
  select(start, duration, pitches)

# Self similarity data
lowest_track <-
  get_tidy_audio_analysis(low_track_id) |>
  compmus_align(beats, segments) |>
  select(beats) |>
  unnest(beats) |>
  mutate(
    pitches =
      map(segments,
          compmus_summarise, pitches,
          method = "acentre", norm = "manhattan"
      )
  ) |>
  mutate(
    timbre =
      map(segments,
          compmus_summarise, timbre,
          method = "mean"
      )
  )


highest_track <-
  get_tidy_audio_analysis(high_track_id) |>
  compmus_align(bars, segments) |>
  select(bars) |>
  unnest(bars) |>
  mutate(
    pitches =
      map(segments,
          compmus_summarise, pitches,
          method = "acentre", norm = "manhattan"
      )
  ) |>
  mutate(
    timbre =
      map(segments,
          compmus_summarise, timbre,
          method = "mean"
      )
  )

# Keygrams

keygram_lowest_data <-
  get_tidy_audio_analysis(low_track_id) |>
  compmus_align(beats, segments) |>
  select(beats) |>
  unnest(beats) |>
  mutate(
    pitches =
      map(segments,
          compmus_summarise, pitches,
          method = "mean", norm = "manhattan"
      )
  )

keygram_highest_data <-
  get_tidy_audio_analysis(high_track_id) |>
  compmus_align(beats, segments) |>
  select(beats) |>
  unnest(beats) |>
  mutate(
    pitches =
      map(segments,
          compmus_summarise, pitches,
          method = "mean", norm = "manhattan"
      )
  )


# Saving objects to data directory
saveRDS(object = corpus,file = "data/corpus-data.RDS")


saveRDS(object = lowest_energy_valence, file = "data/lowest_energy_valence-data.RDS")
saveRDS(object = highest_energy_valence, file = "data/highest_energy_valence-data.RDS")

saveRDS(object = lowest_track,file = "data/lowest_track_tidy_analysis-data.RDS")
saveRDS(object = highest_track,file = "data/highest_track_tidy_analysis-data.RDS")

saveRDS(object = keygram_lowest_data,file = "data/keygram_lowest_data-data.RDS")
saveRDS(object = keygram_highest_data,file = "data/keygram_highest_data-data.RDS")


