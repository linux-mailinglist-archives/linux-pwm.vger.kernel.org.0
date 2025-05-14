Return-Path: <linux-pwm+bounces-5984-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B38D6AB6844
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 11:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659F91888261
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 09:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1454D25DD01;
	Wed, 14 May 2025 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1ZgMsxn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD77C13E41A;
	Wed, 14 May 2025 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747216780; cv=none; b=uiSaW/jsdMB+x4EugaQ3K2sI7JRqlItfGihAqH9CKpog0THDV7IrONlnlylaQX4jyhuj/dq/I9qFwnYvwH3ov6ZTtfykWffpkvWBYWtM+Y35tKuONDAzNLgjG6G7/hMsP47feFxa4DZRY3ZDmOFhEMThDx32hlWWBDy2ZEU/ZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747216780; c=relaxed/simple;
	bh=BIvliVdYqXYrImtlDwKxLO6W8rVjN3lVoNpwHJ7DmqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfWj/fCEkIASJKGAugykXMsvkx9y56beOmBuMobx7KbRrk3+yKWo49/dUq4J72InmZNVmxwAYcbmWXXFOAaE/AUcap+UN4+AUGRPFhl4dnB4iG9fbej3EyY7c5qHyIEVEsvxVrja0D/mYiNBWi3QTAWBsb0hOA/2AjfRWEw1iaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1ZgMsxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0E4C4CEE9;
	Wed, 14 May 2025 09:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747216779;
	bh=BIvliVdYqXYrImtlDwKxLO6W8rVjN3lVoNpwHJ7DmqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1ZgMsxntfuQjd/h0unBrYQzcBKcUtoZTyNYAlmMYABq7mggbRuFNxpn9cAuJ6eDk
	 0Z8XvWh06F7bYvpiZwiclrBuU8j/kYGkd6FpebniW4vlRWP7vflhc0jS+0li+X1D55
	 N1L/QACKMuDc2pwJXUq8VNiM3M2ugqKzbWPVq1IIwCvakFQTbLHcJctn/pfLuR3ZW+
	 JOkyjtI/bRtsKS0x0AdnKXUQrtSUeFaeKQ5Qn+eJez4y8yC4grPLdUyTwK8KAtoSsF
	 A+r2Dl0BkVNvO/eI5Tc0yoN9/SB0KVF+6VRjlHN+akhG8PVIsjIekmlRQWWQNHh+Uj
	 U/O/LV2oEVORw==
Date: Wed, 14 May 2025 11:59:35 +0200
From: Mark Brown <broonie@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v8 05/11] regmap: irq: Add support for chips without
 separate IRQ status
Message-ID: <aCRph9Qo7BbtTjIR@finisterre.sirena.org.uk>
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
 <20250509-mdb-max7360-support-v8-5-bbe486f6bcb7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z3tfCnzQ5p+24U/H"
Content-Disposition: inline
In-Reply-To: <20250509-mdb-max7360-support-v8-5-bbe486f6bcb7@bootlin.com>
X-Cookie: Well begun is half done.


--Z3tfCnzQ5p+24U/H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 11:14:39AM +0200, Mathieu Dubois-Briand wrote:
> Some GPIO chips allow to rise an IRQ on GPIO level changes but do not
> provide an IRQ status for each separate line: only the current gpio
> level can be retrieved.

This doesn't build in a wide range of configurations (none at all
AFAICT):

/build/stage/linux/drivers/base/regmap/regmap-irq.c: In function =E2=80=98r=
egmap_add_irq
_chip_fwnode=E2=80=99:
/build/stage/linux/drivers/base/regmap/regmap-irq.c:914:88: error: macro "a=
rray_
size" requires 2 arguments, but only 1 given
  914 |                 memcpy(d->prev_status_buf, d->status_buf, array_siz=
e(d->
prev_status_buf));
      |                                                                    =
    =20
               ^
In file included from /build/stage/linux/include/linux/string.h:13,
                 from /build/stage/linux/include/linux/bitmap.h:13,
                 from /build/stage/linux/include/linux/cpumask.h:12,
                 from /build/stage/linux/include/linux/smp.h:13,
                 from /build/stage/linux/include/linux/lockdep.h:14,
                 from /build/stage/linux/include/linux/spinlock.h:63,
                 from /build/stage/linux/include/linux/sched.h:2213,
                 from /build/stage/linux/include/linux/ratelimit.h:6,
                 from /build/stage/linux/include/linux/dev_printk.h:16,
                 from /build/stage/linux/include/linux/device.h:15,
                 from /build/stage/linux/drivers/base/regmap/regmap-irq.c:1=
0:
/build/stage/linux/include/linux/overflow.h:327:9: note: macro "array_size"=
 defined here
  327 | #define array_size(a, b)        size_mul(a, b)
      |         ^~~~~~~~~~
/build/stage/linux/drivers/base/regmap/regmap-irq.c:914:59: error: =E2=80=
=98array_size=E2=80=99 undeclared (first use in this function)
  914 |                 memcpy(d->prev_status_buf, d->status_buf, array_siz=
e(d->prev_status_buf));
      |                                                           ^~~~~~~~~~
/build/stage/linux/drivers/base/regmap/regmap-irq.c:914:59: note: each unde=
clared identifier is reported only once for each function it appears in


--Z3tfCnzQ5p+24U/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgkaYYACgkQJNaLcl1U
h9D5cAf+JhYoPK5A9iw0gYMdc9xLOUPvzCDacN5d5KvUrO4WUo6ZpEumlPwyI5kX
700vdHFINWEJgKwy1UTRj70pXgkPkVUDDDZ4Y2hZZloQEgl10N+mm/hUZLxNlNRS
N6idzTanOzTogg/bVYiNuMylxLNewGi93QqK7oplFA5eaRVbgFd5y1VJsECAEyfo
TNqEmn+isUKmP0uC3NWbADZek2IOZ5wqt7WBVPPvF3zdNaLelFCiMw+N7Zm8xI1r
S9UOfg4eKan6E2SVhwyr5Aemj+gpEhFgpJEVRUpOXZOGIymWcf2oFqbvDFs1YuLg
n02uX8JFzuLgwFezUggjRZsJVJxw1A==
=Mu44
-----END PGP SIGNATURE-----

--Z3tfCnzQ5p+24U/H--

