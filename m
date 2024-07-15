Return-Path: <linux-pwm+bounces-2816-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D19931B84
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 22:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7772E282F3A
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 20:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E6D139CF7;
	Mon, 15 Jul 2024 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kO+WXtS/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004F133C5
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074124; cv=none; b=juPg/4tJaTcH8RfNDlfFgagLUVsSeLRsmT9eOKtRB0XCDni0z4bhOeAnKDxBEWsAgFrKjXuor4ozvNr+29EmAt2+L5yUa/O90F53+Qpl0PjDBo9t5v1enZ1oNqwG/alxncB1YbTwza0MOwvR/aa8KSeONna2GiBnJtOv5999wFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074124; c=relaxed/simple;
	bh=rUzUyh9PQpckWzyMajnB6ppfJjzmvPdn/6ZvcnvJI4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kD7F+Op0xbU3eWMdXJi8N4rIeXDCxfv7BJ4+IHC/EM68Gq3t1rd2BC/XtqF+DGcJpX4NLOsHQFsC68Nid8253huw93a3s61M9isKVJR1+v1ah6sH6m3b6JO9MhgoG47CWadfx0aUbWRYzV5epk9Frd4YaeHEN+Ic2Z7GDJ8thHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kO+WXtS/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5854ac817afso5952227a12.2
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 13:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721074119; x=1721678919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHKyNBxOJSokc766/ELAKnXSYexgm1oJcAXI3rNIYVc=;
        b=kO+WXtS/L9Sb86zjY4jWGCqBzXx2H9Lgo+Oqyxu20KmXv7M9VCxA158JpOWzjYYi26
         kyx7JTcervnbxiuRHXfYR9QIDxAjANRY6Bb8aHFNoEdVQSTkN6YAxahjW0dRn1YonvAv
         Dy/ycQHpZu8uTMKVmNYp8B0hY3SjSqrtfl7cw0U7OmE0OzbZeOyuzcKrSg3dikwrmSZ2
         zlkfNTv/1KI/3KABmbhEnS+H+7Uyy9jQ2Kh1fEGmnnzMTgpPw8/2ToeioFzTvkSlIJ4m
         ynsbvVHOMoXwMTMEPod1s03hMwYGE8Wgo/l3yvv/gtzV/b46IVoCGDoeHEaDfFVf9T/E
         ggyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721074119; x=1721678919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHKyNBxOJSokc766/ELAKnXSYexgm1oJcAXI3rNIYVc=;
        b=QjyjNu5PoIbRxYnK0FnSa31Qk8skoax8rpgdrwZwTIp6c9hDlHyB2e6JGKW5XqI/z1
         pZjUaoGARH86CjHugskrVJ2Y4n+xtVgFFcjYoHdqmcsqevgk0W95S30oX2rq6emjkE+x
         FIfs1RBAvL/pCiRKRHPGC2FGKERdRH0XRpFx1j7xqeyAEPjbsxlNSILZvCViksz36XIV
         whGeCdLx2ZmEFWslpRXWUwi6h0mnjgisJGpSBruuZRiTUPMkxg6VswzFSydgW/t2ClRq
         Y6m7vp96q+k3+dwzBD546A78oHgXM5Tlbj8krbZJvvQVWSLc4HSCdLaSd8bvow7unUCQ
         EXmQ==
X-Gm-Message-State: AOJu0Yy5PtHfknHMVBju5BBUs8BQ3/HtMSVX0YTlw2/h9PTuC+UJTkA5
	kPm2apbwuKiGo6bRHHqrw95WNPTxQDb7i219mp6NM6WzH6WGpn87Lgo/DF0NVK8=
X-Google-Smtp-Source: AGHT+IG2bhTSv7irZB2Sv1f8+l/94S3vAho1O/pvm3WrKSxKSOPfjvX9+T+jRbntadbaQHrNjul/dQ==
X-Received: by 2002:a50:9ea3:0:b0:58e:a9b7:d351 with SMTP id 4fb4d7f45d1cf-59e9780f222mr586803a12.23.1721074119319;
        Mon, 15 Jul 2024 13:08:39 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b268a271fsm3769931a12.78.2024.07.15.13.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 13:08:38 -0700 (PDT)
Date: Mon, 15 Jul 2024 22:08:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v2 2/8] pwm: Add more locking
Message-ID: <bja33skzmb4rlwoj74pmek7ceuterzlhsn4zrpvugeruur7qup@ccwhsa2jxdy2>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
 <54ae3f1b9b8f07a84fa1a1c9a5ca2b815cea3b20.1721040875.git.u.kleine-koenig@baylibre.com>
 <c4d00e3b-3a8e-445f-882f-7fd9305a989f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4bs7a67ptv3eievh"
Content-Disposition: inline
In-Reply-To: <c4d00e3b-3a8e-445f-882f-7fd9305a989f@baylibre.com>


--4bs7a67ptv3eievh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Mon, Jul 15, 2024 at 11:56:05AM -0500, David Lechner wrote:
> On 7/15/24 6:16 AM, Uwe Kleine-K=F6nig wrote:
> > @@ -1138,6 +1190,9 @@ int __pwmchip_add(struct pwm_chip *chip, struct m=
odule *owner)
> >  	if (IS_ENABLED(CONFIG_OF))
> >  		of_pwmchip_add(chip);
> > =20
> > +	scoped_guard(pwmchip, chip)
> > +		chip->operational =3D true;
>=20
> Strictly speaking, is the pwmchip lock actually needed here since nothing=
 else
> can access the chip until device_add() is called?
>=20
> I guess it doesn't hurt to take it anyway though.

It might not be technically necessary, but __pwmchip_add() is the
exception here and holding the lock consistently while accessing
chip->operational has some benefit, too. I prefer to keep it.

> > @@ -1164,11 +1222,27 @@ void pwmchip_remove(struct pwm_chip *chip)
> >  {
> >  	pwmchip_sysfs_unexport(chip);
> > =20
> > -	if (IS_ENABLED(CONFIG_OF))
> > -		of_pwmchip_remove(chip);
> > +	scoped_guard(mutex, &pwm_lock) {
> > +		unsigned int i;
> > +
> > +		scoped_guard(pwmchip, chip)
> > +			chip->operational =3D false;
> > +
> > +		for (i =3D 0; i < chip->npwm; ++i) {
> > +			struct pwm_device *pwm =3D &chip->pwms[i];
> > +
> > +			if (test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
> > +				dev_alert(&chip->dev, "Freeing requested PWM #%u\n", i);
>=20
> Is it really so serious that dev_alert() is needed? dev_warn() or
> dev_err() seems more appropriate IMHO.

I think I picked dev_alert back when this was indeed alarming and
leaving behind some dangling pointers. Today you're right, "action must
be taken immediately" doesn't apply any more. I'll go for dev_warn().

> > @@ -290,6 +293,16 @@ struct pwm_chip {
> > =20
> >  	/* only used internally by the PWM framework */
> >  	bool uses_pwmchip_alloc;
> > +	bool operational;
> > +	union {
> > +		/*
> > +		 * depending on the chip being atomic or not either the mutex or
> > +		 * the spinlock is used. It protects .operational and
> > +		 * synchronizes calls to the .ops->apply and .ops->get_state()
>=20
> nit: inconsistent use of (), and also synchronizes calls to .ops->capture=
()

ack. It also protects the new lowlevel driver callbacks, so will reword
to just speak about pwm_ops callbacks.

Thanks for your feedback, I really appreciate people looking in detail
before the new API is set in stone.

Best regards
Uwe

--4bs7a67ptv3eievh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaVgcEACgkQj4D7WH0S
/k72LAf/ViMl/eqaiYXOQ8QIAC7U3+/a9LDLtUSRUmzXOQ78bWS8C6o/pX50Rzto
j6rOlzplQez+/OHoUhwAa5sBLG0uskYT5MQntSl2IzyhtqFAF6hgmG5ZyNjv9SAv
KyXwNz9OMpDe+Nc9xwkhRl/9nc7WJw4xEXn3TgMoCgdJVs0RAfjfy4gY5YkKm1xF
JVc7ep5gxwxU1ShuaazoyZBH5fDNuWadcQEAfiDATUQ9v1KLH6qHawNmHDwU+KH4
BDqMuehf92b50eRh2+quC1ID5dbuQJfrNRMT1pEQHoDb+FLGTwqw+7YJAjZ0AvaR
bWorfspYAlGeUygZedLP8cXqs+d/Ew==
=c7zR
-----END PGP SIGNATURE-----

--4bs7a67ptv3eievh--

