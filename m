Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E940F25FD05
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Sep 2020 17:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgIGP0U (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Sep 2020 11:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730129AbgIGPWG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Sep 2020 11:22:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A7EC061573
        for <linux-pwm@vger.kernel.org>; Mon,  7 Sep 2020 08:22:06 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kFIy4-0001sZ-RA; Mon, 07 Sep 2020 17:22:04 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kFIy3-0000XG-Js; Mon, 07 Sep 2020 17:22:03 +0200
Date:   Mon, 7 Sep 2020 17:22:03 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH] pwm: Allow store 64-bit duty cycle from sysfs interface
Message-ID: <20200907152203.jau6smhesqlfvexm@pengutronix.de>
References: <20200824145539.3160946-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6niw5vtvjtsmp353"
Content-Disposition: inline
In-Reply-To: <20200824145539.3160946-1-jarkko.nikula@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6niw5vtvjtsmp353
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2020 at 05:55:39PM +0300, Jarkko Nikula wrote:
> PWM core was converted to u64 by the commit a9d887dc1c60 ("pwm: Convert
> period and duty cycle to u64") but did not change the duty_cycle_store()
> so it will error out if trying to pass a numeric string bigger than
> 2^32-1.
>=20
> Fix this by using u64 and kstrtou64() in duty_cycle_store().
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6niw5vtvjtsmp353
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9WUBgACgkQwfwUeK3K
7AlUwAf8CKeSCFdwJ6Iag5/UayQwdXb4Xa9SStlIyYj3B+B3rMMTWPPhfMHBOHwJ
VglByCZx9+UQ6M4zP2PbGzXfsQ+TZEIU6VI6b5V1K8Ha01AXIt1lnVbAyq6+bXdA
ulcIoSLUJTTTK0jj/UomS/wecn7aoJHyDZ2AoPBO2O497/BXdSmNos2+oiZ1sFum
mnEirZtvdGG1FHAsZHNeNayDP27+7n72lVDtTy8Wmw1MZfmay8EMdqkvVuNiYKlS
EdkqEv4SThboD+Zm5SlZqTGMjtlPu71vgIlM+s6B9pcyPN9/pHVKw9Ze9L4t+NTZ
rXghIGPBic/aysn2fXDTM0afstwkxw==
=f4kB
-----END PGP SIGNATURE-----

--6niw5vtvjtsmp353--
