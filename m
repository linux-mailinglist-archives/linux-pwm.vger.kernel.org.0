Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6282E2FD75D
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Jan 2021 18:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbhATRm3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Jan 2021 12:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732755AbhATRiq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Jan 2021 12:38:46 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B402AC061575;
        Wed, 20 Jan 2021 09:38:00 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 19so26099320qkm.8;
        Wed, 20 Jan 2021 09:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fXzwMVogqDvK2f8fn8CTgEE+JZ+HrCHP+qXvVICM9to=;
        b=de2S+XDN4SetD2uJ6R5xNZS+NHJ3PlRiwed1XKZAtFi+eD36pCrXG54ylI7Cu4D2Mq
         DNmrJxJCwrZZ87I4DtgSJUdaEXKiXvlzvfMOnDcGsVDtnKcYiiesOM7kvWMk5RmIEIcn
         JrhacS5eJ12QDZVf+PzNCOJbXnp5kPjCcCa5PcovIOm+DMS6iUqjB71+XTGlKaPD3r+k
         mL2V7gpMekklrA7UQiwr83jPUJy3fAa7MCJDUJYGrUt+qGIenBxll6Z7i7Sr/pEMltZ5
         Pc0wl8mf6B6yw0gOiQxK/WEEA1pAY6Q3cYepuu0P716181T444uz0F8QctrrMmzwA4Dt
         rLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fXzwMVogqDvK2f8fn8CTgEE+JZ+HrCHP+qXvVICM9to=;
        b=nbYcVWNreRWqOpud49fFTeBzQkdHJ8PWnFLI8w8OJDrS5lpbEACUX41R0hKoJIGAJB
         gJEC13Ec1Y3IzN/U0mepkhcPULCKFYUXzgoPOrJVlQHuaSf8jZsgHQNgDC1yKbw/lsvg
         5TfyI7kxexQzMZn62YZlIcenb4cwbAnVupr8a5qbGnAc1k5oUEaoW19POnnQ7tzPoq18
         v+3554MAYFQqxFGQly6cDHjOk8RnYgiEkUjdChuxQfil1uowCq+MQUf1B1YJI9ssDzLU
         3BHnNLG4v4jLbK2gYWakpctALJ9/3hx5y7Op01x/ose2MJ6J2ZWuhKhMB+LiHL62zQw1
         EsFw==
X-Gm-Message-State: AOAM533ylTIhlTsDcEv0A1ZC4g2oPu0B98twg+3TmFIhWyKFpZK61Q7s
        /cQGcwVOXg32nkxSSRloNeI=
X-Google-Smtp-Source: ABdhPJzlm+CfygWXDAnwQfxgsHclgXc/ogYnn4aSL59U+RNQqGJUw3aMWdOu3o0hwSsLIY0K5aFiWw==
X-Received: by 2002:a37:a950:: with SMTP id s77mr10546135qke.122.1611164280028;
        Wed, 20 Jan 2021 09:38:00 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id k23sm1582944qtp.61.2021.01.20.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 09:37:58 -0800 (PST)
Date:   Wed, 20 Jan 2021 18:37:56 +0100
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
Subject: Re: [PATCH v8 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <YAhqdGMd/2Iviy2g@ulmo>
References: <20210116194826.3866540-1-j.neuschaefer@gmx.net>
 <20210116194826.3866540-5-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lBNzTqKU9kiRT1e4"
Content-Disposition: inline
In-Reply-To: <20210116194826.3866540-5-j.neuschaefer@gmx.net>
User-Agent: Mutt/2.0.4 (26f41dd1) (2020-12-30)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lBNzTqKU9kiRT1e4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 16, 2021 at 08:48:23PM +0100, Jonathan Neusch=C3=A4fer wrote:
> The Netronix EC provides a PWM output which is used for the backlight
> on some ebook readers. This patches adds a driver for the PWM output.
>=20
> The .get_state callback is not implemented, because the PWM state can't
> be read back from the hardware.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--lBNzTqKU9kiRT1e4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmAIanQACgkQ3SOs138+
s6EFrQ/9EEAHn2rbJKEm/DmKgeQNHRPrNspWJNLAd53/w8b0Eb4c7ujIzIEsgRNk
86gHze1V2P1dKsLKV+ySTJI5TcLmF6GW6I0IVf1uhivnEZ9PtHxniB3BORCZQZvF
Jk+RaVLggKutE8CJiiCYJAliVJ2/5jLGeTTsLTs14iKZ/a6x17Aw+M0Qvol9B33m
CfebZDSZzGM2/MbjtSNDfvXW8cYj9rf0bpMO8U8QO8gDmd4zKGsG53RFEmnfrtHa
ELKkOlUxesIery21g4utWAIdr9ElWV/rs55UuTdxn5PuaLkxQXqTiE04ZowMLnJ0
8+85TgNAYDR+8gJ1kTZRBxAfV17MIN0lRh+Mduzuius7DEzynTvSJ146xr6rO23s
lLB84rDocawfBd0kgjYY97axNfHPFiXo98Y+D3e7REdmg4XvV2Q/gkgOzlfQ5kUu
fd+a13gTJdlJuDQZfbylK7BKB8EQ5FMBCXp6LBstmkfHFVFkzIwRzBETQNC6PPXS
iXvVMWP7BiM8YXDvKK9msIPPUCHCC8kTDj6X0ugayoz+wezYtS+qqpEkv4UO9VoQ
jtpjl7aNGLZlymFv0g/R9J1Bsx0fSpKqG6kLUmTyz0b+Y49qkwEYvoye3kqqGvRp
pgoXtrlwLuotaKafrrzcigIEXmOZGw+jmgVcf2XrKscB8jyXqto=
=zLz8
-----END PGP SIGNATURE-----

--lBNzTqKU9kiRT1e4--
