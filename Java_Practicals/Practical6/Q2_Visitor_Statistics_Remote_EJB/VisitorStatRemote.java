package p1;

import javax.ejb.Remote;

@Remote
public interface VisitorStatRemote {
    public void connect();
    public void disconnect();
    public int addvisitor(String host);
}
