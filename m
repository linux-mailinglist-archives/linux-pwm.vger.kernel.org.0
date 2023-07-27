Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C582764769
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jul 2023 09:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjG0HBM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Jul 2023 03:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjG0HBE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Jul 2023 03:01:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B5726A8
        for <linux-pwm@vger.kernel.org>; Thu, 27 Jul 2023 00:01:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOuzZ-0004al-6y; Thu, 27 Jul 2023 09:00:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOuzY-002Prj-0y; Thu, 27 Jul 2023 09:00:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qOuzX-0088Kb-7a; Thu, 27 Jul 2023 09:00:55 +0200
Date:   Thu, 27 Jul 2023 09:00:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     claudiu beznea <claudiu.beznea@tuxon.dev>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] pwm: atmel-tcb: Harmonize resource allocation order
Message-ID: <20230727070055.xnojyc4kejwxwvwi@pengutronix.de>
References: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
 <20230719192013.4051193-2-u.kleine-koenig@pengutronix.de>
 <7890a50f-48dc-0179-c08b-7f351f42cd1e@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u4asky6gczgmnvap"
Content-Disposition: inline
In-Reply-To: <7890a50f-48dc-0179-c08b-7f351f42cd1e@tuxon.dev>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--u4asky6gczgmnvap
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello claudiu,

On Thu, Jul 27, 2023 at 09:00:28AM +0300, claudiu beznea wrote:
> On 19.07.2023 22:20, Uwe Kleine-K=F6nig wrote:
> > +	tcbpwm =3D devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
> > +	if (tcbpwm =3D=3D NULL)
>=20
> I know this was previously but maybe we can change it like this now:
> 	if (!tcbpwm)
>=20
> this is how is done in most of the memory alloc failure checks (AFAICT).
>=20
> > ...
> > -	tcbpwm =3D devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
> > -	if (tcbpwm =3D=3D NULL) {

I don't care much. If and when I resend I will change to !tcbpwm.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--u4asky6gczgmnvap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTCFiYACgkQj4D7WH0S
/k4yYgf+P6xsiapDwM5ThXe/nP/54F02uvLdzxg2LDVwF6Wa7tpH/SWUrXvg+8uv
Wb1POUBoat0q65/DsronUmIman7YdeCG88CE9R0rka8oMntJnsoJyRcQXPXKfwsf
HiAreTnmdUmeINcL0jIS8IE0U4K4zFpnu8sm7d2brmrtdDtZvEPpkca9MFSIiqqT
BMF2dbZo6uozJ1zZI/keZHZm2anCrFRHWl10Kuyd0AYxY4EMo5sArfjtgmPBVbFu
sA9OKfDN/M9mVyqSkrTirquoKkntJIWlpkhxwK3fk1CIa/+sNw582/lMaUY1fZWU
UKvypC69uyaZrA3IkK9FYMBWQHwjtg==
=gsyv
-----END PGP SIGNATURE-----

--u4asky6gczgmnvap--
