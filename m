Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3489C2B00A2
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 08:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgKLH4u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 02:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgKLH4u (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 02:56:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1253BC0613D1
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 23:56:50 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kd7TM-0002mh-6I; Thu, 12 Nov 2020 08:56:48 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kd7TK-0007lx-Uk; Thu, 12 Nov 2020 08:56:46 +0100
Date:   Thu, 12 Nov 2020 08:56:45 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Ajit Pal Singh <ajitpal.singh@st.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] pwm: sti: Avoid conditional gotos
Message-ID: <20201112075645.cjm6csuxwhzs5aqf@pengutronix.de>
References: <20201111191449.409402-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ybq6akyf2gmwvhwr"
Content-Disposition: inline
In-Reply-To: <20201111191449.409402-1-thierry.reding@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ybq6akyf2gmwvhwr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Wed, Nov 11, 2020 at 08:14:48PM +0100, Thierry Reding wrote:
> Using gotos for conditional code complicates this code significantly.
> Convert the code to simple conditional blocks to increase readability.
>=20
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Great you picked that up, thanks.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ybq6akyf2gmwvhwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+s6roACgkQwfwUeK3K
7Am+Jwf+IChwKZS3+CB/KYPKC8vOq6YksTZEo+su6fb+1ChHLuygdgSBPykcADwn
rsdvHn0CRLCrm6FBLjbtfrism8Rj2PcJDdtWy4BduwmUaSm/i4LQODtC+7I9JUaf
Pw0Ad3HGVO4BOPZngoNI5xgcwYsu9XQ7ytf8S11V5H57xDcS/OsqWYJ6wE4JQY2Q
M8XKgEVirAlR8oLkBbMlKm3DaTYoMCYKb3pQts2tSmMHm/EWO+swHpGSsgPBY7kR
Ff2iTSpW8ptSggoOmclyz8T7m0jYF0+JxVJ/O1yq5S6r8gRVsFEkqAv2wRDiFWpA
rEBUFkjp28UdP1O9UYavk3L2iIkP3w==
=w040
-----END PGP SIGNATURE-----

--ybq6akyf2gmwvhwr--
