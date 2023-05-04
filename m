Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565E56F6539
	for <lists+linux-pwm@lfdr.de>; Thu,  4 May 2023 08:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjEDGrs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 May 2023 02:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjEDGrr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 May 2023 02:47:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CC218D
        for <linux-pwm@vger.kernel.org>; Wed,  3 May 2023 23:47:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1puSkW-0004GN-Oj; Thu, 04 May 2023 08:47:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1puSkV-00107Q-Pp; Thu, 04 May 2023 08:47:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1puSkU-0019d4-Dc; Thu, 04 May 2023 08:47:30 +0200
Date:   Thu, 4 May 2023 08:47:30 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: pwm-meson: remove not needed check in meson_pwm_calc
Message-ID: <20230504064730.gaguyecx4q7duatk@pengutronix.de>
References: <d2aa9fa6-4513-c3e8-493a-3a34d5a1143b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l27iljz5ce5hmtes"
Content-Disposition: inline
In-Reply-To: <d2aa9fa6-4513-c3e8-493a-3a34d5a1143b@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--l27iljz5ce5hmtes
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Heiner,

On Thu, May 04, 2023 at 07:35:55AM +0200, Heiner Kallweit wrote:
> duty <=3D period implies that duty_cnt <=3D cnt. We verified before
> that cnt <=3D 0xffff, therefore we can omit the check here.
>=20
> Suggested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> Note: Applies only after "pwm: pwm-meson: fix handling of period/duty if =
greater than UINT_MAX"

Do you know there is git magic to express this that (at least some of)
the build bots understand? Look at git format-patch's --base option.

Otherwise:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--l27iljz5ce5hmtes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRTVQEACgkQj4D7WH0S
/k7Itwf/UZ6xOm61HvMKYT2c1czPL/YVbje2gB9Puc7t7yZ0YQN9h9ASOBj0/aY9
gskUx0GfnV5QhN3ndbSF1HqArPXArPrnzscmdmgrxSPNOk6xy7ArGd91UyXDLJ9o
Bh08dPiuPYKqdMMyCCFRfF14DLLti+MY/nLCmQdX250pgNnzXqM79oZ+1IQA+69U
nrX/wH1qsXBsA+gnI3GLJsf7hMDaKxRrgcyghlN5kpewEdpQ/HUzTcrsyxG9e8fn
ovuN/WBjN63WMpi2J+qImticMa3iwqBvGTOSlg6YbG5wdxeIHa1PbY08xUP52/Mj
VdNyxG0WVz6/gFAdqxBYjQUey/Z8Zg==
=4XkC
-----END PGP SIGNATURE-----

--l27iljz5ce5hmtes--
