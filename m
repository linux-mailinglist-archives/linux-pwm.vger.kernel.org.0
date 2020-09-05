Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E2A25E911
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Sep 2020 18:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgIEQhO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Sep 2020 12:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgIEQhM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Sep 2020 12:37:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B722AC061244
        for <linux-pwm@vger.kernel.org>; Sat,  5 Sep 2020 09:37:11 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kEbBS-0002cw-8d; Sat, 05 Sep 2020 18:36:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kEbBQ-0007ue-8J; Sat, 05 Sep 2020 18:36:56 +0200
Date:   Sat, 5 Sep 2020 18:36:56 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     vineetha.g.jaya.kumaran@intel.com
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v5 2/2] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Message-ID: <20200905163656.sbctznrjtvyig7q4@pengutronix.de>
References: <1598437559-25828-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1598437559-25828-3-git-send-email-vineetha.g.jaya.kumaran@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7b3py3w6jnkytncl"
Content-Disposition: inline
In-Reply-To: <1598437559-25828-3-git-send-email-vineetha.g.jaya.kumaran@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7b3py3w6jnkytncl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 06:25:59PM +0800, vineetha.g.jaya.kumaran@intel.com=
 wrote:
> From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>
>=20
> Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.co=
m>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7b3py3w6jnkytncl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9TvqUACgkQwfwUeK3K
7AmQLwf+J4RUaf8pOJUOCMZ+9mUrNJ43GrcPM7pzG9YYID6HIJDFb31W0LDtwdsV
xiZyMkGsv9XapXuOmoivzkxiPNhvaPDoSPgLOzDK7GGsy8fwSe09f1FvapeSbuk+
bta7tdu9eCGJEORcb8b+Qv5m4YzylOUAWlFB06O3oqrFFWrgwmUvIDmWlrTzodD4
r2+6xwttv+gTK8RI+RGFSAUx8HR2jOjz56XTiveNHcLul7diBf0ZBLXb3GmGi1Lw
By70dBhwsaxw2YYZOGDjta4W83tj9w5KCBNYOcrU29Aj/da5/2m9GH2MwvYCZzhN
8hP6R7dx34fMGU0IjXYOipIMkRDt6A==
=d+G6
-----END PGP SIGNATURE-----

--7b3py3w6jnkytncl--
