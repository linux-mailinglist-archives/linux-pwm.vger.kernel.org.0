Return-Path: <linux-pwm+bounces-5986-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90459AB6AC3
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 13:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EA019E0606
	for <lists+linux-pwm@lfdr.de>; Wed, 14 May 2025 11:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0A2750E8;
	Wed, 14 May 2025 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pS5ClvLR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DDD2750E3;
	Wed, 14 May 2025 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747223961; cv=none; b=YLqrcZi0pXi/avniqVzOzSibS8hIQe/9eTCqDjeLUVHPolOxMR+iwHr9+0TGrQOukJpNwiPwErXMxGtyCcC0FJfKYPCh6/ZTB+KTfOUS/HYxLF8/wEe8AJXDdCsYiUaZkg3H0Y6PuoCir9RsBMbZSYPaPYGvPP50o1CIHKW80d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747223961; c=relaxed/simple;
	bh=KhTRneUkTX9EBKW+iyOoaMIrQvNJC+gMVHEHh8UDj+I=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=CukK4xw6VHrRrTjSb8Rsg1DNxaYaM9RXPOpJS3KQMwqpXx7pEhMa0vA6HnNTffrVqLZU+06AF4akUFLUxR6Simh2s++xOeAyy06I4LyqAvVzTvXMTiaHMNNpDXPuWJ29QwzaEOw85mDDi5xh6Z/YUbCpQ1e7nUaWDT9ZfFbvL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pS5ClvLR; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2F5243AE1;
	Wed, 14 May 2025 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747223955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hx8hZadhPLNPdx/ZVIFSoWCGdjdrp3mSlEudiBBNUXQ=;
	b=pS5ClvLRuSk+5kUEP9oDRWUgPmmp8md/PBTinyu9u263y7Y1aVN/ZEV7mJtFy5tfDw0NG5
	MHF7WB/EloSufQwNR/UK5323cmQt6RnHWFqrD0tuVV0DPKX+Ex6yVGQ5SYyHyOsepJUECV
	xhh7xiBblKace48GK8/7uILLtbF85iqMUdVvr/LUUcaw+/qkcqXlOWGfLpYT/a5I83nVx6
	i//NYXHuS1DZ/yFar21QR381M6oJhsjaqEgfjLadkUMBiGIENvJJXFG0AQWfwKLkEutaUF
	d/61eZwhBkc9tOEDkZKLYKoQVeG4E8Hp+nZM+X8h0PRI/GWS/9FepiH+IlW/gg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 May 2025 13:59:11 +0200
Message-Id: <D9VV76MU61HW.XEELOHWXFW3Q@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH v8 05/11] regmap: irq: Add support for chips without
 separate IRQ status
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael Walle"
 <mwalle@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <andriy.shevchenko@intel.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
 <20250509-mdb-max7360-support-v8-5-bbe486f6bcb7@bootlin.com>
 <aCRph9Qo7BbtTjIR@finisterre.sirena.org.uk>
In-Reply-To: <aCRph9Qo7BbtTjIR@finisterre.sirena.org.uk>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeileefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkhffvufevofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehvedtkeffueelheektddvjefhiefhgedtudevgeehvdevlefgveetkeevleelteenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtdegmegtvggttdemfhdtheefmegvfhegmeefjeefjeemfeeijeejmegvvgdtieemugelvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtdegmegtvggttdemfhdtheefmegvfhegmeefjeefjeemfeeijeejmegvvgdtieemugelvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtt
 hhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed May 14, 2025 at 11:59 AM CEST, Mark Brown wrote:
> On Fri, May 09, 2025 at 11:14:39AM +0200, Mathieu Dubois-Briand wrote:
>> Some GPIO chips allow to rise an IRQ on GPIO level changes but do not
>> provide an IRQ status for each separate line: only the current gpio
>> level can be retrieved.
>
> This doesn't build in a wide range of configurations (none at all
> AFAICT):
>
> /build/stage/linux/drivers/base/regmap/regmap-irq.c: In function =E2=80=
=98regmap_add_irq
> _chip_fwnode=E2=80=99:
> /build/stage/linux/drivers/base/regmap/regmap-irq.c:914:88: error: macro =
"array_
> size" requires 2 arguments, but only 1 given
>   914 |                 memcpy(d->prev_status_buf, d->status_buf, array_s=
ize(d->
> prev_status_buf));
>       |                                                                  =
      =20
>                ^
> In file included from /build/stage/linux/include/linux/string.h:13,
>                  from /build/stage/linux/include/linux/bitmap.h:13,
>                  from /build/stage/linux/include/linux/cpumask.h:12,
>                  from /build/stage/linux/include/linux/smp.h:13,
>                  from /build/stage/linux/include/linux/lockdep.h:14,
>                  from /build/stage/linux/include/linux/spinlock.h:63,
>                  from /build/stage/linux/include/linux/sched.h:2213,
>                  from /build/stage/linux/include/linux/ratelimit.h:6,
>                  from /build/stage/linux/include/linux/dev_printk.h:16,
>                  from /build/stage/linux/include/linux/device.h:15,
>                  from /build/stage/linux/drivers/base/regmap/regmap-irq.c=
:10:
> /build/stage/linux/include/linux/overflow.h:327:9: note: macro "array_siz=
e" defined here
>   327 | #define array_size(a, b)        size_mul(a, b)
>       |         ^~~~~~~~~~
> /build/stage/linux/drivers/base/regmap/regmap-irq.c:914:59: error: =E2=80=
=98array_size=E2=80=99 undeclared (first use in this function)
>   914 |                 memcpy(d->prev_status_buf, d->status_buf, array_s=
ize(d->prev_status_buf));
>       |                                                           ^~~~~~~=
~~~
> /build/stage/linux/drivers/base/regmap/regmap-irq.c:914:59: note: each un=
declared identifier is reported only once for each function it appears in

My bad, I somehow ended with this commit introducing bad code but having
the next patch of the series fixing it. I will take care of that. Thanks
for pointing this.

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


