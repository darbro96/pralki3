package pl.edu.utp.pralki3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.edu.utp.pralki3.entity.Laundry;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.entity.Washer;
import pl.edu.utp.pralki3.repository.WasherRepository;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class WasherService {
    @Autowired
    private WasherRepository washerRepository;
    @Autowired
    private LaundryService laundryService;

    public List<Washer> findAll() {
        return washerRepository.findAll();
    }

    public void saveWasher(Washer washer) throws Exception {
        Laundry laundry = laundryService.get(washer.getIdOfLaundry());
        washer.setLaundry(laundry);
        if (!washerExist(washer)) {
            washerRepository.save(washer);
        } else {
            throw new Exception();
        }
    }

    private boolean washerExist(Washer washer) {
        List<Washer> washers = findAll();
        for (Washer w : washers) {
            if (w.getLaundry().getIdLaundry() == washer.getLaundry().getIdLaundry() && w.getNumberWasher().equals(washer.getNumberWasher())) {
                return true;
            }
        }
        return false;
    }

    public Washer get(int id) {
        return washerRepository.getOne(id);
    }

    public List<Washer> getWashersToUser(User user) {
        List<Washer> washers = findAll();
        washers = washers.stream().filter(w -> w.isAvailable()).filter(w -> w.getLaundry().getDormitory().getIdDormitory() == user.getDormitory().getIdDormitory()).collect(Collectors.toList());
        return washers;
    }

    public List<Washer> getWashersFromLaundry(Laundry laundry) {
        return findAll().stream().filter(w -> w.getLaundry().getIdLaundry() == laundry.getIdLaundry()).collect(Collectors.toList());
    }

    public void setAvailable(Washer washer) {
        washerRepository.setAvailable(washer.getIdWasher());
    }

    public void setUnavailable(Washer washer) {
        washerRepository.setUnavailable(washer.getIdWasher());
    }

    public void updateNumberOfWasher(Washer washer) {
        washerRepository.updateNumberOfWasher(washer.getNumberWasher(), washer.getIdWasher());
    }

    public void deleteWasher(Washer washer) {
        washerRepository.delete(washer);
    }
}
