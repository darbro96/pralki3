package pl.edu.utp.pralki3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.edu.utp.pralki3.entity.Laundry;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.entity.Washer;
import pl.edu.utp.pralki3.repository.WasherRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class WasherService {
    @Autowired
    private WasherRepository washerRepository;
    @Autowired
    private LaundryService laundryService;

    public List<Washer> findAll() {
        return washerRepository.findAll();
    }

    public void saveWasher(Washer washer) {
        Laundry laundry = laundryService.get(washer.getIdOfLaundry());
        washer.setLaundry(laundry);
        washerRepository.save(washer);
    }

    public Washer get(int id) {
        return washerRepository.getOne(id);
    }

    public List<Washer> getWashersToUser(User user) {
        List<Washer> washers = findAll();
        washers = washers.stream().filter(w -> w.getLaundry().getDormitory().getIdDormitory() == user.getDormitory().getIdDormitory()).collect(Collectors.toList());
        return washers;
    }
}
