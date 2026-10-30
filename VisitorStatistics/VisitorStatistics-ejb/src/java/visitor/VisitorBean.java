package visitor;

import javax.ejb.Stateless;

@Stateless
public class VisitorBean {

    private static int visitorCount = 0;

    public synchronized void addVisitor() {
        visitorCount++;
    }

    public synchronized int getVisitorCount() {
        return visitorCount;
    }
}