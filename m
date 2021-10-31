Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E572440FDC
	for <lists+linux-pwm@lfdr.de>; Sun, 31 Oct 2021 18:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhJaRq0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 31 Oct 2021 13:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhJaRq0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 31 Oct 2021 13:46:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBC4C061570
        for <linux-pwm@vger.kernel.org>; Sun, 31 Oct 2021 10:43:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mhEs2-00089B-TK; Sun, 31 Oct 2021 18:43:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mhEs2-0003ZC-3I; Sun, 31 Oct 2021 18:43:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mhEs2-0005Qm-1n; Sun, 31 Oct 2021 18:43:50 +0100
Date:   Sun, 31 Oct 2021 18:43:47 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Cc:     linux-pwm@vger.kernel.org, Sean Young <sean@mess.org>,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        kernel@pengutronix.de, mchehab@kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: ir-rx51: Switch to atomic PWM API
Message-ID: <20211031174347.57rnaimaagj43u2q@pengutronix.de>
References: <YXqv339PJTHcGxJg@fedora>
 <20211029111232.soknq7mu3r65laar@pengutronix.de>
 <CAH7FV3md_SBTHu9sTp-hLtLd0ERBdXx8HzM=W9hF79X5V=twQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="krrunpn66tkvy3ou"
Content-Disposition: inline
In-Reply-To: <CAH7FV3md_SBTHu9sTp-hLtLd0ERBdXx8HzM=W9hF79X5V=twQA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--krrunpn66tkvy3ou
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 30, 2021 at 08:20:50AM -0300, Ma=EDra Canal wrote:
> Hello Uwe,
>=20
> > Doing this here introduces a change in behaviour. Better do this after
> > pwm_get().
>=20
> I didn't really get this feedback. Isn't pwm_init_state after pwm_get?
> Or should it be before the error treatment of pwm_get?

It is, but it might be repeated resetting the pwm settings when the
device is reopened.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--krrunpn66tkvy3ou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF+1c8ACgkQwfwUeK3K
7AlXGwf/c6JRDXVbOv1soUqXtj9+sMF+3H4FEBWoAfTyAn848wn4B8OsoeP/dBqy
GzDvq8PY22cHUSchUCgTN06oybctgiV/ilIfXRAJiJb4a0c9ZYJ3AnhcHZJYyX/x
nA0PpR6V7YMnY0B+82FAj/Y+V6Q3gHpthTXKRt/s2AZd9XPWvwFO9zHziW46v0fb
csMS0R/PX26EhXMsx+sEMY4fbTG+64crD48E9ZJLMhoax1TYOHahysQptZJCrumX
Md1i284kXoeNjv7QrglumKG+zJuQjTtMRJbrO3T9oCZM+RoysECbrYT73C4Vm8ea
EzCOu17iq8rZikeIzwLjW/c1dZBB1g==
=aM7g
-----END PGP SIGNATURE-----

--krrunpn66tkvy3ou--
