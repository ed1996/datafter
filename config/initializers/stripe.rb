Rails.configuration.stripe = {
    :publishable_key => 'pk_test_vZZJYxpcq1AYeYg6NCDt7Oz6',
    :secret_key => 'sk_test_u3S6j4XYQDBJqImSaNug0Jbu'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]