Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF08359EFF
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 14:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhDIMpl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 08:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhDIMpl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 08:45:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242A2C061760
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 05:45:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 18so6414538edx.3
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4kTBax8RvGap0EwTOM1nxls8YIc1J4whtmxKd3N3Gtc=;
        b=Ri0ZkuzqaWCf/CD15TZ46tz0iGvl6i6B0TPjakgtuvQTxuYXr5OJIF/7JDs+mzA+dh
         oKHmSDGL85Bw6VBkWKm6eBIWgBJST9TF+38SxugJPGsRaJaDfRs0oTe4ZdtONWiIezaP
         0kgGrOkMH1IOMKbw5NUgWncOHLGiUIl3G2qxs4LQlRUzKfEh59Tj+WxG0zK71amyAbX5
         qXM3dhNcg4JIoiSBNWNqRcyIWz5H3mlUkdtw+KmcKgh+Y2jD4FM0RkZ5+JcG5qvXDBwZ
         2KE9ngN9Mc4sPBvPk0/peJtBndqH57KhWjeyr3Kk6zKP1asS3ECqkIGIQZy/08q7hMFf
         q9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4kTBax8RvGap0EwTOM1nxls8YIc1J4whtmxKd3N3Gtc=;
        b=UbLmT6XeQAYrh+f+rstJxsVvzHHcquIyQLDSK9OYvRDbO1Dybsh1twf2an5XM3Em6U
         7Ki58zRl9t3A6el2PI0kbhJ2liiSRBkNruu5DBCZD7n/WmocfFC4bdw5Kk2BMaBB//hE
         o8+sJ+G9K+1Y2dyVXfeEpSqAzQ5AM7FTczERgiMr1VDU8ps5jy1fdTJoGiLg6Pnx4K/W
         VhG3vFfYuy6Vm5zcGCiG4cep1uT+El0YkTU1jgAA6Zd2uBNyeM07vq8xtYVXQIaBcTb4
         gm6UiBgxTdIiGJnOrNCpIOQh7BsO0VuvE2GYg1i0cDf9X1tZ25UUixnwvYPHDWxWmaao
         g+3A==
X-Gm-Message-State: AOAM533WvRcm7kfAw3oLoaOTB1012LChuDbTcAiKPNjvxkJeB4eCT4wk
        UfeKsKthhkQCNhSA0BswszQ=
X-Google-Smtp-Source: ABdhPJyYzASFTk5GeBUfc3Cy55ykmbvhfERuZHv/DCvapsCxGvFIExThcwiJznzLrKwNC/yFIG7ADA==
X-Received: by 2002:a50:f40a:: with SMTP id r10mr17610343edm.200.1617972326944;
        Fri, 09 Apr 2021 05:45:26 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id g25sm1363844edp.95.2021.04.09.05.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:45:25 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:46:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: lpc3200: Don't modify HW state in .remove callback
Message-ID: <YHBMiVT/HCKYjKbM@orome.fritz.box>
References: <20210329064111.148508-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YOZDNKQOsUdR7Pzq"
Content-Disposition: inline
In-Reply-To: <20210329064111.148508-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--YOZDNKQOsUdR7Pzq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2021 at 08:41:11AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> A consumer is expected to disable a PWM before calling pwm_put(). And if
> they didn't there is hopefully a good reason (or the consumer needs
> fixing). Also if disabling an enabled PWM was the right thing to do,
> this should better be done in the framework instead of in each low level
> driver.
>=20
> So drop the hardware modification from the .remove() callback.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-lpc32xx.c | 4 ----
>  1 file changed, 4 deletions(-)

Applied, thanks.

Thierry

--YOZDNKQOsUdR7Pzq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwTIkACgkQ3SOs138+
s6GVxQ/9FN6Hz9ItdmXl/uztN8FMuo8vNn6utKlWoC1JD91naYzalIaX/mD+TPHb
3kQmlgxOdeU9hqMaiepij371v+LkFoDeJ2ubRrV091GnDAcwXE+N9EMxh2GV3CCi
oGt1b3O36+CIethjYbqNko+mcMLU970/9T+EE2EqEtbduPgDvSsuNA59V8Bez2UK
/msfTaKE9tCc14lR4k9hrSbss7wZH5NdQq1zyg7OAAaO+yT3mLkm+Hi8scpbB3sf
/vw/BbhBsMhGBvbCTbS2gSCkdzpIcP1QIQLjyyd1FTQndJqBRjkXmlA4F3bBrMUO
5Zm9VO4f/XcqdMl5Y7JpnN82JGQSLzwniuPk6gbH56pDQ6lDfeyhRbVSJ+bz92/Y
KGgksjfnXk+LDiR7yit4seK6oa6AzKz2ZdMPs09/UolaTU1fm4akT8E9FvT0fQyx
WfgYlVRzUZRITYREwgRBB/ab87qG5aCRTaNa6dXoSiaRqtiVCpnFMY6sobu6SQF/
84GEf8qaJfMXj+C19GDEKpKKIBiNRDfDP16iFsz3Mn6/M3OvlOe5et2YfCETGNuO
NkRF6sfcqNqV4Egnvwhx+/Gy1+4yxO3nqTY9R4qvxDD46I7u1gXG0kzLbblMJABi
bsRmcBYrS+gFmGvqyokprqwgmZGsI+BG6F8L7nI7JvWfhIfPsyo=
=p1A8
-----END PGP SIGNATURE-----

--YOZDNKQOsUdR7Pzq--
