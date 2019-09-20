Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70DAFB99D7
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Sep 2019 00:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405224AbfITWxA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Sep 2019 18:53:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53471 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404344AbfITWxA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Sep 2019 18:53:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so4050240wmd.3;
        Fri, 20 Sep 2019 15:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v/fRS1hf0Y6rzyt4b5luAoMl6E/ZN+a5rOV7iWzdrv8=;
        b=fs38uwnENB07kzzraMJzxVhUi9/QuMy/IoqVZXLmJtTPkl0WNUf17Kn7MnqElzzZgm
         ld3rFKdWrXqN2UsOAhc23r8AvqDU0rxIf5bOhhULsGYtHMIEyCRahK11I583w7PSUeVf
         fGN9oQRaEF2V7gxnb82u1VLgX3Lx4uTSvFposOJtO+AAVVlEzB9YeuCkPE8iWp9z3qHM
         hsOFbaNdmxNqzvJ4FC/9MhYEF64MLw7RVO+I9qw78VRua9n+Shj+eS00fLx1OldgyFks
         ECHuZ2UzFmtuOJsqZxMxIIPBJR1JuWgC+PkusLQm50RuMeNWjjPiZPmA5KLO9TEPrd0X
         YSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v/fRS1hf0Y6rzyt4b5luAoMl6E/ZN+a5rOV7iWzdrv8=;
        b=s8VjbRhqZi5FoBU/69o1eW5dz2tagIHpls6c4sVqNPj3ddvvPYZYx2sDXAcmKmdz6r
         fGGubQDAtvRaWQu5HO3Bt51GWhrUkh17sDBWFCFpERgRfXrzvZLno9dbPlBSV1nscobw
         DcSrecZqQHwr23iaMVUw/rj+xYJDXzLJ7tx8D4HVFK4fM29pXOnXM/7mZaP6XZCO29Sq
         S0hbhXomIFlATQ/6c22XJYzf2nEftWQ1yfxCClDOk3iA414SEmaF2uYj/UXxZmEG26zI
         kDVZIA09LSsB2mVAPfED+AArj4alzJVTMyYl0WZbQFhwSeoL6wai4U0SrxwO4CJhlEhl
         /kBQ==
X-Gm-Message-State: APjAAAV0mXK44rZWM9fAsaivNiKGxE52LasCV+6W/0B2tUyOdjUPD80W
        wtHFo7WBZ99LiwmfynCQtTcSQhso
X-Google-Smtp-Source: APXvYqwuu6T56JZXUFPjhK4cksS1aglyudgoPS/POk9AbVdHsLYal39OIsSDVFifSJUyOvG+8JuR5w==
X-Received: by 2002:a1c:7509:: with SMTP id o9mr5034008wmc.21.1569019977428;
        Fri, 20 Sep 2019 15:52:57 -0700 (PDT)
Received: from localhost (p200300E41F0FEE00021F3CFFFE37B91B.dip0.t-ipconnect.de. [2003:e4:1f0f:ee00:21f:3cff:fe37:b91b])
        by smtp.gmail.com with ESMTPSA id 189sm3059005wmz.19.2019.09.20.15.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 15:52:55 -0700 (PDT)
Date:   Sat, 21 Sep 2019 00:52:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Paul Cercueil <paul@crapouillou.net>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] pwm: jz4740: Make PWM start with the active part
Message-ID: <20190920225254.GA86019@mithrandir>
References: <20190809123031.24219-1-paul@crapouillou.net>
 <20190809123031.24219-7-paul@crapouillou.net>
 <20190809171058.gothydohec6qx7hu@pengutronix.de>
 <1565372004.2091.3@crapouillou.net>
 <20190812055515.ne7o4ujchfeubjid@pengutronix.de>
 <1565643001.2007.2@crapouillou.net>
 <20190812215853.hbhihhtvdziarj3y@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20190812215853.hbhihhtvdziarj3y@pengutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 11:58:53PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Aug 12, 2019 at 10:50:01PM +0200, Paul Cercueil wrote:
> >=20
> >=20
> > Le lun. 12 ao=C3=BBt 2019 =C3=A0 7:55, Uwe =3D?iso-8859-1?q?Kleine-K=3D=
F6nig?=3D
> > <u.kleine-koenig@pengutronix.de> a =C3=A9crit :
> > > On Fri, Aug 09, 2019 at 07:33:24PM +0200, Paul Cercueil wrote:
> > > >=20
> > > >=20
> > > >  Le ven. 9 ao=C3=BBt 2019 =C3=A0 19:10, Uwe =3D?iso-8859-1?q?Kleine=
-K=3DF6nig?=3D
> > > >  <u.kleine-koenig@pengutronix.de> a =C3=A9crit :
> > > >  > On Fri, Aug 09, 2019 at 02:30:30PM +0200, Paul Cercueil wrote:
> > > >  > >  The PWM will always start with the inactive part. To counter
> > > > that,
> > > >  > >  when PWM is enabled we switch the configured polarity, and use
> > > >  > >  'period - duty + 1' as the real duty.
> > > >  >
> > > >  > Where does the + 1 come from? This looks wrong. (So if duty=3D0 =
is
> > > >  > requested you use duty =3D period + 1?)
> > > >=20
> > > >  You'd never request duty =3D=3D 0, would you?
> > > >=20
> > > >  Your duty must always be in the inclusive range [1, period]
> > > >  (hardware values, not ns). A duty of 0 is a hardware fault
> > > >  (on the jz4740 it is).
> > >=20
> > > From the PWM framework's POV duty cycle =3D 0 is perfectly valid. Sim=
ilar
> > > to duty =3D=3D period. Not supporting dutz cycle 0 is another limitat=
ion of
> > > your PWM that should be documented.
> > >=20
> > > For actual use cases of duty cycle =3D 0 see drivers/hwmon/pwm-fan.c =
or
> > > drivers/leds/leds-pwm.c.
> >=20
> > Perfectly valid for the PWM framework, maybe; but what is the expected
> > output then? A constant inactive state?
>=20
> Yes, a constant inactive state is expected. This is consistent and in a
> similar way when using duty =3D=3D period an constant active output is
> expected.
>=20
> > Then I guess I can just disable the PWM output in the driver when
> > configured with duty =3D=3D 0.
>=20
> Some time ago I argued with Thierry that we could drop the concept of
> enabled/disabled for a PWM because a disabled PWM is supposed to behave
> identically to duty=3D0. This is however only nearly true because with
> duty=3D0 the time the PWM is inactive still is a multiple of the period.
>=20
> I tend to agree that disabling the PWM when duty=3D0 is requested is
> better than to fail the request (or configure for duty=3D1 $whateverunit).
> I'm looking forward to what Thierry's opinion is here.

Agreed. If in order to meet the expectations of duty =3D=3D 0 you have to
disable the PWM, then that's what you should do.

Thierry

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2FWD4ACgkQ3SOs138+
s6GJ2hAAp+xxW80HyFVnVRXvrUQU5JL2agGhKkjRCBAKysB5F6LiokWLbc8FNh6s
dgb4u/5YsKPrreVuf485w4ZlkKjWhRVN9bAfmrAcmGRZPc1GBnkBtoIEqK0UHcDF
gsijaWp5QWyjHA5pHDaffdSsB6/HQLJtBa3kIEBOyohyANCI0n8Lwdr58L5jZJz+
fcI8Kf9YxvVrdouKiNpj1KEpPzO2+L9otxl6Bnyul85P/GR/LSw1dcQJMkF61xvy
wuTUwaGls7Q1/W6cENWIH8i8HE+xKbvAI+jINVATxHsqvDgo3L0hI/V93xlqE8Ob
oEhJjOq5T7/c+XOjk6KwZzwc3ycZX6z0SC+NmPksSPJKyORCIPoX7P9K1EzetTjp
fUAB/v12TvTcc4Wm5OchRQmwtefGvv5TM/jC4hGCtOwdbLDQ7myVdKp+vRSYkpef
24MwSs23xRa1GN/67NllTwg97WLsA8mfeXyE+89BKsAfhZe+uFCRI84WWoN22dA/
0DYqZxli22Wpyd9w1CUhJCRcBuALBLASAHHbphQK/cxGtxCH3v5Tf59Ntg2pebg5
wsobhpbyyxd4+U+h/Z+cogq0BfMDy6Jvwxza87qvwaOVGF8jttpY8IAnXFAaGQhk
ydHf6uqppyi5uBJ0Yc88IUBYFgXkf2PypVe7VGByk4SQGRMhI24=
=sC9Z
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
