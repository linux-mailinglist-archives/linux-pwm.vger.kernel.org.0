Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544D75BFEF6
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Sep 2022 15:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiIUNcg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Sep 2022 09:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIUNcf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Sep 2022 09:32:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749AE8A7EC
        for <linux-pwm@vger.kernel.org>; Wed, 21 Sep 2022 06:32:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oazq0-0007yt-15; Wed, 21 Sep 2022 15:32:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oazq0-0024IB-5X; Wed, 21 Sep 2022 15:32:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oazpx-002T0u-MB; Wed, 21 Sep 2022 15:32:25 +0200
Date:   Wed, 21 Sep 2022 15:32:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-pwm@vger.kernel.org,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-tegra@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] pwm: tegra: Optimize period calculation
Message-ID: <20220921133222.bzqnjv5sodynqseg@pengutronix.de>
References: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
 <524ca143-e9d4-2a79-3e9e-c8b9ffc9f513@gmail.com>
 <CAPVz0n1Xy=feSqw7_bvNw17=xVGnk2yhAMFmyfddU128dU+5qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="shqlbnkkxakaeoiu"
Content-Disposition: inline
In-Reply-To: <CAPVz0n1Xy=feSqw7_bvNw17=xVGnk2yhAMFmyfddU128dU+5qQ@mail.gmail.com>
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


--shqlbnkkxakaeoiu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Svyatoslav,

On Wed, Sep 21, 2022 at 12:33:48PM +0300, Svyatoslav Ryhel wrote:
> Asus Transformers are based on T20 and T30 SoC.
>=20
> Thanks for your patience, I am enclosing the pwm trace you requested. It =
is
> taken from Asus Transformer TF700T owned by Maxim Schwalm (he is included
> into this mailing list but was not able to send trace).
>=20
> Best regards. Svyatoslav R.

Yeah, it seems several devices are affected. The one with a tegra124 was
a Nyan one.

> cat /sys/kernel/debug/tracing/trace
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 26/26   #P:4
> #
> #                                _-----=3D&gt; irqs-off/BH-disabled
> #                               / _----=3D&gt; need-resched
> #                              | / _---=3D&gt; hardirq/softirq
> #                              || / _--=3D&gt; preempt-depth
> #                              ||| / _-=3D&gt; migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>  gsd-backlight-h-2626    [001] .n...   161.995352: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D439215 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2631    [001] .....   162.148999: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D486274 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2635    [001] .....   162.315167: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D674509 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2639    [001] .....   162.472855: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D1113725 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2643    [000] .....   162.672130: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D1584313 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2647    [000] .....   162.897159: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D2101960 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2653    [000] .....   163.094710: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D2462745 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2657    [000] .....   163.290172: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D1505882 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2661    [001] .....   163.491553: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D831372 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2665    [001] .....   163.749862: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D439215 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2669    [001] .....   163.922487: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D47058 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2809    [002] .....   313.762043: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D94117 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2814    [003] .....   313.901480: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D643137 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2821    [003] .....   314.033686: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D1427450 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2825    [003] .....   314.168334: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D2101960 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2829    [002] .....   314.294098: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D2729411 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2833    [002] .....   314.424415: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D3560784 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2837    [002] .....   314.530186: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D3843137 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2855    [003] .....   315.054516: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D4000000 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2865    [003] .....   322.214140: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D3717647 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2874    [002] .....   322.446465: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D1976470 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2878    [002] .....   322.583918: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D721568 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2882    [001] .....   322.682135: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D282352 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2914    [001] .....   324.240133: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D407843 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2918    [003] .....   324.376497: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D250980 polarity=3D0 enabled=3D1
>  gsd-backlight-h-2922    [001] .....   324.479360: pwm_apply: 94faa5b6: p=
eriod=3D4000000 duty_cycle=3D47058 polarity=3D0 enabled=3D1

Assuming the parent clk rate of the PWM clock is running at 32768 Hz,
too, the problem is the same.

Maybe

diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arch/=
arm/boot/dts/tegra30-asus-transformer-common.dtsi
index c27e70d8bf2b..8e8cf0abd680 100644
--- a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
@@ -1115,6 +1115,10 @@ bluetooth {
=20
 	pwm@7000a000 {
 		status =3D "okay";
+
+		/* To ensure a faster clock than TEGRA30_CLK_CLK_32K */
+		assigned-clocks =3D <&tegra_car TEGRA30_CLK_PWM>;
+		assigned-clock-parents =3D <&tegra_car TEGRA30_CLK_PLL_P>;
 	};
=20
 	lcd_ddc: i2c@7000c000 {

helps?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--shqlbnkkxakaeoiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMrEmMACgkQwfwUeK3K
7AnBUwf/TcKgYUhHQLkNX2WjrWi69VHL4d9BWnvog4khbcoCk+6OkgKNFCUUNOFf
6pk7lEkto6UbO96AiMq1MjEGxL6xFxlyg5UzOzIck91d8z5z3LHEwungelX03glZ
5lhn8UWjRUGHLkMgxop/zK9lIKQpv9JHNNJ4ph/iI+y69QmeRftKe/QOuX0A6WhC
jDTzpa7YhacA9gYe7r3sqhb/Lb1xax5xU72Wmtd+Ykf1GLBjxY2zdwcFRWHY+Xkz
SqL/7TFRD16gRFRk9gYA7nZm7jXTHqG1X/NnQfAFft+hvchLoLfjbOIKz2lreEYq
1ISIqW0cjbo/EdMRSG/14yMA2EmQLg==
=DWbp
-----END PGP SIGNATURE-----

--shqlbnkkxakaeoiu--
