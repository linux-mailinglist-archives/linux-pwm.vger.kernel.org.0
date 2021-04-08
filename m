Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71BE358039
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Apr 2021 12:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhDHKFl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Apr 2021 06:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhDHKFj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Apr 2021 06:05:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA891C061761
        for <linux-pwm@vger.kernel.org>; Thu,  8 Apr 2021 03:05:28 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lURXR-0000KK-Tf; Thu, 08 Apr 2021 12:05:25 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lURXR-0005xo-6M; Thu, 08 Apr 2021 12:05:25 +0200
Date:   Thu, 8 Apr 2021 12:05:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm: dwc: Use dev_get_drvdata() directly in PM callbacks
Message-ID: <20210408100524.fw3nc5k4vvu76tix@pengutronix.de>
References: <20210317155925.297680-1-jarkko.nikula@linux.intel.com>
 <20210317200936.zfmcpjwuvhvc2pcv@pengutronix.de>
 <0343a601-466f-ad52-cd1c-cb443482018f@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ry2w5eahewfeuysv"
Content-Disposition: inline
In-Reply-To: <0343a601-466f-ad52-cd1c-cb443482018f@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ry2w5eahewfeuysv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Mar 18, 2021 at 10:06:37AM +0200, Jarkko Nikula wrote:
> On 3/17/21 10:09 PM, Uwe Kleine-K=F6nig wrote:
> > On Wed, Mar 17, 2021 at 05:59:25PM +0200, Jarkko Nikula wrote:
> > > -	struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev);
> > > -	struct dwc_pwm *dwc =3D pci_get_drvdata(pdev);
> > > +	struct dwc_pwm *dwc =3D dev_get_drvdata(dev);
> > >   	int i;
> >=20
> > I'm a bit ambivalent here. I'd consider it an implementation detail of
> > the PCI framework that pci_get_drvdata is dev_get_drvdata on the related
> > struct device. So even though the PCI guys probably will never change
> > that, it feels a bit like a layer violation to rely on this behaviour.
> >=20
> > As additionally the status quo isn't less effective (unless I miss
> > something) than the alternative proposed in your patch, I tend to not
> > like your change.
> >=20
> Yeah, agree, it is a bit confusing to see mix of pci_set_drvdata() and
> dev_get_drvdata(). Got the idea for this patch from another driver and
> similar commits.
>=20
> Better would be to switch entirely to dev_set_drvdata() in probe and
> dev_get_drvdata() in all other functions. Perhaps not worth of effort (do=
es
> here 4 insertions(+), 6 deletions(-)) and not many PCI drivers seem to use
> dev_set_drvdata() in their probe (additional confusion?).

ok, I'll discard this patch in our patchwork.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ry2w5eahewfeuysv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBu1WEACgkQwfwUeK3K
7AmCkgf/ao2eDotjRmszV6VR1ek/7m3itWWdBXWIJEaVYLiqWly1dQLq3Wzmpi3X
Hh8wq+LafjEU3vl5L6YGv0o7yvpQyIxPlXk+hgD3wAKO9GrvLhDv4xPSNAQcCDpd
UvLBxDAva+QXM/5La2dLOCONdzFOVBK+q7q3L5BnebcGJb9X6TsVaTgxYH19zNaR
8Y5eiyCDF4vik2nuLDtl0+UcjS6WSQ6YF25VacpsezuC0dOBIbSejlUzfzfzQjas
/0PrjIQKZ7MfNMWAG6dLbxBALEkxyQXEE4EEGSmxHMSLtBwqlTZrdqEnilDbrddE
wg75HwAX+nMXBCttA6zWdjDab+VjMw==
=UyaQ
-----END PGP SIGNATURE-----

--ry2w5eahewfeuysv--
