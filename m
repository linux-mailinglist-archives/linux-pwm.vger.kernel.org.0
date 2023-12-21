Return-Path: <linux-pwm+bounces-596-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA1081B2FD
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Dec 2023 10:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838981F23294
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Dec 2023 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE204D124;
	Thu, 21 Dec 2023 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lB+PhNIA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3254D137
	for <linux-pwm@vger.kernel.org>; Thu, 21 Dec 2023 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e51a7545dso721132e87.2
        for <linux-pwm@vger.kernel.org>; Thu, 21 Dec 2023 01:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703152645; x=1703757445; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czNdiwtjM+Bf3wxnWNI65fEHbodGPjXoLCSns14aIQM=;
        b=lB+PhNIAW4zeRY4fU6OoGmG50KeoQL+jrdAIhT76qESK2KZPcgKop199W3b3EJZ7II
         N2CDMf1yNLxd9w87yFH8pvGwiPIomCmoXD/5J+4qWIfbnjMte7OoFbVCOMv0rsZ9vIVv
         d48ftyINM5QiqbTWWjZSuyXdF6/f33F781GJzAm6DdZVmdkMoW/O1lHXBguzwod43HrG
         JL83Wz9hnjyxOGolb4djZOjEgbYxrgJHnQDZ1gzrN/emboEWPt/BhFm35DxxAIkroRDe
         YxOoUffkluM76Ow9ckb74x5KnxaQ2ev6WMCwUa8al3CL8D503N4AaI1r0nitDm7A+Juu
         xbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703152645; x=1703757445;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czNdiwtjM+Bf3wxnWNI65fEHbodGPjXoLCSns14aIQM=;
        b=dPTCRpb3qluAaodNpRA9uThAMuIkq16hOAINRpO+NF0Q3hsnr7JiHGyPAoC+Nuof7n
         UxJ+EBk/xo+dj7qEuukNJVeMYWX766KnAP2d9CWn90/g9GQBeSHa6Etq1sGAuvUeJ8vG
         cTny0wFnYooddM/a7IYkLzdecNhWuQealNpglqFX4UlOc3yd5H5ZykbAx2QLO0YGpjMI
         houIvyGP4+mPp7bQHl9yA4R3llOPhcyB56FpM9V2Ji8uzvOZItY3S9KVgACAn4SfcD1M
         EoOSLdY3pZl8bDLwr/PGUaCaj1XERb8xiVXpPP05OPUHDTGdvkAL/WEU30+dZdRCyCvh
         CXvQ==
X-Gm-Message-State: AOJu0Ywrfbqm2TfkbpZ1e6lEhy4XOW5IEYnHhno8I7n++Yttpu0xICZL
	KW/6Mzzzta7zAOXdlRnJa9A=
X-Google-Smtp-Source: AGHT+IEBLTiON+N2o0ZM18qKYqb279iJAAAWZJb3MkxNoSZ4VkOf1WKVYg2cLN90TjeVduOvKF/VNw==
X-Received: by 2002:ac2:4119:0:b0:50e:3ca0:d695 with SMTP id b25-20020ac24119000000b0050e3ca0d695mr2618973lfi.89.1703152645110;
        Thu, 21 Dec 2023 01:57:25 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id gq14-20020a170906e24e00b00a26ac39ed4dsm134040ejb.11.2023.12.21.01.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:57:24 -0800 (PST)
Date: Thu, 21 Dec 2023 10:57:23 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-pwm@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Kevin Hilman <khilman@baylibre.com>, kernel@pengutronix.de,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] MAINTAINERS: pwm: Thierry steps down, Uwe takes over
Message-ID: <ZYQMA-tM-zl5IJyC@orome.fritz.box>
References: <20231206214817.1783227-2-u.kleine-koenig@pengutronix.de>
 <ZXM72QYBbb32Q_aL@orome.fritz.box>
 <20231208190620.5qobgtyii2wt7tfa@pengutronix.de>
 <ZXbsDRslZNKCeJF9@orome.fritz.box>
 <20231211141900.x6tpyctch5fv3uqf@pengutronix.de>
 <ZXcpswXxb1oQldp5@orome.fritz.box>
 <20231212203352.wl3rzob75fct4lov@pengutronix.de>
 <ZYMPc50eBi6oBClu@orome.fritz.box>
 <6nj7rmq36hj5m26b7yhlbmpfps5wuxkx4zwyvttg4cpgocimj7@xtqm4qleo3s6>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bpadk4LYFr5KK+oq"
Content-Disposition: inline
In-Reply-To: <6nj7rmq36hj5m26b7yhlbmpfps5wuxkx4zwyvttg4cpgocimj7@xtqm4qleo3s6>
User-Agent: Mutt/2.2.12 (2023-09-09)


--Bpadk4LYFr5KK+oq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 10:21:36AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> It's not easy to let go responsibility for a subsystem that one cared
> for for a long time, but Thierry realized that his heart isn't in the
> pwm framework any more.
>=20
> Thierry cared for the pwm subsystem (commit 200efedd8766 ("pwm: Take
> over maintainership of the PWM subsystem")) as a maintainer during
> nearly 12 years. A big thanks for the time, effort and dedication spend
> during that time.
>=20
> Uwe takes over maintenance.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello Thierry,
>=20
> On Wed, Dec 20, 2023 at 04:59:47PM +0100, Thierry Reding wrote:
> > On Tue, Dec 12, 2023 at 09:33:52PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Mon, Dec 11, 2023 at 04:24:35PM +0100, Thierry Reding wrote:
> > > > It all adds up in the end and keeps me from doing other things.
> > >=20
> > > If that means you'd be glad to give up the PWM maintainer job, I'd
> > > happily take over this post.
> >=20
> > "Glad" is not the word that I would choose. After all I've looked after
> > this subsystem for almost 12 years, and letting it go isn't something
> > that is particularly easy. However, I do realize that my heart isn't in
> > it anymore and I don't want to be in the way of anyone.
> >=20
> > So I'll take you up on that offer. Do you want to send a patch?
>=20
> Sure, here it comes.
>=20
> I hesitated to remove you completely, but I guess you intended a clean
> cut? Or would you prefer to stay as a reviewer?
>=20
> Usually I would have added you to CREDITS, but as you will continue to
> fill your various other responsibilities (I expect), this felt wrong.=20

Looks all good to me. I'll keep things going until the next merge window
and will then send out my last PWM pull request and let Linus know to
expect future requests to come from you.

Thierry

--Bpadk4LYFr5KK+oq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmWEDAMACgkQ3SOs138+
s6GNYg//XoJfUeZxCmfz6spN7CsYd9q987+bqWzWKwEmrBjBHLO7YOY55ZhDeOQt
5mj73V2HPXnOcEUk+0nxlioXrnmhw6J8ruHoUvK43yoQp/WizV48KEOszKwLF3Lo
pixM3gbLj3t9h8EAhlcWy96sFZJIBTqSpL1sQcKIRNVx9e0GvswKvxqCUjfb7KZn
b6RF6ueiuzQWRic3NLWZSvoxh4dWg3fYB2h18DVkq9b+K632a0SsETBmMFry7+1P
yPmLb6wci2Aw2aK2lmXFzO31MD0/lCYC3BLGMTnsXI+Hrl6eASe7WXJ5PVjsrhM7
9B0Si87xDQRKnxHFekuXJSG2+Mw00TBwQN0g+uJt7xaC/47DUO3mWrV9SaK97ksu
CRiH+h22t0wnyWQiqyhsQ1DbLj/c8+WNLYX3gssoSTj9T7trT8/yt5xjU3Td1Xb1
ZA6x0D62WLtz0P44aAxUY5L2nVi7xMXi2v9EBCge9omujFxj98mhWNSFcVNku3fn
8eX5SghdUusYjjl53JzAvqfhFmcHVcRl0dR/O/ro0D+lZ4OZI6i1LhERo9s0IM3z
zZNZQ+HyK46/ZYDWA6G5TZ+Io7thbhY32C5+jneriiEB/B5yFwUzJQU5zXD+A8EW
nmv3sCgW9QibvwpKuryVPPUGBS/l+sJajHsEUJ2OD4JT12rXgpY=
=MIpe
-----END PGP SIGNATURE-----

--Bpadk4LYFr5KK+oq--

