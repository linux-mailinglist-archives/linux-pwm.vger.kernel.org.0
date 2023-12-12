Return-Path: <linux-pwm+bounces-536-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C11F80F0E3
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 16:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05AFB219D0
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 15:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3DE78E8D;
	Tue, 12 Dec 2023 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZE/1j13"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BD76DDF;
	Tue, 12 Dec 2023 15:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6CDC433CB;
	Tue, 12 Dec 2023 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702394866;
	bh=DWg3sQ9qxo14q4VzdIjndy7b2Wyci4KHHq5fC3tFwHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZE/1j13EWy8z8pFkXqNRn6HYJzjFYN/10G8iu8cAoafoyKUIycSHgfsSyvCG2Teo
	 WIYd8P+3bQWl5nIbbFYJJT9TxFvKa61BuG3l1DafVw0ekfJDR8qSKIxXKDzCInlZYV
	 raUWL9oNnYA4SBKtgOH4ful8G+RZ+T/71QpgbHLJGeR0sVbnohOUMP3PCXgg3SfKK2
	 I9ufZ93he66i2gRzet1ebLl1wH5amInfBW6CfiulcjcH7V2WDx4RmZaQ5GFC1P65zR
	 XRdJhdv/ySQONhdGuJFe03izK1d+T/JtjpbEhiwAqjmZ4pejzLDtj95C/Gi2y5/LVG
	 RVsC/UmRz27YA==
Date: Tue, 12 Dec 2023 15:27:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Sean Young <sean@mess.org>, Jean Delvare <jdelvare@suse.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Helge Deller <deller@gmx.de>,
	linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Support Opensource <support.opensource@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Gross <markgross@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v8 1/6] pwm: Rename pwm_apply_state() to
 pwm_apply_might_sleep()
Message-ID: <7594ea09-a6f3-4dac-acb3-d5f899f9cf84@sirena.org.uk>
References: <cover.1702369869.git.sean@mess.org>
 <9af7ba748fd2eb7e04208b6b183185f1daf78016.1702369869.git.sean@mess.org>
 <20231212114100.sn7nzntousql2ays@pengutronix.de>
 <f7be8d89-25ae-4d83-9577-12fcac41d0ab@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iRFgPhdLTHQFhazT"
Content-Disposition: inline
In-Reply-To: <f7be8d89-25ae-4d83-9577-12fcac41d0ab@roeck-us.net>
X-Cookie: If rash develops, discontinue use.


--iRFgPhdLTHQFhazT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 07:22:18AM -0800, Guenter Roeck wrote:
> On 12/12/23 03:41, Uwe Kleine-K=F6nig wrote:

> > Several affected maintainers already acked, so I guess it's fine to take
> > this via the pwm tree. An Ack from the remaining maintainers would be
> > very welcome, an alternative would be to split the patch.

> > Missing Acks so far:

> >   - Jean Delvare / Guenter Roeck for drivers/hwmon/pwm-fan.c
> >   - Javier Martinez Canillas for drivers/gpu/drm/solomon/ssd130x.c
> >   - Liam Girdwood / Mark Brown for drivers/regulator/pwm-regulator.c
> >   - Helge Deller for drivers/video/fbdev/ssd1307fb.c

> Personally I find the change unnecessary and pointless, which is why I
> didn't ack it. Even if function names were deemed important enough, keepi=
ng
> pwm_apply_state() for the time being and just adding pwm_apply_might_slee=
p()
> as duplicate would have done it, all the changes could have gone in long
> ago, and per-subsystem cleanup could have been orthogonal.

> I refrained from commenting because it might be considered bike shedding,
> but I don't want to ack something I deem unnecessary and pointless without
> comment. But then don't want to keep arguing either, so

I haven't been reading this series because I couldn't tell why I was
copied on it, it's only chance that made me open Guenter's mail here...

Acked-by: Mark Brown <broonie@kernel.org>

--iRFgPhdLTHQFhazT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV4e+YACgkQJNaLcl1U
h9Aqewf/UALlUMgqzHC9oYZI+Kcf9eGgd7QO/+pxhbI5hMnT5tFRH9lkihV8NhkZ
moY0GH6PcO8YFj0y+Hs89vmJCd3MRAJ7tZ3eEg5/Q7BJejmk7kB24R5TlqUHUcg7
DcHugsUrGAmvt3afuF03VqA53HlJ6D43J0cIv5j5X8x18v9Z4s0/4z+/zuMEJ8qi
05gpioqCsqqPxlKMuWv9qPxn6PDVO3JMk7OUodLi1Tdzfio/b7/81nRQX6DgpHm4
odCEdmvJwIAukE1TlXxfpb7GZuHEe0z04rKSLfvDj6s90hRM9uHdJb3L7kp1Xf0n
nsm4Twh4PnRdMJRKACafo9HyC8RvJw==
=Wkx1
-----END PGP SIGNATURE-----

--iRFgPhdLTHQFhazT--

