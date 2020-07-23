Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D8F22A90A
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jul 2020 08:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgGWGea (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Jul 2020 02:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgGWGe3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jul 2020 02:34:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A36C0619DC
        for <linux-pwm@vger.kernel.org>; Wed, 22 Jul 2020 23:34:29 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jyUoD-0008Pl-5F; Thu, 23 Jul 2020 08:34:25 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jyUoB-0001C2-NZ; Thu, 23 Jul 2020 08:34:23 +0200
Date:   Thu, 23 Jul 2020 08:34:20 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v4 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200723063420.rn4q74vasg54k6v7@pengutronix.de>
References: <cover.1593503228.git.rahul.tanwar@linux.intel.com>
 <a74b18b68f26bf902c30a017050cc4ea070da887.1593503228.git.rahul.tanwar@linux.intel.com>
 <20200713191059.zsokzvv3k2hyaxcl@pengutronix.de>
 <409ee148-a6a6-327f-e4d7-455f98ef4c66@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d5jj35vqcv44tli3"
Content-Disposition: inline
In-Reply-To: <409ee148-a6a6-327f-e4d7-455f98ef4c66@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--d5jj35vqcv44tli3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jul 23, 2020 at 12:16:18PM +0800, Tanwar, Rahul wrote:
> On 14/7/2020 3:10 am, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >
> > On Tue, Jun 30, 2020 at 03:55:32PM +0800, Rahul Tanwar wrote:
> >> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
> >> This PWM controller does not have any other consumer, it is a
> >> dedicated PWM controller for fan attached to the system. Add
> >> driver for this PWM fan controller.
> >>
> >> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> >> ---
> >>  drivers/pwm/Kconfig         |  11 ++
> >>  drivers/pwm/Makefile        |   1 +
> >>  drivers/pwm/pwm-intel-lgm.c | 266 +++++++++++++++++++++++++++++++++++=
+++++++++
> >>  3 files changed, 278 insertions(+)
> >>  create mode 100644 drivers/pwm/pwm-intel-lgm.c
>=20
> [...]
>=20
> >> +
> >> +static int lgm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> >> +			 const struct pwm_state *state)
> >> +{
> >> +	struct lgm_pwm_chip *pc =3D to_lgm_pwm_chip(chip);
> >> +	u32 duty_cycle, val;
> >> +	unsigned int period;
> >> +
> >> +	if (!state->enabled) {
> >> +		lgm_pwm_enable(chip, 0);
> >> +		return 0;
> >> +	}
> >> +
> >> +	period =3D min_t(u64, state->period, pc->period);
> >> +
> >> +	if (state->polarity !=3D PWM_POLARITY_NORMAL ||
> >> +	    period < pc->period)
> >> +		return -EINVAL;
> > This check looks wrong. If you refuse period < pc->period there isn't
> > much configuration possible.
>=20
> I am kind of stuck here. I made this change of adding a check
> period < pc->period based on your feedback on v2 patch.
> In fact, you had specified this code in v2 review feedback
> and i used the same exact code.

My feedback was nonsense, sorry. Now I don't understand anymore what I
thought. The check you proposed in v2 is perfectly fine.

> How should we handle it when the hardware supports fixed period.
> We don't want user to change period and allow just changing
> duty_cycle. With that intention, i had first added a strict check
> which refused configuration if period !=3D pc->period. Period is
> intended to be a read only value.
>=20
> How do you suggest we handle the fixed period hardware support?
> Would you have any reference example of other drivers which also
> supports fixed period? Thanks.
>=20
> [...]
> >> +static int lgm_pwm_remove(struct platform_device *pdev)
> >> +{
> >> +	struct lgm_pwm_chip *pc =3D platform_get_drvdata(pdev);
> >> +	int ret;
> >> +
> >> +	ret =3D pwmchip_remove(&pc->chip);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	clk_disable_unprepare(pc->clk);
> >> +	reset_control_assert(pc->rst);
> > Please swap the two previous lines to match the error patch of .probe.
>=20
> Again, i had made this change based on your below review feedback
> for v1. IMO, reverse of probe makes more sense.
>=20
> "In .probe() you first release reset and then enable the clock. It's good
> style to do it the other way round in .remove()."

Again my comment was nonsense, I'm sorry. I think I was irritated by the
fact that reset handling happens in between the clk stuff in probe. You
do there:

	devm_clk_get
	devm_reset_control_get_exclusive
	reset_control_deassert
	clk_prepare_enable

and I noticed that as "in probe clk handling is done first".

Looking at the other feedback I think my other comments are not BS.

Best regards and sorry again,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--d5jj35vqcv44tli3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8ZL2oACgkQwfwUeK3K
7AkTaAf+MtroLMbh+kPdFcEyRNOvCTYIKkWxU6avMtvNO0R13KywJo5Wtuepkjhg
IHwwaX24X2AquNZ24HtXnMfunLTGmnIpkDrtaKEkrWExyrI8KZgTZdwhbW9SHJzR
uhkdXl6E5p5rkz8dThregiCt7HfGyNQz8NHnqWBdB9Wz6/gSIsVX5+5dx0nkd8zZ
M9EGO3764K/pSBMqJuTRa4SuERpDp3YRDDjr3cYOQlVAyptVxVxJlAMfneyxB7Nk
9mNZLjs6eOn9VQAv3gLRTBM79kqP00nKY8N3csaENlFOBUQR9sylXdSEsMA9Q3eF
tSBdQQpNp7vUAEVVnVgq4/3k7oPhTQ==
=uN7r
-----END PGP SIGNATURE-----

--d5jj35vqcv44tli3--
