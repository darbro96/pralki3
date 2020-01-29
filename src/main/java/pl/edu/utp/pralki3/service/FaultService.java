package pl.edu.utp.pralki3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.edu.utp.pralki3.entity.Fault;
import pl.edu.utp.pralki3.repository.FaultRepository;

import javax.transaction.Transactional;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class FaultService {
    @Autowired
    private FaultRepository faultRepository;

    public void addFault(Fault fault) {
        faultRepository.save(fault);
    }

    public void setFaultDone(Fault fault) {
        faultRepository.setFaultDone(fault.getIdFault());
    }

    public List<Fault> findAll() {
        return faultRepository.findAll().stream().filter(f -> !f.isDone()).collect(Collectors.toList());
    }

    public Fault findById(int id) {
        return faultRepository.getOne(id);
    }
}
