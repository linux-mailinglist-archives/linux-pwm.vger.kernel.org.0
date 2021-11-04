Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFC24453A5
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Nov 2021 14:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhKDNR1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Nov 2021 09:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhKDNR1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Nov 2021 09:17:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61384C06127A
        for <linux-pwm@vger.kernel.org>; Thu,  4 Nov 2021 06:14:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1micZo-0002J3-BX; Thu, 04 Nov 2021 14:14:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1micZm-0005KK-Iz; Thu, 04 Nov 2021 14:14:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1micZm-0007IK-Hr; Thu, 04 Nov 2021 14:14:42 +0100
Date:   Thu, 4 Nov 2021 14:14:42 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: tpu: Add R-Car V3U device tree bindings
Message-ID: <20211104131442.b3yzmdmq2fylkbpz@pengutronix.de>
References: <8ec1e2aadfc894a3cc8c412e266b87220fa0404e.1635337616.git.geert+renesas@glider.be>
 <20211029160303.lv6je33mjr6zk7xh@pengutronix.de>
 <YYPV0PVC9dwnxG1I@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6d7huwtxdjrm6neu"
Content-Disposition: inline
In-Reply-To: <YYPV0PVC9dwnxG1I@ninjato>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6d7huwtxdjrm6neu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 04, 2021 at 01:45:04PM +0100, Wolfram Sang wrote:
> On Fri, Oct 29, 2021 at 06:03:03PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Wed, Oct 27, 2021 at 02:28:09PM +0200, Geert Uytterhoeven wrote:
> > > From: Duc Nguyen <duc.nguyen.ub@renesas.com>
> > >=20
> > > Add device tree bindings for TPU with the PWM controller found
> > > on R-Car V3U SoCs.
> > >=20
> > > Signed-off-by: Duc Nguyen <duc.nguyen.ub@renesas.com>
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >=20
> > From PWM POV:
> >=20
> > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Uwe, thanks for the ack. Do such changes go via the PWM tree usually?

Yes, but it's Thierry who manages the git tree, so my Ack is mostly
cosmetic. And I said "From PWM POV" because I didn't want to judge if
the added SoC really exists.

Best regards and sorry for the confusion,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6d7huwtxdjrm6neu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGD3L8ACgkQwfwUeK3K
7AmxrAf9GdirV3O0EBkEBm3gFTZLTdWsRqY7hG1z/CdbVA70h84X97FY21hD5WNq
x7uAAd+OSN0l1Jo4MpNb6+Z9jEj9JZZB/IQuM+ig5NQ4lWJ3PYD4C+An+jW6jLuo
xuUhchp7FIHn1VfsP9N+nFzKA4S44/btztYn/CCCLQ36MWt9aRUvhlCek5LNXyVd
KChAETNYUNN6cK266PoobGDyyqv8aWIcPiVulG2ensbaGSYFJVWwiEP2g5MZInjA
BgesGTYyE+4AXyK4z/IIz/fRR7kIesZXXiB/E57U3iBtdngJiE1Uh0mmulKGywmt
yl6zU41dSo+jTkbWaj0a/ofQvWrEsA==
=KYbz
-----END PGP SIGNATURE-----

--6d7huwtxdjrm6neu--
