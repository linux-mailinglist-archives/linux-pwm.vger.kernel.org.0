Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79690359E0C
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 13:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhDIL50 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 07:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhDIL5Z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 07:57:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D288C061760
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 04:57:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id mh7so8195245ejb.12
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 04:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5YQSfSezuRanlE3OTJNyHDneE2k5F65yusxloiDcdCU=;
        b=jgMayyoioQq/ujY9gTQ+BBQlXJXvQHguv/22ilyT23VxAmOKmo05o5q2Ftfq+OiwS9
         OHGgUHbEzlbV1DAuHskgfc0xwmTovP++PwC2Qnw7Iifh+eqVlu9J9vaWPEfIqG/reME0
         sB8SmngZbaTbA1SlL8QiCQtjQFI3sC+AK46PsRi151fG1DcQK5Facr4Nj/fvcfcycbqB
         IYtRf5wCFNRL3f29YpxlazQIzgl4+YzL0oeDzuN6eSdOOmHauMcxUYrxG8cMGv6wSSRI
         MwEflAwSu2nex/pZbehk8MIGHZfbB4T71o3/iUx2T063FucHKy2JAqcUDBOCPQwTtohw
         wUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5YQSfSezuRanlE3OTJNyHDneE2k5F65yusxloiDcdCU=;
        b=svOSaHLOIQhTamgx3xYi3TPla+tpzyiohFH+yBe1J2TDYBkeLWFRb+C4chDakShZaf
         L4eyhbWNTmtNFttZpIE1loYKg1QMfPM9iAb3OKEtatn1xlHvvUq3oZzzSCWTsdpYzHed
         lmfWnqWt4fO1TZ9WLK1rCHqLUY2aGaj97tE3wZgKvPoBDBukbUahEr4m3rf2qcTylnvY
         BpqwWj7ThjqH18fCJaxSOlApGMY6AtAncVMXCEkaHqW/b7OLgwKVdDawOXtoYF2iKpBi
         YFcpURbyBcOuZZyvOa9PN2Y9nIol6S9/kQpfbSjHJyOfEUJldn0p+6qdaXhXi1ARhCu5
         4iDQ==
X-Gm-Message-State: AOAM530362ws3dkveRXk79g0UHSa6D8RWOQa4mCdwdgT6dDTgZJuVFps
        0LWVUuBgLr/M/pS+xciKxS0=
X-Google-Smtp-Source: ABdhPJzYqcskT47zR9CQv+vZNkO7ABfeV62GnaVIaKQsb3rk6XlQ9cAPs6W1fthdvn9SiuBpR8XX7g==
X-Received: by 2002:a17:906:5597:: with SMTP id y23mr16089622ejp.165.1617969431915;
        Fri, 09 Apr 2021 04:57:11 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id o6sm1327656edw.24.2021.04.09.04.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 04:57:10 -0700 (PDT)
Date:   Fri, 9 Apr 2021 13:57:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] pwm: Drop unused error path from pwmchip_remove()
Message-ID: <YHBBOrhHqFdN2QxV@orome.fritz.box>
References: <20210324152058.69022-1-u.kleine-koenig@pengutronix.de>
 <20210324152058.69022-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ilt/HdPSflHjRMRp"
Content-Disposition: inline
In-Reply-To: <20210324152058.69022-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ilt/HdPSflHjRMRp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 24, 2021 at 04:20:57PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Since the pwm core uses device links (commit b2c200e3f2fd ("pwm: Add
> consumer device link")) it cannot happen any more that there is still a
> consumer when a pwmchip goes away. So drop this check.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)

Can't this still happen when a consumer forgets to pwm_put() the PWM?

Thierry

--ilt/HdPSflHjRMRp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwQTgACgkQ3SOs138+
s6Epkg/7BniZbYhgoRovV7Oam4MTnPWVtwnKT3Cgs2VMOdEA/RFNQEZCRUfeKGn3
9hg1xGhZBY88dTrEzO7GKlhGQymh7uURbq6OUVsBJ8QUkvhCOrYZY/DYPSM+1K+3
lpsCWj7DMWOajPUUpTGtJSF9T/jJ+miXCB2QxE42vMGjUyhT84zSPiQ4YV+aqmpd
8Tk+HgqX6sJr1wEBT7g68JCw2EB4C6V61i+6zZSXX+MW3YVRqg/1JZFFdqidvFwJ
SMWMzKL+BVHeVwS9C2VSOAaFWW/Itra0/TBAABvsfwQTpK/2wuVkJg4I9HhK80ES
NoRsgf0uCTfEoimVJBQ+qbZI/XNDfYyzlM337HDB44f01TKiMg+DQoODGDqQ1cAY
ZnBzTJWGY8LwJeAtomps55Bu9tF0kfSinWc/CAGhHC/5aCVBB7ilkITh0Dps0HH6
ASRaXJ0QEYhFv+9AZCvxyYf2EIjTKYS7m8Nr0bsm8fE3if1UWlz6OeKYQkOouEGe
GxXOCnZX66DdSuF9wcZOvWbU2voYzk+wYt5aXY/nvjIuh+/KRaDib1uF6AXm4FJV
INGaEkyywh6ySx/Oz4s9A02vQDYQ3cPUXF02MQKrtx7nunGQb5aHmC27NU8abRCC
zAWuYnxFsCgiLmAXlZaJr9MjVfooyjgYV3YGb9iwQ4SaANH8TKw=
=W/ry
-----END PGP SIGNATURE-----

--ilt/HdPSflHjRMRp--
