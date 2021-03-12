Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70093388BE
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Mar 2021 10:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhCLJcy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Mar 2021 04:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbhCLJcf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Mar 2021 04:32:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47CCC061574
        for <linux-pwm@vger.kernel.org>; Fri, 12 Mar 2021 01:32:34 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKe9o-00051z-Ue; Fri, 12 Mar 2021 10:32:32 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKe9o-0007tY-HJ; Fri, 12 Mar 2021 10:32:32 +0100
Date:   Fri, 12 Mar 2021 10:32:32 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [GIT PULL] pwm: Changes for v5.12-rc1
Message-ID: <20210312093232.pwbz7rpr3muyswct@pengutronix.de>
References: <20210225193426.3679817-1-thierry.reding@gmail.com>
 <20210226095936.sc27f3un5vnc5o62@pengutronix.de>
 <YDjhQvv0vYU890Ol@ulmo.localdomain>
 <20210227174608.p5fha6j33gftt57i@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ftxuee3wwywjxhgd"
Content-Disposition: inline
In-Reply-To: <20210227174608.p5fha6j33gftt57i@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ftxuee3wwywjxhgd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Sat, Feb 27, 2021 at 06:46:08PM +0100, Uwe Kleine-K=F6nig wrote:
> On Fri, Feb 26, 2021 at 12:53:38PM +0100, Thierry Reding wrote:
> > On Fri, Feb 26, 2021 at 10:59:36AM +0100, Uwe Kleine-K=F6nig wrote:
> > > On Thu, Feb 25, 2021 at 08:34:26PM +0100, Thierry Reding wrote:
> > > > ----------------------------------------------------------------
> > > > pwm: Changes for v5.12-rc1
> > > >=20
> > > > The ZTE ZX platform is being removed, so the PWM driver is no longer
> > > > needed and removed as well. Other than that this contains a small s=
et of
> > > > fixes and cleanups across a couple of drivers.
> > >=20
> > > patches I'd have liked to be seen additionally in this pull request a=
re:
> > >=20
> > >   pwm: bcm2835: Improve period and duty cycle calculation
> > >    https://patchwork.ozlabs.org/project/linux-pwm/patch/2021011420480=
4.143892-1-u.kleine-koenig@pengutronix.de/
> >=20
> > There was discussion on earlier versions of this, so I was hoping that
> > Lino and/or Florian would provide a Reviewed-by/Acked-by/Tested-by on
> > this. I'll go ping them to see if we can get a reaction.
>=20
> Fine.

Lino tested and reviewed that change in the meantime, so I assume that's
ready to go.

> > >   pwm: get rid of pwmchip_add_with_polarity()
> > >    https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D2190=
12
> >=20
> > From a quick look I'm not sure I understand what this is trying to do.
> > The goal of pwmchip_add_with_polarity() was initially to support chips
> > that support only PWM_POLARITY_INVERSED (or use inversed polarity by
> > default, rather than normal polarity). So without looking at it more
> > closely it doesn't seem quite right to drop it.
>=20
> This is at least not the effect of pwmchip_add_with_polarity. There is
> nothing in the core that ensures that apply with the other polarity
> fails.
>=20
> There are two drivers that make use of pwmchip_add_with_polarity(); both
> support both polarities.

Does this convince you? If the intention of pwmchip_add_with_polarity()
is that only the passed polarity is supported than the first two commits

	pwm: atmel-hlcdc: Use pwmchip_add() instead of pwmchip_add_with_polarity()
	pwm: bcm-kona: Use pwmchip_add() instead of pwmchip_add_with_polarity()

are right for sure and pwmchip_add() shouldn't be a wrapper around
pwmchip_add_with_polarity(). I think that lowlevel drivers should be
polarity aware and return -EINVAL when .apply() is called with an
unsupported polarity. This is how most drivers work[1] and conceptually
I think this is the right approach to have the capabilities of each
driver in a single place.

> > >   pwm: add a config symbol for legacy drivers
> > >    https://patchwork.ozlabs.org/project/linux-pwm/patch/2020061315574=
2.31528-1-uwe@kleine-koenig.org/
> >=20
> > I think we've discussed this in the past.
> [...]
> > A better way forward would be to start converting some of these drivers
> > to the atomic API since there's apparently not enough incentive for the
> > driver maintainers to do that themselves.
>=20
> That's fine, I can work on that.

I already did this for two drivers:

	pwm: ab8500: Implement .apply instead of .config, .enable and .disable
	pwm: atmel-tcb: Implement .apply callback

I prepared a branch with the mentioned patches and a few further patches
=66rom the list at

	https://git.pengutronix.de/git/ukl/linux pwm-next

that I would consider ready for pushing to next. I'd really like to use
the time until the next merge window opens to breed patches in next and
not only start collecting at -rc6 (or so) time.

Best regards
Uwe

[1] There are two drivers that currently miss this check, I just send
    out patches to fix these.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ftxuee3wwywjxhgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBLNSsACgkQwfwUeK3K
7Akr6QgAi5pl6jufNoh5pvp92mEUpd778GnBB2UKxAw0i3eiA2Vf41ivaid/mdT2
FrNYGQ5J2B4TqRYo/26iCsOAx9J2aXHzNBL7WkohHXxXI1dHSMBwZaSGUAEo3DT3
DqmZWo8Snh3iAuE8zRKQpafK1Dk4gM3RWkT+pznpZeH/i2t+xE4O1kFt9gH+Hnwm
clCgqUfRqgdaWHn+mKlWtyI6aWLVVbzOQmkDHIoIJ1wCO+ExqFBo2Us1rGlQgWQ9
fljRWxuhzH1ncudAYCOBO2HcN4RNQDxrt6sJOF5zHcsZVCgbU1Puj7AI0PlnO/ck
Aeq4CGIwLL822vl53KSN55sUr2X8+g==
=Lqvx
-----END PGP SIGNATURE-----

--ftxuee3wwywjxhgd--
