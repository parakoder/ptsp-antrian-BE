package handler

type HasError interface {
	GetHandler() Handler
}

type Handler struct {
	Status       int    `json:"status"`
	DetailStatus int    `json:"detail_status"`
	MessageID    string `json:"message"`
	// MessageEN    string `json:"message_en"`
	Error        string `json:"error"`
}

type ErrorHandlers struct {
	Error *Handler
}

func (h Handler) GetHandler() Handler {
	return Handler{}
}

func ErrorHandler(status int, detailStatus int, errDesc string) Handler {

	var handler Handler
	switch status {

	case 200 :
		if detailStatus == 204 {
			handler.Status = status
			handler.DetailStatus = detailStatus
			handler.MessageID = errDesc
		}

	
	case 400:
		if detailStatus == 400 {
			handler.Status = status
			handler.DetailStatus = detailStatus
			handler.MessageID = "Bad Request"
			handler.Error = errDesc
			// e.Error.DetailStatus = detailStatus,
		}else if detailStatus == 401 {
			handler.Status = status
			handler.DetailStatus = detailStatus
			handler.MessageID = "Unauthorized"
			handler.Error = errDesc
		}else if detailStatus == 404 {
			handler.Status = status
			handler.DetailStatus = detailStatus
			handler.MessageID = "API tidak ditemukan"
			handler.Error = errDesc

		} else if detailStatus == 405 {
			handler.Status = status
			handler.DetailStatus = detailStatus
			handler.MessageID = "User tidak ditemukan"
			handler.Error = errDesc

		} else if detailStatus == 422 {
			handler.Status = status
			handler.DetailStatus = detailStatus
			handler.MessageID = "Autentikasi gagal"
			handler.Error = errDesc

		}

	case 500:
		if detailStatus == 500 {
			handler.Status = status
			handler.DetailStatus = detailStatus
			handler.MessageID = "Internal server error"
			handler.Error = errDesc
			// e.Error.DetailStatus = detailStatus,
		}
		
	}

	return handler
}
