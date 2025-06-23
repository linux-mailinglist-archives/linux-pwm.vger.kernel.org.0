Return-Path: <linux-pwm+bounces-6474-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E22AE3B39
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 11:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF3D171B14
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 09:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000A62192E1;
	Mon, 23 Jun 2025 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGB/bt+b"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA901A3168;
	Mon, 23 Jun 2025 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672432; cv=none; b=X9O8syg4PxoRlVckGhF26qWagOLoRQ35WWY2kjF9W6BQ6JfH9c5vWoJKZwD3NN6kUL3nC1pRz1QcfuapggCwBvxUOSwlYKg2RHPrb7spyjiy7PYYSlEC9NvJp1xTNPxZWmj7VkP3HpZYCkVxqa+RO2uMXzoY135DZuVPrzOcDbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672432; c=relaxed/simple;
	bh=L+OJqtn3qUy87mOxKth1q/B7lsmQdamD+VL+I15xh2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+1sjcZlOrflOMRz+ySLNTPIvLhica1/3wjfeGaEcCVPm2LIkF1PJK7VRKxgO3fG/HQzOUHIt0slWsKFkx6epKtMCcBDsyVVpYn0N2erXodbReTgGZWe0Bk+rGNcr4kpy7fb+29NMmIzk5gLyUhukOiMSEW0HfOV6Ld1CgNwOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGB/bt+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142C4C4CEEA;
	Mon, 23 Jun 2025 09:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750672432;
	bh=L+OJqtn3qUy87mOxKth1q/B7lsmQdamD+VL+I15xh2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGB/bt+bi2lDKJ/PppR3VOujn+WEhPY4xRESdDAQZ2fn5YqgvyiK3TNRRmR+h2JtE
	 Msuki7nDgU2vjkhnTrSZDdMdhY1qS4+WdlGkb9AvWcU5EkvRWfmFaKZAFSDqsl7n+T
	 2CA3XlN/XBMkaiUCThLe3HcTUCu8btL8VkVA473Awmt+Za2cTVp0fKrZVfmhWci9z2
	 VyrEI3wmA74XRAlApmb+l4opqDHb7dMFiV8l3sRx68QFlj6bkDBTL3zmqd2sC0cY0Z
	 h0czqNDZT/b3p+pbeEZkKVdStSN3pHnhnjY+8OnPRqkSTMscBrVISNqaJ4cUEfMpjE
	 m0pXnr/bJb/1Q==
Date: Mon, 23 Jun 2025 11:53:49 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v14] pwm: airoha: Add support for EN7581 SoC
Message-ID: <ulthwqifylgh5ufrhu43nsboq3a3gykq4isgmrb23g67n2fzs6@4tt5afd73pnm>
References: <20250616201532.29047-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ebvxdda3grak5kqm"
Content-Disposition: inline
In-Reply-To: <20250616201532.29047-1-ansuelsmth@gmail.com>


--ebvxdda3grak5kqm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v14] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello Christian,

On Mon, Jun 16, 2025 at 10:15:24PM +0200, Christian Marangi wrote:
> +static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
> +	u64 duty_ns = state->duty_cycle;
> +	u64 period_ns = state->period;
> +
> +	if (!state->enabled) {
> +		airoha_pwm_disable(pc, pwm);
> +		return 0;
> +	}
> +
> +	/* Only normal polarity is supported */
> +	if (state->polarity == PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	/* Exit early if period is less than minimum supported */
> +	if (period_ns < AIROHA_PWM_PERIOD_TICK_NS)
> +		return -EINVAL;
> +
> +	/*
> +	 * Period goes at 4ns step, normalize it to check if we can
> +	 * share a generator.
> +	 */
> +	period_ns = rounddown(period_ns, AIROHA_PWM_PERIOD_TICK_NS);

I guess this is the one that triggered the exception on m68k (though I
couldn't reproduce it). If you do the clamping first, period_ns can be
an unsigned int and the issue should be fixed.

> +	/*
> +	 * Duty goes at 255 step, normalize it to check if we can
> +	 * share a generator.
> +	 */
> +	duty_ns = DIV_U64_ROUND_UP(duty_ns * AIROHA_PWM_DUTY_FULL,
> +				   AIROHA_PWM_DUTY_FULL);
> +
> +	/* Clamp period to MAX supported value */
> +	if (period_ns > AIROHA_PWM_PERIOD_MAX_NS) {
> +		period_ns = AIROHA_PWM_PERIOD_MAX_NS;
> +
> +		if (duty_ns > period_ns)
> +			duty_ns = period_ns;
> +	}
> +
> +	return airoha_pwm_config(pc, pwm, duty_ns, period_ns);
> +}
> [...]
> +static struct platform_driver airoha_pwm_driver = {
> +	.driver = {
> +		.name = "pwm-airoha",

Given that there must be another revision anyhow, please add

		.probe_type = PROBE_PREFER_ASYNCHRONOUS,

here.

> +		.of_match_table = airoha_pwm_of_match,
> +	},
> +	.probe = airoha_pwm_probe,
> +};
> +module_platform_driver(airoha_pwm_driver);

Best regards
Uwe

--ebvxdda3grak5kqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhZJB0ACgkQj4D7WH0S
/k5MTgf/W7cIrCx/PbaPEthN75RSHyIuk9wfVz9RtYKDKghq9S+RT/Ei/ijwsknm
KdJpJQUiQZok/tACyYViME1daqYZVKt2CCHlqYs4zpaWYNecxOMGcHXSK1/WCHpR
iDDvW3PyPSqOybFieh46IFlyWCqb5ldS4Yw9Bl4Qg1wRo0bUxxjW6vUZktoTMu24
EJUiYVw/5rsCRt98YbipYx2VvRFP4N6YS560SE0VWTRxPY9mMBz8vWTxdUdy+pk4
SM9eMPFwEPAAeYo/gAKrvonkFL5t/NfEN0eYM7Xitg34yX1y9SQB830xw+DsaO8d
570sr7+YkusCzv8U75ZOXwvQxKxG8A==
=e8ML
-----END PGP SIGNATURE-----

--ebvxdda3grak5kqm--

