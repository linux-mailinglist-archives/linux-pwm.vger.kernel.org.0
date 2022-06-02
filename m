Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10ABE53B483
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Jun 2022 09:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiFBHn3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Jun 2022 03:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiFBHn2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Jun 2022 03:43:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E6FF5A9
        for <linux-pwm@vger.kernel.org>; Thu,  2 Jun 2022 00:43:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nwfU8-0004nk-TQ; Thu, 02 Jun 2022 09:43:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nwfU8-005zF4-Fu; Thu, 02 Jun 2022 09:43:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nwfU6-00DgzZ-0z; Thu, 02 Jun 2022 09:43:10 +0200
Date:   Thu, 2 Jun 2022 09:43:06 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 2/2] pwm: Add support for RZ/G2L GPT
Message-ID: <20220602074306.4fp2fmf7fv4jfg5h@pengutronix.de>
References: <20220510144259.9908-1-biju.das.jz@bp.renesas.com>
 <20220510144259.9908-3-biju.das.jz@bp.renesas.com>
 <20220510163405.pts6mm7zdoxxpmqt@pengutronix.de>
 <OS0PR01MB59227827AD31CBD0CCC31A6A86DF9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bikcs47kodnn77gw"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59227827AD31CBD0CCC31A6A86DF9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bikcs47kodnn77gw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jun 01, 2022 at 07:25:28PM +0000, Biju Das wrote:
> > On Tue, May 10, 2022 at 03:42:59PM +0100, Biju Das wrote:
> > > +	clk_rate =3D clk_get_rate(pc->clk);
> > > +	c =3D clk_rate * period_ns;
> >=20
> > This might overflow (once you keep period_ns as u64).
> OK, the logic is changed like below to avoid overflow.
>=20
> 	freq =3D div_u64(clk_get_rate(pc->clk), 1000000);
> 	period_cycles =3D div_u64(freq * period_ns, 1000);

This might still overflow for big period_ns and freq > 1.

Better use mul_u64_u64_div_u64 and limit clkrate to prevent an overflow.
This yields a higher precision without overflow. Something like:

	rate =3D clk_get_rate(pc->clk);

	/*
	 * Refuse clk rates > 1 GHz to prevent overflowing the following
	 * calculation.
	 */
	if (rate > NSEC_PER_SEC)
		return -EINVAL;

	period_cycles =3D mul_u64_u64_div_u64(rate, period_ns, NSEC_PER_SEC);


> > > +	period_cycles =3D div_u64(c, NANO);
> >=20
> > Please use NSEC_PER_SEC here.
> >=20
> > > +
> > > +	if (period_cycles < 1)
> > > +		period_cycles =3D 1;
> > > +
> > > +	prescale =3D -1;
> > > +	/* prescale 1, 4, 16, 64, 256 and 1024 */
> > > +	for (i =3D 0, prod =3D 1; i < 6; i++) {
> > > +		if ((period_cycles / GTPR_MAX_VALUE * prod) =3D=3D 0) {
> > > +			prescale =3D i;
> > > +			break;
> > > +		}
> > > +
> > > +		prod *=3D 4;
> > > +	}
> >=20
> > This would be better understandable if you used:
> >=20
> > 	for (i =3D 0; i < 6; i++) {
> > 		prod =3D 1 << (2 * i);
> > 		...
> >=20
> > 	}
> >=20
> > Have you tested this? The division by GTPR_MAX_VALUE (=3D 0xFFFFFFFF) l=
ooks
> > suspicious. Unless I'm missing something
> >=20
> > 	if ((period_cycles / GTPR_MAX_VALUE * prod) =3D=3D 0)
> >=20
> > is equivalent to:
> >=20
> > 	if (period_cycles < GTPR_MAX_VALUE)
> >=20
> > . Is this really what you want here?
>=20
> On the next version, I have changed the logic to check this condition in =
caller function.
>=20
> 	if (period_cycles > 1UL * GTPR_MAX_VALUE * GPT_MAX_PRESCALE_VAL) {
> 		dev_warn(chip->dev, "ch=3D%d period exceed limit\n", pwm->hwpwm);
> 		return -EINVAL;
> 	}

Please always round down period, that is, if the request it's too big to
implement, do the biggest period that is possible.

With GTPR_MAX_VALUE =3D 0xffffffff and unsigned long being 32 bit on some
arch, this isn't a sensible test.

> > > +	/* Set counting mode */
> > > +	rzg2l_gpt_write(pc, GTUDDTYC, UP_COUNTING);
> > > +	/* Set period */
> > > +	rzg2l_gpt_write(pc, GTPR, pv);
> > > +
> > > +	/* Enable pin output */
> > > +	rzg2l_gpt_modify(pc, GTIOR, pwm->ph->mask, pwm->ph->value);
> > > +
> > > +	/* Set duty cycle */
> > > +	rzg2l_gpt_write(pc, pwm->ph->duty_reg_offset, dc);
> > > +
> > > +	/* Set initial value for counter */
> > > +	rzg2l_gpt_write(pc, GTCNT, 0);
> > > +	/* Set no buffer operation */
> > > +	rzg2l_gpt_write(pc, GTBER, 0);
> >=20
> > How does the output behave on reprogramming? Does it complete the curre=
ntly
> > programmed period? Please document this behaviour as e.g.
> > drivers/pwm/pwm-sl28cpld.c does.
>=20
> Mode and Prescalar must be set, only when the GTCNT is stopped.
> This condition will document.

Please document this at the top of the driver. Take e.g. pwm-sifive.c as
a template. (And please stick to the format used there for easy
greppability, i.e. use "Limitations:" and a list of items with no empty
line between them.)

> > > +	return 0;
> > > +}
> > > +
> > > +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *pc) {
> > > +	/* Start count */
> > > +	rzg2l_gpt_modify(pc, GTCR, GTCR_CST, GTCR_CST);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *pc) {
> > > +	/* Stop count */
> > > +	rzg2l_gpt_modify(pc, GTCR, GTCR_CST, 0);
> >=20
> > Same question here: How does the hardware behave? Does it complete the
> > currently running period? How does the output behave? (Typical candidat=
es
> > are: freeze at the level where it is currently, constant 0,
> > high-z.)
>=20
> It is set to output low during stop.

OK, that should go to the Limitations section, too (even though it's not
a limitation).

> > > +}
> > > +
> > > +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device
> > *pwm,
> > > +			   const struct pwm_state *state)
> > > +{
> > > +	struct rzg2l_gpt_chip *pc =3D to_rzg2l_gpt_chip(chip);
> > > +	int ret;
> >=20
> > As you don't support different polarities, there is the following
> > missing:
>=20
> There is a plan to add polarity in later version.
>=20
> >=20
> > 	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > 		return -EINVAL;
>=20
> Agree, will add this check in initial version.

Does it output low or inactive level on disable if inversed polarity is
configured?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bikcs47kodnn77gw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKYagcACgkQwfwUeK3K
7Ak4zAf9HzpNaec14EeskEd1bP9UkC9HqC0bEfthb5q9L6O4ndzPPNKEha7CMnS4
waugwymTZywgYt3ZIvAk21nQKBqID+evIQ21AiwvEYT5T3/NWHAraAMnd41fVwjw
HuTJeLz00STbuy3NKXhhjDejX54ODjZZGnUmlPdlngqDebSqpd62w/di20atyJvt
KV+dSFjOgXzp5VyqAuDgIzjggYP3RTkaSSKEwxCkZZ4Guirxja9+SSoZErpV3NiT
9OzcdOfXuyhsj4v8XtMT0EatDH5Pa4jZxwq81+gHyBguWOEGMY/2+prwEYU3r+mm
OQNohnlpdwWdhUjKU2j1vd3fcIetPg==
=qLMG
-----END PGP SIGNATURE-----

--bikcs47kodnn77gw--
