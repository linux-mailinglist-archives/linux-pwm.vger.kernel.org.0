Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289C928E7B1
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Oct 2020 22:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgJNUFA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Oct 2020 16:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgJNUFA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Oct 2020 16:05:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13044C061755
        for <linux-pwm@vger.kernel.org>; Wed, 14 Oct 2020 13:05:00 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSn15-0000qa-R7; Wed, 14 Oct 2020 22:04:55 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSn13-0000yi-U4; Wed, 14 Oct 2020 22:04:53 +0200
Date:   Wed, 14 Oct 2020 22:04:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     vijayakannan.ayyathurai@intel.com
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v12 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20201014200453.k5qejablwz6idjxt@pengutronix.de>
References: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <5fc6189f9c4cf382d54ae00e663f296baeb2c06e.1602703463.git.vijayakannan.ayyathurai@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jbgoyawyzvdbxdjz"
Content-Disposition: inline
In-Reply-To: <5fc6189f9c4cf382d54ae00e663f296baeb2c06e.1602703463.git.vijayakannan.ayyathurai@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jbgoyawyzvdbxdjz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2020 at 03:36:09AM +0800, vijayakannan.ayyathurai@intel.com=
 wrote:
> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
>=20
> The Intel Keem Bay SoC requires PWM support.
> Add the pwm-keembay driver to enable this.
>=20
> Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
> Co-developed-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.=
com>
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.co=
m>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks for your persistence to create a great driver.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jbgoyawyzvdbxdjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+HWd8ACgkQwfwUeK3K
7Amxzwf/fhmrdmKQsVVTvRHqFyyCBl2+BlZIoYqRAmBKOBlxX54uLOmA1lirvyob
tcVOjOW7LUYrztsKLegxcjgu9AmQPZU0KdBtdU2WsaQPw0VD4CZ6/W0mkDRz9+s7
w/Sv+iLvQpcuFIRs0bvXFVbUZCa3CMVNjCgg+KCg2aKQ9jrSgGk5IgRCz/GiX+kq
VW6YGUuIgDUGWe1d5YBRC9o66pZ1+5jfWNkryoCrG71xSHWxWcr1LkPF3CpEAnpU
15Z0xoV61bDCKiuXJa76iWtm4hETwyPastsJD017eyKDIoEnj0qoaHaiREv5so1F
4hu9zlhzw6cgGVyy/tfoMxqksu7WYQ==
=M/D6
-----END PGP SIGNATURE-----

--jbgoyawyzvdbxdjz--
