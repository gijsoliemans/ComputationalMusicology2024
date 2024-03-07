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


saveRDS(object = corpus,file = "data/corpus-data.RDS")


lowest_track <-
  get_tidy_audio_analysis("6Sj8Ew4L6zXJjFdS8uAEJr") |>
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
saveRDS(object = lowest_track,file = "data/lowest_track_tidy_analysis-data.RDS")

highest_track <-
  get_tidy_audio_analysis("4NDFxJrczMb3FBQxanKguk") |>
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

saveRDS(object = highest_track,file = "data/highest_track_tidy_analysis-data.RDS")

