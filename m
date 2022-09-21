Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF095BF8D7
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Sep 2022 10:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiIUISY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Sep 2022 04:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiIUISL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Sep 2022 04:18:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789DB357E1
        for <linux-pwm@vger.kernel.org>; Wed, 21 Sep 2022 01:17:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oauv8-0005em-Mn; Wed, 21 Sep 2022 10:17:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oauv9-0021IF-2Q; Wed, 21 Sep 2022 10:17:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oauv6-002Poo-Ve; Wed, 21 Sep 2022 10:17:24 +0200
Date:   Wed, 21 Sep 2022 10:17:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Thomas Graichen <thomas.graichen@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-pwm@vger.kernel.org,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-tegra@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] pwm: tegra: Optimize period calculation
Message-ID: <20220921081721.l2bpeokwxy5pwfdh@pengutronix.de>
References: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
 <524ca143-e9d4-2a79-3e9e-c8b9ffc9f513@gmail.com>
 <20220815070935.guqzzlny7f6kcprc@pengutronix.de>
 <20220818075401.wguqvcbhzj5ttnio@pengutronix.de>
 <8ba9431b-b2bf-9fb0-9ba7-afeb2c3bce94@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j25t6gyhxtnfubqw"
Content-Disposition: inline
In-Reply-To: <8ba9431b-b2bf-9fb0-9ba7-afeb2c3bce94@collabora.com>
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


--j25t6gyhxtnfubqw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

there was some off-list discussion about this problem. I summarize the
technical details and findings here.

On Thu, Aug 18, 2022 at 11:34:03PM +0300, Dmitry Osipenko wrote:
> On 8/18/22 10:54, Uwe Kleine-K=F6nig wrote:
> > On Mon, Aug 15, 2022 at 09:09:35AM +0200, Uwe Kleine-K=F6nig wrote:
> >> On Mon, Aug 15, 2022 at 03:28:25AM +0300, Dmitry Osipenko wrote:
> >>> This patch broke backlight on Asus Transformer tablets, they are now
> >>> getting this -EINVAL. The root of the problem is under investigation.
> >>
> >> This means that you requested a period that is smaller than the minimal
> >> period the hardware can implement.
> >>
> >> What is the clk rate of the PWM clk (i.e. pc->clk_rate?). Looking at
> >> arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi I guess period =
is
> >> 4000000. That in turn would mean that

I got some traces, and while I don't understand the whole picture yet,
they suggest the period is 1000000 ns only.

> >>
> >> 	mul_u64_u64_div_u64(pc->clk_rate, period_ns, (u64)NSEC_PER_SEC << PWM=
_DUTY_WIDTH)
> >>
> >> returned 0 which (with the assumption period_ns =3D 4000000) would imp=
ly
> >> the clk rate is less than 64000.

As the clk-rate is only 32768 Hz we get (with period_ns =3D 1000000)

	32768 * 1000000 / (1000000000 << 8) =3D 0.128

which is indeed rounded down to 0 and then runs into the error path
returning -EINVAL. Before my change (that now broke the backlight
configuration) configuration continued and then ended with actually
configuring period =3D 7812500 ns which is off by nearly a factor of 8.

I didn't find a device tree for an Asus Transformer tablet bases on a
tegra124 in the kernel source, but the options are:

 - Revert commit 8c193f4714df ("pwm: tegra: Optimize period calculation").
   I don't like this. IMHO this commit is an improvement and the problem
   is that the consumer requests a too small period. For a backlight
   this might be ok to result in a much bigger period, for other
   usecases it isn't and so I like refusing period =3D 1000000.

 - We could just drop the "else / return -EINVAL".
   This is inconsistent as then (again) some periods are rounded up
   (with the given clk rate that would be 5334 <=3D period < 7812500)
   while others (period < 5334) yield -EINVAL.

 - Increase the period that the backlight is using to at least 7812500.
   This is done (I guess) by replacing 1000000 by 7812500 (or more) in
   the backlight's PWM phandle.

 - Make the PWM clk faster.
   Looking quickly through the tegra clk driver, the parent of the PWM
   clk could be changed from clk_32k to pll_p or pll_c. This should be
   doable in the dts using something like:

   	assigned-clocks =3D <&tegra_car TEGRA124_CLK_PWM>;
	assigned-clock-parents =3D <&tegra_car TEGRA124_CLK_PLL_P>;

   in the pwm node. (Note this includes much guesswork, I don't know the
   PPL's clk-rate, so this might break in other ways. Another option is
   using PLL_C.)

Probably the latter is the nicest option. Is it possible to find out the
setting when the machine is running the original vendor OS?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--j25t6gyhxtnfubqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMqyI4ACgkQwfwUeK3K
7Ak5dwgAh3sQsDVuo/nr3QDlB8w1S+ywxxhfWqQCzWzLxzzFR3S3+nGU1wi84QOJ
5iOWAuxQ5AB/fJuNjym+NRCEMpUZn6BUWsnjEzKfwZjy/jmvOQLYOnB/hCMZModl
JPouRc5xniZQSnhkKNK+ClSnxJ+FsvOVWR7I/T4w/GXil3d9kBzV2DbE7VWSmH2I
QbAWYLH6XQsfu1tmkRvy0bmMdsNYG06CZX4dsLw5puT0nk4E4f9mtryFyr5Ct8qy
qV9AEEShGBzJTvR5XVq610afDvOrdDEMOwQZ86xoWMzyZTD8YVAP8Ih8T+h/t1d9
NTwzCLo/JnXLPxN5pQkUqKy4K0yFhQ==
=Tfdz
-----END PGP SIGNATURE-----

--j25t6gyhxtnfubqw--
