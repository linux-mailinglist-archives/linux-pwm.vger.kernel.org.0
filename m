Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD81322E7E1
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 10:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgG0IgD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 04:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgG0IgC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 04:36:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D24C061794;
        Mon, 27 Jul 2020 01:36:02 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id g11so4413523ejr.0;
        Mon, 27 Jul 2020 01:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H+xLAiBQ1pH8gECByy/1KrbQRjM9z76f1/RAtD3ZJ0E=;
        b=p3Q3J+WAI8nKPKPg62+INQcxywjWgw6SNOscCCt6ytYnSiEpotAvraZ+nDjQLPHiVG
         3WZdrdopCzSp1TR14OpmPqDZlqm8zkQoST6ni8oBJKZfO49SpA/95H9nhE07DSHNxyVw
         BUJq4rkDqDwckcJZBiPfQCooeB7GzgYQsNzuPh/Ivx0vT3M374PX8qfbz4d0du29353N
         15kEllK8b9B8JiiYRaZj7g5JI5krHN2rfdQLv3Qkw8WOT3dCOCcwlowds3ze28oh+Wjc
         WzRXKBiVmjm3d2zmHdvEuqtdGWizkdcYThxvepgcO+zgMLwBcrDeQKL5Hyq9HVIAZzFV
         XbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H+xLAiBQ1pH8gECByy/1KrbQRjM9z76f1/RAtD3ZJ0E=;
        b=cKp+Jxuym2XAkdHpn0KRHF5eTIg3yHEao6h9Ykm4M4+CdT2Q3q0XRT4CipgyUxK3Mm
         RwJ6fRdiz+EUq457lNNrrLeun7JmfqTtsQuS9XtEQMzwE+XgwZrKEDT6MWYzVcC0dmAE
         4PaJ359ayyJgt0UredFkzkGHIKTrsUR13ttAp1/tv2Tb2Fm8a1sie+O30eK9QAy9ggqQ
         1gDLWBkRZi7X3VjtIDFTwdrA+uWn2pFU5MRq0JMnKW1LF6x59Yy7v65ETjLEXaaeKnC5
         RiAwqAAhbeckcQz5/bg7/zi4VXbu5tIWEASuDeyjI3GUmQgI7Hew6B3/te5nxnemNSyK
         XUbw==
X-Gm-Message-State: AOAM532KGAkNjKzRbukjx4x2W7ZYirFVvbsi10YqjO2d0t2K4UvoHYzt
        7X6QKVKkR+FqBLBz66exR0Gh9Szy
X-Google-Smtp-Source: ABdhPJzdWk1CsONTYOmHqvIRydh45tHT5jOnPly71GQxjIWeNYG2gVBmch+OpkGCQOVzans2fCnw0Q==
X-Received: by 2002:a17:907:42cc:: with SMTP id nz20mr13567797ejb.429.1595838961237;
        Mon, 27 Jul 2020 01:36:01 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id h10sm6902925eds.0.2020.07.27.01.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 01:35:59 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:35:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v3 4/6] pwm: cros-ec: Accept more error codes from
 cros_ec_cmd_xfer_status
Message-ID: <20200727083558.GF2781612@ulmo>
References: <20200726220101.29059-1-linux@roeck-us.net>
 <20200726220101.29059-5-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Content-Disposition: inline
In-Reply-To: <20200726220101.29059-5-linux@roeck-us.net>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2020 at 03:00:59PM -0700, Guenter Roeck wrote:
> Since commit c5cd2b47b203 ("platform/chrome: cros_ec_proto: Report command
> not supported") we can no longer assume that cros_ec_cmd_xfer_status()
> reports -EPROTO for all errors returned by the EC itself. A follow-up
> patch will change cros_ec_cmd_xfer_status() to report additional errors
> reported by the EC as distinguished Linux error codes.
>=20
> Handle this change by no longer assuming that only -EPROTO is used
> to report all errors returned by the EC itself. Instead, support both
> the old and the new error codes.
>=20
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3: Added patch
>=20
>  drivers/pwm/pwm-cros-ec.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8eke4ACgkQ3SOs138+
s6H7tBAAh58Ngu1hLcym7p1Z2mX0XksBPysYjynk4RvIe3RQbRGLOohuXfq0WAn5
ZhBVjcuIB0VJ8L1TEioH2ErYLp6XVVsOTKx1krKxlxV5eKB30IhX2zJyjziXUtIj
HlIqARKkwsJRqk/OhqSwgtdz8vlExufgn1Y8JTbQMNoMRdBfW/GHjPItvBHtbeZ/
mxrOzlNUSUrX6syPy/KkY87i2D9tCwvXssnNh2LMNcSz7ZFB0ca1HZD5tODRRjPP
EfOG+CRPHoB+H6/iYD0P7PaAZACRR/ski38HA9XehRR9p9AjZjx9X+zW4O4wM8Mg
89aFGsH7UZGUXH5R0BEwHkQMfB3Sxvk5pe4aHVWRwcHOA6JXMeqa1Cf7Q++4RTm/
G+/2tGfjqlBjmGNDbsZ+DMM3xycINg7r673bRZQ+ArbXFPMDRi6jSoQNTu1wiSeW
V0cngps+K5oDJ9fl3mpckjuRu6wkGAYNi2vOmRveuM7alk8M8k4vO/Ws695BZuUG
B+ctytEzW2jwRUv1SqCItSgVbmYiJdNG4RNE5SX9OcTezqrZ9xSdabGQL54chwUr
YQ/nGDDiQB90OIs5Xa9eZ5zgKXP7HMYKfqegxE0ULPRthDq8vqle8mKQOxTZjypo
rVzzlpkjjgn5+q+r6wE1AOXZN+aKKhbI9ARGECF8Nfxdvvs0sdA=
=dYyC
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
