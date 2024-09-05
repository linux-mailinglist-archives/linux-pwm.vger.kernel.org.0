Return-Path: <linux-pwm+bounces-3095-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E993C96D355
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 11:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A84F1C25A33
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 09:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95D1199FD0;
	Thu,  5 Sep 2024 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tptvwIFk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0EB198A3B
	for <linux-pwm@vger.kernel.org>; Thu,  5 Sep 2024 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528646; cv=none; b=k993oxF88nJBHPy0CU8xxDdrb5rvyXXZcd5CKY7K17ym5P/Gn8CDU9u5g868SFXkacWd7cL+Tf4g4a3uIHCQcq4hr7BT6UfcMFu/pGYU27/1jSUeMidxiLElW6jcVhjewZT2uhF7TIRJjM70naFDIsfPYG/nMCFRqJd/vKKMMj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528646; c=relaxed/simple;
	bh=J0LZIWMwMt/MZZVW3nq6qgr2WJNe1KV87wCkyEmdGBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvRzG+rd8btCp5vh1oyMTYwpVM8oKE6LADXsVKaBdZwhP+vP1pQ5XaHhJS+NJhctn06MLiLsebucLFaG/u0FN9XHT1OVrwAN9uqha2z1Fb3c/DlMTC+u1kp7tpXtTdrkUp7sB1hZIJZSpr4lzvqJIJhyZVm9LIJoIbtSoh4hyIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tptvwIFk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso904763e87.0
        for <linux-pwm@vger.kernel.org>; Thu, 05 Sep 2024 02:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725528642; x=1726133442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OukU97CSMGxT3uwDMoEVzMhIgXm52avuG4qSgwd2MBc=;
        b=tptvwIFkXUerYt3vwXSSq0bNEpX20nC2yoDmBjVOSq7tY0U2G0ppzidnf4MrcsPkCj
         2dv+Bsfqa43hPSA7dMA6M5c0M2MQ8pnXHBPGtRhAZ8t+IIWdpqkxiyH8p+lbac639WRE
         OKGaqKbxFBws4y+NmwbNd7rgt9U9c/MqqlX+PY3K1GF5Ppk4FZjVAlgJbveT1uUROi76
         zQQ2Lh7/7BZqw4v+dq+ak/uCrBWQMaWSzyk5KBZeI6pq8NwIVJOg5qGjih0tBu7WSWV6
         SBYFCqqo7N9Ae4ORQN2pefCuAeDfN0nBhUdhpMe4nvbnzOvAgek7NdW8QVro7gntI2q/
         xI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725528642; x=1726133442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OukU97CSMGxT3uwDMoEVzMhIgXm52avuG4qSgwd2MBc=;
        b=w18XO1m38FEjjoaRAXMJOtg4KkFLdp1bcibksqwDMfa4onF7aQgbTdxDVU+0SsuRft
         nAVdknFJEDusBj83dIxieebAKTLAV2cW1txDYRxvuAla1tqAZ1ujNbmMmRHDETQqXWxg
         JRX/D7CU/KSk2XNLdySNV2zvbWpA8SOhT0sQbMfMeOgPqJMrgtC5gnh1GHQV1ZemFEwc
         qbr/e/HVD8qy2HckdMixuqU0fXTC+1JnvfCN94Iorc7GxlsU5zck50lC3vn0SDHQtBXX
         jBQ6pGoKy3cntx2fvfz/RXdCOLGPDUA7hIXkMUGlLrc4oQ+RfhbSdXmIrbT5yoBZGlEp
         0C3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXh+1uPcDSk+efS+M4/i2nkY1vtPc85jeVqiBu0DhoUsqNh2rU6B8xy5I+UJhW5uYRG2eNE24amWBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBrKtB3SqEl7wlVYOd5yshjIrLKU7pSIiyTWcxJZQYyRG2ghXe
	s5nqQA9wlgALAq+xSUbCmNd1wBMvFZkJJA2ebvcRMrkAVdcM8nnIN1i4SlowqeM=
X-Google-Smtp-Source: AGHT+IGl97KqbLMslldgmJDsArJp07y5GgcTUh6K+r7VA0eX5LCA05Il4GJUPsiAHiDhjNduobGdJg==
X-Received: by 2002:a05:6512:2523:b0:536:548a:ff89 with SMTP id 2adb3069b0e04-536548b0048mr444189e87.39.1725528642343;
        Thu, 05 Sep 2024 02:30:42 -0700 (PDT)
Received: from localhost (p5dc68f76.dip0.t-ipconnect.de. [93.198.143.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a9234sm109248866b.156.2024.09.05.02.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 02:30:41 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:30:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	upstream@airoha.com, ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 5/5] pwm: airoha: Add support for EN7581 SoC
Message-ID: <xmlta4za6malgthd6cmt5fcipxgyzwmqwxqdg5e4qahcuqzcrt@eidsf6mexrkz>
References: <20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org>
 <20240831-en7581-pinctrl-v3-5-98eebfb4da66@kernel.org>
 <yfqmlca6cnhrghpo5s6tml36tngmekcfbyjakxs7or7wtap3ka@7qlrxjowo4ou>
 <d9298199-fe10-4b28-8e28-dc252bd6832c@genexis.eu>
 <t2f5kockuvfi66qqumda6jxf5a4c4zf35ld5ainsnksavkchyj@kdueaqlhjoar>
 <b7e44fb2-6cf6-4530-a271-9e1730d4f431@genexis.eu>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="43j4qp3ucvr7fjgi"
Content-Disposition: inline
In-Reply-To: <b7e44fb2-6cf6-4530-a271-9e1730d4f431@genexis.eu>


--43j4qp3ucvr7fjgi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Sep 05, 2024 at 01:09:48AM +0200, Benjamin Larsson wrote:
> On 03/09/2024 17:47, Uwe Kleine-K=F6nig wrote:
> > Hello Benjamin,
> >=20
> > On Tue, Sep 03, 2024 at 01:58:30PM +0200, Benjamin Larsson wrote:
> > > On 2024-09-03 12:46, Uwe Kleine-K=F6nig wrote:
> > > > Would you please add a "Limitations" paragraph here covering the
> > > > following questions:
> > > >=20
> > > >    - How does the hardware behave on changes of configuration (does=
 it
> > > >      complete the currently running period? Are there any glitches?)
> > > >    - How does the hardware behave on disabling?
> > > >=20
> > > > Please stick to the format used in several other drivers such that
> > > >=20
> > > > 	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/*.c
> > > >=20
> > > > emits the informations.
> > > The answer to your questions are currently unknown. Is this informati=
on
> > > needed for a merge of the driver ?
> > It would be very welcome and typically isn't that hard to work out if
> > you have an LED connected to the output or a similar means to observe
> > the output. An oscilloscope makes it still easier.
> >=20
> > For example to check if the current period is completed configure the
> > PWM with period =3D 1s and duty_cycle =3D 0 disabling the LED. (I leave=
 it
> > as an exercise for the reader what to do if duty_cycle =3D 0 enables the
> > LED :-) Then do:
> >=20
> > 	pwm_apply_might_sleep(mypwm, &(struct pwm_state){
> > 		.period =3D NSEC_PER_SEC,
> > 		.duty_cycle =3D NSEC_PER_SEC,
> > 		.enabled =3D true,
> > 	});
> > 	pwm_apply_might_sleep(mypwm, &(struct pwm_state){
> > 		.period =3D NSEC_PER_SEC,
> > 		.duty_cycle =3D 0,
> > 		.enabled =3D true,
> > 	});
> >=20
> > Iff that enables the LED for a second, the period is completed. The
> > question about glitches is a bit harder to answer, but with a tool like
> > memtool should be possible to answer. Alternatively add delays and
> > printk output to .apply() in the critical places.
> >=20
> >=20
>=20
> I connected a logic analyzer to a pin and configured the pwm for it.
>=20
> I then configured the pwm with these parameters (setup for 2Hz).
>=20
> echo 1000000000 > /sys/class/pwm/pwmchip0/pwm12/period
> echo 0 > /sys/class/pwm/pwmchip0/pwm12/duty_cycle
>=20
> If I then ran the following (in a script) no pulse was detected:
>=20
> echo 500000000 > /sys/class/pwm/pwmchip0/pwm12/duty_cycle
> echo 0 > /sys/class/pwm/pwmchip0/pwm12/duty_cycle
>=20
> If I added a sleep 1 in between I always got 1 500ms pulse.
>=20
> I then did the same but with direct register access with the same result.
> Setting the duty cycle to 0 disables the pwm function on the pin, it seems
> to take a while before it properly activates but before it disables it the
> cycle completes.
>=20
>=20
> I also tested with enabling the pwn signal and then setting a 0 duty cycl=
e.
> The last observed pulse was always 500ms long.
>=20
>=20
> I am not sure what of your questions this answers and is there some other
> tests I should perform ?

IIUC that means to add:

	On configuration the currently running period is completed.

to the Limitations paragraph.

> For the record while toggling the registers I noticed that it was actually
> possible to generate 1 second long pulses. The documentation is not clear=
 on
> this part.

1 second long pulses with a period size of 1 second, so a constant high
signal?

Another thing that would be interesting is, if it can happen that you
get a mixed signal. That is, if you update from=20

	.period =3D A
	.duty_cycle =3D B

to

	.period =3D C
	.duty_cycle =3D D

that you get one period with length C and duty_cycle B when the period
completes after configuring period but before duty_cycle.

Best regards
UWe

--43j4qp3ucvr7fjgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbZej4ACgkQj4D7WH0S
/k5xhAf9EPcXdp1Pl5jZjnIObpW0/xdCiScDgmou0lMZIm+blc6lkmB/qhCGIQ9k
BKqpP3E9L9wtcT+9VOg6PRd8cvri2K5d0t70K79H4y9hYDqdsvkJWhS2bXuE0cQ3
KmlqPMMRv89xQgBGJcZeDzVzrGZxNzBeuTpUoS3ij3+tfEcliluQKLWyn9kEfq1O
RzSnevhSNZn76LIkK0jX6bzcwY1a3H9xySGnYf8xmKdFRBNPYZa/ToAfAJA0IdSG
yGo7dr2tidwmdeKyz3c2ZuswaYKhGhgu7j3uukcq9unxhmkzyqiaK2zz0ktiyXa7
huaBYupjFR6t/UhFEv6yRv8hjQwZ2A==
=iEnI
-----END PGP SIGNATURE-----

--43j4qp3ucvr7fjgi--

