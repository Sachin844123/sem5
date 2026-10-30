package p1;

import javax.ejb.Singleton;

@Singleton
public class ServletCount {
    private int cnt;

    public synchronized int count() {
        return cnt++;
    }
}
