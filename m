Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBA42D63A9
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Dec 2020 18:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392776AbgLJRex (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Dec 2020 12:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389670AbgLJRev (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Dec 2020 12:34:51 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D345CC061793
        for <linux-pwm@vger.kernel.org>; Thu, 10 Dec 2020 09:34:10 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id jx16so8464684ejb.10
        for <linux-pwm@vger.kernel.org>; Thu, 10 Dec 2020 09:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rrL2bOmT1FBx9qmJXz0d6RtUimYLtADxxXCD/KXUmAw=;
        b=cJxorjfPWtteqJeaZbrfizctbVKihavleCrtjV/i12pOJBxwNd2OFiuJBohLmyVye4
         R+iDZAcCGsSdss6sRw4EiqWDK3zQCBzQs56zlibRETWcoSszMf9VzOuBnY/OML7L69PW
         V0C5xME/aLlX4+W/f4iI1Z/91HMnBJLuPNEu4Qaxy2SO2Xr+s8dfOriR9yq70hmZ8rLe
         pu0UNvh5XxQD0WvViP2nIOY9tCxW9/O23qx7OghOnazA6yqZQZaTw9pINHrLxP0Po+Kd
         ksdny9nVJ+ngt7nx/+MmjD60LBtLSOoInIUJQ3hHz6tMbklMUb5hlJ7/tsi2R7D9rfBl
         Ybiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rrL2bOmT1FBx9qmJXz0d6RtUimYLtADxxXCD/KXUmAw=;
        b=aaVghUnF1O2zo3DjNq20BTPFGIqM/DGaaDGOzEcO2zFDvQ9EBn4OnR95BhYRZ8WeKr
         cmtea1cVe50dSm8X0TN5HVQUQUCyoKuIlzt7u06iK8cspcc9myc75LnQdYVrfR0vk17S
         BSnCVQnJkxIwCZOgDSoenGTalWZiGVMcmV50JXjp1E2cb1Y9uJEK4vrSKaQb5ftrHFV1
         r9E4CvFQvqAsuPvAw52wW8bqqryAeZkzOoVvIZJLUFNlKAB+4ZxTuhccHU6alPx9arVX
         n339cwZMbdbRHEQ/QbiX9ECfxTZRBvH8SBKvtTXIqGaAaL2RYrezHdbOJBfQ4PxhhN0I
         dwNA==
X-Gm-Message-State: AOAM531nz67+PhklVzlK0F86QSf9WY6BnX1etIqRwFHz19R9r4RsXM9q
        ftPAJUlLro1T2Vn+l8uelAezuc3dTAE=
X-Google-Smtp-Source: ABdhPJyQHi+drCeeVbkkB5SoKCYxxuhzqCnr28c2VQsAKzFkzZAOm+GL1dyCGZVbdsz/JQF5AgDTOw==
X-Received: by 2002:a17:906:aec6:: with SMTP id me6mr272945ejb.542.1607621649620;
        Thu, 10 Dec 2020 09:34:09 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id c11sm5645206edx.38.2020.12.10.09.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:34:08 -0800 (PST)
Date:   Thu, 10 Dec 2020 18:34:07 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Johannes Pointner <h4nn35.work@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] pwm: imx27: fix overflow for bigger periods
Message-ID: <X9JcD5y4U/bLCc0N@ulmo>
References: <20201207141324.25945-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tjldQAiH1ajvDz2B"
Content-Disposition: inline
In-Reply-To: <20201207141324.25945-1-uwe@kleine-koenig.org>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tjldQAiH1ajvDz2B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 07, 2020 at 03:13:24PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The second parameter of do_div is an u32 and NSEC_PER_SEC * prescale
> overflows this for bigger periods. Assuming the usual pwm input clk rate
> of 66 MHz this happens starting at requested period > 606060 ns.
>=20
> Splitting the division into two operations doesn't loose any precision.
> It doesn't need to be feared that c / NSEC_PER_SEC doesn't fit into the
> unsigned long variable "duty_cycles" because in this case the assignment
> above to period_cycles would already have been overflowing as
> period >=3D duty_cycle and then the calculation is moot anyhow.
>=20
> Fixes: aef1a3799b5c ("pwm: imx27: Fix rounding behavior")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> ---
> Hello,
>=20
> for a similar patch I said "that looses more precision than I thought at
> first", but I think this was wrong. And if it looses precision the same
> applies to the calculation of period_cycles which uses the same
> operations.
>=20
> I'm a bit at doubt how urgent this patch is. The regression was
> introduced in 5.8-rc1.

Well, given that this has been broken in v5.8 and v5.9 and was only
reported a couple of days ago, it doesn't seem like this is very urgent.
At the same time, it's a regression, so we should get this fixed as soon
as possible.

That said, I'm reluctant to send this to Linus without a bit of soak
time in linux-next. So let me put it in linux-next for now and if
there's an rc8 I'll send a PR next week. Otherwise it'll get picked up
into an early stable release and that's probably okay as well.

Thierry

--tjldQAiH1ajvDz2B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/SXA0ACgkQ3SOs138+
s6F9ag/6AyxRt82sofjlYYk1g8aqA3hdrYgDYapFlXl7yWuBoQ/tS8cmAXHvAcpw
2t1KlRkSWPFx5jYShPqY29rGbUZDFRe4Nr+n5NOGhKxX8e/XXMziRx7KUsx8VOGd
PM+gKr/CucOfEERbtYolvaaeYvsIMhg9SPmxAxFT6T/6yRR23Fh9wtkpxKYpL9MA
sQMbx9oLeU9BNoQ4gTi44bp0xPc9tqrBiT+1QepRnVTa0IO6klMdKGOaU4mdDCyP
ATH+03uGf2AnQSJx/yH0Nq2rysFvihtQ5mEEwvI3J1ALKDweBBWTxfCKC00XLcYW
jdrF6CYfa97XdgEUDwuukgJP1b59sj+4ydaRbegdYwu9+EroLJCoSFPJ6d1Argc1
TbbZg5qDrctQ2bDHhmY+pbcFqFQ1UCDEeCf1YXbmaocbJO9vUcBMuUbShH/ljnbw
JHbT0iqFQpVnAhOjnr6yKGVA/qrK+SDXa51ieXVP1qHk34aIuPMWhY9X8fSA5juI
3eaqQ7ULW3jGt3UubuLnR9npYtfMYDuoQdKbSRIiwCbMTvAOisitVC6yWffvfZHb
oJkDLGXhrFMABUByfX+4MEV2wJQOvagtTLTZFQ9Zm/kAWF/MKjnoahHbw8B1TB1F
3C4G6sgf0AkCgOMA5cvJBaBIbscxV9ltjjklPo76WeessdJNaB0=
=Wmw4
-----END PGP SIGNATURE-----

--tjldQAiH1ajvDz2B--
