package main

import (
	"fmt"
	"net/http"

	"golang.org/x/time/rate"
)

func (a *applicationDependencies) recoverPanic(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// defer will be called when the stack unwinds
		defer func() {
			// recover() checks for panics
			err := recover()
			if err != nil {
				w.Header().Set("Connection", "close")
				a.serverErrorResponse(w, r, fmt.Errorf("%s", err))
			}
		}()
		next.ServeHTTP(w, r)
	})
}

func (a *applicationDependencies) rateLimit(next http.Handler) http.Handler {
	// create a new rate limiter that allows 2 requests per second with a maximum burst size of 5
	limiter := rate.NewLimiter(2, 5)
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// check if the request is allowed by the rate limiter
		// if not, send a 429 Too Many Requests response
		if !limiter.Allow() {
			a.rateLimitExceededResponse(w, r)
			return
		}
		next.ServeHTTP(w, r)
	})
}
