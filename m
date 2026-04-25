Return-Path: <linux-pwm+bounces-8691-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HyRBrcB7WnmeAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8691-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Apr 2026 20:02:31 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 654204672EB
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Apr 2026 20:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92A1A3056D12
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Apr 2026 17:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0A039B943;
	Sat, 25 Apr 2026 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVxMT9NE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340E539B497;
	Sat, 25 Apr 2026 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139443; cv=none; b=OP32vKwXBca76w3II3BUSchtv17oAKG5SlQCDBXKAPy/g54gCJieK6pKwmvgtJNJ/j8tayYaOl3RbDRvIA5/wOCuT25tUiqb+tx5OA7gLZXB54/Rjh0MP2jMtZetRmo3Y4HsV/D6KxH01WtzajjA9dhFmtkGI0ztuLk0S5v8qp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139443; c=relaxed/simple;
	bh=Eq1gWbdZCyBkPLyU8ZI7KGDNpjNSiEaS1D+uvztVezk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBO0RWbRPzFy35H7frU7629+M6G3PXBpSMYCFT6uFavNZfX56a0kh52inzbU8B3LTYiBi6xGhdbN3u45/boL4A+6lFppx6XdROQmyyj3yr4S+oi5JV/slMVcKuEjllVB/NEAjBrkks/hvN3VcL4qSJeyVU7xpkjwW8NR5f86kcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVxMT9NE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8C5C4AF1C;
	Sat, 25 Apr 2026 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777139442;
	bh=Eq1gWbdZCyBkPLyU8ZI7KGDNpjNSiEaS1D+uvztVezk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FVxMT9NETDxJ0HO1pCnX4MSfJsyyRyC0Fbn1Ja0AOjAkO/s9g0NF0cN8kd7e/JGQW
	 WQICJhgz8AR+HBSG/FADsC0A2SnH6qRZt/CRW2uwVBrRVGK18Xge55RFJjSCDIktM2
	 4fGZt8E4nxSFgx58l7hR3XfZi3XzHL1ohjsn9J+B2cjkdKMjpwvz1fOPlEtwYhyy0r
	 X5TkXeskeHTWIZKvJl+6v86LKI2TiD/X73qMlu+YxVlbWQ1O5BISKtQe2CLaFJ42NI
	 d2RrSQtwMN9arEXeuALwEkTgey1H97RsYm/GMaNkpJMrJIRCAfRi70pIxHaOciEN1H
	 xN7XmJLdM6+Og==
Date: Sat, 25 Apr 2026 18:50:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260425185028.6023661e@jic23-huawei>
In-Reply-To: <20260416-ad4692-multichannel-sar-adc-driver-v8-3-c415bd048fa3@analog.com>
References: <20260416-ad4692-multichannel-sar-adc-driver-v8-0-c415bd048fa3@analog.com>
	<20260416-ad4692-multichannel-sar-adc-driver-v8-3-c415bd048fa3@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 654204672EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8691-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email]

On Thu, 16 Apr 2026 12:18:48 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Add buffered capture support using the IIO triggered buffer framework.
>=20
> CNV Burst Mode: the GP pin identified by interrupt-names in the device
> tree is configured as DATA_READY output. The IRQ handler stops
> conversions and fires the IIO trigger; the trigger handler executes a
> pre-built SPI message that reads all active channels from the AVG_IN
> accumulator registers and then resets accumulator state and restarts
> conversions for the next cycle.
>=20
> Manual Mode: CNV is tied to SPI CS so each transfer simultaneously
> reads the previous result and starts the next conversion (pipelined
> N+1 scheme). At preenable time a pre-built, optimised SPI message of
> N+1 transfers is constructed (N channel reads plus one NOOP to drain
> the pipeline). The trigger handler executes the message in a single
> spi_sync() call and collects the results. An external trigger (e.g.
> iio-trig-hrtimer) is required to drive the trigger at the desired
> sample rate.
>=20
> Both modes share the same trigger handler and push a complete scan =E2=80=
=94
> one u16 slot per channel at its scan_index position, followed by a
> timestamp =E2=80=94 to the IIO buffer via iio_push_to_buffers_with_ts().
>=20
> The CNV Burst Mode sampling frequency (PWM period) is exposed as a
> buffer-level attribute via IIO_DEVICE_ATTR.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
Hi Radu,

A couple of comments inline, but only for things to change
if you end up doing a v9 for other reasons.

thanks,

Jonathan

> ---
>  drivers/iio/adc/Kconfig  |   2 +
>  drivers/iio/adc/ad4691.c | 537 +++++++++++++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 524 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 3685a03aa8dc..d498f16c0816 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig

> @@ -84,19 +104,23 @@ enum ad4691_ref_ctrl {
>  	AD4691_VREF_5P0   =3D 4,
>  };
> =20
> -struct ad4691_chip_info {
> +struct ad4691_channel_info {
>  	const struct iio_chan_spec *channels;

We could mark this __counted_by_ptr()  but that's new so no drivers
are doing so yet.  At somepoint I'll have a look at whether it's
worth pushing it into existing drivers and if it is do this
one at that time.  If you are respinning for other reasons though
then nice to have.

> -	const char *name;
>  	unsigned int num_channels;
> +};
> +
> +struct ad4691_chip_info {
> +	const char *name;
>  	unsigned int max_rate;
> +	const struct ad4691_channel_info *sw_info;
>  };
I'm not going to ask you to respin just for this, but it would have
been neater to push this factoring out of channels + num_channels
into the previous patch.


