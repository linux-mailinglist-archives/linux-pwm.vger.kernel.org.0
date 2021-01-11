Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94962F1299
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jan 2021 13:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbhAKMyl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jan 2021 07:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbhAKMyl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jan 2021 07:54:41 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73436C061794;
        Mon, 11 Jan 2021 04:54:00 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a6so13731867wmc.2;
        Mon, 11 Jan 2021 04:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jDh7bR5KL1i+zrcnAe+RgQgH4cW7c4bLFBL7OnmiPNg=;
        b=NlLdCIglQue47msebGNg1KLuPv6LZbFfyxII8Slx8pBwyqBPa6ls5HoEi70qPLQNhO
         m2xDgGfL0Ftld8qKSac48KG0MOYTfqa94Ix4DPTyl7LrTKTDQiwR4i9RJAVd3vVOownF
         Ofg9RGCRZWDtUaXXb+sTyN4d7Nh8PAnw1oqadWXBj5gGdPDbNeJZy+LlIaJuuQpGvUci
         ZUNq0g/+XjwYLjWZB0gKxTEwWFnDuWdghk5mxWeDAEXqawf1/7zwObw2DGRRtHk1HDR0
         lTTJ8zgk+hKBLK1gbFxfVZ3MNzmXJwZSKz7Hb5u3c4EzcDtre+MoDZq63sPJvL47Ne0I
         uX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jDh7bR5KL1i+zrcnAe+RgQgH4cW7c4bLFBL7OnmiPNg=;
        b=l35ww8JNfsLXhc7xkGqNn+rZEZOj8mU3si9e+QyO+fcXI+QSYdCihVTFtAo2F6oanj
         o++2pECcsNplF8iHPi2dpwWjSnbFJ2sc/DxpLxQk4vMo75bfQHSmf87Afm9Osk0uEvop
         Jp8fGXmOWRw0HrBCFEKP0e5qdNXg9nyfFNrVkjhDNa36fXH1vxJcEV9iiRrsImCixnYl
         8wJlN/t8XgIAnEhvkuyDDnrEkScXbHJwuhGCnBasoFOhHQ1YR+U+kVkL2K2GFAoJtULU
         qcLdN/zZLmnKnwJvUkYRv3xQNYgmbC6OOOXclSnstfhPtTcEhKzdHmtXzB/euqtgCuOV
         i0Xg==
X-Gm-Message-State: AOAM531wy2wzvHWESrdgJdIGzDr/51PT8z8Fu+qFj9k493LPEt4o3Ahq
        I1rbX2fJGhGMW5EvNqOO5rE=
X-Google-Smtp-Source: ABdhPJyQ5vYl+NC8F2jQ3VqSj2hFvYa4apLxrSS90IaASq+Z7CKZ8HXEd4QpYqawDmN5A9Sxx93vRg==
X-Received: by 2002:a1c:2605:: with SMTP id m5mr14595416wmm.111.1610369639184;
        Mon, 11 Jan 2021 04:53:59 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id y2sm21195511wma.6.2021.01.11.04.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 04:53:57 -0800 (PST)
Date:   Mon, 11 Jan 2021 13:53:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <X/xKZI04ipiQCUjd@ulmo>
References: <20210109180220.121511-1-j.neuschaefer@gmx.net>
 <20210109180220.121511-5-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z0ToN2/Ipg8oub5U"
Content-Disposition: inline
In-Reply-To: <20210109180220.121511-5-j.neuschaefer@gmx.net>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--z0ToN2/Ipg8oub5U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 09, 2021 at 07:02:17PM +0100, Jonathan Neusch=C3=A4fer wrote:
> The Netronix EC provides a PWM output which is used for the backlight
> on some ebook readers. This patches adds a driver for the PWM output.
>=20
> The .get_state callback is not implemented, because the PWM state can't
> be read back from the hardware.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
> v7:
> - no changes
>=20
> v6:
> - https://lore.kernel.org/lkml/20201208011000.3060239-5-j.neuschaefer@gmx=
=2Enet/
> - Move period / duty cycle setting code to a function
> - Rename pwmchip_to_priv to ntxec_pwm_from_chip
> - Set period and duty cycle only before enabling the output
> - Mention that duty=3D0, enable=3D1 is assumed not to happen
> - Interleave writes to the period and duty cycle registers, to minimize t=
he
>   window of time that an inconsistent state is configured
>=20
> v5:
> - https://lore.kernel.org/lkml/20201201011513.1627028-5-j.neuschaefer@gmx=
=2Enet/
> - Avoid truncation of period and duty cycle to 32 bits
> - Make ntxec_pwm_ops const
> - Use regmap_multi_reg_write
> - Add comment about get_state to ntxec_pwm_ops
> - Add comments about non-atomicity of (period, duty cycle) update
>=20
> v4:
> - https://lore.kernel.org/lkml/20201122222739.1455132-5-j.neuschaefer@gmx=
=2Enet/
> - Document hardware/driver limitations
> - Only accept normal polarity
> - Fix a typo ("zone" -> "zero")
> - change MAX_PERIOD_NS to 0xffff * 125
> - Clamp period to the maximum rather than returning an error
> - Rename private struct pointer to priv
> - Rearrage control flow in _probe to save a few lines and a temporary var=
iable
> - Add missing MODULE_ALIAS line
> - Spell out ODM
>=20
> v3:
> - https://lore.kernel.org/lkml/20200924192455.2484005-5-j.neuschaefer@gmx=
=2Enet/
> - Relicense as GPLv2 or later
> - Add email address to copyright line
> - Remove OF compatible string and don't include linux/of_device.h
> - Fix bogus ?: in return line
> - Don't use a comma after sentinels
> - Avoid ret |=3D ... pattern
> - Move 8-bit register conversion to ntxec.h
>=20
> v2:
> - https://lore.kernel.org/lkml/20200905133230.1014581-6-j.neuschaefer@gmx=
=2Enet/
> - Various grammar and style improvements, as suggested by Uwe Kleine-K=C3=
=B6nig,
>   Lee Jones, and Alexandre Belloni
> - Switch to regmap
> - Prefix registers with NTXEC_REG_
> - Add help text to the Kconfig option
> - Use the .apply callback instead of the old API
> - Add a #define for the time base (125ns)
> - Don't change device state in .probe; this avoids multiple problems
> - Rework division and overflow check logic to perform divisions in 32 bits
> - Avoid setting duty cycle to zero, to work around a hardware quirk
> ---
>  drivers/pwm/Kconfig     |   8 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-ntxec.c | 182 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 191 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ntxec.c

Lee, I assume you'll want to pick the whole set up into the MFD tree? If
so:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--z0ToN2/Ipg8oub5U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/8SmEACgkQ3SOs138+
s6F/3A//SWDNFJM/BhmTosI1HQsrkThdPJ11VkCRyPXOQS4HAWN4ks5Lkds6b0yo
90Pv/UecjXvliFivSNcUeXNUOLeVIm3Wy37/H9D3obOayyvssEaPpv5HYYQ2HkUW
4km3iHOvxG2hD3s0K6FoCPcTIzp3BgVSn8D3TZr+xXlVPEijevLwAtd7h9SYQDLy
f7Eie32+fGLfM/hxDKIfz6gBhL5b1DlWP33RjOtMVVjUvLao1z7rOZGw3BU0Y6MP
z+jDt4b8YKyJ0npSpCOD6ZzOQiynWYmi6+cCbza6C43/o6B9nW+loFBtUcNBg75J
ft++3twZkMXGmdGWoaPMZdxYE/kiO1jmfxICWdJHEeRC4+VUJylNqpkZHhApsd2y
IQBECMBXfdOVVv6xDTM7wyYlGlbHWeDyK4ak21HkLEWucyKx0q74DKujCtONJFCQ
0YRiGVSa1/8tSLOmq3slq6qlx8O30l6yPXyvrHXHozZRqeAjBSGowAIjYfzJX0KC
ik4nyuMOnLqV2Up0hjYForCaQkVyKd1RRDR7iG32ujuaje3v7jOiKHC6+PNbLRmt
iL0nhcROYuTlIA4ubZIusiA8Tky2HadiG6mK56RR6eFA3FDY6OdWqxOPZskhbfzZ
RL66muGfOuKGuNZNHjawwUhozK8Nopkp74nYDxIesQU1dfn/1kA=
=XjN2
-----END PGP SIGNATURE-----

--z0ToN2/Ipg8oub5U--
