Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44ABCBC625
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2019 13:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504520AbfIXLDd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Sep 2019 07:03:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54212 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504519AbfIXLDd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Sep 2019 07:03:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so1735542wmd.3
        for <linux-pwm@vger.kernel.org>; Tue, 24 Sep 2019 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aPNewFKIabAVhRulRTJUvJ4LCImysX5uKq9IsVOhhLA=;
        b=W9b6Tex2B0d5oKFyO5nC27hRGVFVPMraKPqpp1KUzwt/0urbvgAxUehJtXyI8LPDZw
         +7PfvWBDKZyTFNuSJdHG2bdeWwYOnU71mobzqlCyHc/AOBR07QuN2zP3DpyDfvoTKel2
         uc9U+AWKjkke5gwsXsnxyII5CYEKT5Ee+/0MteHJlYrH9SA8ZTvHUOlGJ7Vce3sSd8Fi
         edE5FPXB/A2a+UpJDItdzezSL4DsumwVxrqaSPlFFU341eshliV3FJf4O8lNPyW+nX6l
         GSC41YX9Rs2KLAPfmwqHNFYfyompuYbXXqckc9KFJ4dK5Hv6Wq3CkZewrDv6dhKi4gB6
         o6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aPNewFKIabAVhRulRTJUvJ4LCImysX5uKq9IsVOhhLA=;
        b=W2AJybbU7HSCHjOERdTdkrbyic1YJC7t4wINPv0g9gOkBixSJFzG4IZDDRlYduPQLk
         Wv1kFroH7/nHPr5cR1mh4nljeKFyeGMWoMdCUomeySPLBHxJ+P3QPlZ9DogoXPJ1SjIt
         Sl+ArfMTj1tT68c3wuzZpacL99Dfz/bQqB46tTaHdtnpX6dIJODwNqqEKjaSEjK5AICM
         ey+E/m+LDCjwP+yzoym/eFq6PMMQP/qQcOMQa3h5c9J+VlcH0eJXIuSKM60K88k9O+rk
         FtG8kxRgGTzAzMmGT+461xP0FN7gqb9OFQlbZ8C6GBXJTnYy7tvof+u45Nfw+LloWZLC
         piVA==
X-Gm-Message-State: APjAAAVi95hB7oSOsefp+P/SG44MGhovxHcGfn4wqy2Ig43NoEoIC+K9
        3qmZSIX1sE1TtWUdaN3Ms0I=
X-Google-Smtp-Source: APXvYqzYpAePGifxHHlgdTIafjZamW84yclGMJ8dIOkZtiOwDQ9MOF5eu8ME/cvTsu3XQRnW9qSTwg==
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr2345783wmt.81.1569323009569;
        Tue, 24 Sep 2019 04:03:29 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id a6sm1716327wrr.85.2019.09.24.04.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 04:03:28 -0700 (PDT)
Date:   Tue, 24 Sep 2019 13:03:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/3] MAINTAINERS: add a selection of pwm related keywords
 to the PWM entry
Message-ID: <20190924110326.GG14924@ulmo>
References: <20190923084937.20358-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline
In-Reply-To: <20190923084937.20358-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2019 at 10:49:35AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> This is just a small subset of the relevant functions, but should at
> least catch all new code as every consumer has to call pwm_apply_state
> (or the legacy function pwm_config) and every PWM provider has to
> implement pwm_ops.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

All three patches applied. Thanks for volunteering to be a reviewer!

Thierry

> diff --git a/MAINTAINERS b/MAINTAINERS
> index b85f2abfe69b..2e8dd2ea4eaa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13254,6 +13254,7 @@ F:	drivers/video/backlight/pwm_bl.c
>  F:	include/linux/pwm_backlight.h
>  F:	drivers/gpio/gpio-mvebu.c
>  F:	Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
> +K:	pwm_(config|apply_state|ops)
> =20
>  PXA GPIO DRIVER
>  M:	Robert Jarzmik <robert.jarzmik@free.fr>
> --=20
> 2.23.0
>=20

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2J9/4ACgkQ3SOs138+
s6GAJA/+KAXbZrvmE4BhxjVt6j0+Z+VsP9oculsxeVlXWrvZoklv+7C5URh+jKBg
BO2KsOJjUYFlpI6smIhBrBHIIGrAd35Sastr5uYYn330jkG+bPTjcfx9oon/bPwA
tYHQfJAs64dgE5nSNnp+S91EYO9BuAt0Qsnng13XXPazyjkOVzTp24IMXGLMkG5y
5b8j8Jl3JIqc8AhZIHYru13HACOzdwGA74C2E6hRZzo2lykzqPsROTOc5zOsdwBv
SVcm/Zcte2Vz3QdrjBORfLsWSqNyG3e/SDguNQKYF3qEIEgD1l+IpIf5aafGLPVd
dCwOncRFTz+gFCYFX90bshfmnp5YKCyTwVMAGk6VMjFtqXDAD2MjTVWmAXBByavR
LPR2LsFcCohv3dLTryrha4nUjZwlPQrkhPtrSpKEZi+n2AgAv7ITDe6rb1dNP1rA
6/PwHHi/8udAlIaR763YAAcyGbTOfNPpgmbIUVZt5s2SYKUo/crpQEyGwILZTpeK
hcXTpvtrIE8YNwR6d5nZ1ELbCBiNkpTOCjk/Ospitp0sFoX93sSts8B4WUd/f6ED
46frDDYK9Gw3y1uEmJfZGb5CLb29vkPab4BmRdZxxprtkttxC770/sS/3u51uGkf
GBKLNroYESED770h0LkZZU4WJAFnkx1nZNiVktpcjXEz0x07HBs=
=nVwz
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
