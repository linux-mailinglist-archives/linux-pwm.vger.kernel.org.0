Return-Path: <linux-pwm+bounces-187-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B5D7F73C4
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 13:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1382AB213DA
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4D124B51;
	Fri, 24 Nov 2023 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvfrOh48"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9DFD69;
	Fri, 24 Nov 2023 04:27:25 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a00f67f120aso254346666b.2;
        Fri, 24 Nov 2023 04:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700828844; x=1701433644; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEAN7h4gkKwfL2N1+cj+nO9OHcjJsJmUARGotQEJSfA=;
        b=bvfrOh488rADRKA4pyS4OFAnCUb2youZTlFInp17HhyFtpmZTu3Fdo0HHbka4gNjfw
         J5fniLJp1B+su2EiBqLmzhQKOPENTrnAhTXqy0ueJaDSQrtWf/Evz6H4udm3jpbUmYOW
         VtLHarvIN+IZYp4wd54Wy++aBqCf85fY27RDDJ11A9FazWf4KS9xXklt1rK9Tl+hJL+z
         yz6hFEiOk9gHm3jwQkJ0kP+2/VBs1p2HVeUhfVQVCRxKb8dxWjppbIhl81k1zKLM+29f
         f1P2ruh5nJMzSZS3hj7waGrax4PQO7BBnM3dg5voVBk+Dxsuh6fwR+CcwBPiEwErj7Ii
         j6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700828844; x=1701433644;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEAN7h4gkKwfL2N1+cj+nO9OHcjJsJmUARGotQEJSfA=;
        b=Q7JpetMwgJjPZCBku971TyPgxUTc5Noa/cZmQS1Md3oYHPRmPZPK3ox0Hh7vzBlEeR
         R2q8W7kO5XoRg91hp8FpxlJOAq+7haOe+5eQ6KMz6S16JbNNbvKAWvuqu+F3aqWe9j4Q
         q2TT4MJz/K0LLfE0KgKRmX6mIm/txYj/VGRbhMchRIA8Jpi1GMrFqxtyLxx5Y3AA0GtZ
         V5RARGkn/5wOg5prj/2PbQrE9aPK3s3/taiM3nUTym+Mhkqxaueu/ioF/A3gpF7/mtzS
         9d+tLBi14o13EhyxJ85bYIFJ/FT7ucRTG2MmbpAAvhVs/sjLkHSPFM37aPb1vFZJk0tW
         8Kdg==
X-Gm-Message-State: AOJu0YyVRCAoerpoPPzPv445moO+Dyzpbq6YgZhA9hLqnOnPIgQC/Xa2
	0GO1uneRotXLlR0xAHFOpWE=
X-Google-Smtp-Source: AGHT+IGpjJrs4HuzE4aqjsxS+stk1d8YoQarbthwjz6s91fjqv1yMQV+r35OJ/jUZ825Xskew9BDMw==
X-Received: by 2002:a17:906:10d:b0:a00:8706:c82b with SMTP id 13-20020a170906010d00b00a008706c82bmr1659158eje.47.1700828843637;
        Fri, 24 Nov 2023 04:27:23 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id mm25-20020a170906cc5900b009fdaab907fbsm1999547ejb.188.2023.11.24.04.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:27:23 -0800 (PST)
Date: Fri, 24 Nov 2023 13:27:21 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Kees Cook <keescook@chromium.org>, linux-pwm@vger.kernel.org,
	Luca Weiss <luca@z3ntu.xyz>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	kernel@pengutronix.de,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 102/108] leds: qcom-lpg: Make use of
 devm_pwmchip_alloc() function
Message-ID: <ZWCWqcxbAtmNPY85@orome.fritz.box>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-103-u.kleine-koenig@pengutronix.de>
 <20231122115621.GK173820@google.com>
 <ZV43NHr1QN79lsaJ@orome.fritz.box>
 <20231123104458.2pfaowqylmpnynhx@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TN2hYkUOhq+Fy2y+"
Content-Disposition: inline
In-Reply-To: <20231123104458.2pfaowqylmpnynhx@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)


--TN2hYkUOhq+Fy2y+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 11:44:58AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> [adding Bartosz to Cc]
>=20
> On Wed, Nov 22, 2023 at 06:15:32PM +0100, Thierry Reding wrote:
> > On Wed, Nov 22, 2023 at 11:56:21AM +0000, Lee Jones wrote:
> > > On Tue, 21 Nov 2023, Uwe Kleine-K=C3=B6nig wrote:
> > > > +	*(struct lpg **)pwmchip_priv(chip) =3D lpg;
> > >=20
> > > This is vile!
> >=20
> > Indeed. This highlights one of the weaker parts of this whole design and
> > I really don't like it. The whole chip_alloc() construct works fine if
> > you have everything isolated nicely in a single driver and subsystem
> > (like you usually have in network land), but for cases like this where
> > things are spread throughout and a device is actually more than just a
> > PWM controller, it looks like we now have to work around this design
> > because it doesn't fit.
>=20
> With the patch I suggested in reply to Lee's mail this is IMHO much
> nicer and with that squashed into the patch under discussion I'd not
> call this a work around.
>=20
> Note that the thing you consider ugly here (I think) is that for
> handling a combined "PWM + something else" device a separate allocation
> is needed for stuff that embedded a struct pwm_chip before. With
> Bartosz's approach you have that second allocation for all PWM devices
> ---and so the downsides hurt all PWM implementations and not only those
> combined devices.
>=20
> Also note that among the four external PWM drivers (i.e.
>=20
> 	drivers/staging/greybus/pwm.c
> 	drivers/leds/rgb/leds-qcom-lpg.c
> 	drivers/gpu/drm/bridge/ti-sn65dsi86.c
> 	drivers/gpio/gpio-mvebu.c
>=20
> ) only two suffer from this complication, because the other two use a
> pwm specific private data structure already which seems natural to me.

That's true for now, but new drivers get added all the time, so anything
we do here should be as future proof as we can make it.

> > In fact, this reminds me about the "midlayer mistake" in many ways and
> > combined with what Bartosz said, I'm not sure this is going to hold up
> > very well the more special cases we get.
>=20
> Where do you see a midlayer and how would that be better with what
> Bartosz suggests?

I wasn't saying that this was a midlayer but rather that it reminds me
of one and the restrictions that it comes with.

Right now all of these drivers work just fine and we don't need any of
these weird assignments due to the single allocation. They all neatly
plug into whatever other drivers or subsystems do.

> The relevant difference between my approach and Bartosz's is that I put
> the driver specific private data in the same allocation as the struct
> pwm_chip and thus reducing the number of allocations and pointer
> traversals. This difference IMHO doesn't qualify my approach as a
> midlayer without Bartosz's qualifying, too.

The solution that Bartosz proposed in his talk has two big advantages:
it can potentially be generalized to a number of subsystems, which means
that eventually we may get an actual library that would allow this stuff
to be unified across subsystems without everyone having to invent their
own and fix the same bugs. Secondly it also puts the lifetime management
where it belongs: in the subsystem. Drivers don't really have to care
about lifetime management of whatever they expose. When they are
unloaded, they should only need to let the subsystem know that they're
gone and then the subsystem can take appropriate action.

There are other advantages as well, mostly derived from the above: the
patch series to implement this can probably be something like 5 patches,
so we don't actually need to touch every driver, because the drivers
themselves are not the issue. It's how the subsystem will expose them
via chardev (or already exposes them via sysfs) that's really the
problem. The only place where it makes sense to fix this is in the
subsystem. Drivers don't need to be concerned about this.

Thierry

--TN2hYkUOhq+Fy2y+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVglqYACgkQ3SOs138+
s6GQug/9GGjghNKsu8++GNrt0kQkr7WO5463KH9B/3Ab1PTlvBScL4Ey0iOTCDvt
tldWRFxQKbu4Zr6DDFgqPP4obQlF0bxnxuuowLSsdRqnr6pTB0QMlL1HlvPZTIoY
24HDXfai/VH6v7UQaxYCrwC/0w47mKncxzDBaW/SVI1P18qGOjKevDcL/co9ZAXd
5a4r21hYKLtPl67xArCWIhSLWUeuLyyD6xM4KyxM/V9XSXs0wAOH4jneAbGEm4Ha
34JzUJY1bkUuCm/LmPXPFT2k4blaTXvspT8v9GPnEt+OdXE+xzkUqWTrOQMDSaqR
Mxfgg6jLoHnUonmLlq84gDO/4YEJdZGfh/NCfQB5kgYnriiFnZDdpmhDhG6crz3F
Fey3/2PBZQvs8Wr/9lftHHVXilxUSkcgkDPB/sp003hs1FgtKmXMuPvaiKxCodec
E0a9hWVNvYQC9dzd+O+MIhbx2B7Uc9ymSDTitOVHdZWnkNziTAAzuLzbalxzF67E
d8Ce5THrm99Lp6Xl3USzHRzpawkUhpIUa6oIpUVavmChfIe4KAB/+Bz2dueuLT+z
OiE0UK8n5NjT6HXklvHd/u/vVjLkPclT+D0GkUUvG+cK1KajhODsnNGVCqQ2w1QK
5B3u7tn4VfVSvizphilFsrC5rRjSQO5Ekp0xEB43zimCFg6E+yY=
=vskI
-----END PGP SIGNATURE-----

--TN2hYkUOhq+Fy2y+--

