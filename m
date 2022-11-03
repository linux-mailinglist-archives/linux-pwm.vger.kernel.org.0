Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C45C6180C8
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Nov 2022 16:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiKCPNR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Nov 2022 11:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiKCPNF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Nov 2022 11:13:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A91101D5;
        Thu,  3 Nov 2022 08:13:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id q9so6245452ejd.0;
        Thu, 03 Nov 2022 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoaIlM8xIgahG5JFmkc83N9GLE7kxUB3z/5iN5C/P6U=;
        b=i8gImPBsW4BoJnyy6VwgXLmzycc2IWmBB4zDz5bfkjEvYbWOcVOu1YvFRAZ61dPjMR
         Z3qD1xv+QiyxIaFF5qweljJxJkd6/wtA1Ojy2kQEIckQFy0NRMdVLuOLMXFGKNCb/cSl
         iahqWySyzTiStWYYH4cpwJe+7mlTXseEVdHXY/uzis+4tK6mK62W/fQvrT0OmhfmW6XP
         Ryu84s9dDR3NxHthkp8qmt37kqZ/2hcly6UJNdwWhmeOvRjRkkXfsZlGz5f4MOww8AmV
         XkxWOxCzisbwvCHU07pmIDe3+pjgvLfweCLDmJMYrNgPFA4iNYsUFuiyb0xH92XUysa1
         1e8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoaIlM8xIgahG5JFmkc83N9GLE7kxUB3z/5iN5C/P6U=;
        b=jp5B1T/UiKQ/Syt2hiwbFAB0YkLBad26EjEQjSuhHv7PRD/EXb/RPFomxhAj53Y5K/
         Hss8Z2qhrkdhc4S77tOrsj5jyhU+u615VXMi/DKOyvl7kDhHaAubZnDSDdUKKnvm9Ue1
         CXld66O3LyBHA+w2eduvM9OGMNVTd9DHZR8C5OiS68r4GEMDtL7VZHLsO/I2gcng2BFF
         Qka5JR4LJJFXZuQqMCW7JAfhlZ1K7Zo/0BBGp8a1hABAoAn1Ru/yY/xV8KCa40cIKGgl
         V/fdsqDvfkNlrdW2gWgZ1txKhtILYCbU/Jxx0xDS04Re00GCdyfhlbDvX3nq4S3QcIIt
         4GrQ==
X-Gm-Message-State: ACrzQf2fNYz1HDRH+o3tvqh4RgdQXhnpK+q/TwFONKmYYmdKkTEzpCOh
        5pR6AyS1dR2kfkyt9l8vVlQ=
X-Google-Smtp-Source: AMsMyM5kWK8thE8eDyVT8fSVWJ2nskYfHq0/tz3aDMtwjzqRMgpWx0BsaQUJGLovv9kI86HKGJCitg==
X-Received: by 2002:a17:907:9603:b0:742:9ed3:3af2 with SMTP id gb3-20020a170907960300b007429ed33af2mr29591779ejc.510.1667488382185;
        Thu, 03 Nov 2022 08:13:02 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bu24-20020a170906a15800b00722e50dab2csm605167ejb.109.2022.11.03.08.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:13:01 -0700 (PDT)
Date:   Thu, 3 Nov 2022 16:12:59 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2 1/2] pwm: tegra: Improve required rate calculation
Message-ID: <Y2Pae2xvi+d/qhod@orome>
References: <20221028123356.133796-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/Uw4l+j+ezP++LUf"
Content-Disposition: inline
In-Reply-To: <20221028123356.133796-1-jonathanh@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--/Uw4l+j+ezP++LUf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 01:33:55PM +0100, Jon Hunter wrote:
> For the case where dev_pm_opp_set_rate() is called to set the PWM clock
> rate, the requested rate is calculated as ...
>=20
>  required_clk_rate =3D (NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
>=20
> The above calculation may lead to rounding errors because the
> NSEC_PER_SEC is divided by 'period_ns' before applying the
> PWM_DUTY_WIDTH multiplication factor. For example, if the period is
> 45334ns, the above calculation yields a rate of 5646848Hz instead of
> 5646976Hz. Fix this by applying the multiplication factor before
> dividing and using the DIV_ROUND_UP macro which yields the expected
> result of 5646976Hz.
>=20
> Fixes: 1d7796bdb63a ("pwm: tegra: Support dynamic clock frequency configu=
ration")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Changes since V1:
> - Dropped extra parenthesis
>=20
>  drivers/pwm/pwm-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--/Uw4l+j+ezP++LUf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNj2nkACgkQ3SOs138+
s6HElQ//dP1kdJEc57w75eDrLaQgIhsYtdw38PTkmWvY5nDr32t91Ki12UVT8+Jg
AZ0AgqZEg+dmWI+oC8M30W9SswaOpVb0YLWauW3S5Y1B0B01Y4lFBiBmyqt9urr+
16iCBybU7hmeu5IlSCei4LDAEXDB5h2RmBN9XqvR6hwMRKAEH2Wt+DG0TqHkaiNX
AGDmi95jgRu9uGP8wT3nyiN7i9y1Gs7sSRGiQdEVhbcTph51b2is8458ZrmeRebV
9MvppuKEAQfzPaTN67LAqbmKZVAHFmMBCt9l3nb6IFZAPILyvV9im9fj7d/tqcLE
bzJeo6GjFJGhLD4t8Jna5UprhKYni5kfe/l+Ha3a31dgzL0EDzQkhfUu6QA2+VGJ
6ywDi2YIYD+iDQdv58CQvFv83un2HEqBK19EjZCBUqxiLM7PmrwfHDtp7FAyu07X
n562dFob3yqegQA3yaRSNzRVHDhh2BEFSDV0wQuOdnwc7mTZ4uIViyaIUbdGujL1
5LcZ+w9lPBS+K/VRvXLbe9B5l0CU+JHNbJrAWr2J0fS0SIsgXmOtEz7oM5kwQ7TN
VHsvxSYYPZxSga12VsGTk1WyAUByPoKSJUgk22Orb+CsqRN2jinnqgxmgfsb1TSI
LN1X77KJ43U1TIxFMARtgpFHdFTFrI+aoT9yqLCWi5xR3uzF0CI=
=9BFL
-----END PGP SIGNATURE-----

--/Uw4l+j+ezP++LUf--
