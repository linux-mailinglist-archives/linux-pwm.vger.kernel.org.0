Return-Path: <linux-pwm+bounces-8781-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I0/IPf4+WmNFgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8781-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 16:04:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 832A54CF048
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 16:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F1563006024
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 14:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995747887A;
	Tue,  5 May 2026 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBoi3Cmj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C835F189;
	Tue,  5 May 2026 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989854; cv=none; b=n+VQTEUNmt5jcZD7mzdKja19UW8y8UpG+vkACgUDnKZarAUUN/bjeepWJHI/6mBBR/PH1K9gcZFa9+jihOZpolS8euFEr3GVzs9Fg6/ZKDoCadZUeA1y4lQmQtXj2Bmv4jAz+YI/crFG7xHAUhrbXKtsKo3qSSyUbaKLJV0B4sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989854; c=relaxed/simple;
	bh=Ux3dNW05X+8WWEHwiwqSOeOpXAo3OQsJiO2o1/H20jg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0e6QgVIhGgeFC5s/I1ZzMercyc/2RnE1v6UY230LFzW9D8fbaXahHoQAW+hNX1WDkWIe3BQS++34w53XGgNHQNPC9JwHoVLizvP0p/ED6soawamtlEIykLmptOJ2lRBNALz6L6uHVYe2m6hrM8IhnF6K+i6Z+YaCKI6JxidU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBoi3Cmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48269C2BCB4;
	Tue,  5 May 2026 14:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777989853;
	bh=Ux3dNW05X+8WWEHwiwqSOeOpXAo3OQsJiO2o1/H20jg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LBoi3CmjpdEPfhcnaxBDANrmzPX3Zhl92s+kYLCpISfdI4iDF0MR7jpB4p+KbIBCZ
	 5GRhokW7f0cxRmdXab6uYxlAvvnP1P4GMaEBU9/vIHc0OnVua6eQYjV/en6ax2C/XF
	 sel2VvwXLO8WyR5JqoiG1t3s9m71FBssTRXOuYaFEhA5A8uJNexk1KL9rbkJlvwwYJ
	 NwODokMZwRer8Y2nD4YF3V6P+42LJauPHCYwrBJ4d/+XvdR2Yc71Z401lQcA2XeGr3
	 L702rFlNNcOer74qeC+9TyTrUg0RbTWzzoYjwM4GNFwmTCx+1zhKXx4tzJqhs85ZBd
	 2+bL1KcGtOMKw==
Date: Tue, 5 May 2026 15:04:00 +0100
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
Subject: Re: [PATCH v9 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260505150400.59e18fad@jic23-huawei>
In-Reply-To: <20260430-ad4692-multichannel-sar-adc-driver-v9-3-33e439e4fb87@analog.com>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
	<20260430-ad4692-multichannel-sar-adc-driver-v9-3-33e439e4fb87@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 832A54CF048
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8781-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]

On Thu, 30 Apr 2026 13:16:45 +0300
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
Hi Radu

I haven't chased it through but Sashiko is raising concerns around the
irq enabling / disable tricks this pulling and they may well be correct.
Please take a close look at what happens in the remove path. We may
need some local driver logic to avoid a double disable.

https://sashiko.dev/#/patchset/20260430-ad4692-multichannel-sar-adc-driver-=
v9-0-33e439e4fb87%40analog.com

> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> index 05826b762c7f..c1e3406fef18 100644
> --- a/drivers/iio/adc/ad4691.c
> +++ b/drivers/iio/adc/ad4691.c


> +
> +static irqreturn_t ad4691_irq(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev =3D private;
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +
> +	iio_trigger_poll(indio_dev->trig);
> +	/*
> +	 * Keep the DATA_READY IRQ disabled until the trigger handler has
> +	 * finished reading the scan, to prevent a new assertion mid-transfer.
> +	 * The PWM continues running uninterrupted; the IRQ is re-enabled in
> +	 * ad4691_trigger_handler once spi_sync completes.
> +	 *
> +	 * IRQF_ONESHOT already masks the hardware line during this threaded
> +	 * handler, so disable_irq_nosync here ensures the IRQ stays disabled
> +	 * even after IRQF_ONESHOT unmasks on return.
> +	 */
> +	disable_irq_nosync(st->irq);
> +
> +	return IRQ_HANDLED;
> +}

> +
> +static irqreturn_t ad4691_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +
> +	ad4691_read_scan(indio_dev, pf->timestamp);
> +	if (!st->manual_mode)
> +		enable_irq(st->irq);

I think this should be in the reenable_trigger callback rather than here.
That's ultimately fired by iio_trigger_notify_done.

Sashiko had quite a bit to say about the problem paths around the buffer
being disabled between the interrupt and the trigger handler. I don't think
using the reenable trigger solves that though :(  We might be able
to fix that centrally by always reenabling the trigger before
disconnecting it but that's rather ugly. There is a note for the async
trigger reenabling about a driver possibly needing to be careful
to not reenable if the whole trigger was disabled in the meantime but
this particular race isn't covered.


Terrible though it is we may need to have some extra infrastructure
to avoid the double disable (assuming it is real).


> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}



