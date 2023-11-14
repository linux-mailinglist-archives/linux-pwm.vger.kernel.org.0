Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F23C7EAAE6
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 08:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjKNH3H (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 02:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKNH3H (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 02:29:07 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C98D1
        for <linux-pwm@vger.kernel.org>; Mon, 13 Nov 2023 23:29:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2nr2-0005ut-T6; Tue, 14 Nov 2023 08:29:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2nr2-008wNB-9B; Tue, 14 Nov 2023 08:29:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2nr2-001HCH-00; Tue, 14 Nov 2023 08:29:00 +0100
Date:   Tue, 14 Nov 2023 08:28:59 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee@kernel.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH 0/2] pwm: Use an idr to assign pwm_chip IDs
Message-ID: <20231114072859.ffikahqfjufgw3j6@pengutronix.de>
References: <20230808165250.942396-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ddsg4ab7menppnul"
Content-Disposition: inline
In-Reply-To: <20230808165250.942396-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ddsg4ab7menppnul
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Aug 08, 2023 at 06:52:48PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> this series depend on patch "leds: qcom-lpg: Drop assignment to struct
> pwmchip::base" which Lee already claimed to have applied in
> https://lore.kernel.org/linux-leds/169054337847.351209.786409848151140673=
7.b4-ty@kernel.org/,
> but it didn't made it into next yet.

The led patch is in v6.6-rc1 already, so this series could go in, too.

Applying it to v6.7-rc1 yields an easy merge conflict. Please tell me if
I should resend.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ddsg4ab7menppnul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVTIbcACgkQj4D7WH0S
/k4coAgAqSImS2aFmt8jFMPUtvcMDtBRaqtEX3SxZWBGk6KI0huWbzxGX8yYjsjL
HGJkbEg+d7x6v7c0CtdGPIrRZvX0VNsOP9pY7PggZ+QpwP7pEyMe4NupvOCGse09
nmxrJsEyza69JYMH2JboXugwCD6+LMTF5xDn5LcMJrX7ynQq9zZcH9DOnmCs04Gz
fGIIZpm7yMhYd3RfGA8QtI6GPZtgvVOzxmBQ/sGqcEAL+tSodb/MiIVyfZTFiELV
6pB1m3nDejkkqsIvPX93wDTpFqqudsF1X1ihuGKHPfGFet7xqVPHTkNQ1fRMpGRG
Sc5/VITkx1LSiR4HY1FgZlIxTOs/3Q==
=SwO8
-----END PGP SIGNATURE-----

--ddsg4ab7menppnul--
