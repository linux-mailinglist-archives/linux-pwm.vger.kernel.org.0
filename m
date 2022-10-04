Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1A5F40F2
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Oct 2022 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJDKl5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 Oct 2022 06:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJDKl4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 Oct 2022 06:41:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FFF50503
        for <linux-pwm@vger.kernel.org>; Tue,  4 Oct 2022 03:41:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1offMz-0005sA-PM; Tue, 04 Oct 2022 12:41:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1offMz-004Xsu-PS; Tue, 04 Oct 2022 12:41:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1offMw-005Vuc-U0; Tue, 04 Oct 2022 12:41:46 +0200
Date:   Tue, 4 Oct 2022 12:41:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thomas Graichen <thomas.graichen@googlemail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] pwm: tegra: Optimize period calculation
Message-ID: <20221004104147.7bx5iwz7bx5dc5ir@pengutronix.de>
References: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
 <524ca143-e9d4-2a79-3e9e-c8b9ffc9f513@gmail.com>
 <20220815070935.guqzzlny7f6kcprc@pengutronix.de>
 <20220818075401.wguqvcbhzj5ttnio@pengutronix.de>
 <8ba9431b-b2bf-9fb0-9ba7-afeb2c3bce94@collabora.com>
 <20220921081721.l2bpeokwxy5pwfdh@pengutronix.de>
 <e109b19b-47a6-28b6-3eca-b45720637afe@nvidia.com>
 <Yy2iSuOiShnokwGL@orome>
 <CAOUEw12eDo2k5h+A05EHDkr4xDCQVw3O=2T-30KpFjhYRWhXmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wbwgvgriivqu65ja"
Content-Disposition: inline
In-Reply-To: <CAOUEw12eDo2k5h+A05EHDkr4xDCQVw3O=2T-30KpFjhYRWhXmw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wbwgvgriivqu65ja
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thomas,

On Tue, Oct 04, 2022 at 12:28:25PM +0200, Thomas Graichen wrote:
> On Fri, Sep 23, 2022 at 2:10 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > On Thu, Sep 22, 2022 at 12:12:31PM +0100, Jon Hunter wrote:
> > > Hi Uwe,
> > >
> > > On 21/09/2022 09:17, Uwe Kleine-K=F6nig wrote:
> > >
> > > ...
> > >
> > > > As the clk-rate is only 32768 Hz we get (with period_ns =3D 1000000)
> > > >
> > > >     32768 * 1000000 / (1000000000 << 8) =3D 0.128
> > > >
> > > > which is indeed rounded down to 0 and then runs into the error path
> > > > returning -EINVAL. Before my change (that now broke the backlight
> > > > configuration) configuration continued and then ended with actually
> > > > configuring period =3D 7812500 ns which is off by nearly a factor o=
f 8.
> > >
> > > I am seeing the same issue on Tegra210 Jetson Nano (device-tree
> > > tegra210-p3450-0000.dts). This also has a clock rate of 32768 Hz by
> > > default which means the min period is 30517ns. However, in the probe
> > > the min_period_ns comes from the pc->soc->max_frequency which is 48
> > > MHz for Tegra210. The min_period_ns =3D 1/(48 MHz / (2^8)) which is
> > > 5334ns. Hence, the actual min period is less than what is actually
> > > possible.
> > >
> > > I wonder if we should be warning about this and fixing the min
> > > period ...
> > >
> > > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > > index 2f3dcb9e9278..f72928c05c81 100644
> > > --- a/drivers/pwm/pwm-tegra.c
> > > +++ b/drivers/pwm/pwm-tegra.c
> > > @@ -310,9 +310,13 @@ static int tegra_pwm_probe(struct platform_devic=
e *pdev)
> > >          */
> > >         pc->clk_rate =3D clk_get_rate(pc->clk);
> > > +       if (pc->clk_rate < pc->soc->max_frequency)
> > > +               dev_warn(&pdev->dev, "Max frequency limited to %lu Hz=
!",
> > > +                        pc->clk_rate);
> > > +
> > >         /* Set minimum limit of PWM period for the IP */
> > >         pc->min_period_ns =3D
> > > -           (NSEC_PER_SEC / (pc->soc->max_frequency >> PWM_DUTY_WIDTH=
)) + 1;
> > > +           (NSEC_PER_SEC / (pc->clk_rate >> PWM_DUTY_WIDTH)) + 1;
> > >         pc->rst =3D devm_reset_control_get_exclusive(&pdev->dev, "pwm=
");
> > >
> > > The above does not fix this issue but ...
> > > > I didn't find a device tree for an Asus Transformer tablet bases on=
 a
> > > > tegra124 in the kernel source, but the options are:
> > > >
> > > >   - Revert commit 8c193f4714df ("pwm: tegra: Optimize period calcul=
ation").
> > > >     I don't like this. IMHO this commit is an improvement and the p=
roblem
> > > >     is that the consumer requests a too small period. For a backlig=
ht
> > > >     this might be ok to result in a much bigger period, for other
> > > >     usecases it isn't and so I like refusing period =3D 1000000.
> > > >
> > > >   - We could just drop the "else / return -EINVAL".
> > > >     This is inconsistent as then (again) some periods are rounded up
> > > >     (with the given clk rate that would be 5334 <=3D period < 78125=
00)
> > > >     while others (period < 5334) yield -EINVAL.
> > > >
> > > >   - Increase the period that the backlight is using to at least 781=
2500.
> > > >     This is done (I guess) by replacing 1000000 by 7812500 (or more=
) in
> > > >     the backlight's PWM phandle.
> > > >
> > > >   - Make the PWM clk faster.
> > > >     Looking quickly through the tegra clk driver, the parent of the=
 PWM
> > > >     clk could be changed from clk_32k to pll_p or pll_c. This shoul=
d be
> > > >     doable in the dts using something like:
> > > >
> > > >             assigned-clocks =3D <&tegra_car TEGRA124_CLK_PWM>;
> > > >     assigned-clock-parents =3D <&tegra_car TEGRA124_CLK_PLL_P>;
> > > >
> > > >     in the pwm node. (Note this includes much guesswork, I don't kn=
ow the
> > > >     PPL's clk-rate, so this might break in other ways. Another opti=
on is
> > > >     using PLL_C.)
> > > >
> > > > Probably the latter is the nicest option. Is it possible to find ou=
t the
> > > > setting when the machine is running the original vendor OS?
> > >
> > > The latter does seem correct to me. This fixes the issue for Tegra210=
 ...
> > >
> > > diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/bo=
ot/dts/nvidia/tegra210.dtsi
> > > index 4f0e51f1a343..842843e0a585 100644
> > > --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> > > +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> > > @@ -670,6 +670,10 @@
> > >                 clock-names =3D "pwm";
> > >                 resets =3D <&tegra_car 17>;
> > >                 reset-names =3D "pwm";
> > > +
> > > +               assigned-clocks =3D <&tegra_car TEGRA210_CLK_PWM>;
> > > +               assigned-clock-parents =3D <&tegra_car TEGRA210_CLK_P=
LL_P>;
> > > +
> > >                 status =3D "disabled";
> > >         };
> >
> > Traditionally we've always set the clock parent in the driver via the
> > init table (at least on chips prior to Tegra186). On the other hand we
> > have a few occurrences of assigned-clock-rates already for Tegra210. I
> > don't feel strongly either way. A minor advantage of having the fix in
> > the clock driver is that it fixes this automatically for older device
> > trees. Not that it really matters since people always update kernel and
> > DTB at the same time on Tegra devices.
> >
> > It'd be great if we could get confirmation that changing the parent
> > clock fixes this on all other boards as well, then we can fix it at the
> > same time for all of them.
> >
> > Thierry
>=20
> just a little update: i just compiled a v6.0 kernel for the nyan
> chromebook (tegra124) and now the display remains completely black -
> with v5.19 it was at least working with broken brightness control -
> reverting the pwm optimization patch it works perfectly fine in both
> cases ... please let me know if you have any patches i should test to
> fix this

You might want to test

https://lore.kernel.org/linux-clk/20221003101555.25458-1-jonathanh@nvidia.c=
om

(Hmm, tegra124 !=3D tegra210? Then something similar should be done for
tegra124?)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wbwgvgriivqu65ja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM8DegACgkQwfwUeK3K
7AlIVgf/Tcmig8Ju2M07YFX3jmaYsH/LoZ7FJWit9fhijB3Oht4XUkABUS9Dj10y
D/wD/0PpZzfxKUjM6Am0uSBAbddKEM45ld1Qr6V4NvKF3sjv1goSKEm4xgh1SDiQ
H2mlty3nspHnkk/X+6iinDX3dpGdRSH+4QoYA+AnMfnj2vdm3l3mPVH3WIlNCg+Z
2+vc9C2637/K6TTwinz/z2qsWt/XPr97ceU3U7EoXiP8vj36Hez2hizAlUzoPgqS
soPVNUKBjqM1MOr2mx8ZWwzUfuobpjq3GjvAfW07d2deqiJZsEHxEYthhGm3/q22
UCKwrnfc47PvXtHfrCv9CMDZDiKffw==
=kgdZ
-----END PGP SIGNATURE-----

--wbwgvgriivqu65ja--
