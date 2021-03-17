Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9904133F9C2
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Mar 2021 21:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhCQUJ4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Mar 2021 16:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhCQUJj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Mar 2021 16:09:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D150FC06174A
        for <linux-pwm@vger.kernel.org>; Wed, 17 Mar 2021 13:09:38 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lMcU5-0001ij-FR; Wed, 17 Mar 2021 21:09:37 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lMcU4-0007XK-Tn; Wed, 17 Mar 2021 21:09:36 +0100
Date:   Wed, 17 Mar 2021 21:09:36 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm: dwc: Use dev_get_drvdata() directly in PM callbacks
Message-ID: <20210317200936.zfmcpjwuvhvc2pcv@pengutronix.de>
References: <20210317155925.297680-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6rqqqz2dj65c2dsg"
Content-Disposition: inline
In-Reply-To: <20210317155925.297680-1-jarkko.nikula@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6rqqqz2dj65c2dsg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jarkko,

On Wed, Mar 17, 2021 at 05:59:25PM +0200, Jarkko Nikula wrote:
> Instead of figuring out struct pci_dev pointer from device pointer and
> then pci_get_drvdata() we can use directly dev_get_drvdata() to get the
> pointer to struct dwc_pwm.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/pwm/pwm-dwc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> index f6c98e0d57c2..4d59a035c0c9 100644
> --- a/drivers/pwm/pwm-dwc.c
> +++ b/drivers/pwm/pwm-dwc.c
> @@ -258,8 +258,7 @@ static void dwc_pwm_remove(struct pci_dev *pci)
>  #ifdef CONFIG_PM_SLEEP
>  static int dwc_pwm_suspend(struct device *dev)
>  {
> -	struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev);
> -	struct dwc_pwm *dwc =3D pci_get_drvdata(pdev);
> +	struct dwc_pwm *dwc =3D dev_get_drvdata(dev);
>  	int i;

I'm a bit ambivalent here. I'd consider it an implementation detail of
the PCI framework that pci_get_drvdata is dev_get_drvdata on the related
struct device. So even though the PCI guys probably will never change
that, it feels a bit like a layer violation to rely on this behaviour.

As additionally the status quo isn't less effective (unless I miss
something) than the alternative proposed in your patch, I tend to not
like your change.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6rqqqz2dj65c2dsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBSYf0ACgkQwfwUeK3K
7AkhJggAjkMjyWGir4afb06LcpMuobEQe5lVSEqs6XzUKYJcKUASHsUqKWGq15RZ
Xc+em0lS8ObnYIHXLwQqrVKGKP8NMiBsTTrtkpIEgG4EdVdo1Hql97is5b8OOE8Y
AKUCarmipCba0506fRoJV0qFqiKDtHumcFlwj0fkV2/wjwWQgP74YsRhnb0lVijL
E/CPiWkuQCqE3K7/pCclmnEL8Pi+IqIy/6PIkK2EWmMjatxNfYp4NQSRd/Jeo2Ao
iHIQmiVniB2X8tnCnWsumLVpAP6S322zhbynVgFPW3Syz21W+dOVqcV0KC/MxHct
3QvKm6vudj1tAJypfzaJMYoVlzmRfw==
=rfun
-----END PGP SIGNATURE-----

--6rqqqz2dj65c2dsg--
