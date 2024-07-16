Return-Path: <linux-pwm+bounces-2825-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C53D9320EB
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 09:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C1B1C21548
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 07:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47245219F6;
	Tue, 16 Jul 2024 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OG9wqCTt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E55C2BAE9
	for <linux-pwm@vger.kernel.org>; Tue, 16 Jul 2024 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721113597; cv=none; b=OIn2DV0umavVj76clAarlfxXYccQ/RrMl3AIPCeG4jdgdlqT6V+xhptMFlLMUxpPY89tDudqWqVI6czW12XvYaZIP6PtbHhNR9qcOtU0PmaWa0RuSoB2sEMUEpTOK6ro6wwQGIbWwKJlOC8E75dNrStB2uqYM2DJn9rRxvQ3vtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721113597; c=relaxed/simple;
	bh=OPDt1x0G23efIPOchsHmuIyCGE9lUqx5H3/vbhyTc30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B48mTJ11KENrHY19pnwjuumOwjmcEQRlOKjw3mOuKrFaWiFwCSrJDWseCFkealNtFiRybxNIZM7ECRw/0rGCuANv6y+hl9i7WjqdEvnG1BK50J+0Hq5RYB2thXK3AqmiiCnRu2BRWE6dgZcW52PxzTMbwUM40PXQTyu4nll6PKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OG9wqCTt; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4266fcb311cso35864125e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 16 Jul 2024 00:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721113590; x=1721718390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=304jo1FwBHiIbWA6hyHqRpGRdWqrS/IKcrrefU+bu08=;
        b=OG9wqCTtUGuEtkNh9bfKudhVypEiUBo0gv3E4J8mSH94GZ9XOEfscFdE+b+ZxtWp2+
         lhqRYpYxgrVn3CAt9brcxqPi0YuM55KDrnIhXczUkzpzHd1PtcsB6s+xNkNKSU0yuhuH
         diAtN0s5Cssf5G4p3/qlAwfoTj5DaITQHZQtOaalX6gtDpYjPBeiF0/gcpIzD/82IsI4
         Np4CqaL18lpKhR1YWg8aPdnULdMmC0Rg3WQimXzRUZcygZjBqrIUM3scIPI539M9aOwN
         2IjCZjWaAgc3hP4MIoerbFvow+TN7GolUedpvJsQ8HgxdyqlWUcAO8AI4Gt/S46PmiXQ
         Fjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721113590; x=1721718390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=304jo1FwBHiIbWA6hyHqRpGRdWqrS/IKcrrefU+bu08=;
        b=RFQEIhQHmBqeVgxqEHtqefdi4r/cJgkSt0noep9C5u1HhhZmWIm/RvPmoX1yV154Z7
         V/V407UB2H8CRnSzRyFf7oW8vYTroIoHVKU82+5eXJja3BUZ6OrTNL/4d7iiTk9OzoLU
         vopQEqC3Eq8dBvBvgJ57fQ/Qo0NmYM3p2H4yZ/BAQoaHilXPLWMkDV1nx10EWCiN45W9
         gapiuiSrXyQrMECXPiBHIsKL2CM8vYM5lNdOsfG2wEu+/NqH5T9k2mAXzaXyENbnHsql
         sFVY9vlFKhuOxvhUI2EVKR+gysSvky0wZvInNrOgyvYgjgMESQ9Q5rMDCp5XTfFSwEB1
         qKIA==
X-Gm-Message-State: AOJu0Yzt/YxNkYmXzX8rX7kx9qukQ/KnvthV2kH6OXZbbHaW81YZbyjH
	/ddVSfmBM3U8HKB7w+6yPXLbHmwKk5el5Z7jPEJDy9m1MujfjKjSfryr+Si9kHk=
X-Google-Smtp-Source: AGHT+IGFe9AD3XugInsTNJr47NhzRmSr3mgCyY7ZrhA7CvTrbqzFyVDOgvFqCRCugEDwT/caGu6BcA==
X-Received: by 2002:a05:600c:45ca:b0:426:59ad:bbb3 with SMTP id 5b1f17b1804b1-427ba71c66cmr8529395e9.32.1721113589553;
        Tue, 16 Jul 2024 00:06:29 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc244sm145669275e9.37.2024.07.16.00.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 00:06:28 -0700 (PDT)
Date: Tue, 16 Jul 2024 09:06:27 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v2 4/8] pwm: Provide new consumer API functions for
 waveforms
Message-ID: <cwgrbvzc73hnsmkfigq2t5t43y73oyz54tugad6ayxwzrlawlw@qd3bylzfqvns>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
 <8db2c6f239b9e101f85d556d9e203935c2da2570.1721040875.git.u.kleine-koenig@baylibre.com>
 <ff628d7e-bd87-48e7-b80c-aff2d4e61f2c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r462l6yflr5zhf3h"
Content-Disposition: inline
In-Reply-To: <ff628d7e-bd87-48e7-b80c-aff2d4e61f2c@baylibre.com>


--r462l6yflr5zhf3h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Mon, Jul 15, 2024 at 05:23:45PM -0500, David Lechner wrote:
> On 7/15/24 6:16 AM, Uwe Kleine-K=F6nig wrote:
> > Provide API functions for consumers to work with waveforms.
> >=20
> > Note that one relevant difference between pwm_get_state() and
> > pwm_get_waveform*() is that the latter yields the actually configured
> > hardware state, while the former yields the last state passed to
> > pwm_apply*() and so doesn't account for hardware specific rounding.
> >=20
>=20
> ...
>=20
> > +
> > +/* PWM consumer APIs */
> > +int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_=
waveform *wf);
> > +int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_wa=
veform *wf);
> > +int pwm_set_waveform_might_sleep(struct pwm_device *pwm, const struct =
pwm_waveform *wf, bool exact);
> >  int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_sta=
te *state);
> >  int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *s=
tate);
> >  int pwm_adjust_config(struct pwm_device *pwm);
>=20
>=20
> It seems like there could be a potential race condition between rounding
> and setting a PWM.
>=20
> Consider two PWM devices that share the same clock and the driver can
> set the clock rate to accommodate a wider range of periods or get a
> more accurate duty length.
>=20
> Thread 1				Thread 2
> --------				--------
> PWM consumer A calls round_waveform()
> a few times, e.g. to round up or round
> closest. Clock is not exclusive so
> rounding assumes the rate can be
> changed to get the best rate.
> 					PWM consumer B call set_waveform().
> 					clk_set_rate_exclusive() is called
> 					on the clock so the rate can no
> 					longer be changed and the rate is
> 					not the one PWM consumer A selected
> 					in the rounding operation.
> PWM consumer A calls set_waveform().
> This will either fail or will
> not get the same results that
> was returned by round_waveform().

The "exact" parameter has the purpose to make this fail. While
implementing the idea I wondered if I should drop the parameter and
make .set_waveform() imply exact=3Dtrue.

Two more thoughts about this: First, I think the most usual use cases
are rounding up or maybe rounding closest (instead of rounding down as
done by default). It's easy to implement a helper function in the pwm
core that holds the chip lock and does the necessary function calls to
determine the rounded setting needed.

The second thought is: Even when holding the chip lock, another clk
consumer can theoretically change the flexibility of a participating clk
while the right settings are determined for a given pwm consumer. Also
if I use clk_round_rate() to determine the resulting rate of a parent
clock, it's not sure that I can set this rate because again the
situation might have changed since I called clk_round_rate() or because
another consumer refuses my request to change the rate.

So as soon as you consider changing an upstream clock to reach a certain
PWM setting, this all degrades to a racy best effort quest.

> If it wasn't for the userspace cdev interface, I would suggest
> to drop pwm_round_waveform_might_sleep() and pass an optional
> function pointer to pwm_set_waveform_might_sleep() instead of
> the `bool exact` argument so that the full operation of rounding
> and setting could be performed with the pwmchip lock held without
> consumer drivers having to worry about getting it right. Consumer
> drivers would then just have to implement functions to suit their
> needs, or there could even be standard ones like round_closest().
>=20
> But that still might not fix it in all cases e.g. if two pwmchips
> share the same clock as opposed to one pwmchip with two outputs.
> If this is possible, then then "pwm: Add more locking" patch
> might already cause some problems with race conditions in the
> existing PWM apply() ops. Although, I suppose this kind of
> clock coordination between pwm chips (and potentially other
> devices) should be handled outside of the PWM subsystem.

I would expect that the "Add more locking" patch doesn't enable more
races than are possible without it? I don't understand the problems you
think of here.

Best regards
Uwe

--r462l6yflr5zhf3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaWG/AACgkQj4D7WH0S
/k47Mgf/Uo0JQgbfcblucZy+iJbh7IPZRupq2AGkJ6L15RyMxgD0sw2pXY3BbTvW
JhFsxAFnXOliva37bqZcrQfPf4VMc5Haa458aCG1gJD4iWPP2OONoKiG1eL6NbP1
gFMuuIICgmtTlypqR3IQnN9RkMiQfRfWcIOdMnGfBzRih6REY8oTf01Vk+u3RQFD
LYQ0/uC1Cs7HxmnPsxgiSn8Nln9W7pE1BIo4f+3G9doH4Enx5dpwtpaF4aRS/nf2
Ww8ocluw1i4xFcgM9BlQtdmuBzy2IyEancRaT3SW0n9gk3zKLitSFURWBA7uMIbD
4sASTDHfIriCDxhM+Xvv879O5+lrRw==
=bSfl
-----END PGP SIGNATURE-----

--r462l6yflr5zhf3h--

