Return-Path: <linux-pwm+bounces-8931-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JiNBsqzCWqulwQAu9opvQ
	(envelope-from <linux-pwm+bounces-8931-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 14:25:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9F1560F21
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 14:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47E393007AFE
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 12:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977E3364941;
	Sun, 17 May 2026 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZAIcCP7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A08364935;
	Sun, 17 May 2026 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779020739; cv=none; b=GTjSd9mSQPyACqp4nTuoRi6m1MwZIM3S2rIG8KUeUgzf5JZabpReu7l2LE8f2HzkgBc1V14lMHh/RafgmiMbt9BpinjkspBKqoZH4XYm+U4D1Ropco7mrNK6j1XXg9qfq8OzGVKK0uurFoToqkx8oQeqZ5Dh//4va2b8kIeL2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779020739; c=relaxed/simple;
	bh=XSkWEDKw02puX5qq9iVXr5jO9QBcF6MO0A6mYsf1hdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnghgpROWLC4u3g+M3TuxyfH9YwCum+0qrJvoxCzmbvhTZT0S08f/jlr6IqNwB1cnMhF1eNn60Sv7e0ud6G3/XkDFackMDbP6+lxcpl7uD3KcLGaBk6O1632Wf1bObDZWuoGCNZDtuj6m1zjgbm87LrwPtvIMHOPvIQdEjfxtFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZAIcCP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D06C2BCB0;
	Sun, 17 May 2026 12:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779020738;
	bh=XSkWEDKw02puX5qq9iVXr5jO9QBcF6MO0A6mYsf1hdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EZAIcCP7v4Ac0pHIPolzYXkoyEpgmNqJuYvvoCfXRzGhU48cxxNog+zKms+IJtyQ8
	 qiHSWt2RbE+p7qFLGY0zIT9kJWZNDIf+QEyS7xStQacOhcwwLtSkktiq/yfqjHL4ic
	 vm4tu1Sdmud0fcfd4AQRs2/2oI1aFkOkDyGARhbXwEqJ2PplwVU3KKMP8RZkGWTJti
	 poTy161sTSD2Z59gKnCwwzgt/brsxmfKFga7GqkNlou83OpWHqlzvX8ed+jpKmxzSz
	 AH9xUuYP4J6X7FbRUA2JZ5xVspn2tO7VNW4HQM+YAPuFLJdXwiUX95R244DCdo+m1G
	 IveIOhBeg0iPg==
Date: Sun, 17 May 2026 13:25:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v11 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260517132526.27c71b70@jic23-huawei>
In-Reply-To: <9b7986e1-6550-415d-b301-33089ba10177@baylibre.com>
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
	<20260515-ad4692-multichannel-sar-adc-driver-v11-3-eab27d852ac2@analog.com>
	<9b7986e1-6550-415d-b301-33089ba10177@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9D9F1560F21
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
	TAGGED_FROM(0.00)[bounces-8931-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Action: no action

On Sat, 16 May 2026 12:32:51 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/15/26 8:31 AM, Radu Sabau via B4 Relay wrote:
> > From: Radu Sabau <radu.sabau@analog.com>
> >=20
> > Add buffered capture support using the IIO triggered buffer framework.
> >=20
> > CNV Burst Mode: the GP pin identified by interrupt-names in the device
> > tree is configured as DATA_READY output. The IRQ handler stops
> > conversions and fires the IIO trigger; the trigger handler executes a
> > pre-built SPI message that reads all active channels from the AVG_IN
> > accumulator registers and then resets accumulator state and restarts
> > conversions for the next cycle.
> >=20
> > Manual Mode: CNV is tied to SPI CS so each transfer simultaneously
> > reads the previous result and starts the next conversion (pipelined
> > N+1 scheme). At preenable time a pre-built, optimised SPI message of
> > N+1 transfers is constructed (N channel reads plus one NOOP to drain
> > the pipeline). The trigger handler executes the message in a single
> > spi_sync() call and collects the results. An external trigger (e.g.
> > iio-trig-hrtimer) is required to drive the trigger at the desired
> > sample rate.
> >=20
> > Both modes share the same trigger handler and push a complete scan =E2=
=80=94
> > one big-endian 16-bit (__be16) slot per active channel, densely packed
> > in scan_index order, followed by a timestamp.
> >=20
> > The CNV Burst Mode sampling frequency (PWM period) is exposed as a
> > buffer-level attribute via IIO_DEVICE_ATTR.
> >=20
> > Signed-off-by: Radu Sabau <radu.sabau@analog.com>

> > +
> > +static int ad4691_manual_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +	struct ad4691_state *st =3D iio_priv(indio_dev);
> > +	unsigned int k, i;
> > +	int ret;
> > +
> > +	memset(st->scan_xfers, 0, sizeof(st->scan_xfers));
> > +	memset(st->scan_tx, 0, sizeof(st->scan_tx));
> > +
> > +	spi_message_init(&st->scan_msg);
> > +
> > +	k =3D 0;
> > +	iio_for_each_active_channel(indio_dev, i) {
> > +		if (i >=3D indio_dev->num_channels - 1)
> > +			break; /* skip soft timestamp */ =20
>=20
> I don't think timestamp gets set in the scan mask. It is handled separate=
ly.

FWIW that is a sashiko false postive (I believe anyway!)
If we do hit this please shout as we have a core bug.

If anyone has time to look at how hard it would be to tweak
iio_for_each_active_channel to skip a last element timestamp that
would be great.

I think that iterates one too far which is what sashiko is tripping over.

I'm only keen to fix that if we can make it low cost and hid it entirely
from drivers.

Jonathan

>=20
> > +		/*
> > +		 * Channel-select command occupies the first (high) byte of the
> > +		 * 16-bit DIN frame; the second byte is a don't-care zero pad.
> > +		 * put_unaligned_be16() writes [cmd, 0x00] in memory so the
> > +		 * SPI controller sends the command byte first on the wire.
> > +		 */
> > +		put_unaligned_be16((u16)(AD4691_ADC_CHAN(i) << 8), &st->scan_tx[k]);
> > +		st->scan_xfers[k].tx_buf =3D &st->scan_tx[k];
> > +		/*
> > +		 * The pipeline means xfer[0] receives the residual from the
> > +		 * previous sequence, not a valid sample. Discard it (rx_buf=3DNULL)
> > +		 * to avoid aliasing vals[0] across two concurrent DMA mappings.
> > +		 * xfer[1] (or the NOOP when only one channel is active) writes
> > +		 * the real ch[0] result to vals[0]. Subsequent transfers write
> > +		 * into vals[k-1] so each result lands at the next dense slot.
> > +		 */
> > +		st->scan_xfers[k].rx_buf =3D (k =3D=3D 0) ? NULL : &st->vals[k - 1];
> > +		st->scan_xfers[k].len =3D sizeof(st->scan_tx[k]);
> > +		st->scan_xfers[k].cs_change =3D 1;
> > +		st->scan_xfers[k].cs_change_delay.value =3D AD4691_CNV_HIGH_TIME_NS;
> > +		st->scan_xfers[k].cs_change_delay.unit =3D SPI_DELAY_UNIT_NSECS;
> > +		spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
> > +		k++;
> > +	}
> > +
> > +	/* Final NOOP transfer retrieves the last channel's result. */
> > +	st->scan_xfers[k].tx_buf =3D &st->scan_tx[k]; /* scan_tx[k] =3D=3D 0 =
=3D=3D NOOP */
> > +	st->scan_xfers[k].rx_buf =3D &st->vals[k - 1];
> > +	st->scan_xfers[k].len =3D sizeof(st->scan_tx[k]);
> > +	spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
> > +
> > +	ret =3D spi_optimize_message(st->spi, &st->scan_msg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ad4691_enter_conversion_mode(st);
> > +	if (ret) {
> > +		spi_unoptimize_message(&st->scan_msg);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}

