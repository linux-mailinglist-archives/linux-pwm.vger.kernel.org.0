Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188F36E4374
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Apr 2023 11:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDQJSM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Apr 2023 05:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjDQJSD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Apr 2023 05:18:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ED42693
        for <linux-pwm@vger.kernel.org>; Mon, 17 Apr 2023 02:18:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94a342ef3beso469899766b.0
        for <linux-pwm@vger.kernel.org>; Mon, 17 Apr 2023 02:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681723080; x=1684315080;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnOiUrSlOjkwJ/PCdyt/fDYs9vgdZj5CIL2URkjgkis=;
        b=ZXy6nZiCQkkHAdkmK+QTIKd8euTv+OnwRIQa5CxswFKlrzAe3UB0TXFSdbDkOxQJJJ
         8ppPAc7vQ8xJw4KS1Ih7mT4mapWbhaqGEguSTPsR5Pj/aRQq7O9yYmF56a21LimyER9V
         f1oi1MKleg3kaQX+NbQ+jGN74S+gRTXhV7Qkzf8TInbOU9kt8dfjEqCdBc8uNWbS+FUi
         zlcUJGs/6bjUBDCHzrndjAgQ5V1wSxsLwokRyEg2FuOe3e4lvx6WOWCh+6E5ea6L6aAU
         2n0MRy/hMXnAli3nJWWigw9ZSiWvTmmtVDh0R3pEIKO3tusrYtqEzitl+0y3b0o8+k8N
         HTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681723080; x=1684315080;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnOiUrSlOjkwJ/PCdyt/fDYs9vgdZj5CIL2URkjgkis=;
        b=IzE7BhrgJzFLCU82vvXQxCfrDQeyiAsyGaky92LBPl4d5r0lXGc6N8w/ab7CSDemun
         gaSnmC/N4CduvIPaP4ba96Ncmjkct+4dYK66CDJ8GIos+TKgTaOY//8+4GGOkJlSjCfm
         xu0WhkOn2vjCDCb3Mi67GorhGy5HQI5l9ysNGL2dBCfgxIns+oIZTC2kgKpwBOhP1VzA
         cXDL4F82N4ynmQwHF1LKDnKDqticycCUu9djjrVmcsB4k46+uCVdENq2MNqP0gFsvybk
         femWUu4M86qANMPYRUlaY61KqMMWfDvayt1pVeKDnL7i5AKJbM+NY0np6YoLirXHxnDJ
         O1nw==
X-Gm-Message-State: AAQBX9eeppvZlfbEcGMyekCh23hlWrer6QjuISr0aV76ZiLIYsUWxICo
        MUeoCplLSEJOb8V8+dwBH9g=
X-Google-Smtp-Source: AKy350bLypDyZYiwmOfVMXJ/w1f11DKhG+GkKEVp8W0HDqIqtvntxyHcXVWSBmmFnEtVjG60t3/N+w==
X-Received: by 2002:a05:6402:219:b0:506:8632:6696 with SMTP id t25-20020a056402021900b0050686326696mr8900555edv.16.1681723079483;
        Mon, 17 Apr 2023 02:17:59 -0700 (PDT)
Received: from orome (p200300e41f053a00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f05:3a00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p24-20020a170906615800b00923f05b2931sm6335951ejl.118.2023.04.17.02.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 02:17:59 -0700 (PDT)
Date:   Mon, 17 Apr 2023 11:17:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] pwm: meson: make full use of common clock
 framework
Message-ID: <ZD0OxV_VOWcS7URd@orome>
References: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
 <cb79d313-c7a2-42e9-639a-63cb5366521a@gmail.com>
 <ca531c1a-3c62-5fb1-6765-68ec1e541483@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="viCwK5jD5+sqkLig"
Content-Disposition: inline
In-Reply-To: <ca531c1a-3c62-5fb1-6765-68ec1e541483@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--viCwK5jD5+sqkLig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2023 at 09:23:35AM +0200, Neil Armstrong wrote:
> On 13/04/2023 07:54, Heiner Kallweit wrote:
[...]
> > diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
[...]
> > @@ -271,16 +255,16 @@ static int meson_pwm_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> >   			/*
> >   			 * This IP block revision doesn't have an "always high"
> >   			 * setting which we can use for "inverted disabled".
> > -			 * Instead we achieve this using the same settings
> > -			 * that we use a pre_div of 0 (to get the shortest
> > -			 * possible duration for one "count") and
> > +			 * Instead we achieve this by setting an arbitrary,
> > +			 * very high frequency, resulting in the shortest
> > +			 * possible duration for one "count" and
> >   			 * "period =3D=3D duty_cycle". This results in a signal
> >   			 * which is LOW for one "count", while being HIGH for
> >   			 * the rest of the (so the signal is HIGH for slightly
> >   			 * less than 100% of the period, but this is the best
> >   			 * we can achieve).
> >   			 */
> > -			channel->pre_div =3D 0;
> > +			channel->rate =3D 1000000000;
> >   			channel->hi =3D ~0;
> >   			channel->lo =3D 0;
>=20
> This looks like a really bad idea... please don't do that and instead int=
roduce
> some pinctrl states where we set the PWM pin as GPIO mode high/low state =
like we
> did for SPI:
> https://lore.kernel.org/r/20221004-up-aml-fix-spi-v4-2-0342d8e10c49@bayli=
bre.com

Yeah, absolutely. If the pin controller can do that, that's the right
way to implement the desired behavior.

Thierry

--viCwK5jD5+sqkLig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQ9DsIACgkQ3SOs138+
s6Hu9A//Y6qDIc+qtZCTOD6QrHlTZwNP4jZgVS/PunIv30X2bFreKZ8zMLX+ALYR
rpIyQqBxAt/W6PyIqRKr8sqkj7/qC32j4wziGuBLzclSFUsPCjHtbmwDhrRYVmbi
BFMqMtp7D0LiMBN9XSwVd1dgzSqSo7Fwip1PzH4++IKHFf8b8Jt3FiJrwmOgnncB
LsVTJJW3y7FlznWd0kWsnUjlkjPeP+5uNPTSRQm4OfkU8OdFmzIF8/JZHkSHwBQ2
31UAjJT14/KmNmVlHadU+T5433KN8AdDur/ZH3SJ4DinVYnH3lHTP/G8Bb8wHJUZ
Jf3r8S4M0RKtNS2HFpYwoy7JWknQAbpQOFupG6ZLKPyIdTQk2ee7h7QNNYFuq/9L
kHvd+32O/YejAf1Y0V8bbcCPgeaiT4gKYSXMKQXQ6cVN1Lrl1ExatJsHZ7fYJ0g3
OO9QeRw6Q5wCH534iZSDEzsqebyxPwLkYwHhtnLLPZElyT37puD9/m6L3/Xmo+W7
iOfT1duLDjlfJHJRY4M6PgQ29HvtpqEfA8Sxmg1OAkVSc4w94aZe2dEwGxcnD4p1
sXXbS/RAEqOoaG2MaRw0BcW1dmvw+Hc1EUXDEewIQC0nDxSlx0sYyKaLow30Wrp5
sVar/7H7Q7zsKTD2jrBUzrRdMBckab2jmOqoPyENCm4qT0X4JJQ=
=EYGJ
-----END PGP SIGNATURE-----

--viCwK5jD5+sqkLig--
