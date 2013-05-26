public class DogTestDrive {
    public static void main(String[] args)
    {
        Dog one = new Dog();
        one.setSize(70);
        Dog two = new Dog();
        two.setSize(8);
        System.out.print("Dog one: " + one.getSize() + " ");
        one.bark();
        System.out.print("Dog two: " + two.getSize() + " ");
        two.bark();
    }
}
