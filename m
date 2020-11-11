Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B902AF9E4
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 21:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgKKUkt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 15:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKUks (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 15:40:48 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C58C0613D1;
        Wed, 11 Nov 2020 12:40:47 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id s13so3536835wmh.4;
        Wed, 11 Nov 2020 12:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hm/JpldDm4OEgny1ZiHo3axczA8h9lw8g1XIfych0uA=;
        b=QziK5x3huraePsrO12bMjrdO1q11zknUXfZB7lkf9WDqd4tUtLpbp7wiWRYD+JwnOo
         N5PyLaOuOIcwAUoTK1GB/sSFqItOSwY43fTzNaks8X+h6XQs0RTcUiQ3QGZQnqyYT6yh
         +feX2KUPZyEh287H2dTft1e1uTNlDRgK0uW0sSgvsNuS5GBtgSyotmENVV27enOYIlUD
         gRk0sV8eMelcUO7r/c0FfpPZ2toK/9DdhJ7AbbpmPwKHVYmSott9yxabNu/shi4tKdQI
         l/+6FAyo40oRIRWrCRFqYliE6Qf8Z5GHmJxCjXwHwn1j2I1PJQ5nsccgL/K5u56XM5Vk
         MJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hm/JpldDm4OEgny1ZiHo3axczA8h9lw8g1XIfych0uA=;
        b=GuhGy0/NY7v2LpcNUpgTzmvfIDwLfPU90f3EqdP9KnaQLGhFpODKYaRuPY3gAtCSsC
         D3cj9s+Eb2MJLAqMSrpFdA0GryvbGpAbHHJH67Hs+zBbB7E+56i0ReItmCa5C92ZfoWs
         k/Br4urqXJZMuGrAnwUs3hfd6MZboHxcmG5L/Jo5FjRiJj88VfFZEv9HSUGE3+eoGBuS
         x+FNlPIvy/m4dXISidiMTN2rEaGBvTf9p7s4ybzMOfLcFu3oZY7/p3D8KsbRitk4iups
         /JKkBf/uZVem21tpq0gDl2GMtpnSX+WEqtaGeyImua4elQ0lj+P4tzNv0xbU01Zf3LQA
         6wWw==
X-Gm-Message-State: AOAM5318Kj2p2QQgRJqfHkJQguOeKYHf3emZBFFdaLk8EdIo6EPyAo/6
        5vHPDYelcnSfQZl4/W2evGA=
X-Google-Smtp-Source: ABdhPJyLYBLNacs092MfNlwWJsGDf7s5J+dgBZ4ad3lufgXmAlCtCBXABhYEyhMqzVS2kDIV2hqeiQ==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr6309347wmi.78.1605127245686;
        Wed, 11 Nov 2020 12:40:45 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id j15sm4210882wrm.62.2020.11.11.12.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:40:44 -0800 (PST)
Date:   Wed, 11 Nov 2020 21:40:43 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, lee.jones@linaro.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v15 0/2] pwm: intel: Add PWM driver for a new SoC
Message-ID: <20201111204043.GO6125@ulmo>
References: <cover.1604555266.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kVcb4xucqmsYUpQy"
Content-Disposition: inline
In-Reply-To: <cover.1604555266.git.rahul.tanwar@linux.intel.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--kVcb4xucqmsYUpQy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2020 at 01:49:38PM +0800, Rahul Tanwar wrote:
> Patch 1 adds dt binding document in YAML format.
> Patch 2 add PWM fan controller driver for LGM SoC.
>=20
> v15:
> - Rebase to latest linux 5.10-rc2
>=20
> v14:
> - Address below review concerns from Uwe Kleine-K?nig.
>  * Add limitations info about fixed 2-wire mode support.
>  * Rename clk/reset _disable function names to _release.
>  * Remove clk & rst from driver data structure. Instead
>    use them as arguments.
>  * Add pwm_chip.base =3D -1.
> - Resolve missing MODULE_LICENSE warning.
>=20
> v13:
> - Address below review concerns (Philipp Zabel)
>  * Make unnecessary 2 line comment as 1 line comment.
>  * Move reset_deassert at the last after clk_enable.
>  * Remove unnecessary return ret statement from .remove()
> - Move platform_set_drvdata() at the top of probe.=20

Uwe,

you had concerns about v13 of this. Can you take a look if all your
comments have been addressed?

Thanks,
Thierry

--kVcb4xucqmsYUpQy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sTEsACgkQ3SOs138+
s6F0hQ//c+xpl0v3szV/zRkc3zKiV3TB85jHifUCleXO6DLDpsu9Jz2plr4jmUet
Bop1aM6rd314PLbN3HBfpcND8wqQ8VhoBMY2Fb47uIpdwD0xGmulb2JPJquc0RpR
NSock2udeC4gKSDDAZR/OlRhNxhJb/sPPk4PBYjY/4fSDrKXKkSTmanQeouF780P
2HKoGbmry2QZylB2RG1ugyZWTguAWdlnLacIzpcxiVaTlnDOwndRu2C42XaE2Uy3
vxFLvhaNZ555KMZXQqA9ojFfvhPpMMUfON8ndf08UXuQn4ncdt9mmhTiTg8VEFME
vBzrnXj8S5MjrWdc9Dk4QfZPYiY4LqVKZTigybMGSG2TyogZqLso9WXONA1A15zI
0tEZP1mc2NtoMDV8GzzruJuNyrU4LhGEaIYHs2f5nMbiux2ULLUM8z3RUSGqKW4R
lZfVA3SWTSf9EGES5jQOZ6RcloMshExrkdM60HAS8KIUw+2q8T6082yIupUwjYJf
+FMM9vwesgZnLCP8FEv8FvzOiPDtrxX4x9ec/kH6KOHItWxzGBGd41PjYFjGzRi3
wcuzTxysQAqWZK4HQGRTsb4lLSaiw+tA5tFF0oFYDGt3lEHy1IeCDMnQHW6WWQiC
oI5pqLRokRn75pyQatgxmUvQ6GrrazdmvX2iOOOY0Gmzdh4z3gg=
=nTJP
-----END PGP SIGNATURE-----

--kVcb4xucqmsYUpQy--
