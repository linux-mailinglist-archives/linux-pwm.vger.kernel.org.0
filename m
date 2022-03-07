Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E324D06D5
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Mar 2022 19:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiCGSs6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Mar 2022 13:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiCGSs5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Mar 2022 13:48:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9169D4BFE3
        for <linux-pwm@vger.kernel.org>; Mon,  7 Mar 2022 10:48:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nRIOm-0007c1-Bi; Mon, 07 Mar 2022 19:48:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nRIOl-003Hm4-BB; Mon, 07 Mar 2022 19:47:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nRIOj-007d8T-Mz; Mon, 07 Mar 2022 19:47:57 +0100
Date:   Mon, 7 Mar 2022 19:47:50 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] pwm: brcmstb: Some cleanups
Message-ID: <20220307184750.qkbueadgqohbvv2g@pengutronix.de>
References: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="awn2454gjkedxgqt"
Content-Disposition: inline
In-Reply-To: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
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


--awn2454gjkedxgqt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Florian,

I have a few questions here looking in more detail into the brcmstb
driver:

 - What happens on PWM_ON(channel) =3D 0?
   I guess it just emits a flat inactive line, and refusing a small
   duty_cycle that results in PWM_ON(channel) =3D 0 is just artificial?

 - There is a line describing:

   	W =3D cword, if cword < 2 ^ 15 else 16-bit 2's complement of cword

   The driver only considers powers of two <=3D 2^15 for cword. Is the
   implementation just lazy, or is the comment misleading?
   At least s/</<=3D/ ?
   There is no sense in using a value > 2^15 as for each such value
   there is a smaller value with the same result, right?

 - clk_get_rate(p->clk) is expected to return 27 MHz, right?
   (Just for my understanding, not about to hardcode this in the code)

 - The explanation about period in the comment is:

   	The period is: (period + 1) / Fv

   so I would have expected:

   	pc =3D (period_ns * clkrate * cword / (NSEC_PER_SEC << 16)) - 1

   (assuming no overflows). However the -1 isn't in the code.

 - Duty-cycle calculation is unclear, the docs say:

 	"on" time is on / (period + 1)

   I suspect on time is $on / Fv though?
   But even with that I don't understand the +1 in

 	dc =3D mul_u64_u64_div_u64(duty_ns + 1, rate, NSEC_PER_SEC);

Can you enlighten me?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--awn2454gjkedxgqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmImUysACgkQwfwUeK3K
7AmZDgf7B5qXcFsqaJjpxAxupVAA9oHnn0N580ci6BcEar/KPAWeMzycla/xXc98
8m5e28RRYM2vgo6S9FHQquFSrvvt7NHt6BNecM+5XJGgF1QFznS1MQEB1vcxi4sG
/Lz13oDYgBvYXCVWe+puZAgPcpY/zKmLMdVc2x//nZthcJb9Wb7eMmjzBi9B9HMY
PRdhG3mi0JZ7HJl0n7hJceBV0pcPzrLc+C0+vs+yVm+Tb41IgAnrOtn+tQvmxE/D
UCEnJlOSvnAjFSWW/rlRISeEGA8hIHXXNhdfvoxd4OK8HjRBoI8Dxk7DN7kw3wY+
6VVmeB5ayi5GeMS3G18hUOqjikvI9g==
=BcEX
-----END PGP SIGNATURE-----

--awn2454gjkedxgqt--
