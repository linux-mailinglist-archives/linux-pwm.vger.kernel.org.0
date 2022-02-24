Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54A64C2C3D
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Feb 2022 13:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiBXMzr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Feb 2022 07:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiBXMzq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Feb 2022 07:55:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2B4214F86
        for <linux-pwm@vger.kernel.org>; Thu, 24 Feb 2022 04:55:17 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s24so2689077edr.5
        for <linux-pwm@vger.kernel.org>; Thu, 24 Feb 2022 04:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NI2jH18vr8LZIZZzPgzzMA+ZgbmTn7Ry00NHEfOpo54=;
        b=FdWykswFmhAHXmHdB8vWixPUbfm7cx+6NYWo+P7mBB4GC6fTyvyV9hVOHIx+9zWx4Z
         PNlgFYuDl9CETyX9AGHZ0Re9SMBUkH0CMZQn2l3b7BdoZUCs4D+CyvagNVj0piGd1i28
         3GXFb6QA1whrkA4m9s/O8PeesimhgYJNQ3VzRw39I00t8ejXUY8L82SXeE2GFvsu8fNL
         3UZwmF+shFAY3UC1kDqA+gl2JF+tJkSOx3TWWbcjoc2YcTY7CBhd7t+eJTBWHD8iUFRQ
         PHMl50Eu/l2gj6W3ypSMCw1aA0eszl6MMpcC1Ad3JmOU9lqGcYZy6ih5fWK8CG+pPWJj
         hV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NI2jH18vr8LZIZZzPgzzMA+ZgbmTn7Ry00NHEfOpo54=;
        b=xdcIjsBqCoLZvGutvspd/WL1Dp8FgurU9lXjDJ/HP5ach+sNuDclgv+n549wvr+4qL
         2lsZsP2Sobl96k7VIEU8jBHx9w1bqOJbOEcdunHM2J/R2byvZUEKFIv1ja2hEwus3dOA
         xfCJzlYXcywJZrl672RrnzYJgaiemDgARZll4c3sRuxDYeunbHkp/bklonHx0Od2SAMd
         q6w14scWlwrpls+PT1KGKH12lPdCanl/Sqt0RPoEDE2Iix4yBUXe8BAWuVbY/xO/NFps
         rTQ6CFkdm+cH5TMY/60LQ4Y2zaaN7k5Mhg5PxUOVRBPSSC4ERy9J6095eaQehAuaVquL
         8eGw==
X-Gm-Message-State: AOAM530gLGyYTBbRHU7LBocNA1UFcuXkTYOWt5sgETSgEGDtynPyKI7y
        rgJDEFzqcD3Ox27daEnMRsI=
X-Google-Smtp-Source: ABdhPJyRn6Bi0Q6e5s0QT5OUUlhvnEHIjA/mOhsqTJCo7S2f+ezzGobee1cfY28qdu8zP917WxrNVQ==
X-Received: by 2002:a50:fe89:0:b0:410:f1f7:4983 with SMTP id d9-20020a50fe89000000b00410f1f74983mr2195131edt.135.1645707315617;
        Thu, 24 Feb 2022 04:55:15 -0800 (PST)
Received: from orome (p200300e41f0a6900000000000000043a.dip0.t-ipconnect.de. [2003:e4:1f0a:6900::43a])
        by smtp.gmail.com with ESMTPSA id f22sm1299317edf.95.2022.02.24.04.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 04:55:14 -0800 (PST)
Date:   Thu, 24 Feb 2022 13:55:09 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: raspberrypi-poe: Drop assignment to struct
 pwmchip::base
Message-ID: <YheALS3oEMfw/EcH@orome>
References: <20211209220851.1319460-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="abZzSrWCgHnAw4Sl"
Content-Disposition: inline
In-Reply-To: <20211209220851.1319460-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--abZzSrWCgHnAw4Sl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 09, 2021 at 11:08:51PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Since commit f9a8ee8c8bcd ("pwm: Always allocate PWM chip base ID
> dynamically") there is no effect any more for assigning this variable.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-raspberrypi-poe.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

Thierry

--abZzSrWCgHnAw4Sl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXgC0ACgkQ3SOs138+
s6Hy8g/9GGoR1S9Ee3t8oGgw9E19ocG+9EQ8yAkwPubriWy2MUxf0R94EdWr4g5N
h4qXjlIt/XOle92fMGj0nMwD4vKoikRjwm3SiN4CfEcz9M54qvUoKkUP6jyufPVq
pOuGPfz76JhxyQ70+Sb/b+vP8aBgnvveOnOdh1IB/Mh5d7U+h7OS4aOsm/+tw/qy
dEuYcd4khJCud/uAMWrVWKfIwEN9r8EG2b1XOI97Z0CsXtCpoHoq/yg3jVOsiyeG
bgMsImwpea2gxmxTARymQlbzXR8pGDXaRCUD00eQnoWZ7e4nQjqGRK+43Ai6BhT0
2IVHTvwZSsd7YpPrKGt6adT9ObXcOaZrQrVGDb1QDghOFor44dwp9dwdPkMaSf2M
c9nUNoPUGeDyvn5zHjd3ucrJ/mKZ1j6R7dTJ3hyAJZvdMEEB3M+HZZ6JULXdOS8Z
WkRikTcGJqmGLUdXlc5JlsmB204xKjXKns28azKyhd7P96l3fBEJmklG8yuHw1JG
kbkvlLFJerOnhSqOP4yAcBmsJwaD+dup4bGVcwb753qKsF/FuS+COJsQ6PNVg+b2
zZdfVuA63KHoMl6/Zzp+jZ+fFsWe9HkChJVze/bTvr+Xn6vx65UfbLe09alAJi5E
4OeOrCn5Z04jr2RfsV4JwLAN0QjadDRO0iLgJ+NPoYpUWB9V+Sk=
=3jHk
-----END PGP SIGNATURE-----

--abZzSrWCgHnAw4Sl--
