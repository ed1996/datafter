Rails.configuration.stripe = {
    :publishable_key => 'pk_test_51GrVglG6VjaT54O4hPWOdy8WQLF2EHIiy7uEgifVn4FP2r306QX8PrASCTt0jyv76ZimnNHryheQzoAAJQQFoYhv00mDXeWTvQ',
    :secret_key => 'sk_test_51GrVglG6VjaT54O4ZrKTT7c0l1VjYPnbRPJWZMT91EHIXLCom8i8bv2AzrHuJa9rozFeUsaflQLZZAz3ZGY43uh300oeCkPTsT'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]