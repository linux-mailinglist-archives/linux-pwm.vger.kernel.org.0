Return-Path: <linux-pwm+bounces-3850-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5009AF9F1
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 08:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF711C21B11
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 06:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E6A19A297;
	Fri, 25 Oct 2024 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz1HAba6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F54436A;
	Fri, 25 Oct 2024 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837771; cv=none; b=QyMY5YbR24KG8TISMQ4QOnFWphGOkQm92r7sRCiaaKcsatWuQfX0muVq6OvuoRmp9A9G60wLsB8rFv/ZQpz4o1Tsw9gxDlLrEQkfjIjzsRSeKCJKLaIdOYeObi4hg6xrnHvOMR43vBppYShbBc0pSAQRjfxNgqp1teaDtSWRYck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837771; c=relaxed/simple;
	bh=+XahwEo3QmX+6o02dYWVxQaY93fMwzTYeg7GdldkdOw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aC/DAvJDVsLNxWJg7AJcgNQm2jzWDN7nwwnGCgJ8P1JZNypCkOHvVGPEhg3vtMCmuUWV+vhXjKekztsZSLnWWpsQNKAs00ew9I9L/zRKBRnRrW7RRu26lNfQ+mwkrUMVbDdFlg+HjK+jC3p3nQz14LzbDYvZAeC6OleWQBznIJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz1HAba6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cb6b2b7127so2035009a12.1;
        Thu, 24 Oct 2024 23:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729837765; x=1730442565; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B1LmMY9VF83ON1MEVw29i3xkyJ5S9+Q5AomoQOw126k=;
        b=bz1HAba6gkOjQ4fGHW9b75bTee8tCvbUsuQAfZsiWs6pJMO1ZIgA/F56h2UNqksqsV
         BMudfdnYIti41CmHDCTcJskGWDxTzMx0LfX+3fYIEwYC9AT40VfpKycWGIkVCRzqI3IA
         TDa478eWZmc4ZhQwTyeBkc7V62C5CwgguRAfKPU0wcJX/tKYornuRPkwLS2386Uy4Q/C
         0JCigyEqD7LrDxOG4dlcht+A42G/txJqcC5G+ooRGcCeKgkZtyTyblmL8K7/LP11d8lJ
         Bx19WHn7a+6HLZfUCMAkTwshJW/Kej5V02uaJy6i5sGQ7BoMM985897GNYUp9EycuIA4
         wJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729837765; x=1730442565;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1LmMY9VF83ON1MEVw29i3xkyJ5S9+Q5AomoQOw126k=;
        b=anOhYVx27VAmvKQ/XeUGndBSkF5EGiNfgJAeNwPFreKz79qCgjgUoZMvyqpqPfkJ7h
         +ArCVOjRef7LetLZjeTRdlPGst0vARf9w74Oxa9TB590jeQ/Ujskq4gwYk21odsSG/eJ
         n445pqrXTakhS4BOqc/80cm7ZwGA0DLHMOJ1sEcUwu4OusW6u4Z3hpWHJSxQoG/pSKUP
         TncFRutSAMLKTIAaHboRaB9Bci7O9Jk3noedxjlVKi05G3E5gxGmvxwp+R5vsmW4gD+Q
         L5ZL1IRfV74noXKVuj4ty+x7kF+tnlwrHU4IdtnU3mgmuT1LEFBlNLxIT87stw5Qp1l/
         a8dA==
X-Forwarded-Encrypted: i=1; AJvYcCUdKm/+0+nbqRUSKK8+3iSw+yEegyv9H2gHmRNGtJhDeE0VtNdeAhv7UHprtrUU3/UvuZx8UPW0arxL@vger.kernel.org, AJvYcCUzXCQGKlKSGutLnCfuM8ZZP8lbo0n6gkRvbE0yrphTcolxmLPloz+EF1tI76Q2e/c1Pz5kmaqSdfP7@vger.kernel.org, AJvYcCVADQ1AqQHC+7xA5fLQ30ZhMoBxP+cWPKawxwVpHB8WbNP5CcUr5hch+lBdvksGBvIgxrA8U2nNSePJ@vger.kernel.org, AJvYcCXMNvhFUVorxYD3gqPTSo3L34gDw0XOfV03Ojs7y2KyzVyMamG+f2HRYhV1yhOUeXxvjgLaXNwvlxfgS53U@vger.kernel.org, AJvYcCXkdZoaDOwmLdiPne7GcFZr9vLfcCxAZZi4QFjyGcvD0yqnAOCQQS7ktQcEZ7RW49EiINqzGCU/LIq+@vger.kernel.org
X-Gm-Message-State: AOJu0YxITWk91T5iOf4c0TY4XqFy6pDK/1jXLvun5ZeOkU7ufTSj/Jgv
	RecgpSOLVEZR5WMH3xGytONqRJhvx80M6MZd2IDKbkPCqTjzBexL
X-Google-Smtp-Source: AGHT+IHdBjFJy8whlH5uXwInL5O8VcnvN0wo2fl1irS12tPY4Ac3qsdQ41G7Boc0gW6PVx5vwe8dNw==
X-Received: by 2002:a17:907:2cc7:b0:a99:da6c:f607 with SMTP id a640c23a62f3a-a9abf92f857mr760072766b.44.1729837764442;
        Thu, 24 Oct 2024 23:29:24 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f298df1sm31562866b.135.2024.10.24.23.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:29:24 -0700 (PDT)
Message-ID: <1715db810c98d5e8acc01d8348603c2426a4df4e.camel@gmail.com>
Subject: Re: [PATCH RFC v4 03/15] spi: offload: add support for hardware
 triggers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Fri, 25 Oct 2024 08:29:23 +0200
In-Reply-To: <9d801823-aa90-4b15-9dbb-9da6ad2cb3e4@baylibre.com>
References: 
	<20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	 <20241023-dlech-mainline-spi-engine-offload-2-v4-3-f8125b99f5a1@baylibre.com>
	 <9762d3f3d3a2e5fbe5e5041cbdc928a9ab24e40b.camel@gmail.com>
	 <9d801823-aa90-4b15-9dbb-9da6ad2cb3e4@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-24 at 10:02 -0500, David Lechner wrote:
> On 10/24/24 9:04 AM, Nuno S=C3=A1 wrote:
> > On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
> > > Extend SPI offloading to support hardware triggers.
> > >=20
> > > This allows an arbitrary hardware trigger to be used to start a SPI
> > > transfer that was previously set up with spi_optimize_message().
> > >=20
> > > A new struct spi_offload_trigger is introduced that can be used to
> > > configure any type of trigger. It has a type discriminator and a unio=
n
> > > to allow it to be extended in the future. Two trigger types are defin=
ed
> > > to start with. One is a trigger that indicates that the SPI periphera=
l
> > > is ready to read or write data. The other is a periodic trigger to
> > > repeat a SPI message at a fixed rate.
> > >=20
> > > There is also a spi_offload_hw_trigger_validate() function that works
> > > similar to clk_round_rate(). It basically asks the question of if we
> > > enabled the hardware trigger what would the actual parameters be. Thi=
s
> > > can be used to test if the requested trigger type is actually support=
ed
> > > by the hardware and for periodic triggers, it can be used to find the
> > > actual rate that the hardware is capable of.
> > >=20
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > >=20
> > > In previous versions, we locked the SPI bus when the hardware trigger
> > > was enabled, but we found this to be too restrictive. In one use case=
,
> > > to avoid a race condition, we need to enable the SPI offload via a
> > > hardware trigger, then write a SPI message to the peripheral to place
> > > it into a mode that will generate the trigger. If we did it the other
> > > way around, we could miss the first trigger.
> > >=20
> > > Another likely use case will be enabling two offloads/triggers at one
> > > time on the same device, e.g. a read trigger and a write trigger. So
> > > the exclusive bus lock for a single trigger would be too restrictive =
in
> > > this case too.
> > >=20
> > > So for now, I'm going with Nuno's suggestion to leave any locking up =
to
> > > the individual controller driver. If we do find we need something mor=
e
> > > generic in the future, we could add a new spi_bus_lock_exclusive() AP=
I
> > > that causes spi_bus_lock() to fail instead of waiting and add "locked=
"
> > > versions of trigger enable functions. This would allow a peripheral t=
o
> > > claim exclusive use of the bus indefinitely while still being able to
> > > do any SPI messaging that it needs.
> > >=20
> > > v4 changes:
> > > * Added new struct spi_offload_trigger that is a generic struct for a=
ny
> > > =C2=A0 hardware trigger rather than returning a struct clk.
> > > * Added new spi_offload_hw_trigger_validate() function.
> > > * Dropped extra locking since it was too restrictive.
> > >=20
> > > v3 changes:
> > > * renamed enable/disable functions to spi_offload_hw_trigger_*mode*_.=
..
> > > * added spi_offload_hw_trigger_get_clk() function
> > > * fixed missing EXPORT_SYMBOL_GPL
> > >=20
> > > v2 changes:
> > > * This is split out from "spi: add core support for controllers with
> > > =C2=A0 offload capabilities".
> > > * Added locking for offload trigger to claim exclusive use of the SPI
> > > =C2=A0 bus.
> > > ---
> > > =C2=A0drivers/spi/spi-offload.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 266 ++++++++++++++++++++++++++++++++++++++++
> > > =C2=A0include/linux/spi/spi-offload.h |=C2=A0 78 ++++++++++++
> > > =C2=A02 files changed, 344 insertions(+)
> > >=20
> > > diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> > > index c344cbf50bdb..2a1f9587f27a 100644
> > > --- a/drivers/spi/spi-offload.c
> > > +++ b/drivers/spi/spi-offload.c
> > > @@ -9,12 +9,26 @@
> > > =C2=A0#include <linux/cleanup.h>
> > > =C2=A0#include <linux/device.h>
> > > =C2=A0#include <linux/export.h>
> > > +#include <linux/list.h>
> > > =C2=A0#include <linux/mutex.h>
> > > +#include <linux/of.h>
> > > =C2=A0#include <linux/property.h>
> > > =C2=A0#include <linux/spi/spi-offload.h>
> > > =C2=A0#include <linux/spi/spi.h>
> > > =C2=A0#include <linux/types.h>
> > > =C2=A0
> > > +struct spi_offload_trigger {
> > > +	struct list_head list;
> > > +	struct device dev;
> > > +	/* synchronizes calling ops and driver registration */
> > > +	struct mutex lock;
> > > +	const struct spi_offload_trigger_ops *ops;
> > > +	void *priv;
> > > +};
> > > +
> > > +static LIST_HEAD(spi_offload_triggers);
> > > +static DEFINE_MUTEX(spi_offload_triggers_lock);
> > > +
> > > =C2=A0/**
> > > =C2=A0 * devm_spi_offload_alloc() - Allocate offload instances
> > > =C2=A0 * @dev: Device for devm purposes
> > > @@ -102,3 +116,255 @@ struct spi_offload *devm_spi_offload_get(struct=
 device
> > > *dev,
> > > =C2=A0	return offload;
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_GPL(devm_spi_offload_get);
> > > +
> > > +static void spi_offload_trigger_release(void *data)
> > > +{
> > > +	struct spi_offload_trigger *trigger =3D data;
> > > +
> > > +	guard(mutex)(&trigger->lock);
> > > +	if (trigger->priv && trigger->ops->release)
> > > +		trigger->ops->release(trigger->priv);
> > > +
> > > +	put_device(&trigger->dev);
> > > +}
> > > +
> > > +struct spi_offload_trigger
> > > +*devm_spi_offload_trigger_get(struct device *dev,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_offload *offload,
> > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum spi_offload_trigger_type type=
)
> > > +{
> > > +	struct spi_offload_trigger *trigger;
> > > +	struct fwnode_reference_args args;
> > > +	bool match =3D false;
> > > +	int ret;
> > > +
> > > +	ret =3D fwnode_property_get_reference_args(dev_fwnode(offload-
> > > > provider_dev),
> > > +						 "trigger-sources",
> > > +						 "#trigger-source-cells", 0,
> > > 0,
> > > +						 &args);
> > > +	if (ret)
> > > +		return ERR_PTR(ret);
> > > +
> > > +	struct fwnode_handle *trigger_fwnode __free(fwnode_handle) =3D
> > > args.fwnode;
> > > +
> > > +	guard(mutex)(&spi_offload_triggers_lock);
> > > +
> > > +	list_for_each_entry(trigger, &spi_offload_triggers, list) {
> > > +		if (trigger->dev.fwnode !=3D args.fwnode)
> > > +			continue;
> > > +
> > > +		match =3D trigger->ops->match(trigger->priv, type, args.args,
> > > args.nargs);
> > > +		if (match)
> > > +			break;
> > > +	}
> > > +
> > > +	if (!match)
> > > +		return ERR_PTR(-EPROBE_DEFER);
> > > +
> > > +	guard(mutex)(&trigger->lock);
> > > +
> > > +	if (!trigger->priv)
> > > +		return ERR_PTR(-ENODEV);
> >=20
> > This is a bit odd tbh. Not a real deal breaker for me but the typical p=
attern I
> > would
> > expect is for methods of the trigger to get a struct spi_offload_trigge=
r opaque
> > pointer. Then we provide a get_private kind of API for the private data=
. I guess
> > you
> > want to avoid that but IMO it makes for neater API instead of getting v=
oid
> > pointers.
>=20
> I was just trying to save a step of an extra call to get *priv
> in each callback implementation, but yeah, no problem to change
> it to something more "normal" looking.

Yeah, I figured that but I guess any of these paths are fastpaths anyways..=
.=20
>=20
> >=20
> > Another thing is, can the above actually happen? We have the
> > spi_offload_triggers_lock grabbed and we got a match so the trigger sho=
uld not be
> > able to go away (should block on the same lock).
>=20
> The problem is that it could have gone away before we took the lock.
>=20
> It could happen like this:
>=20
> * Trigger driver registers trigger - sets *priv.
> * SPI peripheral driver gets reference to trigger.
> * Trigger driver unregisters trigger - removes *priv.
> * SPI peripheral tries to call trigger function.
>=20

Ah I see... we're using scoped_guard() in the unregister path.

- Nuno S=C3=A1
>=20


