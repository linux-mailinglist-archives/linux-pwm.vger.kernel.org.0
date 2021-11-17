Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2624454AC3
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Nov 2021 17:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbhKQQTM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Nov 2021 11:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbhKQQTM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Nov 2021 11:19:12 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45960C061570
        for <linux-pwm@vger.kernel.org>; Wed, 17 Nov 2021 08:16:13 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso5241663wms.3
        for <linux-pwm@vger.kernel.org>; Wed, 17 Nov 2021 08:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PtTzqTq/7GodRS9KB9hb31/c+jAATdaH0524DSOISYo=;
        b=VP8SJe1eABY8LFPDx06aSojKjZNvdXZkZFvmxuB423afz9nn8sWKCAcWAaC4upkIyb
         8FthXbEfX8dBXNosuD8X2kRoYMVTWzy4zgc1TRQjbKBsJHAc3XTIB1YIo7HLokoLi8+1
         vipV1Bjpj+7BypsO3866P2WuNuxHN+P+TPkzoz5Dy7aaKDRQRCTVTK3Ro0hG2qVgr6s/
         dS7uB0EFA9DEP1YNPOWjPjzKFax0MYILa+XbnUvFqfR6chVfm2m55QyOCAJL2zHEa1Gi
         ESJoQjwKt6UgqonlcSoucmeDMP00mvo8QXT+T2fI2NU2HqLOODkL8KldETucra8JBVRj
         c8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PtTzqTq/7GodRS9KB9hb31/c+jAATdaH0524DSOISYo=;
        b=mxgri26QhszN9Z3CGepmSYkk+kj23cl8x+H4oC15nXVRqQp/LLA7ZEt7tUtATikyNW
         WUoAuyxnQExfLn3UiGg0ZXevQwRBzV8nfJxFn4TBvPRMg86IMmh+nDfaG/2b8Wa8m/vB
         p9JHROCM4hWKi6AE/WiyoDld+Ob9wOLhAXEwZD4yam9OYmFXdxDPupnxWaM++4TUkNf/
         fKoBhcwcnZo6x2635BeWky+4rWnTqgmHjwKwPOlHdNPPwD2q1sMO2rrNDI8HxS/MzQp5
         yn4O866rVRZt2L4n6Ef2GcQsNBQuc9kWekmBajbyxNIwZ2WzeHDDfpKetO5ko1X8t7LM
         FfDw==
X-Gm-Message-State: AOAM530H1KNFZrVXgoVgLrb/A3pSQtXLF+KWm+1QBuitYAPvmZNCJaRl
        KB8mWz9VqYZWyG3fldbxfRaL62Rx9rTWdg==
X-Google-Smtp-Source: ABdhPJzjGKrN2NWquFVpIaXH3+LPve3S+7MQATdp7vhTwS40clcn6lH9cN47Jd2zE088lDZ7202j2Q==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr947405wmf.143.1637165771860;
        Wed, 17 Nov 2021 08:16:11 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id l15sm115664wme.47.2021.11.17.08.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 08:16:10 -0800 (PST)
Date:   Wed, 17 Nov 2021 17:16:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        Tony Prisk <linux@prisktech.co.nz>
Subject: Re: [PATCH 1/2] pwm: vt8500: Implement .apply() callback
Message-ID: <YZUqx2ncECAo7fuT@orome.fritz.box>
References: <20211102092804.296089-1-u.kleine-koenig@pengutronix.de>
 <20211102092804.296089-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opzhRadO+hn1DJh7"
Content-Disposition: inline
In-Reply-To: <20211102092804.296089-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--opzhRadO+hn1DJh7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 02, 2021 at 10:28:03AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> To eventually get rid of all legacy drivers convert this driver to the
> modern world implementing .apply(). This just pushes down a slightly
> optimized variant of how legacy drivers are handled in the core.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-vt8500.c | 57 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 7 deletions(-)

Applied, thanks.

Thierry

--opzhRadO+hn1DJh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGVKscACgkQ3SOs138+
s6H6iA/9HIE9/ozbCdsqkTp/k9YtPqHNSJuiAnnHMISVyeFvOU3wfgjK5Rya3S5y
iT2b38Ir9bibTD6WKgBgEZkP6ivTrXkgFHY5pPVq/R1kWdgYAkg1cq68M9GYlNS8
2EYyt8v731LH+4YEK4uyL37oFNrkt4/h0H73pQepMCYW5VXWWCBo9iGUWCyD8z04
9Ubt9/3g29QCx3NO5vKKHYvId+c5455rgjaGf9zbVeUe4oMsf2jjokxX7SkxzxGR
WuJabDeLIJ8DW1BoXmYGhpM9T04LzAHfRodjnIJOMiS52zNT8V8U9tJoQ2n9PvrV
5LZ8xSP37Kb/1cCensRW0qTrYbpFf0qoJ2M8Fj10cMRWDlORE72KkLwXoLVUDTdD
O4GnhZAK/t8Oh4QXS6Mlo1M9vBY3DhFi5Pz4H4SG8WpjWoLG4AlJA/zzTTjLb3vQ
ZN0HV5flLVBYIdS5LWAb5P3UjqAhV1J/hra2nWDWQfbvQ2DUqgdxw9MoLb3MDk94
b6xAhlGyCkFt0EC1XO9+M+Vxmvr0omCMA8adjeHaORs+DBv36mxoornl6jfS5rjv
1ZLD3ReQbQmX4gKZ0qeKjMzW/ZoVdUrEyCXav7LLnAp869FHKF8QHcs1u4PbtyzZ
nbCZPHS4GlGJyPDdq1nfEHwKG5TLvbr8x/uBifzWyZA8s/O9upY=
=owdj
-----END PGP SIGNATURE-----

--opzhRadO+hn1DJh7--
