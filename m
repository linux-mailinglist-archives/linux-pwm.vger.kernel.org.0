Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ADE359FF8
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhDINie (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 09:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhDINie (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 09:38:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C389C061760
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 06:38:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s15so6602899edd.4
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ztVSslfeXk+Puzf/6F61J60GRyKpaqQ6M4PfwrNU87w=;
        b=FYMngXVVGj6ygEWQYsxYkNvKGhUzU9mul6NsNKviwxu+ruIgEAiOsLPzJs729MIIde
         pvinkMrV6XdgExeccNrA+iSpRefg5SoRvR7PaBJbC+HB1Kd/udsEzCgTPM4OlOECUvJO
         mjBWcofa74N9P8gGhEYGX9DdPL0qbNbJvjheVqtMJem6R4t/pR/XJg/uNQ4U/bwyrSf3
         a/Ay1SG209ZK2H5Lpv0gIb46n5b56+lt896/xwdRwPhmsfTdatWT1cRBvFu+i5n58Al/
         4GjTbU3IOgbVQVhcZiBgTixYaqQF1/wqp/RO8iKA7GtiLeSjhBpCsmee7uh5Lox+Z6fA
         t2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ztVSslfeXk+Puzf/6F61J60GRyKpaqQ6M4PfwrNU87w=;
        b=l173FZSIqx1LVZFrEs6kiSQg3H+DjpqeBBGv+2QIXBXg3QhaN/gl/lJCYcT0Kilu+9
         eh7umYX1vyGj1I/F/JHtH+RBMiQ4jLjvhvFMj9wMSYdOfLuY7o1eW4tKTpIge3URJDLa
         q/oPKtg0Z5Bia+zvmxQ5w4PBWhg1pFp0/5PEyt0P6NgGEFHYm19XxghT+ykmMmS3oI9X
         meF5p+dThE+AwTkdo37R7B/WLpGDenQMoZQichakCaM+WJ8QPCp8K2ZiIF62kFQQxDLp
         4qRcitwgfQgQUbE8OSSDYKd3Oy9f4ck+vPkkkuMzyDpEh08OQccwn6zoP/u37TJP3dMz
         lBsA==
X-Gm-Message-State: AOAM5320zB38v/+K38WFOatuZ5n+EmADFnuxFCgDa7iqsMhahWh5PHCz
        wjlGW4uef9riPsasYhHdMyo=
X-Google-Smtp-Source: ABdhPJyCeTPNz2c9OBfAmMX9yOr5DZ2g2eo0NxUAYY5PH/S3jOAbf/Zn/DyuyDguF8aff4SkzH/zwg==
X-Received: by 2002:a50:fd16:: with SMTP id i22mr17503935eds.239.1617975500049;
        Fri, 09 Apr 2021 06:38:20 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id r4sm1229894ejd.125.2021.04.09.06.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 06:38:16 -0700 (PDT)
Date:   Fri, 9 Apr 2021 15:38:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 0/4] pwm: Simplify drivers with of_pwm_n_cells = 3
Message-ID: <YHBY7aXlJYKmXKGG@orome.fritz.box>
References: <20210315111124.2475274-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yzwueTQphz5WRVHa"
Content-Disposition: inline
In-Reply-To: <20210315111124.2475274-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yzwueTQphz5WRVHa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 15, 2021 at 12:11:20PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> quite some drivers support the modern PWM binding with #pwm-cells =3D <3>.
> Make this still more normal by simplifying the core a bit which then
> allows to drop the explicit support for 3 cells from the drivers.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=C3=B6nig (4):
>   pwm: Make of_pwm_xlate_with_flags() work with #pwm-cells =3D <2>
>   pwm: Drop of_pwm_simple_xlate() in favour of of_pwm_xlate_with_flags()
>   pwm: Autodetect default value for of_pwm_n_cells from device tree
>   pwm: Simplify all drivers with explicit of_pwm_n_cells =3D 3
>=20
>  drivers/pwm/core.c             | 41 +++++++++-------------------------
>  drivers/pwm/pwm-atmel-hlcdc.c  |  2 --
>  drivers/pwm/pwm-atmel-tcb.c    |  2 --
>  drivers/pwm/pwm-atmel.c        |  2 --
>  drivers/pwm/pwm-bcm-iproc.c    |  2 --
>  drivers/pwm/pwm-bcm-kona.c     |  2 --
>  drivers/pwm/pwm-bcm2835.c      |  2 --
>  drivers/pwm/pwm-berlin.c       |  2 --
>  drivers/pwm/pwm-fsl-ftm.c      |  2 --
>  drivers/pwm/pwm-hibvt.c        |  2 --
>  drivers/pwm/pwm-imx-tpm.c      |  2 --
>  drivers/pwm/pwm-imx27.c        |  3 ---
>  drivers/pwm/pwm-jz4740.c       |  2 --
>  drivers/pwm/pwm-lpc18xx-sct.c  |  2 --
>  drivers/pwm/pwm-meson.c        |  2 --
>  drivers/pwm/pwm-mxs.c          |  2 --
>  drivers/pwm/pwm-omap-dmtimer.c |  2 --
>  drivers/pwm/pwm-renesas-tpu.c  |  2 --
>  drivers/pwm/pwm-rockchip.c     |  5 -----
>  drivers/pwm/pwm-samsung.c      |  3 ---
>  drivers/pwm/pwm-sifive.c       |  2 --
>  drivers/pwm/pwm-stm32-lp.c     |  2 --
>  drivers/pwm/pwm-stm32.c        |  2 --
>  drivers/pwm/pwm-sun4i.c        |  2 --
>  drivers/pwm/pwm-tiecap.c       |  2 --
>  drivers/pwm/pwm-tiehrpwm.c     |  2 --
>  drivers/pwm/pwm-vt8500.c       |  2 --
>  27 files changed, 11 insertions(+), 87 deletions(-)

Given where we are in the release cycle I'm hesitant to apply this, just
in case it regressed somewhere. If you send out a v2 I'll queue this up
shortly after v5.13-rc1 to give it maximum soak time in linux-next.

Thierry

--yzwueTQphz5WRVHa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwWO0ACgkQ3SOs138+
s6HmjBAAgQrWNJdDVuT8Z5Lvs6vWbuS6Ivhmdg3on8U+y4HHCSRuLe/uRzUABtIA
gZVeLqIEdM446+OnR1WTioAIGBAYpy59QjQihQl/Ky9lWdBm7ZJIuMCnHfGRQecL
kpVId8TTwiof6MoH1kcX3MfR6Z6EqyqP2zyLaAXl2PaTpNVOz82hryTK4sLHLC0d
++S6CSWBQg6jLDERJV9TEcTk6mozcnke5tVClq4iLKv3yOmYIRu8Hr1+zDasOQ1/
qhpBtglNdYx20jFBh6sH8ret1gzTfBwxPBfKfZG/wdhQOsHU1dB6my6Pl0vGvksc
Wjhg4u3d3dkpIzXgANtqLRyWXHInWt18FRXD2VMbV4Jkf4cQzN18oVsN2RIMaNV/
ySs3QcPrOtZ9x268L6bDGMhNoUHEmDmmo2xlbbNwdPR7H3re5hnaUtS7szWJex5t
70X/CnCVUShuyKEfac+ve19D+wfypRtUg/DvaT4fyghGqKq9TFWC5srCil3G63u5
Kcow6B04zzSh2W3FbWuQA91lLq65D27LykFX0YBXZ1oIxyn7arzsg/Bz4c2esR+0
No/OlxVPpDlyDb/GJKLw3NuUJIYaDYDoGyfCsNGFy1QmtMu2J+TEIUuJN02IW9gm
yQhEC7c/QIP/ZISj6lDgJNgpN1fU+fvWRXA4COeNGMl3B7YWY8o=
=FxDR
-----END PGP SIGNATURE-----

--yzwueTQphz5WRVHa--
