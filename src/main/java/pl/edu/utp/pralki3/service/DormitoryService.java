package pl.edu.utp.pralki3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.edu.utp.pralki3.entity.Dormitory;
import pl.edu.utp.pralki3.repository.DormitoryRepository;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class DormitoryService {
    @Autowired
    private DormitoryRepository dormitoryRepository;

    public Dormitory findByName(String name)
    {
        return dormitoryRepository.findByName(name);
    }

    public void saveDormitory(Dormitory dormitory)
    {
        dormitoryRepository.save(dormitory);
    }

    public List<Dormitory> findAll()
    {
        return dormitoryRepository.findAll();
    }

    public int amountOfDormitories()
    {
        return dormitoryRepository.findAll().size();
    }
}
