package karaoke.api;


import lombok.*;

@ToString
@EqualsAndHashCode(exclude = {"text", "track"})
@Builder
public class DtoLyrics {

    @Getter
    @Setter
    private Long id;

    @Getter
    @Setter
    private String text;

    @Getter
    @Setter
    private DtoTrack track;

}
