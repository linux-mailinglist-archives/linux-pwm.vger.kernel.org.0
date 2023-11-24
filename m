Return-Path: <linux-pwm+bounces-186-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF917F738F
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 13:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3C90B2102A
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 12:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBE423778;
	Fri, 24 Nov 2023 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCqBPjtn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7828D41;
	Fri, 24 Nov 2023 04:14:48 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507962561adso2763895e87.0;
        Fri, 24 Nov 2023 04:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700828087; x=1701432887; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijQHzf9AIuQQtKW1Zl7mEAUen+sR28AD8rctYV92Mw8=;
        b=hCqBPjtnPzW6Rro2q1jQbmJAG0D9jqGQCPsTvoG6C0K6kyr5ZmnAlxr89Per0t8VSv
         1f0XqNZPLLisCil8UaWcUGbHk9jEv2g7J2TcWTdKF0/lb1AmE5WxlSessFE2YdhfCmx2
         Waw4VzodwvNHX8iRSWUKg/oL+ZkRmkL8UDKcu6cGhAcARUjQ3UprxyHO7LiEDr6JlXc+
         aKRuYGPJ5fwXNkv7NFlXEYsq+VwY7qN7Sasi/KyOlOxw8v+uhfrxadQhC5JzpcyJ8qIb
         1eUP0AYxzPJbWWCz4c3UeY6bOdo3I5cawBPNmTV95TdS52GSMExKuJ8QVLFPMzUXN281
         lJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700828087; x=1701432887;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijQHzf9AIuQQtKW1Zl7mEAUen+sR28AD8rctYV92Mw8=;
        b=hwaPEyb1wR1wJEe1ZyaU5HCcvrDFZMavJl69WOGtiAA6p0d1AOIwtHXX5oBBatSbpW
         I0s9CwMEaOBdmofR1t9shgstEDTwnWEwmZkAd9pruf1nPrLFt7LoImva0a5frrKWEKoI
         DWBuldAIgKVwLYJ2B8AjNbMsvlhBdZEh5DgOZzOlNlZV7/7JrYhhWauNz3fJSRTRUzqn
         /9JBPRn8WLt5g2usKda2QaeLS1ulQeEP5eMaP3LttYvfilahG1/dfEBALi7J9wLEsSYc
         Pp1uT7O8JRTPkdZioxburCvU2an7zEC9pWxkOUU/mlvbGNLuOSt48VSTZFRsXtPZApVt
         vb7Q==
X-Gm-Message-State: AOJu0YzLneBOIVSUnh9zbj5O4PmPaQhdR3guO8W4jYUh60EwmZ4CLn4k
	ijnYDogFaEhCsY5m4HkbHGA=
X-Google-Smtp-Source: AGHT+IF1qhPNascxB1JYcFPeutbxMgKoNy+yeHVNs++AXWy8W7sJOn2ljFtNCp5jtXBINfWvdrzRUg==
X-Received: by 2002:ac2:5dd4:0:b0:503:55c:7999 with SMTP id x20-20020ac25dd4000000b00503055c7999mr1568878lfq.34.1700828086728;
        Fri, 24 Nov 2023 04:14:46 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id da7-20020a056402176700b0054afe3625a9sm444228edb.43.2023.11.24.04.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:14:46 -0800 (PST)
Date: Fri, 24 Nov 2023 13:14:44 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 100/108] gpio: mvebu: Make use of devm_pwmchip_alloc()
 function
Message-ID: <ZWCTtPVkTUQNLVoa@orome.fritz.box>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-101-u.kleine-koenig@pengutronix.de>
 <CAMRc=MdSc3emU+AJpCni6is0qsmR9HcqysSL33gpAmb8JTnjVA@mail.gmail.com>
 <20231121161111.zphi7pn77ns7sgu2@pengutronix.de>
 <20231122090502.tcscaaaf7vuk6g7w@pengutronix.de>
 <CAMRc=MdBvcS8pvtt_mB9NWskJPQgB4t4jot5YZRE=_d+jVNnMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5lLzc8lREJAGeIBz"
Content-Disposition: inline
In-Reply-To: <CAMRc=MdBvcS8pvtt_mB9NWskJPQgB4t4jot5YZRE=_d+jVNnMQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--5lLzc8lREJAGeIBz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 11:36:19AM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 22, 2023 at 10:05=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello Bart,
> >
> > On Tue, Nov 21, 2023 at 05:11:11PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Nov 21, 2023 at 03:02:39PM +0100, Bartosz Golaszewski wrote:
> > > > Eh... I had a talk at LPC where I explained why I really dislike th=
is
> > > > approach but I guess this ship has sailed now and it's not a subsys=
tem
> > > > where I have any say anyway.
> > >
> > > Is there a record of your talk? I'm open to hear your arguments.
> >
> > I found your slides at
> > https://lpc.events/event/17/contributions/1627/attachments/1258/2725/Li=
nux%20Plumbers%20Conference%202023.pdf
> >
>=20
> My talk is here: https://www.youtube.com/watch?v=3DVxaAorwL89c&t=3D29310s

I've been watching this along with Laurent's talk from last year (and I
guess I should probably also go through Wolfram's patch from earlier
this year) and I really like what you presented. It also sounds like
there was a lot of support across various audience members, so I think
it'd be good to rally around such a common pattern so we can start to
improve things on a more wide basis.

Given that this wasn't very long ago, I wouldn't expect that much work
has happened yet on the resmgr library. However, I think it would fit
very well both with how PWM works today and with what Uwe has in mind
for the character device support.

Thierry

--5lLzc8lREJAGeIBz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVgk7EACgkQ3SOs138+
s6GVgxAAmPYulAEXVMYP2z7UIE6P44qIb8bsjaoQzBuvD/UPZpcrEYTQSa0KHrFy
DVX0j0INr4vBdA8mh8fwyCKR+QutZ1gUcCOPvHnVoHEJf866ZZX2R/St+VvO/lJV
WLlJIud+PvK84LqeVT4DIVR9nk0J45aIXHqMUgsVrYmwmjw4CIHmquVxm1Z31v+L
ShI8UKv8UGiP6HKFeQFMFSYvVDyTkxzZCNzAdz0hwSmGh0V2c01AonghJDfgDAe1
W6jCKmJ0TfDRauzXNYGyq/mzHUDJp9Uk+M0v4I1N7eMLQQ75ZjQSg+p3aFkCcXgm
xVMd7E2i2wGoM/EWNzilatFU0AhrBA8WJZzBeUQM+30rCuIvF7SRo6eX9Gz1W6w5
ZaQCptQHSWaZc1jiAxEstIQpAaUR+X7l+nutq0jJF7b79vgkEEgm7VIP2u+/7LUL
4BOafUprmuPCJr8mMQXtbgos1DjnyE4ZcPrfqSAJUHKN7yq+VLkgb6ub74fi5Uon
d/JgiWh9r6/asxeKOycu4G0+wWxaSZKnliY0P4Z0dH/7NmX3pdSepfnSfcysJ7kM
u8LZY/9zcwn07GLrplvhsf121OXj0PgWAq3Qb73spNo0jksg28f/GKLCG9+NkaIq
SiVSgO0mp5HWkpVd3At6skCaOR6XwS9p4sQTvAS/dijaw2Sq1OI=
=BXca
-----END PGP SIGNATURE-----

--5lLzc8lREJAGeIBz--

