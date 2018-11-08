package karaoke.api;

import com.veronezi.cache.Cached;
import karaoke.lyrics.Lyrics;
import karaoke.lyrics.LyricsService;
import karaoke.lyrics.Track;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.Collection;
import java.util.stream.Collectors;

@ApplicationScoped
public class ServiceThirdPartyLyrics {

    @Inject
    private LyricsService lyricsService;

    @Cached
    public DtoTrack getTrack(long trackId) {
        final Track track = lyricsService.getTrack(trackId);
        return DtoTrack.builder()
                .id(track.getId())
                .artist(track.getArtist())
                .title(track.getTitle())
                .length(track.getLength())
                .build();
    }

    @Cached
    public DtoLyrics getLyrics(DtoTrack track) {
        final Lyrics lyrics = lyricsService.getLyrics(track.getId());
        return DtoLyrics.builder()
                .id(lyrics.getId())
                .text(lyrics.getText())
                .track(track)
                .build();
    }

    @Cached
    public Collection<DtoTrack> findByArtistName(String artistName) {
        return lyricsService.findByArtistName(artistName).stream()
                .map(track -> DtoTrack.builder()
                        .id(track.getId())
                        .title(track.getTitle())
                        .length(track.getLength())
                        .artist(track.getArtist())
                        .build())
                .collect(Collectors.toList());
    }
}
