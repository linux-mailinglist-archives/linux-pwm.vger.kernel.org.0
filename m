Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBBB554BA6
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jun 2022 15:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355441AbiFVNqj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 22 Jun 2022 09:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbiFVNqi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 22 Jun 2022 09:46:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88768275E4
        for <linux-pwm@vger.kernel.org>; Wed, 22 Jun 2022 06:46:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i10-20020a1c3b0a000000b003a0297a61ddso512584wma.2
        for <linux-pwm@vger.kernel.org>; Wed, 22 Jun 2022 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EnwrFeJKBOPsgt831LETBk9GpBVXeeMmiO8A1SR8eE8=;
        b=qW25mBzZig2InBdGJOuFffVnjFbwrO2NK0NRq7mkhCjQyTm7T4WVHNJJxwfEzaLOFk
         S3dkV3AQSAsXsm307JY4qbzvwDCPCoP27ssfnjEvYmdMbMSRjebFIa4WwJWVLIRmRrAJ
         Hh6OQZq9CdeUcfp1naQ9ju5KT37w0rrceCrznidZSSD8ooNvnpAsVcCLOx3+ubgzN/RI
         DRyodkEh+FVh8CRCrLyTdpI9UWYtf7HE7zr+O5R5gsRiiRt+7YavAPKCTDrGklzAC1Tk
         YZP1o6h1lBixnQIIIpiyMxTZ8Qbh5PueIiB8DI0EMB5ljWsWbGhHdXfK6Fs8CBWIA4zV
         TeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EnwrFeJKBOPsgt831LETBk9GpBVXeeMmiO8A1SR8eE8=;
        b=w0yBlt1/XMeu+F8zfyvMpecdHwnIgUOrKkLI4WqxU76KM+1ZJUQA+wqwkd4PPRYveV
         KsrgRiIB75AgHfk7OeZHerUtG3sh9TafYlHt3pSPfe0mNwHoV1NYzIeSHZ7dhO3cFcw5
         1E7uZsHaQT5do+3bhEqhQXRpnMO5mIPCLVkdw/OuJZmpge9MqDpxdbgO/Iq+eOyoSDv9
         tb6YtWP29L5eIYqATDZq63qJTNTTQlwYi0IeczMxd2bKcrRf/qQwsU/l52bEduoFvprc
         7CA01I/X1ZWyoNDkOUYrvkPVwErTDgzy7frzlJCvMtZziW8HEgcw4CDskmG6HyjIA5WZ
         HJgA==
X-Gm-Message-State: AJIora8daD/6CX/lOVNkhQWMwqpFxm0J/VOPbUWhayJV/vBCcMF3asvE
        Gp2a8Li39bFgeLGAsVnJktE=
X-Google-Smtp-Source: AGRyM1v+5Cc7OZEvv2RMNi+be8GHbujKNckPXTpHm0m5KyPl7CZTdCQTJ9qwlFxNpUCmL9H242ESKA==
X-Received: by 2002:a7b:c1cf:0:b0:39c:4460:cfa8 with SMTP id a15-20020a7bc1cf000000b0039c4460cfa8mr4013869wmj.21.1655905596062;
        Wed, 22 Jun 2022 06:46:36 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b0039c4ff5e0a7sm22755032wmq.38.2022.06.22.06.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 06:46:34 -0700 (PDT)
Date:   Wed, 22 Jun 2022 15:46:32 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/3] pwm: Make capture support optional
Message-ID: <YrMdON4uOMfDFN8h@orome>
References: <20220523174502.987113-1-u.kleine-koenig@pengutronix.de>
 <20220523174502.987113-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jNoQ2KZQIZ7W8SqM"
Content-Disposition: inline
In-Reply-To: <20220523174502.987113-3-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jNoQ2KZQIZ7W8SqM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 23, 2022 at 07:45:02PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> The only code making use of the capture functionality is the sysfs code
> in the PWM framework. I suspect there are no real users and would like to
> deprecate it in favor of the counter framework. So introduce a kconfig
> symbol to remove the capture support and make the sysfs file a stub.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/Kconfig     | 12 ++++++++++++
>  drivers/pwm/core.c      |  3 ++-
>  drivers/pwm/pwm-sti.c   |  4 ++++
>  drivers/pwm/pwm-stm32.c |  4 ++++
>  drivers/pwm/sysfs.c     |  4 ++++
>  include/linux/pwm.h     |  5 +++++
>  6 files changed, 31 insertions(+), 1 deletion(-)

I've applied patches 1-2 for now, but I'm not convinced about this yet.

The PWM capture is something that's typically useful for applications
served from userspace, which is why only the sysfs implementation
exists. So anything that's based on another framework is likely not
going to have in-kernel users either. Can you specify exactly how this
alternative implementation would look like and how it would be an
improvement over the current implementation?

Thierry

--jNoQ2KZQIZ7W8SqM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKzHTYACgkQ3SOs138+
s6HmjRAAuFoaSIF3YIDnVXqf7MW9DZ5tTP598dfkUjBSo8MOI0ddqSll3G8MPyvX
7js6YluQnuSNpJp0+xJ6mJvB7r3jHTdgLc7nu/Yop1YJl1mgTsHI0zQbqk7nsN9/
lbwTCqGxFKP42EIBuUOwKwXS+TPa1UmJsTHm4EBgMkgz04AqATJ5LwnSGoL33mW2
Fu8hqT6RWFWN9XIJmV3vfkJJ639/JkzT3NzlwmxpUh+Awc3y+BF++S6YV219AOun
csCTIyYkqgbseHH2zN7AxrMxo4M3Smv7zCT7rEI5wKv3TZLE61MSsoljUvrfrnv6
6NlZh9PXbEdKpN1WrsLRU4PiCzKRmXOu4UKg0d5NhlT+r/aW13DSwLGbhm60aPi4
ydgZ3r5I+wdVUecKvsral01DSdYkHgseM+Yl5bVNtCGyk1slhjT1/YCeavEdCsA4
qTLFGRdW0MfhytnS43ZkUsHbR2Pa4soY7AQXBBn0vsJPlrMRH3V6QIWQQjnEkv7G
5bBOcDv18k5PpWl47Pws8bjxbxl+m66Jf/JIrO2+ggugWaaHwa9zzd5Y3Mo1mtiH
XWcnmS0MeVeqAkiwLLgQ2jbZxTqAbI3jnpRKDoLpImFzyrJ0T8KoIAfxLTcczcB3
vPHeSpZ3BXpQWVUBfHYXUVGM3fdnAUFXynsfAfa9ZmTmc2dZ89Q=
=iis6
-----END PGP SIGNATURE-----

--jNoQ2KZQIZ7W8SqM--
