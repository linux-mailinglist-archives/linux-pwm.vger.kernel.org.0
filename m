Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32857BF924
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Oct 2023 13:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJJLFA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Oct 2023 07:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjJJLE7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Oct 2023 07:04:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E249E
        for <linux-pwm@vger.kernel.org>; Tue, 10 Oct 2023 04:04:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqAXj-00011h-83; Tue, 10 Oct 2023 13:04:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqAXh-000drE-Vt; Tue, 10 Oct 2023 13:04:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqAXh-00D468-MO; Tue, 10 Oct 2023 13:04:49 +0200
Date:   Tue, 10 Oct 2023 13:04:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] pwm: Add support for RZ/V2M PWM driver
Message-ID: <20231010110449.7nxb6p675qkujg3q@pengutronix.de>
References: <20230630114003.320641-1-biju.das.jz@bp.renesas.com>
 <20230630114003.320641-3-biju.das.jz@bp.renesas.com>
 <20230916153248.27k7erg7i7ruf76w@pengutronix.de>
 <TYWPR01MB8775150932FD1F0A346029B7C2C4A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <20231004141521.rgm74pepirnvzrwm@pengutronix.de>
 <TYWPR01MB8775EBB5A3A6D446D3B6F811C2CDA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r3y576m5r4tbur5m"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB8775EBB5A3A6D446D3B6F811C2CDA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--r3y576m5r4tbur5m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 10:48:19AM +0000, Fabrizio Castro wrote:
> Hi Uwe,
>=20
> Thanks for your reply!
>=20
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Sent: Wednesday, October 4, 2023 3:15 PM
> > Subject: Re: [PATCH v5 2/4] pwm: Add support for RZ/V2M PWM driver
> >=20
> > Hello Fabrizio,
> >=20
> > On Tue, Oct 03, 2023 at 09:19:41PM +0000, Fabrizio Castro wrote:
> > > > > +	if (period)
> > > > > +		period +=3D 1;
> > > >
> > > > This looks bogus, why don't you add 1 if RZV2M_PWMCYC is 0?
> > >
> > > Agreed. We should always add 1.
> > >
> > > > Also it suggests that the hardware cannot do a 100% relative duty
> > > > cycle?
> > >
> > > It does support 100% duty cycle.
> > > PWMCYC =3D 0 actually means 1 clock cycle, that's why the faff with
> > > increment and decrement operations, and that's why the confusion.
> >=20
> > So it doesn't support a 0% relative duty cycle?
>=20
> It does support 0% duty cycle.
>=20
> >=20
> > > > If I didn't miss anything here, please add that to the list of
> > > > Limitations above.
> > >
> > > Thankfully not a limitation.
> > >
> > > >
> > > > > +	state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)period
> > << (4
> > > > * prescale),
> > > > > +					 rzv2m_pwm->rate);
> > > >
> > > > The multiplication can overflow. I see no easy way to prevent this
> > > > without introducing a mul_u64_u64_div_roundup helper. Maybe I miss
> > > > something?
> > >
> > > It does overflow, good catch!
> > > I think we could split this in three operations for now, and maybe
> > > improve it later on:
> > > period =3D NSEC_PER_SEC * (cyc + 1);
> > > period =3D DIV64_U64_ROUND_UP(period, rzv2m_pwm->rate);
> > > period <<=3D rzv2m_pwm_prescale_to_shift(prescale);
> >=20
> > You're loosing precision here though. With /^ =3D div_round_up:
> >=20
> > 	1000000000 * 5 /^ 3 << 2 =3D=3D 6666666668
> > 	1000000000 * 5 << 2 /^ 3 =3D=3D 6666666667
>=20
> Yep.
>=20
> >=20
> > So I correct my statement to: I see no easy and exact way to prevent
> > an
> > overflow without introducing a mul_u64_u64_div_roundup helper. :-)
>=20
> Indeed. In my mind, the best way to tackle this problem is for such an
> API to use an internal representation of 128-bit, so that it can calculate
> (a*b + c - 1)/c accurately, and return both the high and low part of the
> 128-bit result (and maybe keeping the high part result optional?).
> Something like
> u64 mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64 c, u64 *res_high);
> or
> void mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64 c, u64 *res_high, u64 =
*res_low);
>=20
> Needless to say, the API may take quite some time to perform the calculat=
ions,
> but if precision/accuracy is what we need, there is probably no better
> way of addressing this, unless you have a better idea?
>=20
> Looking around, my understanding is that other drivers may benefit from
> this sort of accurate rounded up result when a, b, and c are 64-bit, is t=
hat
> why you think it has come the time to address this, or do you think this
> is the first instance of such need?

The assumption of mul_u64_u64_div_u64 is that the result won't overflow
a u64. Iff your hardware doesn't support a period > U64_MAX I think
there is no need for an overflow-checking variant of
mul_u64_u64_div_u64(). I didn't recheck, but this would be the first
driver I'm aware of that can support a period > U64_MAX ns. But maybe it
depends on the clkrate and if that's small enough it can happen?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r3y576m5r4tbur5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUlL9AACgkQj4D7WH0S
/k4hOwgArpbEpps7do0LD1XAMcXUIrCZgaYdU/7sSfynsoohmT37nNQkGoXmBu87
MeRaxdE53FJxdgLc+x/SNbF2EGWQfvIR/1d4DyHtsrS6AJ4jxqYLOM0d6dPsaCxy
4avIk8H1y3wURoX3ejJhqb7+8lpFOam7lNYCB5kBEHXxvTD6W1/wC9yzKLoRcPCz
Pg0M1XBuuUZWvgiu6ErDNQlyTCoYFVDMwgThIC2rI0zt8GhH3zVu5iZF1bOunm44
HZmGT/hmg2O+wWd+PqXeGhiv9bgUWNbWWJE44Ps3QtUTVfercmT3y7q9+90FCyT7
LcuS7e1CrDLqEqSgVAndn/pzepvzGQ==
=1N5r
-----END PGP SIGNATURE-----

--r3y576m5r4tbur5m--
