package karaoke.api;

import lombok.*;

@ToString
@EqualsAndHashCode(exclude = {"title", "artist", "length"})
@Builder
public class DtoTrack {

    @Getter
    @Setter
    private Long id;

    @Getter
    @Setter
    private String title;

    @Getter
    @Setter
    private String artist;

    @Getter
    @Setter
    private Long length;

}
