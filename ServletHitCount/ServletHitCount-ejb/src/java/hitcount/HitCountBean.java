package hitcount;

import javax.ejb.Singleton;

@Singleton
public class HitCountBean {

    private int hitCount = 0;

    public synchronized int incrementHitCount() {
        hitCount++;
        return hitCount;
    }

    public int getHitCount() {
        return hitCount;
    }
}