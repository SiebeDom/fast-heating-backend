package be.fastHeating.controller;

import be.fastHeating.model.Customer;
import be.fastHeating.model.CustomerNotFoundException;
import be.fastHeating.repository.CustomerRepository;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
class CustomerController {

    private final CustomerRepository repository;

    CustomerController(CustomerRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/customers")
    List<Customer> all() {
        List<Customer> result = new ArrayList<>();
        repository.findAll().forEach(result::add);
        return result;
    }

    @PostMapping("/customers")
    Customer newCustomer(@RequestBody Customer newCustomer) {
        return repository.save(newCustomer);
    }

    @GetMapping("/customers/{id}")
    Customer one(@PathVariable Long id) {

        return repository.findById(id)
                .orElseThrow(() -> new CustomerNotFoundException(id));
    }

    @PutMapping("/customers/{id}")
    Customer replaceCustomer(@RequestBody Customer newCustomer, @PathVariable Long id) {
        return repository.findById(id)
                .map(employee -> {
                    employee.setType(newCustomer.getType());
                    employee.setName(newCustomer.getName());
                    employee.setStreet(newCustomer.getStreet());
                    employee.setHouseNumber(newCustomer.getHouseNumber());
                    employee.setBoxNumber(newCustomer.getBoxNumber());
                    employee.setPostalCode(newCustomer.getPostalCode());
                    employee.setCity(newCustomer.getCity());
                    employee.setPhone(newCustomer.getPhone());
                    employee.setMobile(newCustomer.getMobile());
                    employee.setEmail(newCustomer.getEmail());
                    return repository.save(employee);
                })
                .orElseGet(() -> {
                    newCustomer.setId(id);
                    return repository.save(newCustomer);
                });
    }

    @DeleteMapping("/customers/{id}")
    void deleteCustomer(@PathVariable Long id) {
        repository.deleteById(id);
    }

}
