Return-Path: <linux-pwm+bounces-511-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D8080CF6E
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 16:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 172E0B212AF
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6CC4AF83;
	Mon, 11 Dec 2023 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrWj8a31"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ED1D6
	for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2023 07:24:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54c70c70952so6557928a12.3
        for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2023 07:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702308278; x=1702913078; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bjsk1T6zWHBNqkcu8mlXzkpQPoZwdAp78nI27bikvLA=;
        b=MrWj8a31DI5Ss4kzfVFF9SReLZfOOJpRnrGCT0crGCZ0zU3+pIFYhMGBvO3uqPwEtT
         VneOTHYk162j90Xh8RkYWtoi13np1hVey3Z4BErys2MtZYNDvWKOnO3ESzr8WF6Z9kEq
         VVb5S/VNQJxj5P7XFlOjS50/Pxnk9HU9w2FuKSo9bFNbK+6rmgFaJUo5HqamHW4DkRSB
         mZlQq0NHkJsBoYILaJPPu/xcXFhwFKJ9Rc0MYFuIPvhsK1xaCF/nH0piG2ZW+yFiud0w
         G6lbPZZWoOgZua3o4P4aUiEHqwgPvFxXF8fkBQN2B4CbSWZmPeuLHnZx7CVBotalRNxt
         2sJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308278; x=1702913078;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bjsk1T6zWHBNqkcu8mlXzkpQPoZwdAp78nI27bikvLA=;
        b=S44V8lAkGRr/FvTq7PY9+aWwJ7GzokOm+bqMaMQJKRpNUGbexnDlvWQUXV1TIrdW5d
         ulwCJEhfkJnRw2wyPAdse4bSmQfUjODYEvjcO7wVi9hAnYQW0MhQN+Ajz98dehmhvZIh
         d/HuGfIZpwci6WcTSGSYl2VgixJtmsFoDrW49+sRnf3uIuMQvqz944SstVy/My1sYLFP
         RFjgvvnUTIcyDCsot3r4pEkAW6n2WXhSmlMBtVzwjNVJy60bnvjZv7vv7erMvpibUadB
         yDaQQIxxVNmOt5yRZP8TzpldwHMP2m8++d/aPesLUmYE9HjZ3dGyLAM5MPNnxRRzYa0F
         WISg==
X-Gm-Message-State: AOJu0Yz4mjN9pLYOKryN5mkOuo8mQyONQopBcJ25ZFiy087Z5LzN+Vzd
	c3MYg1B77p/85U2LPK+w7jE=
X-Google-Smtp-Source: AGHT+IFbzgHeqitxqguLprNLF0JYPjAO2jKvpdmZzZDz8TIDT9tgiggTFH9ZEBns9yvuXoCJnLKwcg==
X-Received: by 2002:a17:907:7f94:b0:9e5:ee70:5da1 with SMTP id qk20-20020a1709077f9400b009e5ee705da1mr1648796ejc.53.1702308277671;
        Mon, 11 Dec 2023 07:24:37 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ry9-20020a1709068d8900b00a1f744953c1sm4302276ejc.105.2023.12.11.07.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:24:37 -0800 (PST)
Date: Mon, 11 Dec 2023 16:24:35 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-pwm@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Kevin Hilman <khilman@baylibre.com>, kernel@pengutronix.de,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] pwm: meson: Simplify using dev_err_probe()
Message-ID: <ZXcpswXxb1oQldp5@orome.fritz.box>
References: <20231206214817.1783227-2-u.kleine-koenig@pengutronix.de>
 <ZXM72QYBbb32Q_aL@orome.fritz.box>
 <20231208190620.5qobgtyii2wt7tfa@pengutronix.de>
 <ZXbsDRslZNKCeJF9@orome.fritz.box>
 <20231211141900.x6tpyctch5fv3uqf@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eUC+m1HNmJK0/n+y"
Content-Disposition: inline
In-Reply-To: <20231211141900.x6tpyctch5fv3uqf@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)


--eUC+m1HNmJK0/n+y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 03:19:00PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Mon, Dec 11, 2023 at 12:01:33PM +0100, Thierry Reding wrote:
> > On Fri, Dec 08, 2023 at 08:06:20PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Fri, Dec 08, 2023 at 04:52:57PM +0100, Thierry Reding wrote:
> > > > This is a lot of churn for very little gain.
> > >=20
> > > We seem to have different conceptions of churn. Each hunk here is an
> > > improvement for both SLOC count and usefulness of the generated error
> > > message.
> > >=20
> > > 	failed to register somename: -5
> > >=20
> > > is worse than
> > >=20
> > > 	error EIO: failed to register somename
> > >=20
> > > , isn't it?
> >=20
> > That's entirely subjective.
>=20
> It's not. You and me both know that -5 is EIO. But there are quite a few
> people who don't.

So it is, in fact, subjective.

>                   And for other error codes I'm not that fluent. (Do you
> know -2 and -19?) Also some constants are architecture specific, so e.g.
> -11 is -35 on alpha.

I didn't know about -11 and -35 on Alpha. Looks like %pe would handle
those properly, so yeah, I suppose one could count that as a benefit.
Not sure if we have PWM drivers that run on Alpha, and Meson in
particular probably doesn't.

> > I think the first version is just fine. I,
> > and I suspect most developers will, know what to do with either of those
> > error messages.
>=20
> Error messages aren't only for (kernel) developers. If you don't know
> that the kernel uses negative error numbers as return codes, the
> translation of -5 to EIO is even further away than opening
> /usr/include/errno.h.

Actually, kernel developers are exactly who these error messages are
for. Regular users that don't know how to decipher the error codes are
typically not going to know what to do about the error anyway, so they
are likely just going to copy/paste into some forum or bug tracker.

> > > > None of these functions are ever going to return -EPROBE_DEFER. And
> > > > yes, I know that function's doc says that it is "deemed acceptable =
to
> > > > use" elsewhere. However, the existing error messages are just fine,=
 no
> > > > need to churn just for the sake of it.
> > >=20
> > > We had this disagreement already before. Yes dev_err_probe() is useful
> > > for three reasons and this driver only benefits from two of these.
> > > That's IMHO still one reason more than needed to justify such a chang=
e.
> >=20
> > I disagree. There are certainly cases where dev_err_probe() can be a
> > significant improvement, but there are others where the improvement is
> > very minor (if there's any at all) and in my opinion the churn isn't
> > justified.
>=20
> What is churn for you? Many changes? Big changes? For me churn is only a
> big amount of changes where a considerable part cancels out if it was
> squashed together. For you this concept seems to be broader.

Churn for me is really any kind of change and it's not bad per se. What
I don't like are changes that are basically done just for the sake of
changing something. I don't have any strict rules for this, so I apply
common sense. If you want to rewrite an error message because it
contains typos or bad grammar, or is generally hard to understand,
that's what I'd consider fine and an improvement.

But this patch exchanges one format of the error message by another. It
doesn't change the error message or the information content in any way,
but instead just rearranges where the error is printed.

On top of it not adding any benefit, this might cause somebody to get
confused because some error message that they were looking out for is
now different. They may have to adjust a script or something.

You also mentioned that you saw the opportunity to do this while
reviewing Jerome's patches and looking at those patches, Jerome will now
have to solve a couple of conflicts when rebasing. They should
admittedly be fairly minor, but if Jerome wasn't experienced this might
be really annoying. Again, if this was a significant improvement I'm
sure this would be easily acceptable, but if it's just for format's sake
I'm not so sure it is.

> > Otherwise we'll just forever keep rewriting the same code
> > over and over again because somebody comes up with yet another variant
> > of mostly the same code.
>=20
> If there is an improvement in each adaption that's fine for me.

I can't speak for other maintainers, but I get very annoyed every time
somebody introduces some new helper and then I get to deal with 60 or so
patches just because there's a new thing that ultimately doesn't really
change or improve anything.

It's easier to apply 60 patches today that it was perhaps a few years
ago, but it also entails a bunch of things like reviewing the code
because sometimes even trivial conversions are faulty, the nrunning test
builds and pushing changes.

It all adds up in the end and keeps me from doing other things. Again,
if this all has some sort of benefit it makes sense to put in the time,
but if it's just for the sake of shuffling around parts of error
messages it just makes me grumpy.

Unfortunately, with all of that said I probably have no other choice but
to apply this patch because if I don't, then I know somebody else will
send the very same patch at some point...

Thierry

--eUC+m1HNmJK0/n+y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmV3KbAACgkQ3SOs138+
s6HuRA//cFZS5pBnD1ziuKfUh1H4yg5+iHug/NGIaioAfyPPCMBoh3B+okZjcChw
W9TZHVKEdi/VfxqpRxQ+nuwVOhqWHQtu4OF/YRsfXoKcOcK73EBGD19FSgta6oPN
qRdE/3Hm9oNjhiwTUxAOBZAZxl7xkWe/JdIg3k9ysd2arvkpEwhoX245jsUJ/Fj3
WGb8zcTh9/7XJ+IPeRvO51rryMG0ppJaSzbYpQwg9F760GOvQ4/Vv9fwzxCAKdeD
GNpH3PyuBCYSPffXA9K2LJta82PoHhfpVR52QSU6N4BocfYIFSVAdZsoZVkzPA3M
QN1huMTUgYgxht8zYIVWAdexDBnAXamjztalR7o9z9CslfG4lEVcD+3R7ZvUC5fi
wAe6zJSKvPRiU92u7OZIdZwN7nJo1WE2DckcxWKf2T3by/IV5Ku+FdRtXA0ibBYO
8aaCE6k5G6PZMiv+kEHN5RilVZQLfoSBhZeWQN1S8PXLsQePVxFcPug3pxOiSKPz
5jjVrzYBPo1dxl3EFbdB4vkuVFKIjbXOoHTgJfr82WC8EZLBh6cin7DnODJMbH7m
qsyHhJgbGXdTUGaNAGFsjae8rFmOjowlqlSGbFiCm11GIs8bGV7icgLOHZNX0mrt
RqPmNYmEaA/RQM/Oy3z4LEdVdE5ora7MkQMJTI279hZbVLInycU=
=hDh0
-----END PGP SIGNATURE-----

--eUC+m1HNmJK0/n+y--

