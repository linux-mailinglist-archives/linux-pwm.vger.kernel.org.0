Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF539E6E3
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 20:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhFGSxy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 14:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhFGSxy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jun 2021 14:53:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6222C061766
        for <linux-pwm@vger.kernel.org>; Mon,  7 Jun 2021 11:52:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lqKLv-0005zF-F8; Mon, 07 Jun 2021 20:51:59 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lqKLu-0002M5-WC; Mon, 07 Jun 2021 20:51:59 +0200
Date:   Mon, 7 Jun 2021 20:51:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sven Van Asbroeck <TheSven73@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/4] pwm: core: Support new usage_power setting in PWM
 state
Message-ID: <20210607185158.jweahkoa3cxwl2nh@pengutronix.de>
References: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
 <20210507150317.bnluhqrqepde4xjm@pengutronix.de>
 <YJVhLrkeNXBp6M1p@workstation.tuxnet>
 <20210507231831.zmvyspcq7xhm25y4@pengutronix.de>
 <YLUK8GXHaBYyVe1R@workstation.tuxnet>
 <YLn3MZ+6HJM/UrRT@orome.fritz.box>
 <20210607060827.vxdihsfqtw3otyco@pengutronix.de>
 <YL4vzvznTzqih0pA@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mghuouuljigxlq7q"
Content-Disposition: inline
In-Reply-To: <YL4vzvznTzqih0pA@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mghuouuljigxlq7q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Mon, Jun 07, 2021 at 04:40:14PM +0200, Thierry Reding wrote:
> On Mon, Jun 07, 2021 at 08:08:27AM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello Thierry,
> >=20
> > On Fri, Jun 04, 2021 at 11:49:37AM +0200, Thierry Reding wrote:
> > > In the interest of making forward progress, I've applied this series.
> >=20
> > I proposed a different approach that in contrast to usage_power:
> >=20
> >  - is well defined
> >    (so driver authors and consumers know what to provide or expect resp=
=2E);
> >  - has good name people understand without reading documentation;
> >  - fully covers the problem Clemens want to address;
> >  - fully covers what the only implementing lowlevel driver does; and
> >  - is easy to implement based on the patches in this series
> >=20
> > This is not what I call "forward progress". I take it personal that
> > after I pointed out technical shortcomings with this patch set and even
> > suggested a better concept, you didn't even made the effort to argue
> > but instead simply went on applying the patches.
>=20
> Forward progress doesn't always mean that everybody gets their way.

Do you agree that the usage power flag introduced here isn't well
defined? If you think it is, tell me, what is the maximal and minimal
period a consumer has to expect when .period =3D 10000 ns is requested.
Assume you have a driver (think pwm-gpio) where a longer period means
more power savings. What is "the reasonable" period that the driver
should configure?

Do you agree that in contrast to usage-power allow-phase-shift is well
defined?

Did you ask people in your bubble what they expect from a usage power
flag for a PWM without first explaining what it does? Did you try to ask
an internet search engine what it suggests when searching for "PWM usage
power"?

Do you agree that allow-phase-shift is good enough to solve Clemens'
problem?

Either you give completely other answers than I do or you don't consider
it bad that consumers don't know what they can expect and that names are
unintuitive.

My problem is not that in the end a solution is picked that wasn't my
favourite. My problem is that I have the impression my arguments were
not considered but simply ignored.

> And this is nothing personal, so please don't take it that way.

If this isn't personal (which is great) then it's a decision that is (at
least for me) obviously wrong and ignoring the good arguments against
this choice without any relevant advantages compared to my suggested
solution. I have problems to not take this personal.

> I don't see where you pointed out technical shortcomings with this
> patch, you merely pointed out that you don't like this solution and that
> there might be a better way to implement it by expanding on the concepts
> introduced in this patch series.

Either you didn't read my mail at all, or you have a different idea
about what you consider a relevant argument. (Well, or you don't care
that your choice is bad. I hope this is only a theoretical possibility.)
Being well defined and having an intuitive name belong into this
"relevant" category in my book.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mghuouuljigxlq7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmC+assACgkQwfwUeK3K
7AkKawf+LgHvZxkGwuwIw1V8lZKV6LqHBQteMo2jDtkuYpJzFHnfxd9//MeDExD7
2Vs5CRRs4s18ase22C2v+cFUqG1J4NST4+/7jrZyaADOsNR6ex6QQi/DXXyA/jPh
JZ1r1nk8gGGl5NZV4CX7gIE1TAhmBh8co/IN9hbG2fAOTYPHHgFDTtDFW+HwW14G
pWX8k137a4JdEyYgKBxWMsYoTg8uALw7Lb1L4nlAxi0+IkDJpNk0Ox3OFXhOZcGP
Xvnen1+C+ZjFd4zpjeDooVP3FVQerHSrWifXkeLru7x4P8shIaaKYkn+piT3d5Vq
Q1aDO2t5vLTJj53gPHU+Q7M1kiwOng==
=TlBH
-----END PGP SIGNATURE-----

--mghuouuljigxlq7q--
