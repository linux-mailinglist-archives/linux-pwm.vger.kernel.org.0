Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D976270B70C
	for <lists+linux-pwm@lfdr.de>; Mon, 22 May 2023 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjEVHvj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 May 2023 03:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjEVHvO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 May 2023 03:51:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8208170A
        for <linux-pwm@vger.kernel.org>; Mon, 22 May 2023 00:49:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q10HR-00044b-3S; Mon, 22 May 2023 09:48:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q10HQ-001xDC-57; Mon, 22 May 2023 09:48:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q10HP-006p7y-1t; Mon, 22 May 2023 09:48:31 +0200
Date:   Mon, 22 May 2023 09:48:30 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v16] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Message-ID: <20230522074830.fi2zciilwv236jgq@pengutronix.de>
References: <20230418102037.346405-1-biju.das.jz@bp.renesas.com>
 <20230516064304.cdiifro7lb7ne2jp@pengutronix.de>
 <OS0PR01MB592277041AD411D212853FF586799@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB59221BF4B6ADC538CFE3BC8786439@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="265tid57ieqfa3aq"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59221BF4B6ADC538CFE3BC8786439@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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


--265tid57ieqfa3aq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 07:43:28AM +0000, Biju Das wrote:
> Hi Uwe,
>=20
> > -----Original Message-----
> > From: Biju Das
> > Sent: Tuesday, May 16, 2023 9:15 AM
> > To: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Cc: Thierry Reding <thierry.reding@gmail.com>; linux-
> > pwm@vger.kernel.org; Geert Uytterhoeven <geert+renesas@glider.be>;
> > Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; linux-
> > renesas-soc@vger.kernel.org
> > Subject: RE: [PATCH v16] pwm: Add Renesas RZ/G2L MTU3a PWM driver
> >=20
> > Hi Uwe,
> >=20
> > Thanks for the feedback.
> >=20
> > > Subject: Re: [PATCH v16] pwm: Add Renesas RZ/G2L MTU3a PWM driver
> > >
> > > Hello Biju,
> > >
> > > here now comes my promised review. Took a bit longer than anticipated,
> > > sorry for that.
> >=20
> > I know you are busy with "Convert to platform remove callback returning
> > void".
> >=20
> > >
> > > On Tue, Apr 18, 2023 at 11:20:37AM +0100, Biju Das wrote:
> > > > +static u8 rz_mtu3_pwm_calculate_prescale(struct rz_mtu3_pwm_chip
> > > *rz_mtu3,
> > > > +					 u64 period_cycles)
> > > > +{
> > > > +	u32 prescaled_period_cycles;
> > > > +	u8 prescale;
> > > > +
> > > > +	prescaled_period_cycles =3D period_cycles >> 16;
> > > > +	if (prescaled_period_cycles >=3D 16)
> > > > +		prescale =3D 3;
> > > > +	else
> > > > +		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;
> > > > +
> > > > +	return prescale;
> > >
> > > That value is supposed to be written to RZ_MTU3_TCR_TPCS, right? This
> > > is a 3bit register field and in .get_state() you handle values up to
> > > 7. I wonder why the max here is 3 only.
> >=20
> > I thought, for the initial basic driver, support bit values {0, 1, 2, 3}
> > as It is same for all MTU channels and later plan to support the
> > complicated external and internal clocks as it different for each
> > channels.
>=20
> Shall I add this in limitations section, so that limitation is clear to e=
veryone?? And then send V17,
> as it is only the open point.

I'd put it in a comment in rz_mtu3_pwm_calculate_prescale, for the
general overview it's not that important I guess.

> I am planning to change non-error check version
> "pm_runtime_get_sync" to error check version "pm_runtime_resume_and_get()=
" as you suggested.

I didn't check the details here, but note that in .remove()
pm_runtime_resume_and_get() is probably wrong. See for example
commit 9496fffcb28f39e0352779a0199b6e61861c9221.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--265tid57ieqfa3aq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRrHk4ACgkQj4D7WH0S
/k629wgAhFA2gVhbwY6eOY7lwWHo9mWqsX8UkpXL6nNtyOxK3dLvjL2f1H/E4txI
CWSaCu3jeWXh7I2ZPv8tSiX6Rmuz1ISrgcbNLCRJGEG16cTafBXRDAKUEQ3/tLUO
Er/0X8f4R69Mrjo/vqP1xRH9IXXEmV8FGEFxEDJ8RonAbey3Ow8u2yljnOgUKnm+
Bm55IHRPucVTNh5B7Ma4kYF8KC8H/VuQ/dJrR9+gwq+7h3GAvkQ/IPut/m4TtZ2p
eHGQ7uNHxVPYlHX7F0hH7qAXyYhDWpnTNyCMJYmbUtttLFsS4x8cdSm6QnXgLktE
Y+1zumQRe6il9boaVJxhuDbbhy9HRw==
=9Tto
-----END PGP SIGNATURE-----

--265tid57ieqfa3aq--
