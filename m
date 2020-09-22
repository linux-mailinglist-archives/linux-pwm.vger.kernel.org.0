Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B06E273AFF
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Sep 2020 08:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgIVGeI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Sep 2020 02:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgIVGeI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Sep 2020 02:34:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744ADC061755
        for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2020 23:34:08 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKbsM-0006DQ-J4; Tue, 22 Sep 2020 08:34:06 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKbsK-000454-3O; Tue, 22 Sep 2020 08:34:04 +0200
Date:   Tue, 22 Sep 2020 08:34:03 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     vijayakannan.ayyathurai@intel.com, thierry.reding@gmail.com,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v7 2/2] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Message-ID: <20200922063403.5sm6fk7qopggoitc@pengutronix.de>
References: <20200909162719.7585-1-vijayakannan.ayyathurai@intel.com>
 <20200909162719.7585-3-vijayakannan.ayyathurai@intel.com>
 <20200921084401.gtesjzentxrly47c@pengutronix.de>
 <20200921103756.GP3956970@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3riy4hp7mq7zkjls"
Content-Disposition: inline
In-Reply-To: <20200921103756.GP3956970@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3riy4hp7mq7zkjls
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Mon, Sep 21, 2020 at 01:37:56PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 21, 2020 at 10:44:01AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, Sep 10, 2020 at 12:27:19AM +0800, vijayakannan.ayyathurai@intel=
=2Ecom wrote:
> > > From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> > >=20
> > > Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
> > >=20
> > > Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@inte=
l.com>
> > > Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel=
=2Ecom>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > nitpick: Your S-o-b should always be last. This way it becomes clear who
> > added the other tags.
>=20
> I think it should reflect chronological order. If SoB has been given befo=
re
> e.g. Ack then SoB should be followed by Ack and not other way around.

This is how I interpret the rules even though I admit it is not
formalized explicitly. The idea is just what I wrote, when the patch
ends up in git with:

	Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
	Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
	Reviewed-by: Rob Herring <robh@kernel.org>
	Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
	Signed-off-by: Peter Maintainer <p.maintainer@tralala>

I'd expect that is was Peter M. who added Rob's and my tag, while when
it is

	Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
	Reviewed-by: Rob Herring <robh@kernel.org>
	Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
	Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
	Signed-off-by: Peter Maintainer <p.maintainer@tralala>

it was Vijayakannan who added them.

IMHO this makes sense as Vijayakannan modified the commit log and then
it is usual to add the signature at the end. In my eyes this is more
sensible than the date order, but it seems this is subjective.

I'm aware that most people don't care; and I don't care enough to argue
this case any further.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3riy4hp7mq7zkjls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9pmtgACgkQwfwUeK3K
7AljeAf/TACR7/NNqYto9dvZocCa4ZRdCBGdD/55DvvBeu9xw3qjAxti/3BC+ecE
9mMMEDSVN04aKFjkjybb0PqK0rAOMbTWDn7XvzAhkqH30s63PWgtJjqFUqwGRbK5
ecG9fUXmVat6fvH27LW6sD53FSfVWBLEPE5kgqte2bKmwu+12ll2seb+e3uooupL
/aWodx2FAFX7GMABbHWzTHQ17bGs+Is8wJm04IqEX4h4h2luC/DgXwnIRQdgl3o7
mFI8xHY098pxG7S9VaoGXCANraja4VKeiFWsue6//t7YakFI9UqcNaAQjUbawVNI
igP/VSVSA5CFj+2Czu3kaQ9caemMCg==
=DzkG
-----END PGP SIGNATURE-----

--3riy4hp7mq7zkjls--
