Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3647739068D
	for <lists+linux-pwm@lfdr.de>; Tue, 25 May 2021 18:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhEYQYk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 May 2021 12:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhEYQYj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 May 2021 12:24:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69929C061574
        for <linux-pwm@vger.kernel.org>; Tue, 25 May 2021 09:23:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v12so32892854wrq.6
        for <linux-pwm@vger.kernel.org>; Tue, 25 May 2021 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WJXUFUWkTS+Q5XKn6bv9hmJyRN8g3GaQbZfI8qeHFJo=;
        b=j66S6mXISPQxevBWVobG70A1qbw9C4JcdU4rhLt9BDEG2haCBBpGhysZSCc9U1Elzj
         UQh/KCHw8RLlk4WXhEopbvWCySrCb0KiyV56as3Rnbragoi3LzLzIFmwCmnnlys0hmVU
         iKpDvoH0X4Vc+lBWVbB4UWi6BMZbBJsPYIXnbDsYuav7yI7wMjOA0e+na5ew3lGNAjfn
         chIZfoC75OVvIUHG37MPALHJEgMGuS+P+gXW148+cvhV4oQ6alSTmMybO7f99eryJBx5
         Ew2HFpzRaeSurWngHPWUaJ8A0Q6/qdLqFgW9n7Efw+oqnMRSD5NxwURTpAD1cmsCVKda
         MlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WJXUFUWkTS+Q5XKn6bv9hmJyRN8g3GaQbZfI8qeHFJo=;
        b=NN4JBdjXczFVCRR0Xj7qhhAbHTDHjqb0jWvviPAXbA47WJ3iN5qnu2uqdKMsnfUryM
         VgGS38ooGDSNtGX26y1NZOkehmtQYM6FNxIHmePPBOMKTG1gAn1yIXSaciLVajs/+BFa
         p9N14gjBjBo3u8NnAuH63ATjvUijg26iescfbv9ETBQG9HeQV5t0VKE2z0Bfr6Q3euMy
         ZWtEPOubr95ITpi1nNa9q9syritTZc+eF28XDKEh9eqsmGK6uoypLCli7W3udkKc+02O
         KAJ7QNRkNV1Kqim36zHLCbUNBoUHWaz+rn0ck4hjGX+882JSZDH4AaFZUU1EAzotw0N9
         52wA==
X-Gm-Message-State: AOAM5327VcIF21ilr/M6tlNlDZIFuYJ4OBWmKALTlasmtx+ABSQaCZMF
        m6QaGX+tf0Wm25CAIOQNyF4=
X-Google-Smtp-Source: ABdhPJxdyS3WHe0A9AAPLsGL2N26+Ht+uZuOcu8oY5voOb1eM7z8HpldbIPUVjKuGsbox0B466Atww==
X-Received: by 2002:a5d:4b87:: with SMTP id b7mr27295214wrt.129.1621959786932;
        Tue, 25 May 2021 09:23:06 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id m7sm17267084wrv.35.2021.05.25.09.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 09:23:04 -0700 (PDT)
Date:   Tue, 25 May 2021 18:24:33 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 0/4] pwm: Simplify drivers with of_pwm_n_cells = 3
Message-ID: <YK0kwVVTX86f8lzc@orome.fritz.box>
References: <20210424210718.2787498-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hTeeQED8qmvjf+s5"
Content-Disposition: inline
In-Reply-To: <20210424210718.2787498-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--hTeeQED8qmvjf+s5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 24, 2021 at 11:07:14PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> this is v2 of the series sent earlier starting with Message-Id:
> 20210315111124.2475274-1-u.kleine-koenig@pengutronix.de. (See
> https://lore.kernel.org/r/20210315111124.2475274-1-u.kleine-koenig@pengut=
ronix.de).
>=20
> The only change is using
>=20
> 	if (pc->of_pwm_n_cells >=3D 3) {
> 		if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
> 			pwm->args.polarity =3D PWM_POLARITY_INVERSED;
> 	}
>=20
> instead of
>=20
> 	if (pc->of_pwm_n_cells >=3D 3 && args->args_count > 2 &&
> 	    args->args[2] & PWM_POLARITY_INVERTED)
> 		pwm->args.polarity =3D PWM_POLARITY_INVERSED;
>=20
> in the first patch which is semantically equivalent but Thierry likes it
> better. This targets to go into next early after v5.13-rc1 so that it
> gets proper testing before entering mainline.
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
>  drivers/pwm/core.c             | 44 ++++++++++------------------------
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
>  drivers/pwm/pwm-rockchip.c     |  5 ----
>  drivers/pwm/pwm-samsung.c      |  3 ---
>  drivers/pwm/pwm-sifive.c       |  2 --
>  drivers/pwm/pwm-stm32-lp.c     |  2 --
>  drivers/pwm/pwm-stm32.c        |  2 --
>  drivers/pwm/pwm-sun4i.c        |  2 --
>  drivers/pwm/pwm-tiecap.c       |  2 --
>  drivers/pwm/pwm-tiehrpwm.c     |  2 --
>  drivers/pwm/pwm-vt8500.c       |  2 --
>  27 files changed, 13 insertions(+), 88 deletions(-)

Applied, thanks.

Thierry

--hTeeQED8qmvjf+s5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCtJL4ACgkQ3SOs138+
s6HBqRAAjuavQltVJvYibr22kzFrP00aj8PR5DLUn/dyI0ZRQURkwSwbiKT+mICv
XZ/KJwKU50BadFPi96uEsZAeLzZWvMp/R1IVwS67ECc8dxbZATy73zwRQZFdyh0r
wxM4aIRizx26jn3PtrNDKcpY0bkRWJaPkIYsvG1vRwc+LinTv/yc7sEOstWvT5tG
ekZhQUCmaQMJwYBV9Igg6H+SatyQc19QSnaSbyxQK+xdRb0rIsfPW1H4yDaGrwjk
62bAwO5qfiKYwunmo21psiUyinoYdQ5AwfwYDsVPZC7nUZeOyIoK0Nk2mJZwYwAF
bAm9JZhImSrkZHQ5agA04CvfFxsq9ihm3IjBYTZJYXPMUbueXEGXMWctCuQxdtb7
oKyoGU+GGu/t/qr/cW5KEzZUUHE4DCpZZ8uSouJxTxW37/DfrvSnrCwHcNokoK31
pgJWRB0t4kDnCcSQOXOK87MuY2EmR+ZbDC2/yx7eRk/npzsK6Z93LFcJGmvAWc82
v+Bi6phVnmwU3rDMVvbUMDmsLNQNEdrupGMap8zqNi8uNkeGItCni/XluRFX+TtQ
PCVdyCPfgPPgClB1gdNlg17J2Dfm1eDE5oS/19f212iW7DmSFD339SliZ/tJUk/q
6MJGJDW606siN34LTB+3t3Q0rA/X2W/kZRpPEqW+DSK3f8QzZpg=
=0laK
-----END PGP SIGNATURE-----

--hTeeQED8qmvjf+s5--
