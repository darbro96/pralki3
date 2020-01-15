package pl.edu.utp.pralki3.model;

import lombok.Getter;
import lombok.Setter;
import pl.edu.utp.pralki3.entity.Reservation;

import java.awt.*;

@Getter
@Setter
public class SpecialReservation {
    public static final String USER_COLOR = "#00FA9A";
    public static final String OTHER_COLOR = "#FF4500";

    private Reservation reservation;
    private String color;
}
