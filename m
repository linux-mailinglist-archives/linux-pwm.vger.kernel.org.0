Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101371EBBDB
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jun 2020 14:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgFBMkJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Jun 2020 08:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMkI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 08:40:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E876C061A0E;
        Tue,  2 Jun 2020 05:40:08 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n24so12610137ejd.0;
        Tue, 02 Jun 2020 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pnkbE2uBubmbsQ93vSdhuAVLA29ePPmsNN07Qt9DHJ4=;
        b=dYsfrN7LwYJdkBm0nZ1qPQHkUNeGceflDzI5C5NUoLIiZvmiZpWFc/mmvz6qM3A546
         /5G/DdfN6Fg7pJ/64PoBkDDacuYGmPLFyoa4RbNvSIoU7w8rWqRVJ3lxBvGe+S/i0UYD
         6iliy99FeqPecrqyPhTWDxi57Bh0r7g21U11O5jYSVleisF4GZ0k9xl02xK5uf+FAIuO
         +UH2SEnaIXNdaGfuINUDDJ2CSi8JhQnS5Um2aqFgmbbPy5RE1fxA+70wAVhFoo7t0KfN
         saJOvarvOlt/HnlsrlRRlvB9tcD9bYWuRv3vYg08ILqVox2Iyxml5oYoM8QCFsvyPI1G
         8ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pnkbE2uBubmbsQ93vSdhuAVLA29ePPmsNN07Qt9DHJ4=;
        b=djjKYeVuLKGy2NfqlTMUfx6EcQ8xqFEFqxLIYLrKgXrNiDiEaBI4GYbvgBZ1Vbw/74
         GO0ntF7f8ypY9va3efRksgFC+phmvZCxG6JqmgrFFrTtjPYeiTnf7zjhnzuVQ/LXtKTv
         U7Fc4MbJd4bTqanUijFp+Zj/mFp3kYGw+MGpGMZ+5mthqquXf5T2X6aI9X1DMO1Ve6wS
         cKH4hR/SH2iCtkflYZD7zecONYeT9L0LMY6pUpnmOtg/0QIpJyTryY/aqJ70YFdRklIZ
         46QGVV8kzTCPDuBd0m6XKc6uFYysPF6MTBD9Y8BznzugNliNIUTJfKXMAljJRiboGSRm
         mosA==
X-Gm-Message-State: AOAM530crT94CJEbL5OK5SKzvOgjqXrV+88T/Q7oaasVpe93SMgyGpYp
        e0Mjl/h/drF1nGIwDhzX5g4=
X-Google-Smtp-Source: ABdhPJz4LZjAT+sYrMfbdPxp8PF2QaCCD5/7pLVxD/qNvvvB/GiZeB2y1VMgWBQYjIBc3hOGpR7vVQ==
X-Received: by 2002:a17:906:4d04:: with SMTP id r4mr22460219eju.317.1591101607207;
        Tue, 02 Jun 2020 05:40:07 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id cb6sm620637edb.18.2020.06.02.05.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 05:40:05 -0700 (PDT)
Date:   Tue, 2 Jun 2020 14:40:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Peter Vasil <peter.vasil@gmail.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nightwolf@relghuar.net
Subject: Re: [PATCH v2] pwm: sun4i: direct clock output support for Allwinner
 A64
Message-ID: <20200602124004.GB3360525@ulmo>
References: <20200428164150.366966-1-peter.vasil@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <20200428164150.366966-1-peter.vasil@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 06:41:50PM +0200, Peter Vasil wrote:
> Allwinner A64 is capable of a direct clock output on PWM (see A64
> User Manual chapter 3.10). Add support for this in the sun4i PWM
> driver.
>=20
> Signed-off-by: Peter Vasil <peter.vasil@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.

Thierry

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7WSKQACgkQ3SOs138+
s6EaEhAAm/NQGeJ/IOWtqrbF6KZ1hxhFv6kLldfbKchk0A0Rhnebp1FqHYMkQBwu
/KzAQl8/ZLrQMM3oXqYeKEWW+sSowB/KyICk7Ynx/RRJjAQiBsdOjfANNvONeF56
4VOWkiC12fHm7l+vOFWtQttg8ShAIoKQQM/XQ+Gj259BfdAeSs+Gv+7FL9ue8pTI
n6iM9g68mr88CP2XkWMPsMhaSAE21o7UEgMI6y4BpHXETnb2bmbaIHPoWJB2jx/E
rLpCN6iQTkxrgtV/mU8sXggejhRDqTWdq9aueNt3dEDj4o2eAayIJy4Rba4zbyb/
l1C+6qiuT9MQglKbmY4of4FXWt339nfgtgXJL6aHRJob1ROu/OH0hVmW/jDfJV64
C73+XaNUyfNUqgNc2Q+5B/xNCuRa7cENLhA8j3vu+gKFIlSMHVpD35ISBr/DSQwR
qEBPZ2ZDW6TmqUxr2ZLuirW3SXV6jVngsMJhDqAFSWEaLc49MjIi3LG9ItEQdj6h
h2OTJPS+IE3JSTKkX90e9BA/QEsi+f/SP3sQBpxetXYn19eUliLXMzIKv0V/rWUc
L85/oyvgT1n8PVbc7O0hMEgqoRxwth9R/EOtozadIlceBw9zdpRy3lp+aO4DL8NR
5mOiC5GtWuBmP2/l8/edwhneBVDCQQP2AYVZ6vm29XVX5Glklvs=
=FM1x
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
