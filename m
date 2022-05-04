Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B9F51AC9F
	for <lists+linux-pwm@lfdr.de>; Wed,  4 May 2022 20:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376841AbiEDSXc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 May 2022 14:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376834AbiEDSXY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 May 2022 14:23:24 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4E39A99B;
        Wed,  4 May 2022 10:47:46 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9BFA11C0BA5; Wed,  4 May 2022 19:47:44 +0200 (CEST)
Date:   Wed, 4 May 2022 19:47:44 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     sven@svenschwermer.de
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com, robh@kernel.org
Subject: Re: [PATCH v8 0/3 RESEND] Multicolor PWM LED support
Message-ID: <20220504174744.GD8725@duo.ucw.cz>
References: <20220407073225.71605-1-sven@svenschwermer.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
Content-Disposition: inline
In-Reply-To: <20220407073225.71605-1-sven@svenschwermer.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I believe this patch series is ready for merging.
>=20
> Pavel, please let me know if you need more to get this merged.

Thank you, applied.

Could I get you to submit patch to move this driver into
drivers/leds/rgb/ ?

Thank you,							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYnK8QAAKCRAw5/Bqldv6
8t20AJ9HBoq52uBLzlVv+ezyjmGiVvVGeACgwSQPI+4j9mspEvGIvPZebP/r0zg=
=TO83
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--
