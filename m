Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1626D2D71DC
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Dec 2020 09:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405504AbgLKIfJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Dec 2020 03:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391068AbgLKIel (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Dec 2020 03:34:41 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CF9C0613CF;
        Fri, 11 Dec 2020 00:34:00 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id a12so8119008wrv.8;
        Fri, 11 Dec 2020 00:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9wVsVXIb8fDr6eSEsD4+RYpMLWOVulxTaFgMno8M5zM=;
        b=KFH5c70WyCbUPoZz4frHjSgHFrqvAt9Oa4oZI8sjvay91vkGiIT1+fo4jY/cFsxydX
         er5j8OAFLs8Q8yH6MYbQTfjwp8SZaN9ZAhtB7y5OPk1jqhtvx+z8g0HDFzY4MU1sRSBc
         x2b9XYE9xAy4BijYvDUYqEhPpdm8eSIkRFHGoiEtIiJ3qB/nfmZSostv1Ev654V9LsJo
         ryfM/tZwxO3PPwikn5nilrFYBcwOZT4qs9SNqhNmEsPXOZyOECo8UsMueJTtjYFZJ++f
         8D1XI0jczlDXt0hhOAB7G/nUQmWBualUdijslP724QNmcnsHollBVx8R+51cLS0/ZNI0
         Cd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9wVsVXIb8fDr6eSEsD4+RYpMLWOVulxTaFgMno8M5zM=;
        b=YT7dBJ/S6TvE00MNHCq0tstjENQ0CrFRKtqfFUmJMLSFsvUJnvhj98sIcJ8CqPu7HY
         fBavHCdRMtWmCEvV3lWkGRwlyUWxa4remKgJpS1X/pFZHMwLnc5M4ypj+3PAmtEnoQUJ
         AktFFpEuhR+OGf/khb65URpnrg/2p+QHnFum/XXzBIvdCRpSWcPCiETnEOsiQcyKHnco
         nqmLXKM5RDj1jiotVcyVt4PhQRbLStvMXGgnLWgx1pKLjG8A8Kl9RVs4V8JqUUpcIydc
         6oHWlbf1PLKxMaTR0tazZI4pCI3MiuS4Xj8UV+vKaJt8fIFPV0JmOTsUJNV+rDldzeGr
         UW8A==
X-Gm-Message-State: AOAM5300zvHWGluS4sW+bzht/XF2JdUel+SC+LPSxJY3HLoIVb4/QNS2
        HKIuxxW4IAvXTa0yfehIM04=
X-Google-Smtp-Source: ABdhPJzCHRHbxg9IB9AwOKw10nWYsskXXsOjjvTRCKZTCyw1YoZiC+LWJCbQVh8n//+055s8TpPvJg==
X-Received: by 2002:adf:82c5:: with SMTP id 63mr12704763wrc.38.1607675639647;
        Fri, 11 Dec 2020 00:33:59 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id b4sm13313790wrr.30.2020.12.11.00.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 00:33:56 -0800 (PST)
Date:   Fri, 11 Dec 2020 09:33:55 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <X9Mu8zrJjFTe6fJq@ulmo>
References: <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de>
 <X89RgpTb3sBBI++w@workstation.tuxnet>
 <X8+DI7ZN7mXtsxv9@ulmo>
 <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo>
 <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
 <X9EDGHySNYb7CxcW@ulmo>
 <20201210090124.rfswkrcttsg5gszp@pengutronix.de>
 <X9JWlVPb9ZGdB4q9@ulmo>
 <20201210203926.ouzrq3ff5k6zhlvt@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hmzyeSm2KOFrlm0S"
Content-Disposition: inline
In-Reply-To: <20201210203926.ouzrq3ff5k6zhlvt@pengutronix.de>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--hmzyeSm2KOFrlm0S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2020 at 09:39:26PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Thu, Dec 10, 2020 at 06:10:45PM +0100, Thierry Reding wrote:
> > Like I said, that's not what I was saying. I was merely saying that if
> > there aren't any use-cases that current users rely on that would be
> > broken by using this simpler implementation, then I'm okay with it, even
> > if it's less flexible than a more complicated implementation. It should
> > be possible to determine what the current users are by inspecting device
> > trees present in the kernel. Anything outside the kernel isn't something
> > we need to consider, as usual.
>=20
> If "users in mainline" is the criteria that's a word.

I didn't say "users in mainline", I said "use-cases". What I don't want
to happen is for this change under discussion to break any existing use-
cases of any existing users in the kernel. I said that we can determine
what the existing users are by looking at which device trees use the
compatible strings that the driver matches on.

> So you agree we remove the following drivers?:
>=20
>  - pwm-hibvt.c
>    Last driver specific change in Feb 2019, no mainline user
>  - pwm-sprd.c
>    Last driver specific change in Aug 2019, no mainline user

No, that's an extrapolation of what I was saying above. Drivers with no
apparent users are a separate topic, so don't conflate it with the issue
at hand.

While it's certainly unfortunate that these don't seem to be used, I see
no reason why we should remove them. They don't create much of a
maintenance burden, so I'm fine with keeping them in the hopes that
users may still show up at some point.

> Most PWMs are added to cpu.dtsi files with status =3D "disabled", I wonder
> if it makes sense to check the machine.dts files if some of the PMWs are
> completely unused. Do you consider status =3D "okay" a use that we have to
> retain even if the node has no phandle?

A PWM controller may be in use via sysfs even if it has no phandle.

Thierry

--hmzyeSm2KOFrlm0S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/TLvAACgkQ3SOs138+
s6GvGA//Sr5JVDPGWermBKcZG8UUNpYyW2wQ0zas64dDUSOU/pW7gvSU/e6G8Gdz
d/CD5y6g8JGl/scTt+vprgkRSaYbuK/uXcQF3qz+6sTILzwfCYpKsx6Ko0JV6Efc
ymNV3yn3ejAbHoF6Fr3wBIV02MrKU00p3OcWY+9TfjE7Ato7D/bFxi3G7KP6z4PE
BU9zyYMaSDpzvECDpssG+o6VFbQIbES2RRhmc3114w1Qn+lAWvgAyCX0hp7SY7Qj
91j6AbyV1BpaqCptEfs9tGoQFXMLOqw/S3J8tCMc2oAtH1evSJDozdVSJwQV0FDk
ifOyBWIoLV74OuuTirayN9GibzFNF2G7VsS5jKd033tCN+EMKgXGxLPA4NAvXhoX
3+HmnBG9i0XYeXCyO/To26Jj4C0XV2amFII1kd8f6cbEx522T+QrRIA33r2eA+YE
7tiygRFucDwQPHMKtAxTsTwYmjGF8eNXYBhv0/xldHDzt8eF6jj/SOOxzVYV92PO
gQJyO9Huy7wWuVbt3A2xLxsqOvHWT3hERCvDUDQNwbWyOxyd+HCB41Cu9vjbyAd2
fKwGSLvq3rqya8euA1qPzYjBq5gKyvnn8lKOlLjrlQq9bs/grgfoss9+lRjYZiLN
AjGRiBIY6VJNT8b+DCb6wou6/f1/RvzldDbGIIjXqzBPYu5mEOE=
=W/qR
-----END PGP SIGNATURE-----

--hmzyeSm2KOFrlm0S--
