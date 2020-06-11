Rails.configuration.stripe = {
    :publishable_key => 'pk_live_ajF4hY4CAVdaErMv1JYHVitr00QfZBC4Ll',
    :secret_key => 'sk_live_ozrtEWNJ3x5oVt2e8mM2BPee00cUZmWJTZ'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]