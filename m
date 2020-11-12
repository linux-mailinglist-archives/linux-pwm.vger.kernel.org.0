Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8762B0D6E
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 20:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgKLTGy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 14:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgKLTGy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 14:06:54 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6F2C0613D1;
        Thu, 12 Nov 2020 11:06:54 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k2so7200836wrx.2;
        Thu, 12 Nov 2020 11:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xEBQ+X3j8UVOYbY0ZzGSw1N+DpyyJg/wWh7q1siWRJ4=;
        b=h33D+mRRRvo6/1txIF4V3Jz/UuKLAJaOqy8ik/N8dTlunkqrn4JyGAQ8GkXQG7Xg7K
         VKYedpGIlTERFNHTDnq8DKx/hnoo/zVqhxAGgVlP5TlU7R0LmnWRAbLGzfIHBGL4fQ8C
         EDh5ZV4UMdnQeLnqJaxygnqvmbOlkCNB+U0iHJB3JgfkiVQz5FzZZgwhTYLdOhrTZCcn
         5sbGvhYzkUh7OV0odRqD2N1T0g93/QWFlRlkuSazpVwvFD9fQh2X+LrO+kYCZ41en1fJ
         //XCnICraHifQu4S96Icxg6l8XtlgTOndlf66hH/CqGZPpPybDGFHT4BExopTX/NPqcD
         8m5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xEBQ+X3j8UVOYbY0ZzGSw1N+DpyyJg/wWh7q1siWRJ4=;
        b=H3OiDC5iI/jEsCUxkwwqdURobYLkZYSqaczgg75Yipo5GFzyuWDFfm1Y3olLc3mgbl
         fYTj7dl7aDZZ0hkqUZ+ZhOANjuL1PmzwdGqlrWcsKQiHrPW2BDw9jXfUbjBBaZupc91P
         yWhCjjMUGciGQL6qkpM6DYdduktSIoKeWuccLwF+aZdmKIeUEsqNmEzbwD69pT0r7eF9
         /jZz4qoAvR0MgcuEKQt5J2KtOdug+wwDj4NzASi/GC3RWPgUs4PXyemn6XOGM44M+Iya
         KjHsCEt3B/N/dJbnOI79SIVSzAfhZ/liXzkoCPq6v4BI3BDwVyJPtk2D3k424QJqYtJh
         Zq8w==
X-Gm-Message-State: AOAM532r+FegXLXoGwwhpyWYD0OFEKA58Kv4uMgg1lELxrgZhjNdOb7g
        wnj0fP3VgdzhbdmZzg4nIKs=
X-Google-Smtp-Source: ABdhPJwh5v5jsUINEfAgHo+Yz1dU4BfWu2Vhg3yORml9Zdo4fRJyxoz3JbVnZCE8wfzxzwdlH9aG6Q==
X-Received: by 2002:adf:f085:: with SMTP id n5mr1086434wro.293.1605208012606;
        Thu, 12 Nov 2020 11:06:52 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id n6sm7959107wrj.60.2020.11.12.11.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:06:51 -0800 (PST)
Date:   Thu, 12 Nov 2020 20:06:49 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Yangtao Li <tiny.windzz@gmail.com>, claudiu.beznea@microchip.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        f.fainelli@gmail.com, nsaenzjulienne@suse.de, shc_work@mail.ru,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, vz@mleia.com,
        slemieux.tyco@gmail.com, khilman@baylibre.com,
        matthias.bgg@gmail.com, heiko@sntech.de, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mripard@kernel.org, wens@csie.org,
        jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-tegra@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 01/32] pwm: sun4i: convert to
 devm_platform_ioremap_resource
Message-ID: <20201112190649.GA908613@ulmo>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
 <20201112161346.gp5nenuagx5wmwl2@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <20201112161346.gp5nenuagx5wmwl2@pengutronix.de>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2020 at 05:13:46PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Sun, Dec 29, 2019 at 08:05:39AM +0000, Yangtao Li wrote:
> > Use devm_platform_ioremap_resource() to simplify code.
> >=20
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 581d23287333..f2afd312f77c 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -344,7 +344,6 @@ MODULE_DEVICE_TABLE(of, sun4i_pwm_dt_ids);
> >  static int sun4i_pwm_probe(struct platform_device *pdev)
> >  {
> >  	struct sun4i_pwm_chip *pwm;
> > -	struct resource *res;
> >  	int ret;
> > =20
> >  	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> > @@ -355,8 +354,7 @@ static int sun4i_pwm_probe(struct platform_device *=
pdev)
> >  	if (!pwm->data)
> >  		return -ENODEV;
> > =20
> > -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	pwm->base =3D devm_ioremap_resource(&pdev->dev, res);
> > +	pwm->base =3D devm_platform_ioremap_resource(pdev, 0);
> >  	if (IS_ERR(pwm->base))
> >  		return PTR_ERR(pwm->base);
>=20
> Can you please comment why you don't apply this series?

I did in fact apply this yesterday, but I now see that I didn't reply to
the thread to report that.

> My point of view is:
>=20
> devm_platform_ioremap_resource is the designated wrapper to replace
> platform_get_resource() and devm_ioremap_resource(). So I don't see a
> good reason to continue open coding it.
>=20
> The patch series doesn't apply to 5.10-rc1 as is. (pwm-puv3 was removed
> and a simple conflict in the pwm-rockchip driver.) The overall diffstat
> (of the fixed series applied on top of 5.10-rc1) is
>=20
> 	31 files changed, 32 insertions(+), 96 deletions(-)
>=20
> and it converts all of drivers/pwm but a single instance of
> platform_get_resource() + devm_ioremap_resource() (for pwm-lpss where
> platform_get_resource and devm_ioremap_resource are in different
> functions (different files even)) which isn't trivial to fix.
>=20
> So in my eyes applying this series is the right thing to do.

For the record, I personally think this helper is a bit over the top. I
do agree that it's nice to create helpers for common code sequences, but
this is a *lot* of churn all across the kernel to save just two lines,
which I don't think is worth it in this case. Often these helpers allow
common mistakes to be avoided while at the same time reducing lines of
code, but devm_ioremap_resource() was already created to address the
pitfalls (like returning all sorts of weird and inconsistent error
codes). So this helper doesn't actually add any value other than saving
a few lines, which I don't think justifies the churn. I would've been
sold on this if the ratio had been slightly higher, like maybe saving a
dozen or so lines, but as it is, I just don't think it's worth the churn
that it's causing.

I also think that it's overly narrow is scope, so you can't actually
"blindly" use this helper and I've seen quite a few cases where this was
unknowingly used for cases where it shouldn't have been used and then
broke things (because some drivers must not do the request_mem_region()
for example). And then there are cases where the driver needs the
resource for some other purpose, so you can't use the helper either, or
at least it looses all of its advantages in those cases.

That said, the helper is there and has been widely accepted, so my
opinion has been overruled by the majority.

Thierry

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+th8UACgkQ3SOs138+
s6EJGw/9H77dbaNDlBX7JuQrZ1yTANFYsknIsNBqiHqxVyeNOvnNiOCwLyMpfyD4
ZhxeUvz370ZXDuCQoA8kSbANuC36XqIoYJXUX2WbN5WQ6eJF1sRxXmctvY11Fpkc
mnztEolVT5ygFHRfXvCEeoZ2ucAZMcnKKXOMSMDLcWw4NHl5qLMwZITmtJMBQd/w
F3nHNtv+e9Za7m162+G4XXLpaMxEpD+mx0/MKKU9OQyWmNolPSQQ0TEhIX31v9gK
CpR2u5izH0pYJzo7nZahyzWGVi5cLxid93pF8wobHhvcXOGtwXH0ThZB3q7BSles
EDr//4p1Fx/99llemBrp1LO+koGgl7x7mkFFWMmakmtEueBLzmcR6jKU4A9qKera
t5AkiFK2MpzpY62o/g9JPpVDRJUFUB7z2xv4Nv6QH7Xc9rXlb5eA36T3RfOUgybi
MDbiB/6+bjnmzsKvmzmVZTAdRKPQHJh1XVX6l5qZsHU8xW3ZrG4zsZ94/gIE82w9
Ib1moNdBt7MT2XH4AILfVx+7xJtyRetkhoDMRBfsqBQZvFDbr7zuszXPPKvPQIuo
jL7uT6OIs6Yc16b0qk1My2XNO/YGufWXUMTnZoixkngZHDd0nQ+Bx49K9AR847dI
XokkpjXh91solUKZCbEhV0guv43K1HCmU9z3KOCV4RoS93nObXM=
=kMKR
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
