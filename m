Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A396B50BD9E
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Apr 2022 18:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449926AbiDVQzI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Apr 2022 12:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449918AbiDVQyq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Apr 2022 12:54:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534545F8FE
        for <linux-pwm@vger.kernel.org>; Fri, 22 Apr 2022 09:51:50 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p12so9741755lfs.5
        for <linux-pwm@vger.kernel.org>; Fri, 22 Apr 2022 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6VrGwQD7al08XKL+o4zC3y9gLRT3nIeX9lZuJZpW50Q=;
        b=VosOKDaC4qALsB3oUT33xKKT/CrvKuIkS9agO4VPqWgXExtMC3bmtGwb1aTvnXqDcG
         WwJlcZM5DQGv5LcdNlDhwiBHtTSXGWM8Sd3ONsqFhrRu5w+xQQAPO5QeqnztfYavO0rF
         BjI8JoE2Zr1dPVB4eBOf7GGi6LWvmm04pmQI5ZStpm+vCPF2jfwWi1SOxqn75kEAaP0V
         ilMZ2p68U/vGX04DfihWnfpR7nCa5PcNA+vAsBeioKgixT6HOH9ENw3onfvYthbsRVkK
         2kHzwZGYUOQI6jv23flOnsAPOJk5D/49Xq8twrUdwnMhayEJrt5KcreGlZM94jsherQK
         CsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6VrGwQD7al08XKL+o4zC3y9gLRT3nIeX9lZuJZpW50Q=;
        b=KUV9KF7n2gNlJduh/AmYD5GeOXnARbYxQx4pKFSHSjbMfmjYeAj8VxLmgc8sM23//o
         Y2Y/eeNIBlMCARiyEVyx3UE81i+VXSAViBrGgCGccR8ZTZBDsV8pKtO150m+3p8fV+CT
         fzLj45S/6oIl8lt0u1DkrkNhPrPSJUA8E3nF2IuYdc8ooNad8uoyVhDUOGbpT1JeEcxk
         +Y0zD0dBDuf6RT+lgvazkB6IhFXltIcfAqP022QF8ae3U7xrkQLp+P5tI2odHm28iNvt
         FnnFqVQ/BTut0eK4bS83jSv7e8ESjoRskQyhwd4SMwGNtYFu+jJwmgzliSn8USD2ijRp
         T/Xw==
X-Gm-Message-State: AOAM531envJwPK6Mpzn0Ye4A+UrNCaRm7mdf0KRVi4108k4WAl0fm/l2
        3R9eND+URdz77A0XIvOnWv0=
X-Google-Smtp-Source: ABdhPJzOJX1iL0zyaycZm5tRazJQZo+soRiFT6n/7gTMuGSEzOyyIRFOW80yJ/GvBc0GpCSS7IPFJw==
X-Received: by 2002:a05:6512:2304:b0:471:c1a3:9d0f with SMTP id o4-20020a056512230400b00471c1a39d0fmr3723971lfu.339.1650646308539;
        Fri, 22 Apr 2022 09:51:48 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id o5-20020a198c05000000b00471b18fb5fesm279557lfd.306.2022.04.22.09.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:51:47 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:51:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: raspberrypi-poe: Fix endianess in firmware struct
Message-ID: <YmLdIUoeIgGgwkT6@orome>
References: <20220408153846.172701-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jRZQOAO45MYM8cbE"
Content-Disposition: inline
In-Reply-To: <20220408153846.172701-1-u.kleine-koenig@pengutronix.de>
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


--jRZQOAO45MYM8cbE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2022 at 05:38:46PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> The reg member of struct raspberrypi_pwm_prop is a little endian 32 bit
> quantity. Explicitly convert the (native endian) value to little endian
> on assignment as is already done in raspberrypi_pwm_set_property().
>=20
> This fixes the following sparse warning:
>=20
> 	drivers/pwm/pwm-raspberrypi-poe.c:69:24: warning: incorrect type in init=
ializer (different base types)
> 	drivers/pwm/pwm-raspberrypi-poe.c:69:24:    expected restricted __le32 [=
usertype] reg
> 	drivers/pwm/pwm-raspberrypi-poe.c:69:24:    got unsigned int [usertype] =
reg
>=20
> Fixes: 79caa362eab6 ("pwm: Add Raspberry Pi Firmware based PWM bus")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-raspberrypi-poe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--jRZQOAO45MYM8cbE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJi3SAACgkQ3SOs138+
s6H7AQ/9EuzIw+kg5ZS3uJgpQtAm4zKHt1hY+DknntMIcCXXalK52oE7SB6qwTHw
rMZ69THXB0cCkK2G4/sTYHaM2o4Nq2oulwRCAui++FXvHJAAGo4ambA8sLekPNBd
cG7XEJlWFoqdumaJ8djbHrSXZiqGOnKFXVSVWUBIHfQl4mcG8xLYL41Vbb6+eDPD
GIitZf5czD42do03QQ+JKP0auW/HClW/Px2MadV0Hl1TjtaehQEsop3z/vTr3dDv
iV7yzQT4ix+9L7HIjUVQWIerRSq8YcnolZho5NQQVjdq0bDwn5u++ShjS5x7fRCN
0vYuw+tb0zyEDwumHyp2YWKwuXITlUAytxsF5YgWXpE1RKAolX8sI3AkIBlE64+T
Etzehuyl+h+rdqVNFKTMdG+3AGL2QiIO2QGk/l+MqKZpHFYdvUo71MSeY1iQVd8Q
NGpv3b51BzH6vJTk5Wnc7L+9vywPm1WZa278E8HzLfaAf0VdmHfNmgayVdtC+5OO
wcesYjvJR7s3OWLokPXunD4iEEXBObVWZ80qeFKrpdxima83yZiGORl8wQrR2peR
ACyQV3uehFeB0oG9xpWBeNFvHZsWrUD7pOajMFBJY1ocqUqyKwoSTJ01IZV+Ue9c
3j7WrVH5UYFqYoEAbXJXpaW6/a1Y20vdKKru+Rlj/iN9kS6BsWc=
=nNWD
-----END PGP SIGNATURE-----

--jRZQOAO45MYM8cbE--
