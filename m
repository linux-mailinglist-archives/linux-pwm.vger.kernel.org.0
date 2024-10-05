Return-Path: <linux-pwm+bounces-3492-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CA0991804
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 17:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60481F22EBB
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7CB153808;
	Sat,  5 Oct 2024 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lqqOdV/S"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E18155756
	for <linux-pwm@vger.kernel.org>; Sat,  5 Oct 2024 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728143846; cv=none; b=o9a5HNOJNzpQieUShllS08CIU/xjHxLmeBbcWMq+S2rAY6+23/iOD9tjPil9/x63RgASeOVyju3K4Avqk06BnGtIq1CMan9gL6pau/FFVXqBv+YxvDdxxZojLfaUm1Evamcm98R7COOET0cYjczc2AyZm5xiE/Ko2TjFfZ++NxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728143846; c=relaxed/simple;
	bh=rvOfxqkLW8T3+y8E0eE6uYFdvtJ8ggCwhrQBDymZLck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX9gkkZl5Dw1MS0epCgsYlKL+3SiFDOnTtKFIcTHVdfcwkqbEpH0CGlzq3YstI8Y/ZE0Xs8GKPLm9oiUFRPY9EiqySthYikc0VmoTPfwEO85XZIFAH3ueGvi4QhUghnE9/wSgMD1HiGKU6N8nURGyBfKfD9Zz909zB96PsvKx+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lqqOdV/S; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cca239886so1846323f8f.2
        for <linux-pwm@vger.kernel.org>; Sat, 05 Oct 2024 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728143841; x=1728748641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qXz9vBq3bu3888Z5jpvuBKQzYSQvLNzRZ8Js/IdLunM=;
        b=lqqOdV/SoS5xOHQ9AN48wb0TBffqbCyIWFPNr2LXN7YqnVYXMkp3sO/RGlO46LWUQE
         QhAc7HjX4aaW/014tX7gn3X6j1EstAQGiJbYW09tP93WktqmrlzGotfJPmjcQ+B5PlHD
         vTLDEp5SISw8PKC5NQdfJt9Ui9924o0WL+VEj872Su/4cTiiFW4Sen65CyfgPJ8v350N
         bnrwRxDfptclFi+jtckjHQXaeCu5pL48x6VJ7KI3LqZ50kdsqFObdRbu54CBDb1HMw50
         5VaQQ3Ctx6LOdqW1HTr/NJTVXCF0sWhoAUTACko5lHoZhau3//40+5oZjDhvzqLQTa+y
         tb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728143841; x=1728748641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXz9vBq3bu3888Z5jpvuBKQzYSQvLNzRZ8Js/IdLunM=;
        b=UXdP6ACgfj0Q8qJrWdE0aU25Nfju5Z2+ArsSsfsC2IKyam+/p75r8KGevAszMVWd0I
         7vyOiQLB3iaF3KFB0BW4YqRn7avGI5Daysrkw8YgCHVO9Yv+fTCPQLaVOqYWZRSRgEBK
         3BSn/npAmJIp/Zt59nqlAH1fKUzLu6qaZcsvETPE+6oQLgn5IkVkdbWcZVV1oQXzHtBo
         ZGe9I8Xthl8IcyDytwF9LTnW+P5TgU6v60rqCkEw6k9Qu3jrA8+fupkbDESOOXIwP6+l
         eR1tr/NUdqH9VgMQQlavB26RBeTMR0VsVzOh0rfqSKxf5ZBuMjWujSr+QWwAv3ihQAoa
         I/dw==
X-Forwarded-Encrypted: i=1; AJvYcCVkjMUfjvyqT6M4Jf09pm/XCPNlcy+Q+g7ctUGatqklB02iK60p7/baMO7LODyN24KU4rMNy5Kh774=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOqwWNmnKIviW7+zBnJY3Jft9b13CREaZonyWmjrbLAlHrzF79
	5L+LeSvCEBRksiil3NepKsOup9yrrVcMwIbpWvP7Kx/vPE06PQm7Lvb9tD07L9w=
X-Google-Smtp-Source: AGHT+IF43/A7zCrs3+gI5xHgV4LbW1A2YYw/wvq0IVL4OE5XX61u/Z+s9jLqofsLCP7Kzw+4y8PJaQ==
X-Received: by 2002:a5d:5108:0:b0:37c:d522:af6d with SMTP id ffacd0b85a97d-37d0eb1ae9fmr3448004f8f.58.1728143840880;
        Sat, 05 Oct 2024 08:57:20 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:69c5:ee3e:d780:d02b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695f113sm1988217f8f.80.2024.10.05.08.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 08:57:20 -0700 (PDT)
Date: Sat, 5 Oct 2024 17:57:18 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Marek Vasut <marex@denx.de>
Cc: Frank Li <Frank.Li@nxp.com>, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, festevam@gmail.com, francesco@dolcini.it, imx@lists.linux.dev, 
	jun.li@nxp.com, kernel@pengutronix.de, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	p.zabel@pengutronix.de, pratikmanvar09@gmail.com, robh@kernel.org, 
	s.hauer@pengutronix.de, shawnguo@kernel.org, xiaoning.wang@nxp.com
Subject: Re: [PATCH v7 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Message-ID: <gnlm4u7dc2aktycxzn4nqw3anzeit6tbtgcq7kv3pzbrorwg6o@h35yxit5y2a3>
References: <20241004193531.673488-1-Frank.Li@nxp.com>
 <5cvzarqkldstuziokdbxxne75i35odexkcykzikyq2gm6ytdyd@5wkm7mhotgej>
 <4166d68c-5eca-406a-936f-412dd2ae72fc@denx.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ctgpfajami44sg5x"
Content-Disposition: inline
In-Reply-To: <4166d68c-5eca-406a-936f-412dd2ae72fc@denx.de>


--ctgpfajami44sg5x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 05, 2024 at 02:41:29AM +0200, Marek Vasut wrote:
> On 10/4/24 10:58 PM, Uwe Kleine-K=F6nig wrote:
>=20
> [...]
>=20
> Why not simply duplicate the ERRATA description for iMX8M Nano MX8MN_0N14Y
> errata sheet ?
>=20
> "
> [...]
> "
>=20
> That is very clear to me.

Fine for me. Frank, do you want to try creating the right mix of the NXP
text, your and my description?

> > 	/*
> > 	 * At each clock tick the hardware compares the SAR value with
> > 	 * the current counter. If they are equal the output is changed
> > 	 * to the inactive level.
>=20
> I would skip this ^ part unless you can surely say the IP works exactly t=
hat
> way because you checked the RTL.

That it works that way is clear from the errata text IMHO.

> > As a new SAR value is applied
> > 	 * immediately to the currently running period, it can happen
> > 	 * that no falling edge happens in a period and so the output is
> > 	 * active for a whole period. Consider a change from
> >           *     ________
> > 	 *    /        \______/
> >           *    ^      *        ^
> > 	 * to
> >           *     ____
> > 	 *    /    \__________/
> >           *    ^               ^
> > 	 *
> > 	 * where SAR is written at the time marked by *. The counter
> > 	 * didn't reach the old (bigger) value because it was changed
> > 	 * before the counter reached that value and when the new value
> > 	 * becomes active it is already lower than the current counter
> > 	 * and so doesn't trigger either while the counter continues to
> > 	 * grow. So the resulting waveform looks as follows:
> > 	 *
> >           *     ________        ____________________
> > 	 *    /        \______/                    \__________/
> >           *    ^               ^      *        ^               ^
> > 	 *    |<-- old SAR -->|               |<-- new SAR -->|
> > 	 *
> > 	 * that is the output is active for a whole period.
>=20
> The ascii/infographics is nice and would be good to keep, but regarding t=
he
> description, frankly, the NXP errata description says the same thing in
> fewer words :)
>=20
> > 	 */
> >=20
> > > +	 *
> > > +	 * If the new SAR value is less than the old one, and the counter is
> > > +	 * greater than the new SAR value (see above diagram XXXX), the cur=
rent
> > > +	 * period will not flip the level. This will result in a pulse with=
 a
> > > +	 * duty cycle of 100%.
> > > +	 *
> > > +	 * Check new SAR less than old SAR and current counter is in errata
> > > +	 * windows, write extra old SAR into FIFO and new SAR will effect at
> > > +	 * next period.
> > > +	 *
> > > +	 * Sometime period is quite long, such as over 1 second. If add old=
 SAR
> > > +	 * into FIFO unconditional, new SAR have to wait for next period. It
> > > +	 * may be too long.
> > > +	 *
> > > +	 * Turn off the interrupt to ensure that not IRQ and schedule happen
> > > +	 * during above operations. If any irq and schedule happen, counter
> > > +	 * in PWM will be out of data and take wrong action.
> > > +	 *
> > > +	 * Add a safety margin 1.5us because it needs some time to complete
> > > +	 * IO write.
> > > +	 *
> > > +	 * Use __raw_writel() to minimize the interval between two writes to
> > > +	 * the SAR register to increase the fastest PWM frequency supported.
> > > +	 *
> > > +	 * When the PWM period is longer than 2us(or <500kHz), this workaro=
und
> > > +	 * can solve this problem. No software workaround is available if P=
WM
> > > +	 * period is shorter than IO write.
> > > +	 */
> > > +	c =3D clkrate * 1500;
> > > +	do_div(c, NSEC_PER_SEC);
> > > +
> > > +	local_irq_save(flags);
> > > +	val =3D FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + =
MX3_PWMSR));
> > > +
> > > +	if (duty_cycles < imx->duty_cycle) {
> > > +		if (state->period < 2000) { /* 2000ns =3D 500 kHz */
> > > +			/* Best effort attempt to fix up >500 kHz case */
> > > +			udelay(6); /* 2us per FIFO entry, 3 FIFO entries written =3D> 6 u=
s */
> >=20
> > I don't understand the motivation to wait here. Wouldn't it be better to
> > write the old value 3 - val times and not sleep?
>=20
> No, because you would overflow the FIFO, see:
>=20
> 137fd45ffec1 ("pwm: imx: Avoid sample FIFO overflow for i.MX PWM version2=
")

val holds the number of uses FIFO entries, so writing (3 - val) new
items should be fine?!

> > Or busy loop until
> > MX3_PWMSR_FIFOAV becomes 0?
>=20
> Do we really want a busy wait here if we can avoid it ?

udelay(6) is a busy loop, so we're already there.

> We can do udelay(3 * state->period / 1000); so faster PWMs would wait
> shorter.

state->period is the new value (and you want the old, right?), but
otherwise I agree

> The delay is here to basically wait until the FIFO is surely empty and has
> space for 3 consecutive writes (see the commit above wrt. FIFO overflow).

Best regards
Uwe

--ctgpfajami44sg5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcBYdsACgkQj4D7WH0S
/k7uuwgAryHou4sFu87uurvIotcWUKE3UOcqqY5ITxmszZHlYLbHtjxWc6nKPXg8
FfDoH/A2Jf3US9mmdD+a24P3re08XgJisyGHdMeQonTuUznsfsNH6yPwyTNJX6k+
HZdk+7t4orcYA8aulNs4I85QB/+UPqwJ/P+szn2IvSfOjuy1hSNCuvMrL0VT6MGZ
dMwSKWoYDhmtf9/YiYbNvCFec5hvePwkcQQvjwKaF1bhJEVDN9iKeVB0HWVgfsWx
MsHGlTf7tjp4XhI4PJMLV2yqCYKMkCs/mHV/lQjJSqTE8vusPMUUAe/jNx5iIkVr
mk2wXkaesccaUsLMjRzR8Dc+DwrAuA==
=WUha
-----END PGP SIGNATURE-----

--ctgpfajami44sg5x--

