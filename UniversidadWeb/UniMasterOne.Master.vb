Public Class UniMasterOne
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Clic()
        Session.Clear()
        Session.Abandon()
    End Sub

End Class