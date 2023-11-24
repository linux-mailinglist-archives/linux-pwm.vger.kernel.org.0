Return-Path: <linux-pwm+bounces-188-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FB07F73D0
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 13:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C522F1C20A12
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 12:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60B120B09;
	Fri, 24 Nov 2023 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLXBGAQG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AD8D43
	for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 04:28:53 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a02cc476581so251952566b.2
        for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 04:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700828932; x=1701433732; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAsevE/oWxSaAiKmXa/hcVFltm53STUppRz8uPrsqzk=;
        b=hLXBGAQGBg7i56NmXFA6i1baZEm5aI35TbIdTVJjsX5KLzdcBZgX8J4KX0Uq7cbsmd
         dMT6+v2hBBHMVC3q9+i2ZTumIfYsIpgTLLFhhbVRDRe3FoGb9DKIYxO4aYxcQx/E7+Pv
         9acqiYiR2ou8vlygxECYAIBOUWF+KfW32A+8pe86loDrfAdooiWc9i9Zkp7t1c1d/yVp
         /6aqfzIFjp42yTRtaxR5EnUA9axxifyqe/EauBg+YJEPxKUoihZYikn7l8iMxO71cegJ
         NFCbSJH3pcuhbWdtNsuIAQyT0NuSnfRkpl6j/O5qeGFbOkIQULjYnGpHcLBJiGsaKF5W
         EgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700828932; x=1701433732;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAsevE/oWxSaAiKmXa/hcVFltm53STUppRz8uPrsqzk=;
        b=qxHe0LA6mlY+HJd3nd1PVo2BMA9QH4Z/z4SQ4ljHcss03cv3mJVQjZNd/BB1xu19tJ
         +kBqb5oHZ3W4hAmF5zOJSOZcRuv2kzTc0juWQk5c7wvh0GChHlGPLRxXun0DjdYM/7zj
         d4dEEPXLD2xIbBYqyWieGg10aTXUVJdAjCmbN9g2aL9Uy2xCQlqcLaohUgrNiB516H19
         usuPaAkrCA8DmOZUg6vOvjWLyFKGLoPogsPlPYkgoATe6XpXK3DZs6N5ofIhVxdxlK5J
         BnU8KAG6Q0HDXxgHJsHa/JKSPgCVzMBBUBKlr7CBSW0oJNEdLWJPKLbHKdbMW6u/efFz
         Xc6g==
X-Gm-Message-State: AOJu0YySWxfQgdflxUpaODFR1j68mFqvjn7cdknlqH4SCfGeCKNztXWZ
	poAeeK1uE2yLgk6lZ2ebte8=
X-Google-Smtp-Source: AGHT+IERMMtui+IETP0ovSnsm4qXwMTSMy0nSp/dAyLrk/bplp+aiX1xBUY9QtFkFFPTigvl0ZKhyw==
X-Received: by 2002:a17:906:2707:b0:a04:c9c4:8fc with SMTP id z7-20020a170906270700b00a04c9c408fcmr1915956ejc.18.1700828931424;
        Fri, 24 Nov 2023 04:28:51 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id lv23-20020a170906bc9700b009f28db2b702sm1996582ejb.209.2023.11.24.04.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:28:51 -0800 (PST)
Date: Fri, 24 Nov 2023 13:28:49 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 104/108] pwm: Ensure that pwm_chips are allocated
 using pwmchip_alloc()
Message-ID: <ZWCXAdG3v6a0-yH2@orome.fritz.box>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-105-u.kleine-koenig@pengutronix.de>
 <ZV44H9ZQDuEA217B@orome.fritz.box>
 <20231122235223.jsksp43mfdbwls7i@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EoXZqGvoPTiX7kN9"
Content-Disposition: inline
In-Reply-To: <20231122235223.jsksp43mfdbwls7i@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)


--EoXZqGvoPTiX7kN9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 12:52:23AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Wed, Nov 22, 2023 at 06:19:27PM +0100, Thierry Reding wrote:
> > On Tue, Nov 21, 2023 at 02:50:46PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Memory holding a struct device must not be freed before the reference
> > > count drops to zero. So a struct pwm_chip must not live in memory
> > > freed by a driver on unbind. All in-tree drivers were fixed according=
ly,
> > > but as out-of-tree drivers, that were not adapted, still compile fine,
> > > catch these in pwmchip_add().
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/core.c  | 10 ++++++++++
> > >  include/linux/pwm.h |  1 +
> > >  2 files changed, 11 insertions(+)
> >=20
> > We don't usually care about out of tree drivers.
>=20
> I'm open to drop this patch if you insist. But I think it's nice to
> out-of-tree driver maintainers (not sure how much there really are?) to
> not silently break their drivers.
>=20
> > But this also indicates to me that we're doing something wrong here.
> > If we cared about out of tree drivers we should be implementing this
> > in a way that doesn't break things immediately.
>=20
> Given that drivers need adaption -- see the main amount of the patches
> in this series -- not breaking out-of-tree drivers isn't possible.
>=20
> > If we don't care, we might as well make sure that compilation breaks
> > for any drivers that haven't been adapted.
>=20
> This could be done. The most straight forward way to do that is to
> invent a new name for struct pwmchip or pwmchip_register() or change the
> latter's arguments. However I like the outcome and wouldn't change the
> implementation just to break out-of-tree driver's compilation. That's
> why I chose to implement this patch.

One more advantage of Bartosz' proposal is that out-of-tree drivers
would continue to work unmodified. Nothing really needs to change in any
driver with such an implementation.

Thierry

--EoXZqGvoPTiX7kN9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVglwEACgkQ3SOs138+
s6Hx9RAAvE1/7wuAC2CtXRyj0p2lyKNuNPECusPiEYAnxtopMaM7NlTWmChvZO+e
ekKggQmZNeSpisZjb/oYXMf03NjEJrtK5h2vpilOVoHJbpJiQrQD8lB/L9itbkrr
1KLVMN3RPLGaBFomrUe2GUYbmMcuqPcrWL5k8aw14tk8/vlRUMTG+jl63Gyld//T
CtryMaacbiMI0SO0SmT5YF6eT3ECXmzgBqgdqNnMnFlVdrVotL46Nx5NEffkt/Bv
xz6FatxIVTqKmCF4nv7AiG43nPeTLZTK3+DTnR7/pNL8O0HM9PmFW94ecIwOU1HY
IONzTJE5vqr7287itraMhtWb4xCNhEUYO/YWEu4KsMpTrmNaU1qWTxYpJlO82mUD
eSDVhs2pmcmXKWPJhltEbGlkDZbe0KbXaD8XMkiFJACEAnNZYOxMYQ1iD/6mkI5h
gKTP1nAA6HiMUpG449c39Ktw9y19zc6bnCA7Zagh+Ecqx4MzJwWdzJm5ac7On1pg
pvn0yJoXQT1HJ2dkYrDU//4rjpoKJOTPWhp9PZ+fpGUzif5bQMxvXEqYjZkgVIZo
cSEXM26wI3YzUm+Jy6i/M5AfLdWfWXBPFGMb2ZwH/y6UiRjgfSk4bhW4YTWt4zmd
34XRjDfV3RJ9eGteyH5fCLFitMk3UfRWAnhb78/cC8EQeJZFcsw=
=S+j5
-----END PGP SIGNATURE-----

--EoXZqGvoPTiX7kN9--

