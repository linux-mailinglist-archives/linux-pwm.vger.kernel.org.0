Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A82F45585E
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Nov 2021 10:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245315AbhKRJ6s (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 18 Nov 2021 04:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245264AbhKRJ5f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Nov 2021 04:57:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BEAC06121D
        for <linux-pwm@vger.kernel.org>; Thu, 18 Nov 2021 01:54:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mne7i-0003yE-ID; Thu, 18 Nov 2021 10:54:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mne7f-000OTo-OI; Thu, 18 Nov 2021 10:54:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mne7d-0008SV-T7; Thu, 18 Nov 2021 10:54:25 +0100
Date:   Thu, 18 Nov 2021 10:54:18 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     cgel.zte@gmail.com
Cc:     alexandre.belloni@bootlin.com, deng.changcheng@zte.com.cn,
        lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        thierry.reding@gmail.com, zealci@zte.com.cn
Subject: Re: [PATCH V3] pwm: Use div64_ul instead of do_div
Message-ID: <20211118095418.mfodz4ubde5qsx57@pengutronix.de>
References: <20211117145419.b4wb6zp42rjdpgn5@pengutronix.de>
 <20211118025254.163231-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7kouj4zcq22bjk3w"
Content-Disposition: inline
In-Reply-To: <20211118025254.163231-1-deng.changcheng@zte.com.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7kouj4zcq22bjk3w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 18, 2021 at 02:52:54AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>=20
> do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> which on some platforms is 64 bit wide. So use div64_ul instead of do_div
> to avoid a possible truncation.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

There is no S-o-b line matching the mail sender.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7kouj4zcq22bjk3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGWIsUACgkQwfwUeK3K
7AkZ5Qf9HR7iISiYdJZ8YBH614+DPXIpNQoQGAMYpBT/IMDvHXQGKwLZwDr4tje4
+vgghB4LPVcApwDENj78/nnJAkSCtYnoSPKk0b3YR9CBEIviBbbJLWLENtNk1hlW
EaLOf4cs9PF1Or/zfllcRw9fpjVpd4DUtfYfLwOM7ktiYMqem30NQ8GNQalCPcOa
DCWaVwBp/6Dl3QBxnKKoZSFbpT+WinrbVOb6gtDETANXcDe6BSe0SeyhRM+umoQ6
UA8GcslIzt+exZ9qDbgMA4myrnQSyD7pSeEI0FhLPVly06RVhA2H3/2HQB0McYsS
/99h9TRhwJqUhzzvk8cP0B0v66V7mw==
=2WhT
-----END PGP SIGNATURE-----

--7kouj4zcq22bjk3w--
