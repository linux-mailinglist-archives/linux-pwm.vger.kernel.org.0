Return-Path: <linux-pwm+bounces-9215-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id URhfAvD+G2o3IQkAu9opvQ
	(envelope-from <linux-pwm+bounces-9215-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 31 May 2026 11:27:12 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EED4615575
	for <lists+linux-pwm@lfdr.de>; Sun, 31 May 2026 11:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A3B6300827D
	for <lists+linux-pwm@lfdr.de>; Sun, 31 May 2026 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E5B3438BD;
	Sun, 31 May 2026 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUIUlwrA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3D82E7382;
	Sun, 31 May 2026 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780219626; cv=none; b=YhJEzGUjfJNcLYVjuJA4a+3Za1CUuP3j0gQxXYbdJUm463asUkzBP/qiI842DNKnHT/bKlFekoKdyZvOpKG3E1HXFB9dPz2NgTccimvSXaScSurgMCr7HbkJ4QuRVo066ZWA5KZ9brHvJ5HzuAy05aR7Sx9oXwKDdFiUz9r5GNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780219626; c=relaxed/simple;
	bh=dc/ghPput8EC+0X0c+8RPBKVkCPeRlzr10Q810JNLcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJguHkvxuw13gZ9F9+ePQkhKBTYxmPgJyzuF0LFgIZ+4S2IOfrYKAq8HXcLFgHrf2Hkmx67ce6kwM1q3Z5YcxSEtX/tKXAIAvdKkRMiUEEp0F71yGJDtd2pncbf7ENeu53esQLB845+SFmOehpwSmON0TOXyOLDFQTpvuo4lQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUIUlwrA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331BB1F00893;
	Sun, 31 May 2026 09:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780219624;
	bh=YPHbgHOUSUN1JgEk2qqJaetEPOHqrgeTXqGrBDEkJ70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bUIUlwrAo3vBQw7n5Ik92KeGXNhvh1AcCA4iyDEog4sUpSsZh7EzZrChYVsEqdtaj
	 6k/uc94nXKA0qwJlUrlgli6FC7tvmUzrcHSTzEpCBVWczOBZ5ip72t73CuErjzLl47
	 hIfBFpT+SUynRoBLAFns3W4qsa0aILTFT2R/PRVL0tgr4dJjXI/CB+fMUltKq2fuYj
	 ue1JG4XP2pch+aEYyGpyThFHuiv6VeS1mLexoiSMkF5DJR5xuMgk24PX0yDNB2o4IQ
	 5+ZoiiX+KZ0LZksh40NGSDFext4roA0+du6HoGGaJMFFc1U91gO/orrG3Oz/NFmc9T
	 DPVmdYRDQuvLw==
Date: Sun, 31 May 2026 10:26:51 +0100
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
Subject: Re: [PATCH v14 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260531102651.1647e8e1@jic23-huawei>
In-Reply-To: <20260529-ad4692-multichannel-sar-adc-driver-v14-3-e93c2747dc1f@analog.com>
References: <20260529-ad4692-multichannel-sar-adc-driver-v14-0-e93c2747dc1f@analog.com>
	<20260529-ad4692-multichannel-sar-adc-driver-v14-3-e93c2747dc1f@analog.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9215-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,analog.com:email]
X-Rspamd-Queue-Id: 8EED4615575
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 13:15:02 +0300
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

Hi,

> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> index e1febf80f21d..175c80129786 100644
> --- a/drivers/iio/adc/ad4691.c
> +++ b/drivers/iio/adc/ad4691.c
> @@ -11,19 +11,29 @@

> +static int ad4691_transfer(struct ad4691_state *st, u16 cmd)
> +{
> +	u8 buf[2];
> +
> +	put_unaligned_be16(cmd, buf);
> +
> +	return spi_write(st->spi, buf, sizeof(buf));

Sashiko correctly identified this isn't using a DMA safe buffer.
If you want to keep this simple and use a local bugger use something like
	return spi_write_then_read(st->spi, buf, sizeof(buf), NULL, 0);
as that already bounce buffers.

The rest of sashiko's comments look incorrect other than the range clamping
one that I think is intentional, if a little restrictive!)

If nothing else comes up in a final review from me that I'll do shortly
then I'll tweak this whilst applying.



> +}

