package inventory;

import com.intuit.karate.junit5.Karate;

class inventoryTestRunner {

    @Karate.Test
    Karate testInventory() {
        // This will run the feature file located in src/test/resources/feature/
        return Karate.run("../feature/test").relativeTo(getClass());
    }
}
