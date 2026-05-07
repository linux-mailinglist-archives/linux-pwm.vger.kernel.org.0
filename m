Return-Path: <linux-pwm+bounces-8842-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8H7ENbaw/GnlSgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8842-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 17:33:10 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 057FE4EB1D8
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 17:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4C1B3047EB8
	for <lists+linux-pwm@lfdr.de>; Thu,  7 May 2026 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9542C449EB0;
	Thu,  7 May 2026 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXRwrAcC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700F8307494;
	Thu,  7 May 2026 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167625; cv=none; b=EuwNpdknnYa3SYbdXoMiYaq2RNWuzHqLWEDMhYDQiF+/lX/UxRhtLeBwm8Q4RdDSvFJtYmoMe1GZpi+DL5mKK/x2h5yXdGYH40NHoZ8YLqLYjHeWpQV7sUj1YU+fIY0HyD20yUxEiqnC691FTHs2BawK+nkkW3OU1O+BFEGE6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167625; c=relaxed/simple;
	bh=Gy7En/vU2sMCKfgUrfCdWLhMOj6oSO3eGcp/sS8Bwuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaX/HnDMGP2X4+ogAQBVDB5Jbj+lQl9C2BghFPDjiZuRxQ7vnNQL0CXCXIeHlKg/L5kj7hTKHS9tmggR1IOZOrtrWMx2BaGgN1CtugRgYoV6p+W36Fe6XzUskXgcy/IDN0WQwW4/Ooi2BCQJnMMxhjpRXSMSWN3rbhawxpyP6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXRwrAcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E547BC2BCB2;
	Thu,  7 May 2026 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778167625;
	bh=Gy7En/vU2sMCKfgUrfCdWLhMOj6oSO3eGcp/sS8Bwuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qXRwrAcCOh7Tz+VALQS7OpEUePKkjR0GqUxrclVyte7JwXDPKh/aIqqwGp8rL8hel
	 j85NmBB1mYSuv1OwXyY4md4nFmUnFdFQBG2LoKtf6xakWYdPF8cmuyxBqnHNC/uwW9
	 YEiLpRhlchpzp73zTTsjfc8D3yvBbhdzQe3l6wplo2sbcnfXj3xr/vmEmLDoHjrZlE
	 My74kOklbf8x6ekiR++IhnmssTe6q77j2+83Tf0xMENZD9JmQfLIrMvDLAZlmo6rY+
	 /vDQGLN2RUXaPmgxrktY8Z0EfI8wOjrF1vlcN//U2AlsPX0KUDjtrGSlTjU5FcBLvF
	 OUqwk6o780DOg==
Date: Thu, 7 May 2026 16:26:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v9 5/6] iio: adc: ad4691: add oversampling support
Message-ID: <20260507162652.18898e28@jic23-huawei>
In-Reply-To: <LV9PR03MB8414B9A4A4D48BDF8E60398FF73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
	<20260430-ad4692-multichannel-sar-adc-driver-v9-5-33e439e4fb87@analog.com>
	<LV9PR03MB8414B9A4A4D48BDF8E60398FF73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 057FE4EB1D8
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8842-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,bootlin.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 7 May 2026 11:56:53 +0000
"Sabau, Radu bogdan" <Radu.Sabau@analog.com> wrote:

> Addressing Sashiko's review for the oversampling support patch.
>=20
One thing inline. I think Sashiko got it wrong..

> > @@ -691,6 +857,10 @@ static int ad4691_enter_conversion_mode(struct
> > ad4691_state *st)
> >  		return regmap_update_bits(st->regmap,
> > AD4691_DEVICE_SETUP,
> >  					  AD4691_MANUAL_MODE,
> > AD4691_MANUAL_MODE);
> >=20
> > +	ret =3D ad4691_write_osc_freq(st);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret =3D regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
> >  				 AD4691_ADC_MODE_MASK,
> > AD4691_CNV_BURST_MODE);
> >  	if (ret)
> > @@ -844,6 +1014,12 @@ static int
> > ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
> >  	if (ret)
> >  		goto err_unoptimize;
> >=20
> > +	iio_for_each_active_channel(indio_dev, i) {
> > +		ret =3D regmap_write(st->regmap, AD4691_ACC_DEPTH_IN(i),
> > st->osr[i]);
> > +		if (ret)
> > +			goto err_unoptimize;
> > +	}
> > + =20
>=20
> "If the IIO soft timestamp channel is enabled, its scan_index is 16.
> iio_for_each_active_channel() iterates over all active channels including
> the timestamp channel.

I saw this one and think it's wrong.

It is sort of true and sort of not.  active_scan_mask never has the timesta=
mp
channel set.  There is special handling for that channel.

https://elixir.bootlin.com/linux/v7.0.1/source/drivers/iio/industrialio-buf=
fer.c#L613

IIRC the bitmap is technically one bit too large given that quirk
(I've not checked that today so I'm relying on memory of when this last cam=
e up).

Jonathan



> Will this loop process i =3D 16 and access st->osr[16] out of bounds, sin=
ce
> st->osr is an array of size 16?
> Additionally, since AD4691_ACC_DEPTH_IN(16) resolves to 0x196
> (AD4691_GPIO_MODE1_REG), will this silently corrupt the GPIO configuration
> and potentially break the DATA_READY interrupt?
> Furthermore, does the presence of the timestamp channel cause the loop
> iteration to advance k to 17, making the state-reset SPI transfers append=
ed
> after the loop write to st->scan_xfers[34] and [35]? This would overflow
> the scan_xfers array which is sized 34 and could corrupt the surrounding
> struct ad4691_state."
>=20
> Valid for the osr[] out-of-bounds and GPIO corruption concerns. With
> the soft timestamp enabled (scan_index =3D 16), the loop would access
> st->osr[16] out-of-bounds and write to AD4691_ACC_DEPTH_IN(16) =3D 0x196,
> which is AD4691_GPIO_MODE1_REG, silently corrupting the GPIO configuration
> and potentially breaking the DATA_READY interrupt.
>=20
> Added the same guard used by the scan_xfers loops in the triggered-buffer
> commit: if (i >=3D indio_dev->num_channels - 1) break.
>=20
> The scan_xfers k-overflow concern is already handled by that existing gua=
rd
> in a separate loop =E2=80=94 it is not affected by the ACC_DEPTH_IN loop =
added
> here.
>=20


