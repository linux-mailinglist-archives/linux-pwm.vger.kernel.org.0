Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C09C75A6E0
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jul 2023 08:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjGTGsX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Jul 2023 02:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGTGsT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Jul 2023 02:48:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C51026A2
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 23:48:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b962535808so5865071fa.0
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 23:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689835695; x=1692427695;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FkW5AFugHIm4cfLHhBTJhPmVsKSDHP6cvkrfUVdciI=;
        b=AzOk4HbUt9ZK+jgh2do1VmTnHs4dXgElnWxrvk/ChEHWWQTAZ9Vx8z7XNmRbDqPxZ3
         pze3ozYAKUdVg1bDR93gP5GhKEdWWBQ0Z3hpvKSTR3aWKlVmMyKb7oVA0LynQyTcgKv2
         D6nSHWT0sTsM7wGrLweBRaxKnv4ScXH6R7hljPkQgdoR9wDPheqU4d3pdCm1+3XDKlWu
         aJeDJRsVcVA+LxTuN/Lh17Y4eVWY7TL9dsBZ5PDZgdTD3S9dyqQ48/KqD62XG+MERd3j
         v9OutwMGBMZU+qjEDSgxHB5ePtRice9fyfrHWxUYpDn/Ip6PxSF/NyTWH7Duq9PsJPVr
         i08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689835695; x=1692427695;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FkW5AFugHIm4cfLHhBTJhPmVsKSDHP6cvkrfUVdciI=;
        b=e7Xd3OFtDhaX+zc+Vfu36ZNoe3PvTgMyColMc4Ah2KX05072sI3viYdFaT5rQv8gzr
         E7sWUV8O703X+61M2R2tb1OZC/T6KindaMDSX6Uki8QoMw7hl0bn1qqLGiq8Puo1fkwq
         m46o4IG2t1bAGRXv7WoqJuIkloJrukWd6a7xUHFG0R0AjTU1+kc7cVSqJPeHR5U06/ot
         6HiqD6UpILZxuemmV7sn/YBFVc0JS7PxT6T3UlJtWuBE8M6mVuOa0+WA4lo8AT5Zf34q
         tLCecaR0GBG80wIsxFv7czHGT5ckCTOWWqBSj3jMOE/N55pLLePyeh0RxfZA4JmQqMcV
         /bKw==
X-Gm-Message-State: ABy/qLZHufy/WanmD5cL0Pfs5O9CxrZzdpN8oNpQgLtCN1dAk8Vagl92
        NzhTAZslt1xghIl1Ebekxt0=
X-Google-Smtp-Source: APBJJlGrST9hDWvezaAooUi3+dItEEwvvxovRyenIedKgx3brcqw6G9KmcKqHf4GtKi+d6VaNG3D9g==
X-Received: by 2002:a2e:9901:0:b0:2b6:df6b:84c0 with SMTP id v1-20020a2e9901000000b002b6df6b84c0mr1063490lji.25.1689835694948;
        Wed, 19 Jul 2023 23:48:14 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c210900b003fbcdba1a52sm3162159wml.3.2023.07.19.23.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 23:48:14 -0700 (PDT)
Date:   Thu, 20 Jul 2023 08:48:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Benson Leung <bleung@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Walle <michael@walle.cc>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 00/10] pwm: Constistenly name pwm_chip variables "chip"
Message-ID: <ZLjYqwGh178EHrVY@orome>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qz371AQYCl6mZiXj"
Content-Disposition: inline
In-Reply-To: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qz371AQYCl6mZiXj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 10:56:13PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> while working on an extension for the pwm framework, I noticed that some
> drivers and even the core only nearly consistently named all variables
> and struct members holding a pointer to a struct pwm_chip "chip":
>=20
> $ git grep -Pho 'struct pwm_chip \**[a-z0-9_]+(*nla:[\(a-z0-9_])' v6.5-rc=
1 | sort | uniq -c | sort -n
>       1 struct pwm_chip *pwm
>       1 struct pwm_chip pwm
>       1 struct pwm_chip pwm_chip
>       2 struct pwm_chip *_chip
>       4 struct pwm_chip *c
>       8 struct pwm_chip *pc
>      57 struct pwm_chip chip
>     358 struct pwm_chip *chip
>=20
> With this series applied these are all called "chip" with one exception:
> The led driver drivers/leds/rgb/leds-qcom-lpg.c uses "pwm". Maybe
> "pwmchip" would be a better name, but I'm not sure that using "chip" was
> an improvement there as this isn't a pure pwm driver. I'm not touching
> that one.
>=20
> The first offenders I found were the core and the atmel-hlcdc driver.
> After I found these I optimistically assumed these were the only ones
> with the unusual names and send patches for these out individually
> before checking systematically.
>=20
> The atmel-hlcdc patch is included here unchanged, the core patch now
> also adapted the declaration of the changed functions in <linux/pwm.h>.
> I marked these two as "superseded" in patchwork already.
>=20
> All patches in this series are pairwise independent of each other. I
> don't know if the staging patch should better go in via the greybus tree
> or via pwm. Both is possible without needing coordination.
>=20
> Best regards
> Uwe
>=20
>=20
> Uwe Kleine-K=C3=B6nig (10):
>   pwm: Use a consistent name for pwm_chip pointers in the core
>   pwm: atmel-hlcdc: Use consistent variable naming
>   pwm: bcm-kona: Consistenly name pwm_chip variables "chip"
>   pwm: crc: Consistenly name pwm_chip variables "chip"
>   pwm: cros-ec: Consistenly name pwm_chip variables "chip"
>   pwm: lp3943: Consistenly name pwm_chip variables "chip"
>   pwm: rockchip: Consistenly name pwm_chip variables "chip"
>   pwm: sifive: Consistenly name pwm_chip variables "chip"
>   pwm: sl28cpld: Consistenly name pwm_chip variables "chip"
>   staging: greybus: pwm: Consistenly name pwm_chip variables "chip"

This would've been much easier if it had been a single patch. Now I have
to either make you redo the whole series because you've misspelled PWM
or I have to go and update it myself in most of the above patches. Hint:
I'll do the latter.

There is really no reason to split this up into this many patches for
such a trivial change.

Thierry

--qz371AQYCl6mZiXj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmS42KkACgkQ3SOs138+
s6Hrcw//bT6JKDpq1cRgHldmJl93Sju6hsTYMrblCoA1pa6rfV9XZX1D8K1gZUOl
K+6a1mUlkjv1KR7pIvUU7PG47vE66IXBNwAZYLfXYKmrCBiWjF+mT6Azm2rwPguM
02gt5Fmv0Xp0CZ3yc2N4CHhiC+MsyhkliuK/dMfejMaPSQjs3F+yMPo4FUON+CJx
oy+okmnI6VYMtpAX3qDvJ7lrqgmw6CMwkxrYPaCtnzRGYLxOyixhoYy3KzgWS8BO
Aukgm24XROAuq58cCp9EjxYtMWR7jmJdaqY3DVaE4XaAuklI5/s0QfTSachQbTOu
Fv/+/1K4cZjTEhg+qSfSq5xIkmDqDDcHFw5Kobcv9xjXegeFLnrTl541jiMLkgcs
U4zY0OGXm2OZrhqQRj4WmJd8YAkqZbLTquSQb2AtjNyITFKlgQg28Ct6gr5Go9eb
Te+RAcoQkDuIs0qEJe+07qkCEngilTGdXf59kymAsdDzWqM+7qEDOMYnmWzl06KJ
qQFbms1FtSzldFO+upYAYMynS4K2Ni+EY6KbocmUwvs9vYw6FC8pmyfAXvFdGD8D
MXljW6kvcoycIOPlwME1H+b3EourwQhI/wnjLyYmB8Z921+NJZ9D3Bj5ey16YzEp
ZGqr2I+AgbDzS0yQAM/utgHE9jOZy6KOnQGeWvXYOeUSVDlrobA=
=iJ4i
-----END PGP SIGNATURE-----

--qz371AQYCl6mZiXj--
