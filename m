Return-Path: <linux-pwm+bounces-8402-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC0PIiXdyGkorwUAu9opvQ
	(envelope-from <linux-pwm+bounces-8402-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2026 10:04:53 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCB33512CE
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2026 10:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 344FF30071D0
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2026 08:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044B72DCBF8;
	Sun, 29 Mar 2026 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUNOBC6W"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8F624B28;
	Sun, 29 Mar 2026 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774771490; cv=none; b=iFEOxWIPc+xa169opxKQq/djwvi8S91hC78l1iLU1hdgoLU1KR+LPvcYItkgu9nrNwRd8S+haBsFLlaNO5LJDLEZj7DHeYa+B5g/psS+zkw1P82YfYEI+gkulB4swQEGhipt+FEta6KYkIk/1JUEvE48iDWJ11SfhC+1d9xY8Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774771490; c=relaxed/simple;
	bh=i6SF/XNHOmRD3nw7Nr4/q/gJ9IwKNLMR8vrL1INFa/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftOFPiDowGoN7zLJF3dhSjsnBYmKlqwlfjdMRL1nJXnwZaIoj+efUyf61/RsFd3fjjfz9d8DTyFf3OydviVAHldMe6VZugK+aJn1I4AEER+HPoYP7r1k3t/sFU5VpPKlM0J3LHIy9QzPZIT9e9vj3OKN2INMJWEM+QooLv2Dkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUNOBC6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8ACC116C6;
	Sun, 29 Mar 2026 08:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774771490;
	bh=i6SF/XNHOmRD3nw7Nr4/q/gJ9IwKNLMR8vrL1INFa/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LUNOBC6W3siRz3O/MJUXFqKvWhmKuFuVTeOiEgUSLMA2Q2OTfOfA5bVnT1v5+G8K5
	 yzq4CbMUnkIO4kaIVauW0xPyEhCaWxh5lzDDXtjNYdmhRqEcpJWdx1G3bvuzk1esjc
	 NZ7buNMOsoYgX0CR9UHlehhrDlTD0GHPAQqkUFnKaAeEYJvuJ8qhMsBTTe+ZOz6opN
	 ++9tkipFX0uRMDjx4vBhN/WYGlHkFj2zjAYTWJt9ucMQXBWCFqFDFnAlp6lKa4AgZr
	 Yhhknt4ih4Nryxkg1ZK0/Zulz7YIGf0Q0SByyU8KV7OL4RoJlXNi04rH3+TKUIqhXD
	 I0dE71BfmCX6Q==
Date: Sun, 29 Mar 2026 10:04:47 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/4] iio: adc: ad4691: add triggered buffer support
Message-ID: <acjaqByQo0C2Msjo@monoceros>
References: <20260327-ad4692-multichannel-sar-adc-driver-v5-0-11f789de47b8@analog.com>
 <20260327-ad4692-multichannel-sar-adc-driver-v5-3-11f789de47b8@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5etpnf3qopr55utl"
Content-Disposition: inline
In-Reply-To: <20260327-ad4692-multichannel-sar-adc-driver-v5-3-11f789de47b8@analog.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8402-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BCB33512CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--5etpnf3qopr55utl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 3/4] iio: adc: ad4691: add triggered buffer support
MIME-Version: 1.0

On Fri, Mar 27, 2026 at 01:07:59PM +0200, Radu Sabau via B4 Relay wrote:
> +static const char * const ad4691_gp_names[] = { "gp0", "gp1", "gp2", "gp3" };
> +
> +/*
> + * Valid ACC_DEPTH values where the effective divisor equals the count.
> + * From Table 13: ACC_DEPTH = 2^N yields right-shift = N, divisor = 2^N.
> + */
> +static const int ad4691_oversampling_ratios[] = { 1, 2, 4, 8, 16, 32 };
> [...]
> +static int ad4691_set_oversampling_ratio(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> +					 int osr)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad4691_oversampling_ratios); i++) {
> +		if (ad4691_oversampling_ratios[i] != osr)
> +			continue;

Given that ad4691_oversampling_ratios[i] is 1 << i; you can get rid of
the loop using something like:

	if (osr < 1 || osr > 32 || !is_power_of_2(osr))
		return -EINVAL;

	i = ilog2(osr);

> +
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		st->osr[chan->scan_index] = osr;
> +		return regmap_write(st->regmap,
> +				    AD4691_ACC_DEPTH_IN(chan->scan_index), osr);
> +	}
> +
> +	return -EINVAL;
> +}

Best regards
Uwe

--5etpnf3qopr55utl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnI3RwACgkQj4D7WH0S
/k6zzAf+J/7TqFHxQOCCHdUOD0oRn8btWZ2pH95is3fxAKrwDQtngFy3M4CULsCg
GqYyEx+As2PJ1gq8S4Sy8jGMn7um3xjGe/WP82wePbJ1ZnYbfyiGFGRd8Ra5IgV2
rujUIVQnvkbiwWnvg9IYUQmkwOl3aGa+dS13XzG9FO/9hrS/SnxaBdt+rKZrPTD3
GTFcSRG2f8op0gwLh+7uUEOQbos+jI5DhXxujrs56oEJxatRLP/0EKmz6VRVUc1f
8h38ZNXNJP1JlEwYK4HH3PiIF7zDC4i8VFqzph2t1rKkzGwueaUDi72C1HThYl/9
1Nc/iQRpQneT8ikWVpjN8yWMsd5pCQ==
=0mMc
-----END PGP SIGNATURE-----

--5etpnf3qopr55utl--

