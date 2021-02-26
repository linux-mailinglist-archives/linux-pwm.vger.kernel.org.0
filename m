Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C40E32606C
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Feb 2021 10:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhBZJsF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 Feb 2021 04:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhBZJsE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Feb 2021 04:48:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C96C061574
        for <linux-pwm@vger.kernel.org>; Fri, 26 Feb 2021 01:47:24 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lFZiU-0008IA-93; Fri, 26 Feb 2021 10:47:22 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lFZiT-0001rt-RD; Fri, 26 Feb 2021 10:47:21 +0100
Date:   Fri, 26 Feb 2021 10:47:21 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] pwm: iqs620a: Correct a stale state variable
Message-ID: <20210226094721.2uzjupkcy42qpjuw@pengutronix.de>
References: <1611030629-21746-1-git-send-email-jeff@labundy.com>
 <20210122181239.ut33bmzxlvy2mx5f@pengutronix.de>
 <20210215011927.GA15385@labundy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iul7quvq7cqhkcqx"
Content-Disposition: inline
In-Reply-To: <20210215011927.GA15385@labundy.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--iul7quvq7cqhkcqx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jeff,

On Sun, Feb 14, 2021 at 07:19:27PM -0600, Jeff LaBundy wrote:
> Do you have any objection to applying Uwe's patch [1] followed by
> this one so that they can land in 5.12?

FTR: These two patches are in Linus' tree now.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--iul7quvq7cqhkcqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmA4w6YACgkQwfwUeK3K
7AmnKgf/au2V/YbjJGilLTXeJRv30aBAQ/E4uMdQBXO3KxvDBfisSEEQWmEzU1H8
jf3VQpMgCdOjx11AxZIrZMYSNahVk4/HVeQnYwma8gLQwxQnc76V4OdU97rZf6Go
f63u9nOb13vgkC//qKvljfuoTrtxp7dvP9SiaYd3DQFbDOgig7lXPlNBByk2rF5A
1ABdTqhqHtS/L03T4DUwPdMCYaOMj1tusdk+OBdL3TWzB3C9sRoiMPro5eW5+bh3
ju5CRgVBvmWPGlSeYqoO8CvMfem8H05+KHsXgkTSs5xUvvYxONQ42k6Yr9J1p0wT
tbLRJoTrsVlVN18/flHc+99MRKirgw==
=WnQE
-----END PGP SIGNATURE-----

--iul7quvq7cqhkcqx--
