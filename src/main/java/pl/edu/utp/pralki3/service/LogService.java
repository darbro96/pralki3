package pl.edu.utp.pralki3.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.edu.utp.pralki3.entity.Log;
import pl.edu.utp.pralki3.entity.User;
import pl.edu.utp.pralki3.repository.LogRepository;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class LogService {
    @Autowired
    private LogRepository logRepository;

    public List<Log> findAll() {
        return logRepository.findAll();
    }

    public List<Log> findByUser(User user) {
        List<Log> logs = findAll();
        logs = logs.stream().filter(l -> l.getUser().getIdUser() == user.getIdUser()).sorted(Comparator.comparing(Log::getDateAndTime)).collect(Collectors.toList());
        return logs;
    }

    public void saveLog(User user, String content) {
        Log log = new Log();
        log.setUser(user);
        log.setDescription(content);
        log.setDateAndTime(LocalDateTime.now());
        logRepository.save(log);
    }

    public void deleteByUser(User user) {
        logRepository.deleteLogOfUser(user.getIdUser());
    }
}
