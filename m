Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E79C5BFEFF
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Sep 2022 15:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiIUNf7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Sep 2022 09:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiIUNf6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Sep 2022 09:35:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15397330D
        for <linux-pwm@vger.kernel.org>; Wed, 21 Sep 2022 06:35:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oaztD-0008CF-ID; Wed, 21 Sep 2022 15:35:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oaztD-0024Ic-FK; Wed, 21 Sep 2022 15:35:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oaztB-002T1l-CF; Wed, 21 Sep 2022 15:35:45 +0200
Date:   Wed, 21 Sep 2022 15:35:42 +0200
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
Message-ID: <20220921133542.3glfgeddnlhrebkz@pengutronix.de>
References: <20220905171328.991367-1-biju.das.jz@bp.renesas.com>
 <20220905171328.991367-3-biju.das.jz@bp.renesas.com>
 <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
 <OS0PR01MB5922B87D4A05973F88B427A7864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220920155306.dvcz4324zvg72udm@pengutronix.de>
 <OS0PR01MB5922A9B3314F2F2B32F6B0DE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922289B89061F6B3DF4819F864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jbozhv5sc6bhwhkt"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922289B89061F6B3DF4819F864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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


--jbozhv5sc6bhwhkt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Sep 21, 2022 at 10:50:48AM +0000, Biju Das wrote:
> > -----Original Message-----
> > From: Biju Das
> > Sent: 20 September 2022 18:01
> > To: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Cc: Thierry Reding <thierry.reding@gmail.com>; Lee Jones
> > <lee.jones@linaro.org>; Philipp Zabel <p.zabel@pengutronix.de>; linux-
> > pwm@vger.kernel.org; Geert Uytterhoeven <geert+renesas@glider.be>;
> > Chris Paterson <Chris.Paterson2@renesas.com>; Biju Das
> > <biju.das@bp.renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> > lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.org
> > Subject: RE: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
> >=20
> > Hi Uwe,
> >=20
> > > Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
> > >
> > > Hello,
> > >
> > > On Tue, Sep 20, 2022 at 03:31:16PM +0000, Biju Das wrote:
> > > > > On Mon, Sep 05, 2022 at 06:13:28PM +0100, Biju Das wrote:
> > > > > > +	if (period_cycles >=3D (1024ULL << 32))
> > > > > > +		pv =3D U32_MAX;
> > > > > > +	else
> > > > > > +		pv =3D period_cycles >> (2 * prescale);
> > > > >
> > > > > You're assuming that pv <=3D U32_MAX after this block, right? Then
> > > > > maybe
> > > > Yes, That is correct.
> > > >
> > > > >
> > > > > 	if (period_cycles >> (2 * prescale) <=3D U32_MAX)
> > > > >
> > > > > is the more intuitive check?
> > > >
> > > > Ok will add like below, so we support up to (U32_MAX * 1024); Is
> > it
> > > ok
> > > > for you?
> > > >
> > > >   if (!(period_cycles >> (2 * prescale) <=3D U32_MAX))
> > > > +               return -EINVAL;
> > > > +
> > > > +       pv =3D period_cycles >> (2 * prescale);
> > >
> > > Not -EINVAL, using pv =3D U32_MAX is correct.
> >=20
> > OK.
> >=20
> > >
> > > > Same case for duty cycle.
> > > > >
> > > > > > +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle,
> > > > > > +rzg2l_gpt->rate, NSEC_PER_SEC);
> > > > > > +
> > > > > > +	if (duty_cycles >=3D (1024ULL << 32))
> > > > > > +		dc =3D U32_MAX;
> > > > > > +	else
> > > > > > +		dc =3D duty_cycles >> (2 * prescale);
> > > > > > +
> > > > > > +	/* Counter must be stopped before modifying Mode and
> > > Prescaler */
> > > > > > +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> > > > > > +		rzg2l_gpt_disable(rzg2l_gpt);
> > > > >
> > > > > For v5 I asked if this affects other channels, you said yes and
> > in
> > > > > the follow up I failed to reply how to improve this.
> > > > >
> > > > > I wonder how this affects other channels. Does it restart a
> > period
> > > > > afterwards, or is the effect only that the currently running
> > > period
> > > > > is a bit stretched?
> > > >
> > > > If we stops the counter, it resets to starting count position.
> > >
> > > So if I update pwm#1, pwm#0 doesn't only freeze for a moment, but
> > > starts a new period. Hui.
> > >
> > > > >At least point that this stops the global counter and  so affects
> > > the
> > > > >other PWMs provided by this chip.
> > > >
> > > > We should not allow Counter to stop if it is running.
> > > > We should allow changing mode and prescalar only for the first
> > > enabled
> > > > channel in Linux.
> > > >
> > > > Also as per the HW manual, we should not change RZG2L_GTCNT,
> > > > RZG2L_GTBER while Counter is running.
> > > >
> > > > Will add bool is_counter_running to take care of this conditions.
> > > >
> > > > Is it ok with you?
> > >
> > > I'm torn here. Resetting the period for the other counter is quite
> > > disturbing. If you cannot prevent that, please document that in the
> > > Limitations section above.
> >=20
>=20
> OK, I will document this in limitation section.=20
>=20
>  * - While using dual channels, both the channels should be enabled and
>  *   disabled at the same time as it uses shared register for controlling
>  *   counter start/stop.

Actually it's worse:

- When both channels are used, setting the duty-cycle on one aborts the
  currently running period on the other and starts it anew.

(Did I get this correctly?)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jbozhv5sc6bhwhkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMrEysACgkQwfwUeK3K
7AmaUAf9H64E4M3aeRHqvIK0LHpSJD+UTMQJRt7XljAXlFRgpd47x446VLiXD+h5
GfcwiIQ8V0K3GpGRt9B7FKbLftTLdqfWWqJ9XgVVcL/ypFfh2ennmlzqQ6LLc4RW
ipUZjODnldjY1LGUpTCPC7rAk9/Ed5bg6GZscxrYM6RT2M19eDkwV9ZR64AlOKDb
bSbxrHJLbQ6VMDAIS9aZE42D6jaEb8yvkMrm1cmr7Nch/mz5Lb6H8uAPpMec79Gi
aIgJwaM6DFELYSfO9GSJtxMAIWF32OdTespxawnNZRA4UOcMU4kbCyi5fLy5zjur
blUYo81HvwDDNSApifqtTD6F/xFe+g==
=167n
-----END PGP SIGNATURE-----

--jbozhv5sc6bhwhkt--
