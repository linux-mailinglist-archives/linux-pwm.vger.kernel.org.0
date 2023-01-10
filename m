Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E74664736
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jan 2023 18:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbjAJRRp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Jan 2023 12:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbjAJRRZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Jan 2023 12:17:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC51392EE
        for <linux-pwm@vger.kernel.org>; Tue, 10 Jan 2023 09:17:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFIFU-0004lj-Os; Tue, 10 Jan 2023 18:17:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFIFT-0057pq-Gg; Tue, 10 Jan 2023 18:17:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pFIFS-00BlHu-O4; Tue, 10 Jan 2023 18:17:18 +0100
Date:   Tue, 10 Jan 2023 18:17:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/2] backlight: pwm_bl: configure pwm only once per
 backlight toggle
Message-ID: <20230110171718.w7ay7gd3nivprzrb@pengutronix.de>
References: <20230109204758.610400-1-u.kleine-koenig@pengutronix.de>
 <Y72PjEh8QuLdw1hw@aspen.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xxgulczgcvq2jgvs"
Content-Disposition: inline
In-Reply-To: <Y72PjEh8QuLdw1hw@aspen.lan>
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


--xxgulczgcvq2jgvs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Daniel,

On Tue, Jan 10, 2023 at 04:17:16PM +0000, Daniel Thompson wrote:
> On Mon, Jan 09, 2023 at 09:47:57PM +0100, Uwe Kleine-K=F6nig wrote:
> > When the function pwm_backlight_update_status() was called with
> > brightness > 0, pwm_get_state() was called twice (once directly and once
> > in compute_duty_cycle). Also pwm_apply_state() was called twice (once in
> > pwm_backlight_power_on() and once directly).
> >
> > Optimize this to do both calls only once.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> This will reverse the order in which the regulator is toggled versus the
> PWM starting/stopping. It would be nice to that in the description.

Oh, that wasn't a concious choice. I agree this should be noted. The
current state is also a bit confused because the duty cycle is setup
before the regulator but the PWM only gets enabled afterwards.

Expect a v2 with an updated commit log.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xxgulczgcvq2jgvs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmO9nZkACgkQwfwUeK3K
7AkQ4wgAl7ijOwjOlTvwIq/BaEuRvNSEKmzbya0rwCm24A2WzblV0fAoAccbT3u1
A8wGB3yxdu4VjAOJT/Wh5d8fbQYfnqYEuLrN9afMOGZaSh5IZUW3p30Sk/jHmA23
lJFMGNgycHQnTvJJ038I0zND3lnIsouoQhubHyIYfvaL3ODCalP4HTb6l+SAozc+
UkIiO10cnUVs7wixb2vRls8MICKASpVMAiqDupcFggZiK/5PQ3EEq3u704DnrLbk
EvzYggXV9ePrGAkgNfpdYZLiVevrkaSAu1mdNsMEk9Pv65A+nzEglhETNGkpOlpS
2IxCChH+r1cF7FT4mzp1Qzo/0xX7Jg==
=ZaRD
-----END PGP SIGNATURE-----

--xxgulczgcvq2jgvs--
