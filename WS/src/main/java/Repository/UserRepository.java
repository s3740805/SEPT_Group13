package Repository;

import java.util.List;

import javax.transaction.Transactional;

import model.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
@Transactional
public interface UserRepository extends CrudRepository<User, String> {
    public User findByUserNameAndEnabled(String userName, short enabled);

    public List<User> findAllByEnabled(short enabled);

    public User findById(Integer id);
//
//	@Override
//	public UserInfo save(UserInfo userInfo);

    public void deleteById(Integer id);
}
