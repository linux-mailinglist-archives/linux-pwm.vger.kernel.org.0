Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C817C5979
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Oct 2023 18:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjJKQsP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Oct 2023 12:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjJKQsO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Oct 2023 12:48:14 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574C38F
        for <linux-pwm@vger.kernel.org>; Wed, 11 Oct 2023 09:48:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqcNX-0003YF-Q3; Wed, 11 Oct 2023 18:48:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqcNX-000ww0-5N; Wed, 11 Oct 2023 18:48:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqcNW-00EHb2-SE; Wed, 11 Oct 2023 18:48:10 +0200
Date:   Wed, 11 Oct 2023 18:48:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 04/11] pwm: brcmstb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM
 functions
Message-ID: <20231011164810.zx7upbermqvnv3n5@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
 <20231010075112.755178-5-u.kleine-koenig@pengutronix.de>
 <20231011122152.00007595@Huawei.com>
 <20231011153112.44vfwedz4qxlunsa@pengutronix.de>
 <19a13327-e8b6-4bea-ac93-3b418f8845df@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kskz6ymkeizynq6v"
Content-Disposition: inline
In-Reply-To: <19a13327-e8b6-4bea-ac93-3b418f8845df@broadcom.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--kskz6ymkeizynq6v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 08:42:54AM -0700, Florian Fainelli wrote:
>=20
>=20
> On 10/11/2023 8:31 AM, Uwe Kleine-K=F6nig wrote:
> > On Wed, Oct 11, 2023 at 12:21:52PM +0100, Jonathan Cameron wrote:
> > > On Tue, 10 Oct 2023 09:51:05 +0200
> > > Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
> > >=20
> > > > This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't h=
ave to
> > > > care about when the functions are actually used, so the correspondi=
ng
> > > > #ifdef can be dropped.
> > > >=20
> > > > Also make use of pm_ptr() to discard all PM related stuff if CONFIG=
_PM
> > > > isn't enabled.
> > >=20
> > > The additional change to potentially return an error when not doing s=
o before
> > > wants to be called out in the description.
> >=20
> > Indeed, good catch. Something like:
> >=20
> > 	pwm: brcmstb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM
> >=20
> > 	This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have=
 to
> > 	care about when the functions are actually used, so the corresponding
> > 	#ifdef can be dropped.
> >=20
> > 	Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
> > 	isn't enabled.
> >=20
> > 	While touching brcmstb_pwm_suspend() also propagate the return
> > 	value of clk_enable() to the caller of .suspend().
> >=20
> > 	Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > I fixed that in my tree, so if and when v2 happens, this comment will be
> > addressed.
>=20
> OK so that makes:
>=20
> https://lore.kernel.org/all/20231005164728.1846726-1-florian.fainelli@bro=
adcom.com/
>=20
> void, and now I also need to re-submit:
>=20
> https://lore.kernel.org/all/20231004175414.1738475-1-florian.fainelli@bro=
adcom.com/
>=20
> or is Thierry going to resolve that conflict for us?

Oh right, I remember.

@Thierry: Please drop my patch and take Florian's instead. I mark my
patch as rejected.

@Florian: Sorry!

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kskz6ymkeizynq6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUm0ckACgkQj4D7WH0S
/k5bugf/TXaUg9rpVfGV0mRpFa5idUIm7064FgAXOUNU9P8RHddMEuHzH9STGDZG
gZCU0t5b6auxJ/nQB/WRxj9XkRmudbj8XM60fMUOKISy/ZyvZIynJC3z1mNFBAEq
aCjw7IlHEKngNEmnRt5jEgcs3okH6UHci8qO9N/Vuy2e4j2eeaVVfp7tCi8PmiAu
F1Ng4LC593DyY8Ly3XYRvWz4EaQkTCO5mWqWicBcogWt0JBG7IZkJERMtTIDNCIp
c66mZUEF3G9ecSsjoppkir+CBTM60skPU29Dlbv77zlHuA7LO0sOC4HXar4s3rU+
iuaQIBkIqntP1gJjAi+EBnGmhAKoSA==
=NW3F
-----END PGP SIGNATURE-----

--kskz6ymkeizynq6v--
