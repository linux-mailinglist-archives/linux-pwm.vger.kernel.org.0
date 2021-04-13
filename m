Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D822F35DDE3
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 13:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244635AbhDMLi2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Apr 2021 07:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbhDMLi2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Apr 2021 07:38:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE5BC061574
        for <linux-pwm@vger.kernel.org>; Tue, 13 Apr 2021 04:38:08 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWHMs-0000xm-0y; Tue, 13 Apr 2021 13:38:06 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWHMr-0007JF-BA; Tue, 13 Apr 2021 13:38:05 +0200
Date:   Tue, 13 Apr 2021 13:38:05 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 4/8] dt-bindings: pwm: Support new PWM_USAGE_POWER flag
Message-ID: <20210413113805.mjft5jxt3qhsxg6e@pengutronix.de>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-4-clemens.gruber@pqgruber.com>
 <20210412162723.7hlhgqp6wlfbkeky@pengutronix.de>
 <YHR5eyLPqiwhTGrr@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ylyknhukjyy5n3f"
Content-Disposition: inline
In-Reply-To: <YHR5eyLPqiwhTGrr@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6ylyknhukjyy5n3f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Apr 12, 2021 at 06:46:51PM +0200, Clemens Gruber wrote:
> On Mon, Apr 12, 2021 at 06:27:23PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Apr 12, 2021 at 03:27:41PM +0200, Clemens Gruber wrote:
> > > Add the flag and corresponding documentation for PWM_USAGE_POWER.
> >=20
> > My concern here in the previous round was that PWM_USAGE_POWER isn't a
> > name that intuitively suggests its semantic. Do you disagree?
>=20
> No. It is more abstract and requires documentation. But I also didn't
> want to waste too much time on discussing names, so I used Thierry's
> suggestion.

If you introduce API thinking about the name before actually introducing
it is a good idea in general. (OK, the name doesn't become part of the
(binary) dt API, but we don't even agree about its semantic here.)

And IMHO a bad name with a good documentation isn't good enough.
Otherwise we can better just agree on using plain numbers in the .dts
files.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6ylyknhukjyy5n3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB1gpoACgkQwfwUeK3K
7AnlhQf+LbijeNL99k/BA6DLPwjCqv1BwTNIbQYP8NQWZ+wHI2T36hTFTTkCckKB
MHq5AsWUyTAlD680U+Ya+BStulu3Tw+0NE52w+XHC6d2sK1MtKQxeUvt6px8ynUP
lwtMGi4ceVcGXxlToJtJSRYwO/aOG/aezHdYOqrQ6CQoW1tK6Qux471FY6I3eRx6
oy+X+YZ+eEB6gEj8FdCk46x5Tq/jjLZ5CiW22yppoY6GJH03LsJC/wyKgfhxQBQg
22v2otHIiOxX5jjb2E0ISFh37Oid16PICWEZU7l6aZSYe1Q9nOFjl6L1r8zaqh2g
gxolPAqWjxMlpQnuUNQ+gOrESy3WOA==
=69Rv
-----END PGP SIGNATURE-----

--6ylyknhukjyy5n3f--
