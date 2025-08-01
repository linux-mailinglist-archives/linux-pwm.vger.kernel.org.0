Return-Path: <linux-pwm+bounces-6924-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C30B17F02
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 11:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B01F1621DC
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A105E14F9D6;
	Fri,  1 Aug 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evT0n2kx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E673C38;
	Fri,  1 Aug 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039745; cv=none; b=AgaeAedw0JqN0M/FETa3PLQElosT5/1DfsNGGrE2PIAWOnRAQrtAYULBwjH5XQYGixcBMI4+/hy4GkfP4RVvZZ21+lTOZm7XKnubbOFnY1ShQLuTmW75vShPg3N0rMK4Gb8luiowYgMkCSHPd9MI7JeKp76VRlYLCHRw7b1TwzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039745; c=relaxed/simple;
	bh=v4pCfzvHe1Q7fxLiXnQmzwFXwXiOb7175Hdq9O6RN5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1G5DhPTk+w6c0WxWSxi73mrB54ortcmWuErXdfR4ctL7vryYm6f2xzXqCawcX7ov5SpWEpe5MAyXMOZkiuAh4PrewQkCZyFMGviB9bcs8YW8zDAgAROyBjkxHWSOGfMrEfkV7beSbUXx3haAa8eaCYSGHNs3K++g0K+kfoWI9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evT0n2kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E50DC4CEE7;
	Fri,  1 Aug 2025 09:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754039744;
	bh=v4pCfzvHe1Q7fxLiXnQmzwFXwXiOb7175Hdq9O6RN5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evT0n2kxx5sbYP5FD1+iW6pFTs2oMrA6YVQUGXDpn35VWfARzsIufjNGhFZngckDt
	 kVOosgKCmNXYyWfFx4DlsxKUJKzc2gHOdYWBfaMcgMV8/3k0dExn4O80bXHLxOSkdx
	 8SLW3ecYjKYDHVnyDxeMfeEL/uN/2AQ5yLM+RQaWE2wc0A5coKJVI9h3OloshTc2aa
	 ckMH9Edf0KSX+7OWL/hhy+LAz40jx85d0zzANNghDOVQ1OSLnQHY//rwP2rjtDa5i7
	 5aYupnA3hsLrIlvRL7mPSE4gKdHpJDYeAFajIl5vqI9dWYzBUx+ZZitQqWTHKScNvJ
	 5vNVZlMDlSaqQ==
Date: Fri, 1 Aug 2025 11:15:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v23] pwm: airoha: Add support for EN7581 SoC
Message-ID: <xsblhw36y3corxx3pxe6223auirrsqr3efovfnrm5lbo4xy3lf@wf3ytlivzv6g>
References: <20250708145053.798-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jv2fclnkddr4r3n5"
Content-Disposition: inline
In-Reply-To: <20250708145053.798-1-ansuelsmth@gmail.com>


--jv2fclnkddr4r3n5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v23] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello Christian,

On Tue, Jul 08, 2025 at 04:50:52PM +0200, Christian Marangi wrote:
> +static u32 airoha_pwm_get_period_ticks_from_ns(u32 period_ns)
> +{
> +	return period_ns / AIROHA_PWM_PERIOD_TICK_NS;
> +}
> +
> +static u32 airoha_pwm_get_duty_ticks_from_ns(u32 period_ns, u32 duty_ns)
> +{
> +	return mul_u64_u32_div(duty_ns, AIROHA_PWM_DUTY_FULL, period_ns);
> +}
> +
> [...]
> +static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> [...]
> +	/*
> +	 * Period goes at 4ns step, normalize it to check if we can

4 ms or 4 ns?

> +	 * share a generator.
> +	 */
> +	period_ns = rounddown(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> +
> +	/* Convert ns to ticks */
> +	period_ticks = airoha_pwm_get_period_ticks_from_ns(period_ns);

Rounding down to the next multiple of 4ns isn't needed for
airoha_pwm_get_period_ticks_from_ns() which is just a division by
AIROHA_PWM_PERIOD_TICK_NS.

> +	duty_ticks = airoha_pwm_get_duty_ticks_from_ns(period_ns, duty_ns);

As duty_ticks depends on the selected period_ticks, I think the bucket
selection algorithm is still wrong.

Consider a request to implement

	period_ns = 256 ms
	duty_ns = 128 ms

which at first correctly results in

	period_ticks = 64
	duty_ticks = 127

If however all buckets are used and we only find one with say 62 period
ticks we get period_ns = 248 and with that duty_ticks should better be
131 and not 127.

> +
> +	return airoha_pwm_config(pc, pwm, period_ticks, duty_ticks);
> +}

Best regards
Uwe

--jv2fclnkddr4r3n5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiMhakACgkQj4D7WH0S
/k4O6AgAnwuiEIWg4JNNxtyNpBHpKfTNQnT/yp7218obiw/jYilMXZPizVXikSDW
H+SW68cUkkdaCxKM6yuIZh0SgLqvbCRc7S3JFw7W/jGqV1tGgJWPrYqExwk1CbsE
8xeJ6fq78EwNZwUzb47NBLZRmqNP5/RPVVWrKydicihRGfZGT0ttMQdC+wLBVDHw
DToW1nJZhZ3R6ZuQEddHV0tNUfk9nNqF8+8uO3xxshFolNoSKfijlGNghUtNTJK3
zHeldsOrXERFClyIm3FhZPqDNnZK1m9idOym65SNSTME7QuPxfpjaWSuX03uE32O
lZtSb2cAXKx0Ws0BeJnWo6hESrPmKQ==
=GFie
-----END PGP SIGNATURE-----

--jv2fclnkddr4r3n5--

