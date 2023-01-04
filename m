Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC0365CE2A
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Jan 2023 09:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjADISo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Jan 2023 03:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjADISn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Jan 2023 03:18:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F421A049
        for <linux-pwm@vger.kernel.org>; Wed,  4 Jan 2023 00:18:41 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pCyyt-0003UI-D6; Wed, 04 Jan 2023 09:18:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pCyys-003jx5-GP; Wed, 04 Jan 2023 09:18:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pCyyr-00A7eU-IQ; Wed, 04 Jan 2023 09:18:37 +0100
Date:   Wed, 4 Jan 2023 09:18:37 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Axel Lin <axel.lin@ingics.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: ab8500:
Message-ID: <20230104081837.3arfyj53zdtyinjb@pengutronix.de>
References: <20230103231841.1548913-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jngmzgeor5naqiuq"
Content-Disposition: inline
In-Reply-To: <20230103231841.1548913-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jngmzgeor5naqiuq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

oops, I fatfingered the subject. Something like

	pwm: ab8500: Properly handle duty cycle > 1024 ns and period

would make sense. I'll wait a bit for more feedback before resending. A
confirmation that my guess about the constant period from someone with
access to the relevant documentation would be great.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jngmzgeor5naqiuq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmO1NloACgkQwfwUeK3K
7AnpMgf9FOFAxZq7FC3FnCY3trKUATVBslPliCrbe12rbRSzvgz+zaut9X5PCHik
MYJF55S2TyY6zWKxH7B60I4vH2JOrHfREfA96yfdGyv4iSHMXrqjbRdr7A8c+dMN
WMEgmAbrTloEwMwMq/kLWxd2Xnxby+rVNTV4lSQEBwvhFp1m9FSRNOpEV4cuSxLT
LbLTwYEZx6zpmH2gjzT8beohQ/NoUjTyfpok8QUMiEL754GwERrqvhWRHR0DaQug
dSpxt0t+eYprl49nJOIF0/z4gK7gbc8QbZOdoVoeZFJ2MgglNsHZSwsjDGVcT68A
/CoJd1JKXc2ksf5P/oDlsCmpYhIdsA==
=Dv22
-----END PGP SIGNATURE-----

--jngmzgeor5naqiuq--
