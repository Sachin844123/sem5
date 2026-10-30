package visitor;

import javax.ejb.ActivationConfigProperty;
import javax.ejb.EJB;
import javax.ejb.MessageDriven;
import javax.jms.Message;
import javax.jms.MessageListener;

@MessageDriven(
    activationConfig = {

        @ActivationConfigProperty(
            propertyName = "destinationType",
            propertyValue = "javax.jms.Queue"
        ),

        @ActivationConfigProperty(
            propertyName = "destinationLookup",
            propertyValue = "VisitorQueue"
        )
    }
)
public class VisitorMDB
        implements MessageListener {

    @EJB
    private VisitorBean visitorBean;

    public VisitorMDB() {
    }

    @Override
    public void onMessage(Message message) {

        try {

            System.out.println(
                "Visitor message received."
            );

            visitorBean.addVisitor();

            System.out.println(
                "Visitor count updated: "
                + visitorBean.getVisitorCount()
            );

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}