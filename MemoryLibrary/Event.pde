class Event {
    ArrayList<Runnable> events;

    public Event() {
        events = new ArrayList<Runnable>();
    }

    public void Invoke() {
        for (Runnable event : events) { 
            event.run(); 
        }
    }

    public void Register(Runnable event) {
        events.add(event);
    }
}
