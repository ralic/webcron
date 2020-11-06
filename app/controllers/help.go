package controllers

type HelpController struct {
	BaseController
}

func (this *HelpController) Index() {

	this.Data["pageTitle"] = "使用幫助"
	this.display()
}
