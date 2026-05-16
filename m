Return-Path: <linux-pwm+bounces-8897-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLfqGvm7CGra2wMAu9opvQ
	(envelope-from <linux-pwm+bounces-8897-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 16 May 2026 20:48:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A6855D553
	for <lists+linux-pwm@lfdr.de>; Sat, 16 May 2026 20:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55C77300D6A7
	for <lists+linux-pwm@lfdr.de>; Sat, 16 May 2026 18:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292E033E347;
	Sat, 16 May 2026 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru9BPIu0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0347405C2C;
	Sat, 16 May 2026 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778957299; cv=none; b=aL3088cMxiAeW0KnvaorWd6ad+L52pdqLg5YhpYtdVkxNTm6GK+f7jTokzdAKw6sVJJ8vBqMQUM5Zb2tNEoaKoMyn6s5aoh87eo7Jzzegadc9kSKR4a07xgRLDy/Eadiq/uyTcJoByDqARSjXBopsTsuf6s0Wl3VDxySlnmNK6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778957299; c=relaxed/simple;
	bh=koZzu9qegl+yA6HJQumUETob9pvN+7fnQkECzRo0yzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQ/ZX7XI5Ha2cskLCJGViho3xSmqVc6Bhn3SzJ0ALydv1L/PMnp3erQs9rVUoo7fgtk2EiUY81NSl2Sm+Pcx7DPOdYgOiSkea1fbBjs0eZeYnaZj6AMfqSlsxjwyy74d1Ka/OsxRgTvVkjV+NhkNH9t9A4xs45JRVf6xzYzlXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ru9BPIu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE691C19425;
	Sat, 16 May 2026 18:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778957298;
	bh=koZzu9qegl+yA6HJQumUETob9pvN+7fnQkECzRo0yzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ru9BPIu0QchNJezGP19SrdGoGGZ7hn/s2L6pGkr0PD0PGdV6KOZMhDNN+fUYJ/wGW
	 egMr+fwD5FpfuDkGjU7mYV7zAyqzMHaevA6W2PkxsIbslXsqDAn7Ag0ggqrlTnAkal
	 tE4nH4bXRvbaMNc1pRZc2iEuNk77jJlZCsxhQqxT9R+FOqVCCWvKcNFEpqfKseEoRJ
	 uZF8gKkggNOTaBpUCUe9Gw1CZlcx6TKZNxPT3xS7qaNdtWTS12YU74RJ2sB+o0kNCp
	 t7m3QRgXcdHdqcMhOScHfmXWGfs5ByIM9oagx10sZ5LD2hV5McvFJA+dxRVi8nFYHM
	 V/wKTc8JY7TKw==
Date: Sat, 16 May 2026 19:48:07 +0100
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
Subject: Re: [PATCH v11 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260516194807.3048d226@jic23-huawei>
In-Reply-To: <20260515-ad4692-multichannel-sar-adc-driver-v11-3-eab27d852ac2@analog.com>
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
	<20260515-ad4692-multichannel-sar-adc-driver-v11-3-eab27d852ac2@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 26A6855D553
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8897-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 15 May 2026 16:31:32 +0300
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
See below. Sashiko noticed an issue.

Note that I think the vast majority of what it came up with for this
version is garbage. Not this one though.=20

For manual mode you still register a trigger and attach it.
That trigger never fires...

I suspect it appears to all work because you just set the trigger
for manual mode before enabling it. However makes more sense to not
register the pointless trigger.  Just a bit of code reorg probably
to fix this.

One other thing inline from the other other sashiko bit that was 'nearly'
right.


>=20
> Both modes share the same trigger handler and push a complete scan =E2=80=
=94
> one big-endian 16-bit (__be16) slot per active channel, densely packed
> in scan_index order, followed by a timestamp.
>=20
> The CNV Burst Mode sampling frequency (PWM period) is exposed as a
> buffer-level attribute via IIO_DEVICE_ATTR.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

> =20
> +static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
> +					 struct ad4691_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	struct iio_trigger *trig;
> +	unsigned int i;
> +	int irq, ret;
> +
> +	indio_dev->channels =3D st->info->sw_info->channels;
> +	indio_dev->num_channels =3D st->info->sw_info->num_channels;
> +	indio_dev->info =3D st->manual_mode ? &ad4691_manual_info : &ad4691_cnv=
_burst_info;
> +
> +	trig =3D devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> +				      iio_device_id(indio_dev));
> +	if (!trig)
> +		return -ENOMEM;
> +
> +	trig->ops =3D &ad4691_trigger_ops;
> +	iio_trigger_set_drvdata(trig, st);
> +
> +	ret =3D devm_iio_trigger_register(dev, trig);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "IIO trigger register failed\n");
> +
> +	indio_dev->trig =3D iio_trigger_get(trig);

One place here where I think sashiko may have a point... You register a tri=
gger
for manual mode.  What actually makes it fire as the only code that calls
iio_trigger_poll() is in the irq that isn't registered in this path.



> +
> +	if (st->manual_mode)
> +		return devm_iio_triggered_buffer_setup(dev, indio_dev,
> +						       &iio_pollfunc_store_time,
> +						       &ad4691_trigger_handler,
> +						       &ad4691_manual_buffer_setup_ops);
> +
> +	/*
> +	 * The GP pin named in interrupt-names asserts at end-of-conversion.
> +	 * The IRQ handler stops conversions and fires the IIO trigger so
> +	 * the trigger handler can read and push the sample to the buffer.
> +	 * The IRQ is kept disabled until the buffer is enabled.
> +	 */
> +	irq =3D -ENXIO;
> +	for (i =3D 0; i < ARRAY_SIZE(ad4691_gp_names); i++) {
> +		irq =3D fwnode_irq_get_byname(dev_fwnode(dev),
> +					    ad4691_gp_names[i]);
> +		if (irq > 0 || irq =3D=3D -EPROBE_DEFER)
> +			break;
> +	}
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "failed to get GP interrupt\n");
> +
> +	st->irq =3D irq;
> +
> +	ret =3D ad4691_gpio_setup(st, i);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * IRQ is kept disabled until the buffer is enabled to prevent
> +	 * spurious DATA_READY events before the SPI message is set up.
> +	 */
> +	ret =3D devm_request_threaded_irq(dev, irq, NULL,
> +					&ad4691_irq,
> +					IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					indio_dev->name, indio_dev);

Sashiko was moaning about something different but it made me look at this.
The irq handler her calls iio_trigger_poll but in a thread.
Either that should be a top half (so dev_request_irq() with flag to force
no threading) or should be iio_trigger_poll_nested()

I'm not sure why you weren't seeing a warning on this.

> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
> +						   &iio_pollfunc_store_time,
> +						   &ad4691_trigger_handler,
> +						   IIO_BUFFER_DIRECTION_IN,
> +						   &ad4691_cnv_burst_buffer_setup_ops,
> +						   ad4691_buffer_attrs);
> +}


