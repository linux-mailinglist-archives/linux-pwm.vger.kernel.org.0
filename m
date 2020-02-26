Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F18D17048F
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2020 17:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgBZQjI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Feb 2020 11:39:08 -0500
Received: from foss.arm.com ([217.140.110.172]:38888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgBZQjI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Feb 2020 11:39:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5320C30E;
        Wed, 26 Feb 2020 08:39:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCCC33F819;
        Wed, 26 Feb 2020 08:39:06 -0800 (PST)
Date:   Wed, 26 Feb 2020 16:39:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] regulator: pwm: Don't warn on probe deferral
Message-ID: <20200226163905.GH4136@sirena.org.uk>
References: <20200224144048.6587-1-jonathanh@nvidia.com>
 <20200224165859.GJ6215@sirena.org.uk>
 <20200226161757.idpzbs3jmayt7ya6@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nOM8ykUjac0mNN89"
Content-Disposition: inline
In-Reply-To: <20200226161757.idpzbs3jmayt7ya6@pengutronix.de>
X-Cookie: May all your PUSHes be POPped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 05:17:57PM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Feb 24, 2020 at 04:58:59PM +0000, Mark Brown wrote:

> > This then means that there's no way for users to determine why the
> > driver has failed to instantiate which can be frustrating.  It'd be
> > better to at least have some dev_dbg() output when deferring so that
> > there's something for people to go on without having to instrument the
> > code.

> Not printing an error message is quite usual however. I think a generic

Usual yet also frustraing.

> approach that for example makes the list of devices that should be
> retried to probe on the next opportunity inspectable would be nice.

That's not really the issue, the bigger issue is trying to figure out
why things are stuck - what exactly caused things to fail to
instantiate.

--nOM8ykUjac0mNN89
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5WnygACgkQJNaLcl1U
h9C0mQf+Je+yXfq6X/+OPbN4ayVYuPYE2Jogk4VoMhPMPWkBhvvwkMwaer0tCd3p
3fjLqb+JrBNj/HDM7DuLyAp/gh9KvTeMOvkat713Rtn3N41DhMBykaKzSAHRPRQm
P4DZJiD1AjacRHfVyFhW0n2HGbQdDCNivbk+JYVyfrkneoY9+d/LbEaKn+P2aoxY
VSPCIPXT9zmdnfym2UVxjAZXvDbY/PjVE6SOlRapjkkUTlyxMINV12lwC3aLM9ni
tyLBcvKHXcJMZdh+Mn+YofFOhvCMsC8HbMLTZwNZaAkv9yVpuOEyI7lu7Z87TUpo
M7XsPuQZQOrPqpCA3pf3fucaux9Dhg==
=RL9B
-----END PGP SIGNATURE-----

--nOM8ykUjac0mNN89--
