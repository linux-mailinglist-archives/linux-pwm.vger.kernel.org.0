Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8EB369831
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Apr 2021 19:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243287AbhDWRVh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Apr 2021 13:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242335AbhDWRVg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Apr 2021 13:21:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF15C061574
        for <linux-pwm@vger.kernel.org>; Fri, 23 Apr 2021 10:21:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZzTz-0003V5-B3; Fri, 23 Apr 2021 19:20:47 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZzTw-00010E-If; Fri, 23 Apr 2021 19:20:44 +0200
Date:   Fri, 23 Apr 2021 19:20:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
Message-ID: <20210423172041.jwmrrbnv76irmzxz@pengutronix.de>
References: <20210419000007.1944301-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <YIL+Xwjbk1EE04Sm@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="obtpyakzbdh7csmz"
Content-Disposition: inline
In-Reply-To: <YIL+Xwjbk1EE04Sm@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--obtpyakzbdh7csmz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 23, 2021 at 07:05:35PM +0200, Thierry Reding wrote:
> On Mon, Apr 19, 2021 at 09:00:05AM +0900, Nobuhiro Iwamatsu wrote:
> > Hi,
> >=20
> > This series is the PWM driver for Toshiba's ARM SoC, Visconti[0].
> > This provides DT binding documentation and device driver.
> >=20
> > [0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/im=
age-recognition-processors-visconti.html
> >=20
> > Updates:
> >=20
> >   dt-bindings: pwm: Add bindings for Toshiba Visconti PWM Controller
> >     v5 -> v6:
> >       - No update.
> >     v4 -> v5:
> >       - No update.
> >     v3 -> v4:
> >       - No update.
> >     v2 -> v3:
> >       - Change compatible to toshiba,visconti-pwm
> >       - Change filename to toshiba,visconti-pwm.yaml.
> >       - Add Reviewed-by tag from Rob.
> >     v1 -> v2:
> >       - Change SPDX-License-Identifier to GPL-2.0-only OR BSD-2-Clause.
> >       - Set compatible toshiba,pwm-visconti only.
> >       - Drop unnecessary comments.
> >=20
> >   pwm: visconti: Add Toshiba Visconti SoC PWM support
> >     v5 -> v6:
> >      - Update year in copyright.
> >      - Update limitations.
> >      - Fix coding style, used braces for both branches.
> >     v4 -> v5:
> >       - Droped checking PIPGM_PCSR from visconti_pwm_get_state.
> >       - Changed from to_visconti_chip to visconti_pwm_from_chip.
> >       - Removed pwmchip_remove return value management.
> >       - Add limitations of this device.
> >       - Add 'state->enabled =3D true' to visconti_pwm_get_state().
> >     v3 -> v4:
> >       - Sorted alphabetically include files.
> >       - Changed container_of to using static inline functions.
> >       - Dropped unnecessary dev_dbg().
> >       - Drop Initialization of chip.base.
> >       - Drop commnet "period too small".
> >       - Rebased for-next.=20
> >     v2 -> v3:
> >       - Change compatible to toshiba,visconti-pwm.
> >       - Fix MODULE_ALIAS to platform:pwm-visconti, again.
> >       - Align continuation line to the opening parenthesis.
> >       - Rewrite the contents of visconti_pwm_apply() based on the conte=
nts suggested by Uwe.
> >     v1 -> v2:
> >       - Change SPDX-License-Identifier to GPL-2.0-only.
> >       - Add prefix for the register defines.
> >       - Drop struct device from struct visconti_pwm_chip.
> >       - Use '>>' instead of '/'.
> >       - Drop error message by devm_platform_ioremap_resource().
> >       - Use dev_err_probe instead of dev_err.
> >       - Change dev_info to dev_dbg.
> >       - Remove some empty lines.
> >       - Fix MODULE_ALIAS to platform:pwm-visconti.
> >       - Add .get_state() function.
> >       - Use the author name and email address to MODULE_AUTHOR.
> >       - Add more comment to function of the hardware.
> >       - Support .get_status() function.
> >       - Use NSEC_PER_USEC instead of 1000.
> >       - Alphabetically sorted for Makefile and Kconfig.
> >       - Added check for set value in visconti_pwm_apply().
> >=20
> > Nobuhiro Iwamatsu (2):
> >   dt-bindings: pwm: Add bindings for Toshiba Visconti PWM Controller
> >   pwm: visconti: Add Toshiba Visconti SoC PWM support
> >=20
> >  .../bindings/pwm/toshiba,pwm-visconti.yaml    |  43 ++++
> >  drivers/pwm/Kconfig                           |   9 +
> >  drivers/pwm/Makefile                          |   1 +
> >  drivers/pwm/pwm-visconti.c                    | 189 ++++++++++++++++++
> >  4 files changed, 242 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/toshiba,pwm-v=
isconti.yaml
> >  create mode 100644 drivers/pwm/pwm-visconti.c
>=20
> Both patches applied, thanks.
>=20
> checkpatch did complain when I applied:
>=20
> > WARNING: please write a paragraph that describes the config symbol fully
> > #9: FILE: drivers/pwm/Kconfig:604:
> > +config PWM_VISCONTI
>=20
> That seems a bit excessive. The paragraph is perhaps not a poster child
> for Kconfig, but there are others that aren't better, so I think that's
> fine.
>=20
> > WARNING: added, moved or deleted file(s), does MAINTAINERS need updatin=
g?
> > #32:=20
> > new file mode 100644
>=20
> Fine, too.
>=20
> > WARNING: 'loosing' may be misspelled - perhaps 'losing'?
> > #112: FILE: drivers/pwm/pwm-visconti.c:76:
> >  +	 * NSEC_PER_SEC / CLKFREQ =3D 1000 without loosing precision.
> >   	                                         ^^^^^^^
>=20
> I've fixed that up while applying.
>=20
> > WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code =
rather than BUG() or BUG_ON()
> > #127: FILE: drivers/pwm/pwm-visconti.c:91:
> > +		BUG_ON(pwmc0 > 3);
>=20
> I think that one is legit. I've turned that into:
>=20
> 	if (WARN_ON(pwmc0 > 3))
> 		return -EINVAL;

>=20
> so that requests for too big period will be rejected rather than crash
> the system.

If this BUG_ON (or your if) triggers we have a compiler or memory
problem. The relevant parts of the code are:

	if (state->period > (0xffff << 3) * 1000)
		period =3D (0xffff << 3) * 1000;
	else
		period =3D state->period;

	period /=3D 1000;

	if (period > 0xffff) {
		pwmc0 =3D ilog2(period >> 16);
		BUG_ON(pwmc0 > 3);

Given that period is never bigger than 0xffff << 3 when it is used to
calculate the argument to ilog2, pwmc0 <=3D ilog2(7) =3D 2.

Hmm, I wonder if the formula is wrong given that pwmc0 never becomes 3?!
Should this better be

	pwmc0 =3D fls(period >> 16);

?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--obtpyakzbdh7csmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCDAeYACgkQwfwUeK3K
7AnE6wf/VLcp2U0NslNg0ihUaTnXfjF2QFwJu5Z4uXMYtV4FxNluPuIDMrDD25Mx
rHh+B9HtUwv8AnDza99HcfBnAq3evh9G+FaXptprl1nHpRNykrcFz3aF0ESz6sDS
oUXO8Ph0qssoheljPBsqBoNlP9tN5ws15eh5Hio0KcrtbmDpBBmKlKB+q43llwIe
132D/rbKTHT1gnozP8lCdAunthT4fscw+RoZTZ8XrOIQkX5ZinYLsGqbh8LquSqe
JblXOthvAQ/ptvFo3eS6JQ4ky3BD6IruGOrHOTUTHf+EkdyMtxi6Fq7Y5tyiclk/
jLNdfWim6WZ+vwlETt12L1Emq+3PpA==
=8DwE
-----END PGP SIGNATURE-----

--obtpyakzbdh7csmz--
