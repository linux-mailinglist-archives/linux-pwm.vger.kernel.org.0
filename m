Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F029F3A1E35
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jun 2021 22:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFIUnn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Jun 2021 16:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFIUnm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Jun 2021 16:43:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763C0C061574
        for <linux-pwm@vger.kernel.org>; Wed,  9 Jun 2021 13:41:47 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lr51E-0004DH-In; Wed, 09 Jun 2021 22:41:44 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lr51E-0004QN-7a; Wed, 09 Jun 2021 22:41:44 +0200
Date:   Wed, 9 Jun 2021 22:41:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sven Van Asbroeck <TheSven73@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/4] pwm: core: Support new usage_power setting in PWM
 state
Message-ID: <20210609204144.nkksqjovs2yqfiyo@pengutronix.de>
References: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
 <20210507150317.bnluhqrqepde4xjm@pengutronix.de>
 <YJVhLrkeNXBp6M1p@workstation.tuxnet>
 <20210507231831.zmvyspcq7xhm25y4@pengutronix.de>
 <YLUK8GXHaBYyVe1R@workstation.tuxnet>
 <YLn3MZ+6HJM/UrRT@orome.fritz.box>
 <20210607060827.vxdihsfqtw3otyco@pengutronix.de>
 <YL4vzvznTzqih0pA@orome.fritz.box>
 <20210607185158.jweahkoa3cxwl2nh@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xtamggj425ztxndq"
Content-Disposition: inline
In-Reply-To: <20210607185158.jweahkoa3cxwl2nh@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xtamggj425ztxndq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Mon, Jun 07, 2021 at 08:51:58PM +0200, Uwe Kleine-K=F6nig wrote:
> My problem is not that in the end a solution is picked that wasn't my
> favourite. My problem is that I have the impression my arguments were
> not considered but simply ignored.

Another thing that annoys me is that there are currently ~20 open
patches by me in patchwork, most of them are easy to understand cleanups
and fixes, most of them are older than Clemens' series and most of them
are uncommented by you. And in this situation you apply the only
controversial series.

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xtamggj425ztxndq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDBJ34ACgkQwfwUeK3K
7Ak+cAgAiYI/FArcq9sayMBtSkEOKbDV7Wf7gdj1mtlUlmJPXx+PmMjzP2eRS3WF
dXyZ5Rpux2AsCyvBKAaYKSIFp4mdwH0hseSBeqwaQdB/g1KBa+3IRek8KLJSGjhb
xKBuzXCCQSQaNwld0cOXEhjAj2YadbfaFf4VZVr02jGH5hw8e7mq40xx/wdvquUP
OfmGSIEHo1Se0x5OgzWBRaeAB+KWQE3UjLdDZ4f2goQH6FVHvcS6aOJriDA3C5EE
13D3CVl3fJP7ZnENaEeO527scoDTG9R86Z3OOeZdaeU/p9gOIqyFWfDkMifhUzsE
joRsnyN0O24f+CdgIvmROpN86PIA3g==
=xKGo
-----END PGP SIGNATURE-----

--xtamggj425ztxndq--
