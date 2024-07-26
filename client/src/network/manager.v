module network

import eventbus
import superernd.cn

pub const gmanager = create_manager()

fn create_manager() &NetworkManager {
	mut nm := NetworkManager{}
	return &nm
}

@[heap]
pub struct NetworkManager {
pub mut:
	current_active_connection cn.Client = cn.Client{}
	eb eventbus.EventBus[string] = eventbus.new[string]()
}

pub fn (mut nm NetworkManager) connect_handler(receiver voidptr, args voidptr, sender voidptr) {
	if nm.eb.subscriber.is_subscribed("connect") {
		nm.eb.publish("connect", args, sender)
	}
}

pub fn (mut nm NetworkManager) payload_handler(receiver voidptr, args voidptr, sender voidptr) {
	if nm.eb.subscriber.is_subscribed("payload") {
		nm.eb.publish("payload", args, sender)
	}
}

pub fn (mut nm NetworkManager) disconnect_handler(receiver voidptr, args voidptr, sender voidptr) {
	if nm.eb.subscriber.is_subscribed("disconnect") {
		nm.eb.publish("disconnect", args, sender)
	}
}

pub fn (mut nm NetworkManager) connect(token string) ! {
	nm.current_active_connection = cn.Client{}

	// init handlers!
	mut eb := eventbus.new[string]()
	eb.subscriber.subscribe("connect", nm.connect_handler)
	eb.subscriber.subscribe("disconnect", nm.disconnect_handler)
	eb.subscriber.subscribe("payload", nm.payload_handler)

	nm.current_active_connection.eb = eb // maybe that will fix the issue. bruh?

	nm.current_active_connection.init(token)!
}

pub fn (mut nm NetworkManager) get_sub() &eventbus.Subscriber[string] {
	return nm.eb.subscriber
}