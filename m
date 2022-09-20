Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916B15BEA8E
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Sep 2022 17:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiITPxX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Sep 2022 11:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiITPxW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Sep 2022 11:53:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6210B6A4B4
        for <linux-pwm@vger.kernel.org>; Tue, 20 Sep 2022 08:53:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oafYf-0007tQ-5J; Tue, 20 Sep 2022 17:53:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oafYd-001t9g-Ky; Tue, 20 Sep 2022 17:53:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oafYb-002GcQ-FI; Tue, 20 Sep 2022 17:53:09 +0200
Date:   Tue, 20 Sep 2022 17:53:06 +0200
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
Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
Message-ID: <20220920155306.dvcz4324zvg72udm@pengutronix.de>
References: <20220905171328.991367-1-biju.das.jz@bp.renesas.com>
 <20220905171328.991367-3-biju.das.jz@bp.renesas.com>
 <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
 <OS0PR01MB5922B87D4A05973F88B427A7864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s5zjhnvg6jj6egah"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922B87D4A05973F88B427A7864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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


--s5zjhnvg6jj6egah
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Sep 20, 2022 at 03:31:16PM +0000, Biju Das wrote:
> > On Mon, Sep 05, 2022 at 06:13:28PM +0100, Biju Das wrote:
> > > +	if (period_cycles >=3D (1024ULL << 32))
> > > +		pv =3D U32_MAX;
> > > +	else
> > > +		pv =3D period_cycles >> (2 * prescale);
> >=20
> > You're assuming that pv <=3D U32_MAX after this block, right? Then maybe
> Yes, That is correct.
>=20
> >=20
> > 	if (period_cycles >> (2 * prescale) <=3D U32_MAX)
> >=20
> > is the more intuitive check?
>=20
> Ok will add like below, so we support up to (U32_MAX * 1024);
> Is it ok for you?
>=20
>   if (!(period_cycles >> (2 * prescale) <=3D U32_MAX))
> +               return -EINVAL;
> +
> +       pv =3D period_cycles >> (2 * prescale);

Not -EINVAL, using pv =3D U32_MAX is correct.

> Same case for duty cycle.
> >=20
> > > +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rzg2l_gpt->rate,
> > > +NSEC_PER_SEC);
> > > +
> > > +	if (duty_cycles >=3D (1024ULL << 32))
> > > +		dc =3D U32_MAX;
> > > +	else
> > > +		dc =3D duty_cycles >> (2 * prescale);
> > > +
> > > +	/* Counter must be stopped before modifying Mode and Prescaler */
> > > +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> > > +		rzg2l_gpt_disable(rzg2l_gpt);
> >=20
> > For v5 I asked if this affects other channels, you said yes and in the
> > follow up I failed to reply how to improve this.
> >=20
> > I wonder how this affects other channels. Does it restart a period
> > afterwards, or is the effect only that the currently running period is
> > a bit stretched?=20
>=20
> If we stops the counter, it resets to starting count position.

So if I update pwm#1, pwm#0 doesn't only freeze for a moment, but
starts a new period. Hui.

> >At least point that this stops the global counter and
> > so affects the other PWMs provided by this chip.
>=20
> We should not allow Counter to stop if it is running.=20
> We should allow changing mode and prescalar only for the first=20
> enabled channel in Linux.
>=20
> Also as per the HW manual, we should not change RZG2L_GTCNT, RZG2L_GTBER =
while
> Counter is running.
>=20
> Will add bool is_counter_running to take care of this conditions.
>=20
> Is it ok with you?

I'm torn here. Resetting the period for the other counter is quite
disturbing. If you cannot prevent that, please document that in the
Limitations section above.

> > > +	pm_runtime_get_sync(chip->dev);
> > > +	val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR);
> > > +	state->enabled =3D val & RZG2L_GTCR_CST;
> > > +	if (state->enabled) {
> > > +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);
> > > +
> > > +		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR);
> > > +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);
> >=20
> > This can overflow.
>=20
> OK will use inverse calculation to avoid overflow.
> mul_u64_u32_div(val << (2 * prescale), NSEC_PER_SEC, rzg2l_gpt->rate);
>=20
> Is it ok?

It uses the wrong rounding direction :-\ Using

	tmp =3D NSEC_PER_SEC * (u64)val << (2 * prescale);

should be enough to fix the problem I pointed out.

> > > +		state->period =3D DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate);
> > > +
> > > +		val =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(pwm->hwpwm));
> > > +		tmp =3D NSEC_PER_SEC * val << (2 * prescale);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s5zjhnvg6jj6egah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMp4d8ACgkQwfwUeK3K
7Amf/QgAhvlOgkkZJzPAYxDlRm+VZdDKfKEy1VRDUuwi6rNc24GxwOApAAPUJgSp
BbxQeYGNUitSVyA8aurleCVaZwaxhmJVb/RdPzU7kA4oI3hHH3Nom+248zVNKNhc
SsETdqJhs/BmSbTkVrByUlgXPl44r61W0BuSve8aUKTASjce/aQkdRwMC0l3YVbq
pfm1nikmAWFUDCdF8kCx1oqYrwKvxzziaC7SLwkKbVLI5MsYvwnGtLnmZJerl2yP
7TM0LauvvANdfsHypGJxvB0DOSHwq+4+b+ilRaO+qXIdMAm/2KDO7RlkRmXuJ3ey
AA3N4Fvq3XWXpE+ZG5C+CUy5LlAp3w==
=0YMW
-----END PGP SIGNATURE-----

--s5zjhnvg6jj6egah--
