Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9FB2AF962
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 21:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgKKUAQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 15:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKKUAQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 15:00:16 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E96C0613D1;
        Wed, 11 Nov 2020 12:00:15 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r17so3756206wrw.1;
        Wed, 11 Nov 2020 12:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tJE+qKAXrMttXhdl27BZUutECGtRZIEzEE5j9CDRQ7Y=;
        b=Qk/DKr7m29Bg2Gv+sFToYs5yx7tZoImTYHpJr4UU0a8ULkXna2TGFXkO4eQ6gOHT6w
         rKzGFPtqZi3PIij6Btu8MSzkfYpi1St+1OuY+rTbhnLv/fCVRkUg224ZlGv1X/P+qGEL
         sXEuPuBAocYmAA+9n311FZq3xoDPpaonp9HOYmDj0B5uebpTzrvr5nQDOTBVOxHuAta4
         Bua9alw7Ap5emTBoDktkss9wJ4VBsqJx/CZKEusLphtu1xW3WFr50YL7bW8zOOae5GPP
         AcaCLgf6eaMnJ9mA9HyP/LDpyu3NnnbsDiIw3qggY2gz+N3X1RJtYsqoftNtFxxKACm7
         tMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tJE+qKAXrMttXhdl27BZUutECGtRZIEzEE5j9CDRQ7Y=;
        b=P/u+xVYDIfE1pQLQqkem/zXri3p5G0KbwPFgAZJWTeeAKY6Q2Np0H7wmc1+C7Zx5jU
         fe0pWMaGhlmI5/Qbvb+q6gJKx2lecoK20xNEcxCG/6SS4VX49zcsrB1TvyvdAYJWlrcn
         38CfWw1l1RqHBqVTTWjdJ/ZLiNo+sqRQZ5Dz5I5tf5XIm4qRbK5F8lmVl1T+X6mW1Ftk
         U/6Jy1TFGMa/9FHPzdgfwbnprboYpolL2pMBezVp7083Fr/o8SyvoFdoruu8tYV0+kGM
         p1Hkinp34x8hhngsnU1HiUhnjeDTUIFY25sL062U77IRLbL3ycrXQg7E+1uJWdldMuFi
         ynrw==
X-Gm-Message-State: AOAM530cFjkm9MZpWWucSY81Mlqy8fVSmqsJuH4bYOk1Ix4ol41XuQ8K
        9SKGSthCRNT9PBqw0PY7K/o=
X-Google-Smtp-Source: ABdhPJyhyZ65LpejTI2ODC9N+g6AecxU/6GGwQTPtERROMfdJm5/9Ns+0NJ3Y8AOaR+jQR7GoFOcrw==
X-Received: by 2002:a5d:4046:: with SMTP id w6mr26262375wrp.51.1605124814454;
        Wed, 11 Nov 2020 12:00:14 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id q2sm3807260wru.76.2020.11.11.12.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:00:13 -0800 (PST)
Date:   Wed, 11 Nov 2020 21:00:12 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: tiehrpwm: handle deferred probe with dev_err_probe()
Message-ID: <20201111200012.GH6125@ulmo>
References: <20201030201254.24557-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0OWHXb1mYLuhj1Ox"
Content-Disposition: inline
In-Reply-To: <20201030201254.24557-1-grygorii.strashko@ti.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--0OWHXb1mYLuhj1Ox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 10:12:54PM +0200, Grygorii Strashko wrote:
> The devm_clk_get() may return -EPROBE_DEFER which is not handled properly
> by TI EHRPWM driver and causes unnecessary boot log messages.
>=20
> Hence, add proper deferred probe handling with new dev_err_probe() API.
>=20
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Applied, thanks.

Thierry

--0OWHXb1mYLuhj1Ox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sQssACgkQ3SOs138+
s6Es6hAAkcm4s47CNuSVr+gkrq3JUtXW9SOOMmSVlAyLrAEp2SG2fBeBFwT1JNSN
cmXw0aAA5dma9CW1DM+50Ay1BksqQqH5mqfSU5zrjF9+nBVBNtvE2KLFq1HbYZHC
ElZDwW3u5SDComUnGiMhtHaKIGDv+EE9pHAqbYYa5YqECzKGlASXeqMDu7IIcn0f
jUy1530GQHYbHlFtMn0P28Oj9oJfZMXJlhSwylTXHd9XORH6CugSINF4miJy+IU5
dDb11/mIlwBHI7HqULJMHKMnVi2hIWuDTd6muz5pVqjzzTHneKEBJ8bmp8R8qmU1
U/G1ZS+027S2EL/axLIQYkP5cIod/UatR4MN5xGznAUqIuEmWJAiSOAfOc+bTDwQ
lAdv0gPisgbDtHlNmKM/UxFueLw027taaN4ADkH7e4h6XxYjRsI+z+U0Tav8Nxnw
LTmL1LNSGf199fhMvl3WeIrp25qOI3JxBab47SNM+2XKJs/tWQRVonzFtB0BNfuV
kwGIxz6PJVgfymiIFXcmCiPs7DeGG1g2QW991EGdVTwHC+Yg6Q5juhFX9y36NaOk
YyxdA/Qyg1l3MHNjpctbUS6slTPQZUEdIQ5ldwNeNtZhpNApOg0IizsEi1dUs9QP
knPdOHGg9HGrjzl6KBjav40pWEFqehv7bHp/bBSaESbw2P4mR6Y=
=f2rv
-----END PGP SIGNATURE-----

--0OWHXb1mYLuhj1Ox--
