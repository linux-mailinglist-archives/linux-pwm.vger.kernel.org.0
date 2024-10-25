Return-Path: <linux-pwm+bounces-3864-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF89AFC31
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 10:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3561C2074A
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 08:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB51C4A12;
	Fri, 25 Oct 2024 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XdMLbG3U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7D18CBF8
	for <linux-pwm@vger.kernel.org>; Fri, 25 Oct 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843830; cv=none; b=u246HA0lL7PMHvcUcE/z5WXfrwWMOPpYFqXU5YZz2Xet1jZowj4Szeatgh2MwecoSMjxajuc0Y0zOGW2tDGcj7sDeqVJ1EWej56foSCOUHXnGrUuGw9TPCmrHglZae09yczCrV9DmKeeSZq9Fqk7ak8FF0Jxl53+MouW9iQsEtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843830; c=relaxed/simple;
	bh=uIHAB8knA67LAdTZXj2iF5vul+ZTR391oAkKc1jLRRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5NpG88Nv1HAW9RVryhbaBFszIstNJhMdPr9PnlqH2OnjrTzjxiL0JiYOfshIWJFOTc7H6jncUVX9kSt7Ggd1/CGGA4zIY3gb+pm4crTBusm1PK5kAhd3CuGDXtitGXBVJEm/2MNzVx+E7wWHWV4bLHujvOPwtIZ8tCDVBX4FF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XdMLbG3U; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso14167801fa.1
        for <linux-pwm@vger.kernel.org>; Fri, 25 Oct 2024 01:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729843826; x=1730448626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/fMOoodbMzbwIVhNycuTPYQFdigoQOM3R/xwLCJOkg=;
        b=XdMLbG3UijKzcGx4luJOSS3z2n3CHj91rWH1iVXDQy9rNjJIWR/xWrAKwKviZIPzUT
         VmrZOWQqWHQtLTvy2VcKUW6iaRkE4U9+ZBuXp3KleimePv+nJI6LpsVfVjYkx6NjLgpo
         y2IDxlbajJuXb+Kepjmb7pkwPFZtswJme4GYRwFSGgWhT4MeBqb5RQh3eu8vsweHXney
         OW6icrloM3j5a9wMH84epGG2WreROzBzTu1HqRpUF97HEAmjSXZTM2DQqPJppn9DHmR3
         5P/yDNsvOac5MfBaIAEJpWArOEo5T4JCQnDZ9mCTJ0kTBPrqj4Q8hbqE8AHCrPNm45wE
         sEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843826; x=1730448626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/fMOoodbMzbwIVhNycuTPYQFdigoQOM3R/xwLCJOkg=;
        b=b85xh5cthXrz/7Y18wnzZcrqnNntVY0E1O5m1e48jSaqJCsHWRCCSiWOy9VXC0OR7+
         Fegq+CAJwXmmP329VZk5Xva/wDWWe9Nywk0iOep8EM2M6n060cSd7zreBW7R2HlVS32a
         i47aVaPZMtrYIbdUWyFsIRWeXFhcDxNekcVaYaSMnmjQOwT4Dy7gn/U2D49YAYd9IGxX
         i6+UE1x3KEzJw8KM4M9K8711Bo7ezCbyZdC2W7R02gL1tKVtIg9ewb1Mt/3UdpuUvOI8
         urfGoL6qr13O8J8l3uLLLNg9L8gClhYGnte3uLsCfP9XH8H4L2tG/b4mt2mrfvCx1Vbg
         MjPg==
X-Forwarded-Encrypted: i=1; AJvYcCXAHvx4xDOxJHcZak407PojQnPL/iYnrv6hVPsS8F370+bcPagHSfykMzY3OkvZV7bvBjt5SUnqAJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRXX+NALCkWCzLP79v/VCoPnFKBmPdplY9apd3e7m3yjt1OuVS
	90yCNF3H4NCVHN5J5uhB90N8owXAJHo1x3qHc3HGBO+i0B7cQ3NljKcr2FbEkcQ=
X-Google-Smtp-Source: AGHT+IFbMHt8LG7ynfMpwb1jF4aZ4NwAbHonDNawD4VDZMCWmBcTP0Lt3O+sjbBuFgQju/DrJheDFw==
X-Received: by 2002:a05:651c:198c:b0:2fc:97a8:48f9 with SMTP id 38308e7fff4ca-2fc9d35a491mr51172391fa.19.1729843826415;
        Fri, 25 Oct 2024 01:10:26 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f6e47sm10446295e9.38.2024.10.25.01.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:10:25 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:10:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Guenter Roeck <linux@roeck-us.net>, 
	"jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, 
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH v1 0/2] Enable WDT reload feature
Message-ID: <6hkiqbgqkpdlr5f27drs7vcee7pb2uahek4zz5pd5ndativk53@42otb625deil>
References: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
 <nm4ckxv6swajr6hnqlkq5uoo6ncjzlg6yfxroftat6dubiefyi@xbhi4dvqacxm>
 <ea1be8af-0948-46b1-a1f4-fe572861cde4@roeck-us.net>
 <OSQPR06MB72529E67E67D0D07E59AF1C08B4F2@OSQPR06MB7252.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="irgwyxo4ns45vjjz"
Content-Disposition: inline
In-Reply-To: <OSQPR06MB72529E67E67D0D07E59AF1C08B4F2@OSQPR06MB7252.apcprd06.prod.outlook.com>


--irgwyxo4ns45vjjz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/2] Enable WDT reload feature
MIME-Version: 1.0

Hello Billy,

On Fri, Oct 25, 2024 at 02:00:39AM +0000, Billy Tsai wrote:
> > On 10/24/24 08:40, Uwe Kleine-K=C3=B6nig wrote:
> > > On Thu, Oct 24, 2024 at 03:15:46PM +0800, Billy Tsai wrote:
> > >> Aspeed PWM controller has the WDT reload feature, which changes the =
duty
> > >> cycle to a preprogrammed value after a WDT/EXTRST#.
> > >>
> > >> Billy Tsai (2):
> > >>    hwmon: (aspeed-g6-pwm-tacho): Extend the #pwm-cells to 4
> > >>    hwmon: (aspeed-g6-pwm-tacho): Support the WDT reload
> > >
> > > Huh, I'm not convinced that extending #pwm-cells for that feature is a
> > > good idea. Unless I'm missing something none of the other supported P=
WM
> > > chips can do that, so I hesitate to change a standard for it. I sugge=
st
> > > to make this a separate property instead.
>
> Using a separate property to enable this feature is a straightforward
> method, but I don=E2=80=99t understand why extending #pwm-cells isn=E2=80=
=99t a good
> idea in my situation. The feature =E2=80=98WDT reload=E2=80=99 can be set=
 for
> individual PWM channels, and the PWM subsystem has the of_xlate
> callback hook, which allows each driver to define its arguments for
> the PWM consumer. I=E2=80=99m unsure if I misunderstood this callback usa=
ge,
> as I couldn=E2=80=99t find examples. If my understanding is correct, this
> method is better for adding our specific feature, rather than using
> child nodes or separate properties to indicate which PWM channel
> should enable this feature with the corresponding duty cycle values. I
> think using separate properties to achieve this feature would be quite
> cumbersome.
> As I know the arguments for this usage are as follows:
> First: PWM channel index
> Second: PWM period in ns
> Third: PWM polarity
> Therefore, I extended our feature to a fourth argument to avoid any confu=
sion regarding usage and added the description in our yaml file.
>=20
> If my thinking is incorrect or doesn=E2=80=99t make sense, please let me =
know.

It might make sense if your bubble only contains that single PWM
hardware. However if you extend the pwm cells semantic for your PWM to
mean "period if the PWM watchdog triggers", i can hardly refuse the next
developer who wants to extend for "period of the secondary output pin of
the PWM" or a step counter or some property that defines how the duty
cycle is modulated over time. And should the next one also use the 4th
u32 for his purpose, or should we consider it reserved now for your
purpose such that the duty_cycle modulation goes into the 7th cell?

Today the bindings are (well nearly) used in the same way for all
hardwares and I want to keep it that way. If your PWM has a special
feature, give it a speaking name that the occasional dts reader has a
chance to understand without reading HW docs or dt bindings.

Best regards
Uwe

--irgwyxo4ns45vjjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcbUm0ACgkQj4D7WH0S
/k669AgAm/vnBOGdRCsvDuzdHkwBbJUkiJHDGNT3nBEs43lY8F0I4G3bDEdGMfgj
Z1EBM6cL0h4BPVxR4vaUd/R8xTuRMkgU5EZy5ic0U+j3KozA6bnYqXuBfUy1VCjL
emUvBEdX7dN2TS2lWnNh/yRpy2IDNYkOEU2ffBGjX1s9xQtVHhtY2yUt3/t7cJwG
HBaMhXhaZD2eUNuhuT5zxW8GA8yiF048vzqIfbBnh7bCqfY7i9XcLQKKcYpOdZ8E
BJ3DF5SRcAv56F0PfkA25qr15QRvzUOt64dNKSVL38Cn7LH4joP2/UtdvjqWlCQm
ytZRxFf+CRo6WHEyCrs0X3asdsChAQ==
=4H4I
-----END PGP SIGNATURE-----

--irgwyxo4ns45vjjz--

