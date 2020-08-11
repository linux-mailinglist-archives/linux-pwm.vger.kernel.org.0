Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211082416C7
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Aug 2020 09:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgHKHAy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Aug 2020 03:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgHKHAx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Aug 2020 03:00:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE3CC06174A
        for <linux-pwm@vger.kernel.org>; Tue, 11 Aug 2020 00:00:25 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k5OGk-0003Q1-JB; Tue, 11 Aug 2020 09:00:22 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k5OGk-0007OT-7C; Tue, 11 Aug 2020 09:00:22 +0200
Date:   Tue, 11 Aug 2020 09:00:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 2/3] pwm: imx27: Use dev_err_probe() to simplify error
 handling
Message-ID: <20200811070022.l6buhlwxkq4pjseo@pengutronix.de>
References: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
 <1597127072-26365-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2k36bqrjpgk6rise"
Content-Disposition: inline
In-Reply-To: <1597127072-26365-2-git-send-email-Anson.Huang@nxp.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2k36bqrjpgk6rise
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2020 at 02:24:31PM +0800, Anson Huang wrote:
> dev_err_probe() can reduce code size, uniform error handling and record t=
he
> defer probe reason etc., use it to simplify the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2k36bqrjpgk6rise
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8yQgMACgkQwfwUeK3K
7Am8dwgAgl4D7gpaE2zxYdJeqrplNb6EZDJK+hf+j2oZo1gK4Qosc/3m+8fjW0BO
HjnzddEx9nL9mKygQDJro1oZozW9NciWiKkNSVpPgQHZYKW84fChlv1gQR42d4qf
cWDGmZT2gOB3lJHiXFLruDLWsK5BcF/z9JEYQ/tcnzoi92PQquQ0g9vnBnEB9bYg
VDnwUu/oBJWXXHPLlFW3qKxps22CiQyy5Ee4c1ovbiWpi9lCJOCsiJyMHGT9Zu4L
bOKW3RZUIzXswHQXJ3lWZ4E1VPmmYWZsX/mBZs5YMUrW38bbl0HjKzHEv0Q3mWPN
xsAaVjgmEPTUmlgSsOc3SIZKz6LeQg==
=405E
-----END PGP SIGNATURE-----

--2k36bqrjpgk6rise--
