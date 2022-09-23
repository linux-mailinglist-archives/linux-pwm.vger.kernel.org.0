Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637495E7A70
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Sep 2022 14:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiIWMV5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Sep 2022 08:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiIWMUU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Sep 2022 08:20:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8519313EEA5;
        Fri, 23 Sep 2022 05:11:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sb3so199726ejb.9;
        Fri, 23 Sep 2022 05:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=HbdDPH64F/izZR7ly2QOBIXzT+xP+w0S1Cpx1XabKT0=;
        b=LCQRSkiR8pebrQ8zexz+ngPqmB4zsLXBzr/xzvJumSthcPcvG0uQszsAg5ejgEnaI/
         gbrAnXGsf1eBCQ1BiYa3OIz81BD2VIbIxQutwkIPuprDniOTz08MGatUjKeWFZkwuq4W
         h/mHhX9VV8w2whNHijV2Wx1MWDL08t66nTTyEVxSjo/FQh07vc7ZeTrZmGTSiqtOOmLN
         HXC6+2Fvi6SAWOav74X1fFFwaWyXsj12ud/+MSNsQ1TCZ0UmdLb4LBodzWlwaRWTXQd4
         +XXp0cmPzSp3P9OpXvng6J0IgrOxySDtvm4Q2UEJ3HeJk85wd3PniH3ci8D0e3FLho4+
         69ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HbdDPH64F/izZR7ly2QOBIXzT+xP+w0S1Cpx1XabKT0=;
        b=xFTYthiTkv5jT8ZHI9MzoFGjYJQ+X+r3oWr0Pneln0rQb1wYN8eDOyYV+NI2LERRQH
         s3i+EHbcdKjlV8wVmOuLC1RXqsMXhUS6TdUYjW570EnE0urWOKjUPtyJwCfDE8FDTQdT
         7iy2VBhM0GHRas0IMjjV1PBzlrYwlo1UhxwErG03LHj1ikiHmjt6VRTCEpYpZHgUXoc7
         2nhgb+ZuhoDyIc2qbGdIpVPerEA5MTJEV+fED9oWfdfySV0tj/kmKQNWsnFqJ8465YaI
         rnHz75gYq+y+L6qK7w/K4Bb1dExk44IaHb4kY6O77DhJXIdpTj3H+vUHHPlCbRb2mrJc
         1xwg==
X-Gm-Message-State: ACrzQf2dqxWhcyXUgsSovNYNsC6s7Eny7dVtiULTThpcjHk8CJmrCI8r
        xu6SuloviuAmfVhj9dGKATc=
X-Google-Smtp-Source: AMsMyM6V955/ZnDV5ju2ltP+LfSZbkCNHpFbRAMr0+FfG1uQIJiCCKugTq8hM/mtt3b+uIouxV0EXg==
X-Received: by 2002:a17:906:cc10:b0:77b:df70:efd2 with SMTP id ml16-20020a170906cc1000b0077bdf70efd2mr7062565ejb.590.1663935053686;
        Fri, 23 Sep 2022 05:10:53 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g7-20020aa7c847000000b0044e01e2533asm1176727edt.43.2022.09.23.05.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 05:10:52 -0700 (PDT)
Date:   Fri, 23 Sep 2022 14:10:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pwm@vger.kernel.org,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>, kernel@pengutronix.de,
        linux-tegra@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] pwm: tegra: Optimize period calculation
Message-ID: <Yy2iSuOiShnokwGL@orome>
References: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
 <524ca143-e9d4-2a79-3e9e-c8b9ffc9f513@gmail.com>
 <20220815070935.guqzzlny7f6kcprc@pengutronix.de>
 <20220818075401.wguqvcbhzj5ttnio@pengutronix.de>
 <8ba9431b-b2bf-9fb0-9ba7-afeb2c3bce94@collabora.com>
 <20220921081721.l2bpeokwxy5pwfdh@pengutronix.de>
 <e109b19b-47a6-28b6-3eca-b45720637afe@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iKShUJFSt12tYGZM"
Content-Disposition: inline
In-Reply-To: <e109b19b-47a6-28b6-3eca-b45720637afe@nvidia.com>
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


--iKShUJFSt12tYGZM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2022 at 12:12:31PM +0100, Jon Hunter wrote:
> Hi Uwe,
>=20
> On 21/09/2022 09:17, Uwe Kleine-K=C3=B6nig wrote:
>=20
> ...
>=20
> > As the clk-rate is only 32768 Hz we get (with period_ns =3D 1000000)
> >=20
> > 	32768 * 1000000 / (1000000000 << 8) =3D 0.128
> >=20
> > which is indeed rounded down to 0 and then runs into the error path
> > returning -EINVAL. Before my change (that now broke the backlight
> > configuration) configuration continued and then ended with actually
> > configuring period =3D 7812500 ns which is off by nearly a factor of 8.
>=20
> I am seeing the same issue on Tegra210 Jetson Nano (device-tree
> tegra210-p3450-0000.dts). This also has a clock rate of 32768 Hz by
> default which means the min period is 30517ns. However, in the probe
> the min_period_ns comes from the pc->soc->max_frequency which is 48
> MHz for Tegra210. The min_period_ns =3D 1/(48 MHz / (2^8)) which is
> 5334ns. Hence, the actual min period is less than what is actually
> possible.
>=20
> I wonder if we should be warning about this and fixing the min
> period ...
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 2f3dcb9e9278..f72928c05c81 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -310,9 +310,13 @@ static int tegra_pwm_probe(struct platform_device *p=
dev)
>          */
>         pc->clk_rate =3D clk_get_rate(pc->clk);
> +       if (pc->clk_rate < pc->soc->max_frequency)
> +               dev_warn(&pdev->dev, "Max frequency limited to %lu Hz!",
> +                        pc->clk_rate);
> +
>         /* Set minimum limit of PWM period for the IP */
>         pc->min_period_ns =3D
> -           (NSEC_PER_SEC / (pc->soc->max_frequency >> PWM_DUTY_WIDTH)) +=
 1;
> +           (NSEC_PER_SEC / (pc->clk_rate >> PWM_DUTY_WIDTH)) + 1;
>         pc->rst =3D devm_reset_control_get_exclusive(&pdev->dev, "pwm");
>=20
> The above does not fix this issue but ...
> > I didn't find a device tree for an Asus Transformer tablet bases on a
> > tegra124 in the kernel source, but the options are:
> >=20
> >   - Revert commit 8c193f4714df ("pwm: tegra: Optimize period calculatio=
n").
> >     I don't like this. IMHO this commit is an improvement and the probl=
em
> >     is that the consumer requests a too small period. For a backlight
> >     this might be ok to result in a much bigger period, for other
> >     usecases it isn't and so I like refusing period =3D 1000000.
> >=20
> >   - We could just drop the "else / return -EINVAL".
> >     This is inconsistent as then (again) some periods are rounded up
> >     (with the given clk rate that would be 5334 <=3D period < 7812500)
> >     while others (period < 5334) yield -EINVAL.
> >=20
> >   - Increase the period that the backlight is using to at least 7812500.
> >     This is done (I guess) by replacing 1000000 by 7812500 (or more) in
> >     the backlight's PWM phandle.
> >=20
> >   - Make the PWM clk faster.
> >     Looking quickly through the tegra clk driver, the parent of the PWM
> >     clk could be changed from clk_32k to pll_p or pll_c. This should be
> >     doable in the dts using something like:
> >=20
> >     	assigned-clocks =3D <&tegra_car TEGRA124_CLK_PWM>;
> > 	assigned-clock-parents =3D <&tegra_car TEGRA124_CLK_PLL_P>;
> >=20
> >     in the pwm node. (Note this includes much guesswork, I don't know t=
he
> >     PPL's clk-rate, so this might break in other ways. Another option is
> >     using PLL_C.)
> >=20
> > Probably the latter is the nicest option. Is it possible to find out the
> > setting when the machine is running the original vendor OS?
>=20
> The latter does seem correct to me. This fixes the issue for Tegra210 ...
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra210.dtsi
> index 4f0e51f1a343..842843e0a585 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> @@ -670,6 +670,10 @@
>                 clock-names =3D "pwm";
>                 resets =3D <&tegra_car 17>;
>                 reset-names =3D "pwm";
> +
> +               assigned-clocks =3D <&tegra_car TEGRA210_CLK_PWM>;
> +               assigned-clock-parents =3D <&tegra_car TEGRA210_CLK_PLL_P=
>;
> +
>                 status =3D "disabled";
>         };

Traditionally we've always set the clock parent in the driver via the
init table (at least on chips prior to Tegra186). On the other hand we
have a few occurrences of assigned-clock-rates already for Tegra210. I
don't feel strongly either way. A minor advantage of having the fix in
the clock driver is that it fixes this automatically for older device
trees. Not that it really matters since people always update kernel and
DTB at the same time on Tegra devices.

It'd be great if we could get confirmation that changing the parent
clock fixes this on all other boards as well, then we can fix it at the
same time for all of them.

Thierry

--iKShUJFSt12tYGZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMtokcACgkQ3SOs138+
s6GzHxAAtZgktIWYaVh0FtY0458PpKea4nibQJyxwuu3tU5ETy4/sTZKVJ1Mm3KP
ZPGlS2Al6R+ly1JAoDhBwPZUMdD4lDf0gvINOCtX/bRMoSGAsLqGVpRs9WG+2wth
xALirq1/qot/v7ewgQKiksyVgNaQMba2+9l8uqGyNJc4LRXeCFZqBIDR81iHrqsS
C0IbQmimICmfoVQoVU5nOxtVk5ozdMF3pdJPQu2cHIBI3IwV6sAlChmQZgkzvlY9
UBDN6xXVEIDBCyRKR/AXF9xlqnP2Vaotfo2jMs7YrIuCCgfhUbYtMBwP52KoyeZi
COyja2A1mid/xaOXWRjBSsA/waiuvLdeY1vhJt0+JJH3xHoh6qBA3z5tYQ5mdf6T
mzNOJQwlNMx8TawB93mYU6fN8du5i6zhWbnVZCLdpNW5Xp/L4XUo4dQbciT2MJTf
kWPQnkPNkRWEUnVG6JYQuUd1q7JEBgZjBmhkcWVn52xEAJ/xS7LtWklDrQYkmV6f
WPVC2VnWDN7GBCQonYV08tNORC6Y0VWuMBqZ4ska3OVg6YbM6DOEF0XSzyKkMyFL
rp+w1713kFH4MMb5P5jedbdUHuAB7YshX5PeRuEED4PuahRbf0ZQAVKdXr8+VGUl
Zxmv0Mqb6KzzHZjl94DzpnZ7X4agZdhBVj4tLABwDuitBUF6wBg=
=SVA+
-----END PGP SIGNATURE-----

--iKShUJFSt12tYGZM--
