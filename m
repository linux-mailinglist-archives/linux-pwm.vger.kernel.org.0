Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BAA2AF90C
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 20:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgKKT2c (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 14:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgKKT23 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 14:28:29 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4A6C0613D1
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 11:28:27 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so3412577wmi.0
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 11:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aB6iIemlowpixW0vNFgd5hMV8RHYg10LZo+pzCljiP4=;
        b=nWHzGc2Py5Bxckde86+G7Ce2QsRO64JhKuvXXroIU+OLLy7vdVzLD+komf0s9ImdOE
         zBAqZaUObRng8MskzN3TfkL6QnNOxZR2LddwezKqDu0Lb68TY7KD/VhyH+b/Ohy2VRSU
         6de0jIohjv2wP0HwFSuXWIiJZwSkS1pM9GO/PM1j5bvUUv6UYfmrRDTpUxRWgrY53h08
         HXKyh3fNDLKLKKqI3x7ACUruqTdnGee+42XLxb7cfT5chK419+8DgOFc2KX9XowMIMFg
         ZvSc/yoQgryZEB70Nahut+sYskqwOXf0jhb0b6UTCJS5vjaRFVPTE0qoTrtEEzJlRyy0
         tUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aB6iIemlowpixW0vNFgd5hMV8RHYg10LZo+pzCljiP4=;
        b=pQSRyK+AmKaCktumonhYr1e94tVtDGP7FvypNzaG2tHLLCzzTI5sHs+rAe6yToMKaC
         zs9Ot8NSObHa54zpQKAadEL7FnvaYCZRzI8CQ6svdepckpJzfS6Pe1/LZiD1YJSPNATM
         XOrj35A2Rnp3OXZe5C9VtoNlJ2CxWU93bzrdsCFzYuHoUi6ZVw+giWXo9eL28Y/4EZS+
         wbHxHqwMxZ327DUWYLFy84OwcUTrrPRgmBs1uCgJYWSyFrUIyF6kGJ2HKLg25GF4rG90
         VEF8EmKS4bVTTY2+YIAqn3PPicEmvO10CnPVozS5PoFW8zLPPkBykChL+tJ5NMXzwlbu
         9UpQ==
X-Gm-Message-State: AOAM533gBSoAvhmjGx50gdMdZzxhxUBfy9YogXLSmf+mWaxwcds1sYSV
        Ay3ZqN5jr8E5v9U34uAOjfw=
X-Google-Smtp-Source: ABdhPJwXNCqe1gwIpOP3bYuhLYYI5g0fZwx4b+Jt5X04f2GEBPq2FnqJ7mVfz5bVHpSoymHVWjcTTQ==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr5620548wmf.37.1605122906621;
        Wed, 11 Nov 2020 11:28:26 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id n10sm3553984wrv.77.2020.11.11.11.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:28:25 -0800 (PST)
Date:   Wed, 11 Nov 2020 20:28:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Ajit Pal Singh <ajitpal.singh@st.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: sti: fix error handling
Message-ID: <20201111192823.GD6125@ulmo>
References: <20201013081531.661528-1-uwe@kleine-koenig.org>
 <20201106082914.GX4488@dell>
 <20201106093435.4mlr6ujivvkzkd5z@pengutronix.de>
 <20201106102908.GC2063125@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline
In-Reply-To: <20201106102908.GC2063125@dell>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2020 at 10:29:08AM +0000, Lee Jones wrote:
> On Fri, 06 Nov 2020, Uwe Kleine-K=C3=B6nig wrote:
>=20
> > Hello Lee,
> >=20
> > On Fri, Nov 06, 2020 at 08:29:14AM +0000, Lee Jones wrote:
> > > On Tue, 13 Oct 2020, Uwe Kleine-K=C3=B6nig wrote:
> > >=20
> > > > This commit fixes several faults:
> > > >=20
> > > >  - Iff a clk was returned by of_clk_get_by_name() it must be derefe=
renced
> > > >    by calling clk_put().
> > > >  - A clk that was prepared must be unprepared.
> > > >  - The .remove callback isn't supposed to call pwm_disable().
> > > >  - The necessary resources needed by the PWM must not be freed befo=
re
> > > >    pwmchip_remove() was called.
> > > >=20
> > > > Fixes: 378fe115d19d ("pwm: sti: Add new driver for ST's PWM IP")
> > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> > > > ---
> > > >  drivers/pwm/pwm-sti.c | 49 ++++++++++++++++++++++++++++++++-------=
----
> > > >  1 file changed, 37 insertions(+), 12 deletions(-)
> > >=20
> > > Sorry for the delay, this ended up in spam.
> > >=20
> > > > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> > > > index 1508616d794c..f89f8cbdfdfc 100644
> > > > --- a/drivers/pwm/pwm-sti.c
> > > > +++ b/drivers/pwm/pwm-sti.c
> > > > @@ -605,7 +605,7 @@ static int sti_pwm_probe(struct platform_device=
 *pdev)
> > > >  	ret =3D clk_prepare(pc->pwm_clk);
> > > >  	if (ret) {
> > > >  		dev_err(dev, "failed to prepare clock\n");
> > > > -		return ret;
> > > > +		goto err_pwm_clk_prepare;
> > >=20
> > > I would prefer these to indicate the intention, rather than were they
> > > were called from.  So err_put_cpt_clk for this one, etc.
> >=20
> > This might be subjective, but I like it better the way I did it. My
> > pattern is:
> >=20
> > 	ret =3D get_resource_A();
> > 	if (ret)
> > 		goto err_A;
> >=20
> > 	ret =3D get_resource_B();
> > 	if (ret)
> > 		goto err_B;
> >=20
> > 	...
> >=20
> > 	put_resource_B();
> > err_B:
> > =09
> > 	put_resource_A();
> > err_A:
> >=20
> > 	return ret;
> >=20
> > This way just looking at on get_resource_$X block it is obvious that the
> > picked label is right and in the error handling blocks that's obvious,
> > too.
> >=20
> > However with the (admittedly more common) style you prefer it is:
> >=20
> > 	ret =3D get_resource_A();
> > 	if (ret)
> > 		goto return_ret; // or just: return ret
> >=20
> > 	ret =3D get_resource_B();
> > 	if (ret)
> > 		goto put_A;
> >=20
> > 	...
> >=20
> > put_B:
> > 	put_resource_B();
> >=20
> > put_A:
> > 	put_resource_A();
> >=20
> > return_ret:
> > 	return ret;
> >=20
> > You have to check the previous block to see that put_A is right for
> > the error path of get_resource_B(). In this trivial example you have to
> > look back 6 instead of 2 lines. For more complex stuff it tends to be
> > 3 lines for my approach (one more for the error message, and so still in
> > the same logical block) but might be considerably bigger for the common
> > approach. The usual amount of context in patches is 3 lines. And if you
> > add another resource allocation between A and B you have to adapt the
> > error path in B which is somewhat unrelated. So a patch adding A2 looks
> > for my approach:
> >=20
> > @@ ...
> >  	if (ret)
> >  		goto err_A;
> > =20
> > +	ret =3D get_resource_A2();
> > +	if (ret)
> > +		goto err_A2;
> > +
> >  	ret =3D get_resource_B();
> >  	if (ret)
> >  		goto err_B;
> > @@ ...
> >  	put_resource_B();
> >  err_B:
> >  =09
> > +	put_resource_A2();
> > +err_A2:
> > +
> >  	put_resource_A()
> >  err_A:
> > =20
> > Here you see that the right error label is used in the new error path
> > and that it is placed correctly between err_B and err_A.
> >=20
> > For your preferred approach the patch looks as follows:
> >=20
> > @@ ...
> >  	if (ret)
> >  		goto return_ret;
> > =20
> > +	ret =3D get_resource_A2();
> > +	if (ret)
> > +		goto put_A;
> > +
> >  	ret =3D get_resource_B();
> >  	if (ret)
> > -		goto put_A;
> > +		goto put_A2;
> > =20
> >  	...
> > @@ ...
> >  put_B:=20
> >  	put_resource_B();
> > =20
> > +put_A2:
> > +	put_resource_A2;
> > +
> >  put_A:
> >  	put_resource_A();
> > =20
> > Note you cannot see by just looking at the patch that goto put_A is
> > right. (Well, if you assume that the old code is correct see that just
> > before put_A B is freed which matches what just happens after your new
> > get_resource_A2, but that's considerably more complicated.) Also you
> > have to modify the goto for B.
> >=20
> > This is in my eyes ugly enough to justify my preference.
>=20
> Wow, you sure put a lot of effort into that. :)
>=20
> I'll leave it up to ST and Thierry to have the final say.

I agree with Lee on this one, so I've applied the patch and touched up
the label names while at it.

Thierry

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sO1UACgkQ3SOs138+
s6FbMw/+KvQUBia9FquepYWhx1aOOQtXgxnsrOw/8uMTNuwn4BI6j3yZFW4hb+zL
hfxqMuEcoIcInFl2s5zsHE93xRLbD8q64YZesXKGp5FLDSJUG7e2CYO6zgW3OFVY
YDqY0Y8UYwn7jiBrHUHNc1wDSYVN5t9bab7wWH1JwWrrDAYF3z8E0KFXP4b8gSgi
STcysatwYDaKdvhCdm9m4kepMVh8qclGuVjJQ7STGwi8PS9u/ZS9nK26wcFvFYsU
U6elOK6/X1PY0j+OxoGfCRAbC/uW+lPUS4DdndafkaNWQWxqHtb22Q11SU99ZSxj
GHtewsbdtubANWGmSxzXeio8NHiU4r9Cbq3yBvNfYLLAeNeRJSly2oQGTyVfoPRk
7czhCtVOOcE9NVEojREb9wG4qlx5Qwz6C58Z2D6O1cZNM7xkVTTbUMQBvnq8NVF8
290hZGbtZni6strVeQsf6MLrbuFwT21xs5kMoW+urvIX0SCm0r4uIhcVjqozyLMq
FMLJ2CVYP37SrPdZ3r9w+QfLAXOJxvT7F/VMxgD3XRbibnOMBMxOif0SyHwmeEX5
m55zzB/1S+NpTiilpqG/Xdj0ZadrfpGVO2bdtUzknI30z5GcT8sDWYfNHlwEN0d7
/EmeLcgCqUFYftXQFr5e86ylkU1xSYyN9NvvlvcYrbTQs7EeG/M=
=4jql
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
