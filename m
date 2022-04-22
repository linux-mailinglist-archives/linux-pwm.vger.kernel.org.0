Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416AE50BD7D
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Apr 2022 18:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448138AbiDVQvy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Apr 2022 12:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386269AbiDVQvx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Apr 2022 12:51:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539315EDD0;
        Fri, 22 Apr 2022 09:48:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id x3so5412359wmj.5;
        Fri, 22 Apr 2022 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dL38edv43CmjGxqKsLlzSbMi1mBsGAdOZRJRrK8uP1Q=;
        b=SKI6oFg3UYVuCZjoi93kuu4JPJJU9ditTEk/iLS7N9IwNpTsQrm+2Fm3TTEyRffpFd
         lzplvaO1W/7LmiZ4jA4Cu7W9MTAy53FNn1jT3LN1D57vZ/tBphBIExS0boCnETizU4n8
         hn7EMTwnpzRlwCkBtQHs4Y0uKvF57NcOeYeG+6uvJtDr39VQsRtwBRL1mlb34MWA/Xqi
         LQcNUcQEUksCabq1sV720nEc31HXFG/o1nGl5bGIrZi8Jq6xGzUmzovxc+91uXcxG7ku
         VqMuvUT6o+B3YTqqBQc4f0HBA2KBzlzaVyQy4RMYlG+edWHWO2q3kqYzTi9pXIxiiA3L
         EpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dL38edv43CmjGxqKsLlzSbMi1mBsGAdOZRJRrK8uP1Q=;
        b=J7iXdp6xVvvtyADc+JyZEzSpvxbrKyPDW0IVnRpmhwCt7ysFQGTBmRX9kLo2dIe0b6
         7ZxxE6RkvfERozASdP41jQwHX0TwkoXcbJnUKYQrMicWnsF2J7Lk2waPZV+9qLQsSDRP
         gOGPXKEcNVrXfw3ruLRh+9tENRTNDryKBJj4jaf5+zSN3efXxXMnOJRolXm61OCJUaaF
         99O/0PT38jTnoTxOR20SFoGuGBBRxG3AJ/nRsojHBADW0bgmm/F6nz4AvpQPd/AtxO41
         M8RoSG6vNVm/uwOtibd81f/vWtGPZQ4T2FBuck0i9q8Aj7v18kBksDtcaLsq3p1Nd0gW
         0aJg==
X-Gm-Message-State: AOAM5318mMMTi+WF6Tzo/NQTSZoczC8n5UblbU+/TJ+if5CR8LQh0JYt
        iLQzoiKzz0dm258w8ep2Z8Y=
X-Google-Smtp-Source: ABdhPJwqxB7C0r/qqWoFw20ciIRPW1RuykSITEtfmPq753Gt1DHrnEl2edEd6TU3dsRrXksSGwk04A==
X-Received: by 2002:a05:600c:6006:b0:38f:fb25:3bb4 with SMTP id az6-20020a05600c600600b0038ffb253bb4mr14089967wmb.78.1650646137842;
        Fri, 22 Apr 2022 09:48:57 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c024700b0038ec0c4a2e7sm4793775wmj.11.2022.04.22.09.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:48:56 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:48:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] gpio: mvebu: drop pwm base assignment
Message-ID: <YmLcdmQrO4+0tEiJ@orome>
References: <145383feecbe43f3bbd3e128143f7890f0314b3b.1649658220.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bgaBTcdcMTmEx8L9"
Content-Disposition: inline
In-Reply-To: <145383feecbe43f3bbd3e128143f7890f0314b3b.1649658220.git.baruch@tkos.co.il>
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


--bgaBTcdcMTmEx8L9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2022 at 09:23:40AM +0300, Baruch Siach wrote:
> pwmchip_add() unconditionally assigns the base ID dynamically. Commit
> f9a8ee8c8bcd1 ("pwm: Always allocate PWM chip base ID dynamically")
> dropped all base assignment from drivers under drivers/pwm/. It missed
> this driver. Fix that.
>=20
> Fixes: f9a8ee8c8bcd1 ("pwm: Always allocate PWM chip base ID dynamically")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/gpio/gpio-mvebu.c | 7 -------
>  1 file changed, 7 deletions(-)

Linus, Bartosz,

I see that this was Cc'ed to linux-gpio but not to you guys, so I'm not
sure if you're aware of this. Given that this touches the PWM-specific
bits of this driver I could also pick this up into the PWM tree if you
don't mind.

Quoting in full in case you don't have this in your inboxes.

Thierry

> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 4c1f9e1091b7..a2c8dd329b31 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -871,13 +871,6 @@ static int mvebu_pwm_probe(struct platform_device *p=
dev,
>  	mvpwm->chip.dev =3D dev;
>  	mvpwm->chip.ops =3D &mvebu_pwm_ops;
>  	mvpwm->chip.npwm =3D mvchip->chip.ngpio;
> -	/*
> -	 * There may already be some PWM allocated, so we can't force
> -	 * mvpwm->chip.base to a fixed point like mvchip->chip.base.
> -	 * So, we let pwmchip_add() do the numbering and take the next free
> -	 * region.
> -	 */
> -	mvpwm->chip.base =3D -1;
> =20
>  	spin_lock_init(&mvpwm->lock);
> =20
> --=20
> 2.35.1
>=20

--bgaBTcdcMTmEx8L9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJi3HYACgkQ3SOs138+
s6ERWRAAqoWZeg5/QEnGAfMtPF5giVzWFHPQKlaRGNGMZEN/19YcpZDJhtXMpoWs
3WTM6Kuh2W2Qb8rei1yF0WAvoS+Mtaxif2gTOzIXYE1Ffy29RIkhY+ibf1zd/XE9
XZpr9V+MyyqsD7ko63Q/H6B7u2ZxvRqDD8zmFRZUjrZk371QWYt+cRcMAb+P0zKp
2BzP/iyFNcO6rN9VaHYnUpNoUwBsN7HdQxHSrQaCgkVSG8lpBGKKsVTu7TAed7iQ
+sW8er2SWOVnE4n442hu3YIMz7D1tHlp6O8+ooaukM3BGvp1uvO5uRP0ps8FUEG2
2MslWKenR3ASgVxokk3xjjk+7di6IGoa5sa1yyEn9YUnRcraZiarS68yp+4YYdbg
pptFcj4g6slBvymy0IhgQAKzGZoB8z4zm/VmaHeE6atLuwW+J67sN/Tb0Gpf0B1L
fuLnXjaDLwWfTwIB5OLYt/CgfoAKzBxmI+jNEStFm16roSgEoVMCnd/FXeVhmKuR
2HtjsC/atmgOVb4MP6U1nxNjhD7zyC2P9zzIIExd4CP+BX4ZZxwsjW6obZ6Bw/9u
JqFNFPrEVieIx9JAHzwcd38kGShza7PTSF2i8p7QudneJtaqXwQSVYnSRBR8/iDC
rSC3+XUSScbh8f43L72NYHN8soHy4nbf2TyE0sbxuO3AsEGT/3A=
=iVqt
-----END PGP SIGNATURE-----

--bgaBTcdcMTmEx8L9--
