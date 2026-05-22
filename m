Return-Path: <linux-pwm+bounces-9082-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Io+ASNCEGrzVAYAu9opvQ
	(envelope-from <linux-pwm+bounces-9082-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 13:46:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B37C5B3359
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 13:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 654B330074A9
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 11:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BE33EB819;
	Fri, 22 May 2026 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NG9+ntPn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14A265CD9;
	Fri, 22 May 2026 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450398; cv=none; b=PxfmTmp7QZ0fN2JxcbcXq8opEvLjt4EM1B7GUThqnEGbZZAglA9NJgebV5udeAKYzwVV70kCduaSz0d02Kw+JZLcBppqjgTf24a/Of3RPygS7WUNbgPvPjIsKfjX12EzQLSxBbwS5jspxZmK4SG2HOH7L+xeCwxj9RyaHC37BpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450398; c=relaxed/simple;
	bh=g6vD/koq/YQFvJ1hHOoVO2KTYjPZ3MlR5w8GxczYSGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNLAOTxU9Rfw1zVfBVnlIQogHP6paJFLQ390s4FbGEx0QIxUICbmPlCC4IK2NjM2bABAbUZ6UeCODx7Ne0EVCZNhWhK13L6a0AKF6FB9+s+o2p0c8o6OJG5lLXcLv1D4q1ovdIZbuXqxDNlB/jZxwKluIhQUX1AzWImRDJQftu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NG9+ntPn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CAE1F000E9;
	Fri, 22 May 2026 11:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779450393;
	bh=SRSNrMsPebt6Vg+4fLWYKnEZZvhbUhBLws7+1vBhpKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NG9+ntPn5mUtEzY2YjQtDl4PqoXUyUc0Gf32aEgat1UwjtU0bEOUCItf09wZXKgv6
	 yTagpqs7DFwZqUj1UCeqSM8FDcdkP66jubFjKfIlqKP5D4dTL3LyyFguU6oU++9QYA
	 IZfV7iugGDjN+dGN5EL11yvONhyy2HSb2bUs2fZcg7vO8siGs7qvYG+0/iTiEk0+fm
	 uZca7hCIVHPlqPcYqvrRkx4IOpT5X97HHmLcoNOEG0MLwo6F4aa9xUuTbew9zs2mub
	 hHL+Zh+v+57gCHtII0hawlFahVq4GNlNsyHtVvAHZCKlXmnuCIjy4imVLgQpX3W5iX
	 5suOGNIRxoIsQ==
Date: Fri, 22 May 2026 12:46:20 +0100
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
Subject: Re: [PATCH v12 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260522124620.35b03d73@jic23-huawei>
In-Reply-To: <20260519-ad4692-multichannel-sar-adc-driver-v12-3-5b335162aa51@analog.com>
References: <20260519-ad4692-multichannel-sar-adc-driver-v12-0-5b335162aa51@analog.com>
	<20260519-ad4692-multichannel-sar-adc-driver-v12-3-5b335162aa51@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9082-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9B37C5B3359
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 15:20:24 +0300
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
> one big-endian 16-bit (__be16) slot per active channel, densely packed
> in scan_index order, followed by a timestamp.
>=20
> The CNV Burst Mode sampling frequency (PWM period) is exposed as a
> buffer-level attribute via IIO_DEVICE_ATTR.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
I didn't spot anything in my read through and most of what Sashiko
is commenting on is wrong or not a driver specific problem
(the trigger leak is a core problem)

One small thing Sashiko did pick up on though that I think could be a littl=
e nicer.
You may well already have this in hand as I know you are checking there
as well!

> +static void ad4691_read_scan(struct iio_dev *indio_dev, s64 ts)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +
> +	spi_sync(st->spi, &st->scan_msg);

One thing from sashiko. If this fails we shouldn't push data and we should
make it clear somewhere (rate limited print or similar).

> +
> +	/*
> +	 * rx_buf pointers in scan_xfers point directly into scan.vals, so no
> +	 * copy is needed. The scan_msg already includes a STATE_RESET at the
> +	 * end (appended in preenable), so no explicit reset is needed here.
> +	 */
> +	iio_push_to_buffers_with_ts(indio_dev, st->vals, sizeof(st->vals), ts);
> +}

