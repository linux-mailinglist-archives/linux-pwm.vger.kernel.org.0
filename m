Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDB4321156
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Feb 2021 08:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhBVHXT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Feb 2021 02:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhBVHXO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Feb 2021 02:23:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3063CC06178A
        for <linux-pwm@vger.kernel.org>; Sun, 21 Feb 2021 23:22:34 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lE5Y7-0005IW-12; Mon, 22 Feb 2021 08:22:31 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lE5Y5-0004hX-OL; Mon, 22 Feb 2021 08:22:29 +0100
Date:   Mon, 22 Feb 2021 08:22:29 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?54+t5rab?= <fengzheng923@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mripard@kernel.org, wens@csie.org, thierry.reding@gmail.com,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: sunxi: Add Allwinner SoC PWM controller driver
Message-ID: <20210222072229.6zvwi2c5eojy2d4j@pengutronix.de>
References: <20210203125317.1975-1-fengzheng923@gmail.com>
 <20210203151200.fdzzq23teoypbxad@pengutronix.de>
 <CAE=m618FY6_Qq1gNmkivswKjCB984WfV_Cr_Cw253ffGQmAS5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vxfyc6lupdiwoyhb"
Content-Disposition: inline
In-Reply-To: <CAE=m618FY6_Qq1gNmkivswKjCB984WfV_Cr_Cw253ffGQmAS5Q@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vxfyc6lupdiwoyhb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 20, 2021 at 10:18:27AM +0800, =E7=8F=AD=E6=B6=9B wrote:
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E4=BA=8E2021=E5=
=B9=B42=E6=9C=883=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:12=E5=86=
=99=E9=81=93=EF=BC=9A
>=20
> > Hello Ban,
> >
> > On Wed, Feb 03, 2021 at 08:53:17PM +0800, Ban Tao wrote:
> > > v1->v2:
> >
> > FTR: v1 wasn't sent to any list, so don't try to find it in some
> > archive.
> >
>=20
> Sorry, I understand. So is the next patch v3? Or v2?

Using v3 is fine. Please don't send another series that is called v2.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vxfyc6lupdiwoyhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAzW7IACgkQwfwUeK3K
7AkWwggAhkq6CJS1KD9oYQ7qNG+6yhKRylexiymtJ45lhxwj/YUPyL7xn23lqE/i
8amGrQHfQQ0UO3CaDg2/TVPRZ2DKdTBjEk9KAvaQNfGdGe67D4f3J0n0Uh/CZThg
BzEVTRg8KwQiTtCUu3pQ3DhKHD9JoZ28S5KB3PZr3yUNhwUAfH+gFeuZzZK7HGUU
CZyaiXha2RC9Rw7E7xl57yCQ1W+0bL8nBxQoWKfcPDvyTicDn1rml5OpVxOuQJEr
nGCvBs1jBi997AKCbpEP0fSlMIpsROdCdYekA1/k6sBXfhkDYsVC5uROJz+c4bmC
hmBwy/BHc+IrAm8ccERZwsUpDnVA+A==
=hBBJ
-----END PGP SIGNATURE-----

--vxfyc6lupdiwoyhb--
