package pl.edu.utp.pralki3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.edu.utp.pralki3.entity.Dormitory;
import pl.edu.utp.pralki3.entity.Laundry;
import pl.edu.utp.pralki3.repository.LaundryRepository;

import java.util.List;

@Service
public class LaundryService {
    @Autowired
    private LaundryRepository laundryRepository;
    @Autowired
    private DormitoryService dormitoryService;

    public List<Laundry> findAll() {
        return laundryRepository.findAll();
    }

    public void saveLaundry(Laundry laundry) {
        Dormitory dormitory = dormitoryService.findByName(laundry.getNameOfDormitory());
        laundry.setDormitory(dormitory);
        laundryRepository.save(laundry);
    }

    public Laundry getLaundryByNumber(String number) {
        return laundryRepository.findByNumberLaundry(number);
    }

    public Laundry get(int id) {
        return laundryRepository.getOne(id);
    }
}
