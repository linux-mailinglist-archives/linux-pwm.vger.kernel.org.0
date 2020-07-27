Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E358922F9BC
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 22:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgG0UAv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 16:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0UAu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 16:00:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D33C061794
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jul 2020 13:00:50 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k09Ik-0003r7-CU; Mon, 27 Jul 2020 22:00:46 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k09Ii-0001LM-QN; Mon, 27 Jul 2020 22:00:44 +0200
Date:   Mon, 27 Jul 2020 22:00:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v5 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200727200044.qmrpjua3fewli3vo@pengutronix.de>
References: <cover.1595489518.git.rahul.tanwar@linux.intel.com>
 <0f47648107ec23f72868ca37f29ea43e15c08e08.1595489518.git.rahul.tanwar@linux.intel.com>
 <20200723161553.ey47oijnwitf4hvu@pengutronix.de>
 <c2ef8f5c-af23-a63d-5f72-de0c307be8eb@linux.intel.com>
 <20200727070126.2juwfmra3i67lxfw@pengutronix.de>
 <70fde2ba-b38f-a0d6-bc2d-89c074afd466@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="udb6nlegm2enchjz"
Content-Disposition: inline
In-Reply-To: <70fde2ba-b38f-a0d6-bc2d-89c074afd466@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--udb6nlegm2enchjz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jul 27, 2020 at 03:30:16PM +0800, Tanwar, Rahul wrote:
> On 27/7/2020 3:01 pm, Uwe Kleine-K=F6nig wrote:
> > In v4 you had:
> >
> > 	if (state->polarity !=3D PWM_POLARITY_NORMAL ||
> > 	    state->period < pc->period)
> > 		return -EINVAL;
> >
> > That's the right thing to do (even though I was unsettled at one point
> > and wrote it was wrong). The check in v5 with state->period !=3D
> > pc->period is wrong.
>=20
> Does that mean we should allow state->period >=3D pc->period cases?

Yes, the driver is supposed to implement the longest period not longer
than the requested one. This implies everything >=3D pc->period is fine.

> If the state->period is greater than HW supported pc->period and
> if we allow it then the duty cycle will again be evaluated to be
> incorrect/higher than requested duty cycle. Am i missing something
> else? Thanks.

Yes, similar as with period you're supposed to implement the longest
duty cycle your hardware supports and that is not longer than the
requested duty cycle.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--udb6nlegm2enchjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8fMmkACgkQwfwUeK3K
7AmMIwgAj2/ZcC+tvYGBFv9yVeB6UDsy/sKUN3nqlJu/OeZ3y7N13gAy+p3IbmNl
AVCGmQTRaUZv3aXXPRASXDktXF7x05ycXJiwTlavY9CKsScmXrkWUdjYJF7qujlV
tsPDmA18PlWwycKsFsp2hj18TbITnwO3rGzeb9qQScLH2iGOH0tjWwKjKhADrz1M
a9ThxUA0AeVCVlIx6f8tJ0CLIKeHrFf85CChfLcD67xh4CqEXo57uDbGnsSGwsa1
wfKdLaeBYoRbpJIEsHUxfmZOfTCv7/V5TGcp7QURaNeUWZvJxRf7iDDP+er70mrX
IieOWaZuvyQhfF5GuiRBqSLKQeZXZg==
=Uk3U
-----END PGP SIGNATURE-----

--udb6nlegm2enchjz--
