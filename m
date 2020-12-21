Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227DB2DFC81
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Dec 2020 15:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgLUOAe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Dec 2020 09:00:34 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54979 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgLUOAd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Dec 2020 09:00:33 -0500
X-Greylist: delayed 14463 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2020 09:00:33 EST
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krLhJ-0000oh-1p; Mon, 21 Dec 2020 14:58:01 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krLhG-0007DV-V1; Mon, 21 Dec 2020 14:57:58 +0100
Date:   Mon, 21 Dec 2020 14:57:58 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-pwm@vger.kernel.org, Artur Rojek <contact@artur-rojek.eu>,
        Mathieu Malaterre <malat@debian.org>,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        od@zcrc.me, Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-clk@vger.kernel.org
Subject: Re: About rounding in the clk framework [Was: Re: [PATCH 4/7] pwm:
 jz4740: Improve algorithm of clock calculation]
Message-ID: <20201221135758.edgskzkyyrw4lcx7@pengutronix.de>
References: <20190813052726.g37upws5rlvrszc4@pengutronix.de>
 <1565694066.1856.1@crapouillou.net>
 <20190813123331.m4ttfhcgt6wyrcfi@pengutronix.de>
 <1565700448.1856.2@crapouillou.net>
 <20190813140903.rdwy7p3mhwetmlnt@pengutronix.de>
 <1565799035.1984.0@crapouillou.net>
 <20190814173218.zhg4se3pppano5m3@pengutronix.de>
 <1571662077.3.1@crapouillou.net>
 <20200212072911.nstwj7dgpvceebpy@pengutronix.de>
 <20200414092412.scsl6sekikc2tsv5@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ghhxmotjruvczaqo"
Content-Disposition: inline
In-Reply-To: <20200414092412.scsl6sekikc2tsv5@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ghhxmotjruvczaqo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 14, 2020 at 11:24:12AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Stephen, hello Michael,
>=20
> On Wed, Feb 12, 2020 at 08:29:11AM +0100, Uwe Kleine-K=F6nig wrote:
> > Can you please explain what is the reason why clk_round_rate_up/down()
> > is a bad idea? Would it help to create a patch that introduces these
> > functions to get the discussion going?
>=20
> I didn't get any feedback on my mail. Are you to busy working on more
> important stuff? Is the answer so obvious that you don't consider it
> worth your time to answer?
>=20
> Looking a bit through the code I see there are two callbacks hwclks can
> provide to implement rounding (determine_rate and round_rate). The docs
> for both use the term "return the closes rate actually supported". Does
> that mean "round-closest" is already the official policy and other
> strategies in lowlevel drivers are a bug?

Feedback here would be really appreciated. I intend to unify the rounding
behaviour of PWMs to always round down. If there was a similar
constraint for clks, some corner cases might be a bit simpler.

Looking forward to read about your thoughts,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ghhxmotjruvczaqo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/gqeMACgkQwfwUeK3K
7AnnlAf8DSLvzEXMd2YTiuND2qxImw4seiPMfTrmw/UXrPQs3+y2Jirvryn9rZOi
trg/AHx1nFiIK4z38ElvsJDovPU4sahlSZfXkYM2V3ZwOOQ0B6+1+vT79K1u3Vys
pz1fKj0ohxzAZdGFG9PYMV3fU+QUOeP77OaRthuauSd0oIreitnyJEX8whBk3Eya
oINBZO8+NL9ZOl95sFCMM+iRWbveg6OTvlIN+tibtr7YkPr2w1RWhVaX4C9ixkvP
HiQPSOXZk7x7aBW279dt9F1j2IvL2z79PN/tSAt0XZhNA6e1puwVwKUjvJupTRny
3RoH8OkBsOcsX4P4LNdWD7Jyh12aqg==
=rnX6
-----END PGP SIGNATURE-----

--ghhxmotjruvczaqo--
