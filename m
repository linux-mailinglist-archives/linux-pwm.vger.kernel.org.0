Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9214650BDA0
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Apr 2022 18:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345128AbiDVQzu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Apr 2022 12:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiDVQzr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Apr 2022 12:55:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269045FF03
        for <linux-pwm@vger.kernel.org>; Fri, 22 Apr 2022 09:52:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g19so15323389lfv.2
        for <linux-pwm@vger.kernel.org>; Fri, 22 Apr 2022 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vhXM0ntcXKHlydbZT/Xpn3h0qeo9VUsocNXCliyhBpM=;
        b=IVijHsfm/xcq9j9GO5ywI9XTVSzWvOmnhnfTZpnrV4mZ86XRKhPyHlDH3SShJe2Szx
         3XRgixRnOd4iBbOkqJqTKuGgirI6dpSUhqFZ+5mFvT43AqFC7sMFv7nUyZUbeHQW67Az
         vynuM8TztIczQ23ev320ep58M0EVBusTQZI28zOZbUpUAlSpfB7MEk0SbfabqGH+dXkd
         V12hr6BZQlENt3mhglKpproJD+6IVv6v/NK+pDYVz4gbVu/VhuLW3Qfh+V2Wu6k4oufX
         ysAOmi3+1lZhboW2T8mtfIzkl6hMSh2HvRvjMk/6790//S02dZqZmnlSydZ8t/oaevG3
         KzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vhXM0ntcXKHlydbZT/Xpn3h0qeo9VUsocNXCliyhBpM=;
        b=DE6XbwVxhx1xiTAw8HzMUAaar0ik1JNFe6AgPil2iTfckV9WmyFipbQRuY4dpWpJ2S
         DLK/QY2ANk8IjBxialYRFUPwNxXnX9X8W2d+s0wTqvSDiC0ZD7DW2NuYKNBNyugaZzCQ
         Zg610RL5MI4/3K/avP7b4Anv/eKHNB0Xn5Y8T97pPXsJaVF0YFCdpYHzTQkABn5su/Bl
         k8p6HcQY1ZJmDUHvf190xizMtgsl+j7sCLobQZZEUnkkxa6o+S3b3kc/xqsNdoSYOZiC
         inyA/fBZpj2LVPS2qQah/CZS9f6sbnjv542lwYXuHcNdCcs+n2U1XDjrKCorn7lMWJdM
         pMiA==
X-Gm-Message-State: AOAM5301cl7989MO6LXfXUlzkM1IAk17hXJ3tb3aiL/9NecmeOsCTzOX
        kwl721eCNqdJUNi8bwCrfVI=
X-Google-Smtp-Source: ABdhPJw9h1Qy6xskefDrAGdXK/zJpcnjGhLLN4AFUFt1X8tV6AusqqGNo5nRHKwc3AZsJRyMX519IQ==
X-Received: by 2002:a19:3845:0:b0:46d:1871:1c6b with SMTP id d5-20020a193845000000b0046d18711c6bmr3695288lfj.429.1650646372440;
        Fri, 22 Apr 2022 09:52:52 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id s22-20020a197716000000b0046bc65188d6sm282643lfc.80.2022.04.22.09.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:52:51 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:52:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: clps71xx: Implement .apply() callback
Message-ID: <YmLdYYg2egS5Jczj@orome>
References: <20220408154520.173148-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cNLg9cLGMqSzp3kN"
Content-Disposition: inline
In-Reply-To: <20220408154520.173148-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cNLg9cLGMqSzp3kN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2022 at 05:45:20PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> To eventually get rid of all legacy drivers convert this driver to the
> modern world implementing .apply().
>=20
> This fixes a small issue in clps711x_get_duty() en passant: the
> multiplication v * 0xf might have overflown.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-clps711x.c | 68 ++++++++++++--------------------------
>  1 file changed, 21 insertions(+), 47 deletions(-)

Applied, thanks.

Thierry

--cNLg9cLGMqSzp3kN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJi3WAACgkQ3SOs138+
s6GOuQ/+JzOk8SNGvtH8CC8lVJaDjbcU8Sun+Wj196osVTj4tuUKlfgSTF5AbmlW
+AeXOjQdIvvklT7OGezv8DovrSk0p9vWasprOrc99nQgQid0YRL5VhZ1OXsrfN/I
Kdr/+g8g6unQvT23ciZOaj7EGKzwzD4HoZLRSq9nPui2b2ZBx04qt5D3M8ksmvYB
RV2qB6c7YD9Q+Y49z0CDbL/4tHHf7qJQeokepzGdZyBL2i0u7bm7VQQwzVxDrZR5
wHSV939GsgI66EMq6j0mfs2Po9id8bkhVnJ3G8JMpZlI5luv/+V6ZgEMED16YSPQ
3yeW6kRZ0h/hh8taU/ezeQrCHI6/FM2OoxdLnPG1k/XpAnB9BtRbb+9yQ7cfLDLH
5D5I5985rjZ2i6KGDo2cO4X7cAnZsWTVUqUN4tX5LUqcxGWj8jszU2goBbTbmInG
FFpXG2XAhlBYx/Xwh+yVLSoeVlsL2d16O52NIafhVWhGj+tIY2LfvhnL0J0Sh47I
q4BERHHTjT6y0uo/jjPwlPqAhh6VhM00t8/Z3BYeY6J2YNvjPT02Erh6QrwMvhLD
dY/HCBBLPYrYADboGwcpRGo8dwz3M7NtL5jsMtjn0e5iLM4N4CZ4xoAIevyzrz8V
jQ0jeNvNlYZiIfX+Z7qiQYDXPjlX2JH2CV8E9kK6BvVHKi8rDO8=
=XbN8
-----END PGP SIGNATURE-----

--cNLg9cLGMqSzp3kN--
