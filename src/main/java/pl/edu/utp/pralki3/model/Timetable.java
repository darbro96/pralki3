package pl.edu.utp.pralki3.model;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
public class Timetable {
        private String day;
        private List<SpecialReservation> specialReservations;
}
