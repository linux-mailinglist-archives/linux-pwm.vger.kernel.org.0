Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A817B65EE00
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Jan 2023 14:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjAEN5C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Jan 2023 08:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjAEN4J (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Jan 2023 08:56:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023E657939
        for <linux-pwm@vger.kernel.org>; Thu,  5 Jan 2023 05:54:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pDQhd-0004lI-NR; Thu, 05 Jan 2023 14:54:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pDQhb-0040Mr-9L; Thu, 05 Jan 2023 14:54:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pDQha-00AQb5-Jh; Thu, 05 Jan 2023 14:54:38 +0100
Date:   Thu, 5 Jan 2023 14:54:38 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 04/11] leds: qcom-lpg: Propagate errors in
 .get_state() to the caller
Message-ID: <20230105135438.j7fdocows5pmtwyr@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-5-u.kleine-koenig@pengutronix.de>
 <Y45xKswRnao8P8Mf@duo.ucw.cz>
 <Y7WvtRoffqWgMohv@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h22dcudmsyxfwchu"
Content-Disposition: inline
In-Reply-To: <Y7WvtRoffqWgMohv@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--h22dcudmsyxfwchu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2023 at 04:56:21PM +0000, Lee Jones wrote:
> On Mon, 05 Dec 2022, Pavel Machek wrote:
>=20
> > Hi!
> >=20
> > > .get_state() can return an error indication. Make use of it to propag=
ate
> > > failing hardware accesses.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> What's the merge strategy for this?  Can it go in on its own?

It's already in Linus's tree as fea768cf68c04d68ea2a8091c559667378f3b77c.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--h22dcudmsyxfwchu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmO21psACgkQwfwUeK3K
7Ak0BAf/daaRqDEhqCpeppDNqEHB2jrGJf1zU2/9jENmroM/OnBIp1qN/nynJ7op
pxVapy99Zij8vCF3wDf4F2KZAdUpnTggALwDrgQ0SNXxipmt4MRUSBMyE20vCP+d
VsouusExV8Eu97Lp9lcTTAWVtYqqCNaXhThOd3BKFKpXzphsSz9D8TgqdU6B/ssB
o8Iw7FTaPQe+C5MdkfJ9TnXLrdFxjv6BR1Y0mlAcqW90pOjQyIttt//vxapd3YhO
EEgIMe7SvRjJ2zWYtnZ0bl49C3zxAjVtCwBKTxwEVP9bO6d+qKvEzS2lpGpbXbbq
WQ2OKnBKo3G+2RuNzECDQyU2S/ULug==
=uhlt
-----END PGP SIGNATURE-----

--h22dcudmsyxfwchu--
