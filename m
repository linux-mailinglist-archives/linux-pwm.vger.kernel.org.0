Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA13352FEC
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Apr 2021 21:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhDBTsQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Apr 2021 15:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhDBTsQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Apr 2021 15:48:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D582C0613E6
        for <linux-pwm@vger.kernel.org>; Fri,  2 Apr 2021 12:48:14 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lSPm6-0001fg-6A; Fri, 02 Apr 2021 21:48:10 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lSPm5-0008ML-NF; Fri, 02 Apr 2021 21:48:09 +0200
Date:   Fri, 2 Apr 2021 21:48:05 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] pwm: pca9685: Support staggered output ON times
Message-ID: <20210402194805.rj65qcdmzfgcbgri@pengutronix.de>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-4-clemens.gruber@pqgruber.com>
 <20210329170357.par7c3izvtmtovlj@pengutronix.de>
 <YGILdjZBCc2vVlRd@workstation.tuxnet>
 <20210329180206.rejl32uajslpvbgi@pengutronix.de>
 <YGRqZsi4WApZcwIT@workstation.tuxnet>
 <YGShjDE8R31LwAbi@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h3wxik5jkm2uo47v"
Content-Disposition: inline
In-Reply-To: <YGShjDE8R31LwAbi@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--h3wxik5jkm2uo47v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Mar 31, 2021 at 06:21:32PM +0200, Thierry Reding wrote:
> However, I'm a bit hesitant about this staggering output mode. From what
> I understand what's going to happen for these is basically that overall
> each PWM will be running at the requested duty cycle, but the on/off
> times will be evenly spread out over the whole period. In other words,
> the output *power* of the PWM signal will be the same as if the signal
> was a single on/off cycle. That's not technically a PWM signal as the
> PWM framework defines it. See the kerneldoc for enum pwm_polarity for
> what signals are expected to look like.

After reading this thread I had the impression that there is no
(externally visible) difference between using ON =3D 0 plus programming a
new setting when the counter is say 70 and using ON =3D 30 plus
programming a new setting when the counter is 100. But that's not the
case and I agree that defaulting to staggering is a bad idea.

Having said that I doubt that adding a property to the device tree is a
good solution, because it changes behaviour without the consumer being
aware and additionally it's not really a hardware description.

The solution I'd prefer is to change struct pwm_state to include the
delay in it. (This would then make the polarity obsolete, because

	.duty_cycle =3D 30
	.period =3D 100
	.polarity =3D POLARITY_INVERTED
	.offset =3D 0

is equivalent to

	.duty_cycle =3D 30
	.period =3D 100
	.polarity =3D POLARITY_NORMAL
	.offset =3D 70

=2E Other inverted states can be modified similarily.) Then consumers can
be coordinated to use different offsets.

I'm aware changing this isn't trivial, and it's not thought out
completely, but I think the end result is rechnically superior to the
approach suggested in the patch under discussion.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--h3wxik5jkm2uo47v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBndPIACgkQwfwUeK3K
7Al2OQf/fo7xgkHJKYOh3gQC77XzTMMGFDbuSKGdRx/ojyJ2jy5wrs7Zp/ChKVIQ
ZCi5nwUg06JYkWWPy+5vUtaIn9bIUXzClrHKz6kKNvLFmevoN4sT/g7jHwekTOqw
SXlMM/gRiHn+m1Xcifn58xLs6W4XMaYWR3CZ/hGWIOqTvgpeVSDuU8eoIvdzb9HQ
UQNr4ZT/BlfT7GSNILntVUitrx8/klmqE/sk3W+kVVVA47qL3UCgVXWiy9jzAiS+
3N2GqdFciEackRGRR6oCiksrVtAeIQSeIf7uca9aEjme7lUZGRPGTnWkOKeT5yxF
pWHNV/cOF85WHFL180aNw6CPROxomA==
=FwRs
-----END PGP SIGNATURE-----

--h3wxik5jkm2uo47v--
