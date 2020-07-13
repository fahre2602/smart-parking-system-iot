package net.fahre.sps1;

public class Booking {
    private int id;
    private String booktime;
    private int slot;
    private String bookfrom, bookuntil;

    public Booking(int id, String booktime, int slot, String bookfrom, String bookuntil) {
        this.id = id;
        this.booktime = booktime;
        this.slot = slot;
        this.bookfrom = bookfrom;
        this.bookuntil = bookuntil;
    }

    public int getId() {
        return id;
    }

    public String getBooktime() {
        return booktime;
    }

    public int getSlot() {
        return slot;
    }

    public String getBookfrom() {
        return bookfrom;
    }

    public String getBookuntil() {
        return bookuntil;
    }
}
