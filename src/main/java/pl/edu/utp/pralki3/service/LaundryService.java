package pl.edu.utp.pralki3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.edu.utp.pralki3.entity.Dormitory;
import pl.edu.utp.pralki3.entity.Laundry;
import pl.edu.utp.pralki3.repository.LaundryRepository;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class LaundryService {
    @Autowired
    private LaundryRepository laundryRepository;
    @Autowired
    private DormitoryService dormitoryService;

    public List<Laundry> findAll() {
        return laundryRepository.findAll();
    }

    public void saveLaundry(Laundry laundry) throws Exception {
        Dormitory dormitory = dormitoryService.findByName(laundry.getNameOfDormitory());
        laundry.setDormitory(dormitory);
        if (!laundryExists(laundry)) {
            laundryRepository.save(laundry);
        } else {
            throw new Exception();
        }
    }

    public Laundry get(int id) {
        return laundryRepository.getOne(id);
    }

    private boolean laundryExists(Laundry laundry) {
        List<Laundry> laundries = findAll();
        for (Laundry l : laundries) {
            if (l.getDormitory().getIdDormitory() == laundry.getDormitory().getIdDormitory() && laundry.getNumberLaundry().equals(l.getNumberLaundry())) {
                return true;
            }
        }
        return false;
    }

    public void deleteLaundry(Laundry laundry) {
        laundryRepository.delete(laundry);
    }
}
