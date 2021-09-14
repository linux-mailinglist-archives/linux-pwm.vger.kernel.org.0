Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BFD40A8B7
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Sep 2021 09:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhINH7l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Sep 2021 03:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhINH7k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Sep 2021 03:59:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34007C061574
        for <linux-pwm@vger.kernel.org>; Tue, 14 Sep 2021 00:58:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mQ3Kd-0000cn-HY; Tue, 14 Sep 2021 09:58:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mQ3Kb-0005d7-UN; Tue, 14 Sep 2021 09:58:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mQ3Kb-0005ui-T4; Tue, 14 Sep 2021 09:58:17 +0200
Date:   Tue, 14 Sep 2021 09:58:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        linux-kernel@vger.kernel.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 7/7] pwm: ep93xx: Prepare clock before using it
Message-ID: <20210914075815.alqnyux5ficgvkme@pengutronix.de>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
 <20210613233041.128961-8-alexander.sverdlin@gmail.com>
 <20210614072222.wgivnzbaekxxw7qu@pengutronix.de>
 <c2d54eb9c0061a779678e311ee6761fa6f117856.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="32krhnwesae5jejf"
Content-Disposition: inline
In-Reply-To: <c2d54eb9c0061a779678e311ee6761fa6f117856.camel@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--32krhnwesae5jejf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2021 at 11:46:41PM +0200, Alexander Sverdlin wrote:
> Hello Thierry,
>=20
> On Mon, 2021-06-14 at 09:22 +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jun 14, 2021 at 01:30:41AM +0200, Alexander Sverdlin wrote:
> > > Use clk_prepare_enable()/clk_disable_unprepare() in preparation for s=
witch
> > > to Common Clock Framework.
> > >=20
> > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> >=20
> > Maybe it would make sense to move the prepare into the probe function?!
> > Anyhow, for now preparing the driver for the common-clk switch is the
> > focus and for that the conversion is correct, so:
> >=20
> > Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> would you take this patch only, please?
> It didn't work out to sell the whole series as one piece and
> most of them were taken individually...

Hmm, this patch is marked as accepted in patchwork
(http://patchwork.ozlabs.org/project/linux-pwm/patch/20210613233041.128961-=
8-alexander.sverdlin@gmail.com/).
There is also a v2, that is also marked as accepted
(http://patchwork.ozlabs.org/project/linux-pwm/patch/20210726140001.24820-8=
-nikita.shubin@maquefel.me/).

Not sure what want wrong here

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--32krhnwesae5jejf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFAVhQACgkQwfwUeK3K
7AlnuAf/QpDpg1S67QGNO3yHsdMWRki6xk1xSc+FsJMh1Zw8AYXWu/zORZ6VEdcz
mwdgiefGiQd1wI8D3ewGdWpKfDcIFBsffRVHpLqB7YFXTKZ8rJDlqKclhGJeGVbE
uYGp9n39fggQHuIgHya2EA3E1HdWQF14hnCyQC1EnN44+01VL0249Fq7G0/fuUc/
UJ6qMgVTaMWZZsNnvILbSeWbdH6XtV8slgB91C44wyi/IkPwXe4R+wZsGHkQUbet
X3qwztxRFpNPChOgK/a3NwXPryCzJbtt4xS2R5URDMvLiS/yt4guKOuXHXxor3sm
HWLOKiVqZSe4gfwMHDDoY6Y96j+yuQ==
=1664
-----END PGP SIGNATURE-----

--32krhnwesae5jejf--
