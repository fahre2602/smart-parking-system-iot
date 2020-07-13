package net.fahre.sps1;

public class Slot {
    private int id;
    private String slot, status;
    private int lock;

    public Slot(int id, String slot, String status, int lock) {
        this.id = id;
        this.slot = slot;
        this.status = status;
        this.lock = lock;
    }

    public int getId() {
        return id;
    }

    public String getSlot() {
        return slot;
    }

    public String getStatus() {
        return status;
    }

    public int getLock() {
        return lock;
    }
}
