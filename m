Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EC1359EBF
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 14:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhDIMcg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 08:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbhDIMcf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 08:32:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0331EC061761
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 05:32:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n2so8380263ejy.7
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 05:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FE6+Gcz+8Id28dE0e39bezaJLuCMZccUrnSuP9fWA/8=;
        b=Nj/4Ogoqchaskl5u/hVcBAe8TvTIeJw/BaCHFOrzUw/eaBUR4Y140A6ENBpl2c0QGO
         BVhN8B+ae6hZfXa33xTb6ne/sixr4R07RLJFYZrAAzvIv3Pahjfl1HdKPLj6uPIovQnY
         cjqp2UxF/+uXm4lsu53RgdnGco+N1dmSe6kp01IRDUguzLZYKhGKHyGtFNJQbYyPNIOa
         F+NKseVMt/l8tppIbPvA6p+8ICeuHTImpEmUuuxxGH0pMQMcz2bDWxQ3T47vsYDEpcgZ
         NHYv/uTn+DdnMY+hGF7fuiZND5NDKk1U6/R6P21d/gYaBCNPhnTNS/HvJbSWUeAP9IKE
         trcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FE6+Gcz+8Id28dE0e39bezaJLuCMZccUrnSuP9fWA/8=;
        b=KXkihTVL503H0MtzlRcQlyDuMuQraV1TW3bbXRieF39QZvmuB5PRd0Begl0LJ9vend
         SnlyFKSbyEJ2pNnI73IJMH9KUg6kxYmAycC4p6AlGt4aY6DYSfUwfRSs9u1AjRW2/n2p
         vgTOe3f/EV0HxZfNXg/fDFGKlZZOobbD2/nJkGFYt1mMxOZsZCKKwhq/pWFiSKDlaZlQ
         iq13z3LiG4Ka26NQwudXe12/DJSLDpyZU3FGgWEG3aBAh9SY9CxQcZuokdmYlp82cnYZ
         MjAI/G6IC566aLulbVqfTux4uJgXIANSli1Eq++5bVsMQS5kXgGxmQpkAjZhl717+aW+
         KS9Q==
X-Gm-Message-State: AOAM532uzpLYlhsOmCrBHme7DpUuFtYS9W5dh4QUerjkDTcwQbn+YBr0
        dsMpxP/9/Fe/eCwOrV/NR3c=
X-Google-Smtp-Source: ABdhPJzs++EY+k0VtfeB2NOxXzpWkZyto0SVnhavMxLDCPHzxRjDVCzScfEnL1Y2mhQrU4+zWnzVuA==
X-Received: by 2002:a17:906:38da:: with SMTP id r26mr16206010ejd.251.1617971540707;
        Fri, 09 Apr 2021 05:32:20 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id t1sm1323752eds.53.2021.04.09.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:32:19 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:32:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Ray Jui <ray.jui@broadcom.com>, Lee Jones <lee.jones@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel@pengutronix.de,
        Scott Branden <sbranden@broadcom.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: bcm-iproc: Free resources only after
 pwmchip_remove()
Message-ID: <YHBJd3FTDZYqTpIE@orome.fritz.box>
References: <20210324200134.75513-1-u.kleine-koenig@pengutronix.de>
 <aea0642b-5646-e368-7f8b-358a7c72659c@broadcom.com>
 <20210325071150.627lorrnfxpqqalr@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sfL8bvBfcEiC5Hix"
Content-Disposition: inline
In-Reply-To: <20210325071150.627lorrnfxpqqalr@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sfL8bvBfcEiC5Hix
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 25, 2021 at 08:11:50AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Wed, Mar 24, 2021 at 02:15:23PM -0700, Ray Jui wrote:
> > On 3/24/2021 1:01 PM, Uwe Kleine-K=C3=B6nig wrote:
> > > Before pwmchip_remove() returns the PWM is expected to be functional.=
 So
> > > remove the pwmchip before disabling the clock.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/pwm-bcm-iproc.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> > > index 529a66ab692d..edd2ce1760ab 100644
> > > --- a/drivers/pwm/pwm-bcm-iproc.c
> > > +++ b/drivers/pwm/pwm-bcm-iproc.c
> > > @@ -253,9 +253,11 @@ static int iproc_pwmc_remove(struct platform_dev=
ice *pdev)
> > >  {
> > >  	struct iproc_pwmc *ip =3D platform_get_drvdata(pdev);
> > > =20
> > > +	pwmchip_remove(&ip->chip);
> > > +
> > >  	clk_disable_unprepare(ip->clk);
> > > =20
> > > -	return pwmchip_remove(&ip->chip);
> > > +	return 0;
> >=20
> > This is a good fix! Given that there appears to be a race condition
> > where the clock can be disabled before the PWM device unregisters from
> > the framework, I assume we might be seeing hangs in corner cases without
> > this fix, i.e., PWM device accessed with clock disabled. Then does it
> > make sense to add a fixes tag so this fix is also picked up by LTS?
>=20
> The hangs are usually short, so I'm unsure if it's worth the backport.

That depends on the hardware. I've worked with hardware that will hang
hard if you try to access a register of an unclocked IP block with no
way to recover other than resetting. Other hardware may raise a system
error that you may not be able to recover from, etc.

> Also before commit b2c200e3f2fd ("pwm: Add consumer device link")---which
> is in v5.3-rc1---you cannot ignore the return value of pwmchip_remove().
>=20
> (And before that change if pwmchip_remove() returned an error the
> situation was grave compared to that clock skew. So on the other hand we
> could drop the return value check there, too, without making the
> situation considerably worse.)
>=20
> Anyhow, the offending commit is (little surprisingly)
>=20
> 	daa5abc41c80 (pwm: Add support for Broadcom iProc PWM controller)
>=20
> which appeared in 4.7-rc1. I let Thierry decide if he want to add this
> fixes line.

Given that I've never seen a report of this actually being a problem,
I don't think it's worth backporting this.

Thierry

--sfL8bvBfcEiC5Hix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwSXcACgkQ3SOs138+
s6E8Yg//QAJm9frfdCpkuWG9a4lE47So28edyx4uZRZUCyypn2HcomX58Z72uYq1
si5VMMpj3ZYNdDugTNIGdCEWbM7qt2ZJ+21MepdzrHcSFnqnfGQOsfhNOm7rD4i5
sQCbz+dgzrr5Yc+3tJxI+PEZ7zYHEmpqZXZG8FlFfKOGAK84CdEPsXA+uBkw6QBD
yEFtgY3k8gIclth1Uelojka2eTLk+iXPd1I5HfxqyeSxyTuvEvhxEBNqRoTliKwz
9O7TTHZ7/23yUm9o4L/xigBnTPqRyaQG/6etuCA83UzmljGQg500jGcn0zeydbqg
R/9Y43aKRrgtPdMAPhkxOewbQAENxHpGxQDNzFU4Et+gQ/qruPQ3wGvaFw2wTmNp
yrFM+evZDjr+aPdIVCzrOpJSrffUnp4HOW36bvAZk7va7AJQaoes02SbFR5Fsjk9
SCfpxaA2SLW71PnSX+rhKJSnbC9W/uEL1aeKhDS8IAe6mNgLxIEPgl95Sa0Bs3QG
aYmidkxQd5VEyA9iK30x3GBlwpBc6c9pvza2HdO+vH4Ag3Rf+PePuHTMXfjuv+5F
IDYWLsLTLymX63ORZ9pMsNhbYZkDY8bxiVfudSNMU+Zl0AeOhoyWRmKG0RjXbwsz
Fg6J8neYKjm2Zt2p6BailBXw9yXYSjh4YUDuJuwVr4EV/En+iZ4=
=5V0w
-----END PGP SIGNATURE-----

--sfL8bvBfcEiC5Hix--
