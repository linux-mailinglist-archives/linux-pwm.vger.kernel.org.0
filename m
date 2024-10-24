Return-Path: <linux-pwm+bounces-3825-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD1D9AE720
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 16:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F6E282DFB
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 14:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78011D9A72;
	Thu, 24 Oct 2024 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jahAGJc0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BAE24B28;
	Thu, 24 Oct 2024 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778661; cv=none; b=BP4il2cOnWol7VLy/bKpZZUBEE4hfuoyT2GgGay09ZRep4/IF3dmz/VhMSgEgjl1TyvWF/VkffanbERVGq2Awwc3aaZEoIzEHSz4nnJIcfcL9uOVmZMvEYtWZzOdOI5IwnldKop2NAKAbYAoxUxD0gMrroadze3QwtgZHxmqHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778661; c=relaxed/simple;
	bh=MKKxgjhlIAvEPf1RqfNwMN9PSwOKdDK9i7QX48sQFAk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V/siX9XDY3BYxrCzC+NnwvKGZp/fNi2/MDwjKz3pf2TNPLpLg4y24vZL0MB3DCOE+5Ei40iOr3nQFNpHUI+tD+2VwyE1gHtCTRnkHLNLPx5S+7cFpWsCvWZK4aHFvUxQlLyJ++QaOfkG87NAe7Ok7MUVcIdm9/YpbrCFD4YHwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jahAGJc0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so139104166b.0;
        Thu, 24 Oct 2024 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729778657; x=1730383457; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TIXIN1+TP3w9ElAArKoeOcSoLCwRyX7h32R4b6WdAXM=;
        b=jahAGJc0Kp4KKhLtRcMmBl6FQVO9F3Y6B20UMQzPuFmJl285PIqmwlTTj9xCghuQ8S
         BEUyz6d1/CehHSDWFZBIkMvOvTVAbpMLD8wWuRXetUV8qNYEgU780QyvSi+RrwjOXKye
         4oxJGfIb6xCcwkx5i5qyJFnO6WHVtN6xiw3KEGfMrd+FSiTjYk6gNzLbXTtWMUcg1r6X
         yKj7mSMfm0IrsZTh9pBEju5+hl/1KCTtJ46OeKNztIQEoGGUF6WBnd+SNYe9acR8hWlG
         rcDuYlLDSGA4Jm+CjeuMA0MwEkIsxAGNWBvuxgtUaxPh2RT2LpkeCgfyVksNvNxknk3z
         H5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729778657; x=1730383457;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TIXIN1+TP3w9ElAArKoeOcSoLCwRyX7h32R4b6WdAXM=;
        b=MUxx0b8OHB7lczptwrnHtGUXfG8/6v77AEAUGo0n8bQN//dGqI0taBBI5fnbJQF4a/
         5VnMjYEthud0B06JEhhLuCXfJaalY+sehzgEqtIrOg8gLYRfUSusVgRmBp5uEbVE5HXe
         0MfD7VfxjcO7cxArmc3cDV5qCGsQFB6xaDx9irigahxyRV6MyvvypfnBR1NENxuhlROb
         VYvNIMsBcfW1O22koeY9Lz2WEKhJUijr8coHDNs6FqeJLyExaeUx+DxI8TV+iKJwHYnh
         fN9/HYFhl9U4NqLk0DRR8++D/IFzh4rTp+wzY5gA1HfGY04IhIFFsFD9CZF2oycxW43e
         ma5g==
X-Forwarded-Encrypted: i=1; AJvYcCUf5XuF8NdQ0Wr/Wt/hfADBLijZeYwTZJDJ37zpT3FYv7tU6mZLI8WtYdp2fTsbhH4+QebhfDwy8idt8bhv@vger.kernel.org, AJvYcCUtnWdNGB6UMPf/y5uF0bfMRaa2aG3BYIbRNyCpwKHSE0agaMM0kqhChwoQligsMXj3B67ET9xo9BXz@vger.kernel.org, AJvYcCUyxLqYEloz0qoWpM44No9WSN82it2KYzRZl+BHGcBsc3p4rxl6zHx2YlBkjtYR2yGM01pyZwH1b8E6@vger.kernel.org, AJvYcCXPU/0scs0QmbStAKJPJsn1k3WGpzNeMvCzfDezmF+oyKqxdlBo1VSuIld03xaEsCg+uDkzgE+EFULM@vger.kernel.org, AJvYcCXmD0B5Rps09jZ0CAnxQrg+3PlXO6KWfpY+rJaH+jUIa1kpOoooOMTQ5V/SDATXutIPfLRggYyuU0wT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxota5JTe2dLcA4g90EmatpEraQGl4Nhg9gqQDqWmYmWoKk/pU8
	jwGypo4UXAf56dbehGj1vrqtiF0jGHHWOFf55qsVcTPvjMmKlDuQ
X-Google-Smtp-Source: AGHT+IFAH1SQUcmJIaJ2QKy7QEw783CHJUohMB1jGAnkB1Nhys0qaAikcw9JtnLzUDJkYZkzc7/1Fg==
X-Received: by 2002:a17:907:6d0f:b0:a99:f283:8147 with SMTP id a640c23a62f3a-a9ad275880emr150745466b.27.1729778655994;
        Thu, 24 Oct 2024 07:04:15 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a915a1133sm620237966b.220.2024.10.24.07.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 07:04:15 -0700 (PDT)
Message-ID: <9762d3f3d3a2e5fbe5e5041cbdc928a9ab24e40b.camel@gmail.com>
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
Date: Thu, 24 Oct 2024 16:04:14 +0200
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-3-f8125b99f5a1@baylibre.com>
References: 
	<20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	 <20241023-dlech-mainline-spi-engine-offload-2-v4-3-f8125b99f5a1@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
> Extend SPI offloading to support hardware triggers.
>=20
> This allows an arbitrary hardware trigger to be used to start a SPI
> transfer that was previously set up with spi_optimize_message().
>=20
> A new struct spi_offload_trigger is introduced that can be used to
> configure any type of trigger. It has a type discriminator and a union
> to allow it to be extended in the future. Two trigger types are defined
> to start with. One is a trigger that indicates that the SPI peripheral
> is ready to read or write data. The other is a periodic trigger to
> repeat a SPI message at a fixed rate.
>=20
> There is also a spi_offload_hw_trigger_validate() function that works
> similar to clk_round_rate(). It basically asks the question of if we
> enabled the hardware trigger what would the actual parameters be. This
> can be used to test if the requested trigger type is actually supported
> by the hardware and for periodic triggers, it can be used to find the
> actual rate that the hardware is capable of.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> In previous versions, we locked the SPI bus when the hardware trigger
> was enabled, but we found this to be too restrictive. In one use case,
> to avoid a race condition, we need to enable the SPI offload via a
> hardware trigger, then write a SPI message to the peripheral to place
> it into a mode that will generate the trigger. If we did it the other
> way around, we could miss the first trigger.
>=20
> Another likely use case will be enabling two offloads/triggers at one
> time on the same device, e.g. a read trigger and a write trigger. So
> the exclusive bus lock for a single trigger would be too restrictive in
> this case too.
>=20
> So for now, I'm going with Nuno's suggestion to leave any locking up to
> the individual controller driver. If we do find we need something more
> generic in the future, we could add a new spi_bus_lock_exclusive() API
> that causes spi_bus_lock() to fail instead of waiting and add "locked"
> versions of trigger enable functions. This would allow a peripheral to
> claim exclusive use of the bus indefinitely while still being able to
> do any SPI messaging that it needs.
>=20
> v4 changes:
> * Added new struct spi_offload_trigger that is a generic struct for any
> =C2=A0 hardware trigger rather than returning a struct clk.
> * Added new spi_offload_hw_trigger_validate() function.
> * Dropped extra locking since it was too restrictive.
>=20
> v3 changes:
> * renamed enable/disable functions to spi_offload_hw_trigger_*mode*_...
> * added spi_offload_hw_trigger_get_clk() function
> * fixed missing EXPORT_SYMBOL_GPL
>=20
> v2 changes:
> * This is split out from "spi: add core support for controllers with
> =C2=A0 offload capabilities".
> * Added locking for offload trigger to claim exclusive use of the SPI
> =C2=A0 bus.
> ---
> =C2=A0drivers/spi/spi-offload.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 266=
 ++++++++++++++++++++++++++++++++++++++++
> =C2=A0include/linux/spi/spi-offload.h |=C2=A0 78 ++++++++++++
> =C2=A02 files changed, 344 insertions(+)
>=20
> diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> index c344cbf50bdb..2a1f9587f27a 100644
> --- a/drivers/spi/spi-offload.c
> +++ b/drivers/spi/spi-offload.c
> @@ -9,12 +9,26 @@
> =C2=A0#include <linux/cleanup.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/export.h>
> +#include <linux/list.h>
> =C2=A0#include <linux/mutex.h>
> +#include <linux/of.h>
> =C2=A0#include <linux/property.h>
> =C2=A0#include <linux/spi/spi-offload.h>
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0#include <linux/types.h>
> =C2=A0
> +struct spi_offload_trigger {
> +	struct list_head list;
> +	struct device dev;
> +	/* synchronizes calling ops and driver registration */
> +	struct mutex lock;
> +	const struct spi_offload_trigger_ops *ops;
> +	void *priv;
> +};
> +
> +static LIST_HEAD(spi_offload_triggers);
> +static DEFINE_MUTEX(spi_offload_triggers_lock);
> +
> =C2=A0/**
> =C2=A0 * devm_spi_offload_alloc() - Allocate offload instances
> =C2=A0 * @dev: Device for devm purposes
> @@ -102,3 +116,255 @@ struct spi_offload *devm_spi_offload_get(struct dev=
ice *dev,
> =C2=A0	return offload;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(devm_spi_offload_get);
> +
> +static void spi_offload_trigger_release(void *data)
> +{
> +	struct spi_offload_trigger *trigger =3D data;
> +
> +	guard(mutex)(&trigger->lock);
> +	if (trigger->priv && trigger->ops->release)
> +		trigger->ops->release(trigger->priv);
> +
> +	put_device(&trigger->dev);
> +}
> +
> +struct spi_offload_trigger
> +*devm_spi_offload_trigger_get(struct device *dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_offload *offload,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum spi_offload_trigger_type type)
> +{
> +	struct spi_offload_trigger *trigger;
> +	struct fwnode_reference_args args;
> +	bool match =3D false;
> +	int ret;
> +
> +	ret =3D fwnode_property_get_reference_args(dev_fwnode(offload-
> >provider_dev),
> +						 "trigger-sources",
> +						 "#trigger-source-cells", 0, 0,
> +						 &args);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	struct fwnode_handle *trigger_fwnode __free(fwnode_handle) =3D args.fwn=
ode;
> +
> +	guard(mutex)(&spi_offload_triggers_lock);
> +
> +	list_for_each_entry(trigger, &spi_offload_triggers, list) {
> +		if (trigger->dev.fwnode !=3D args.fwnode)
> +			continue;
> +
> +		match =3D trigger->ops->match(trigger->priv, type, args.args,
> args.nargs);
> +		if (match)
> +			break;
> +	}
> +
> +	if (!match)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	guard(mutex)(&trigger->lock);
> +
> +	if (!trigger->priv)
> +		return ERR_PTR(-ENODEV);

This is a bit odd tbh. Not a real deal breaker for me but the typical patte=
rn I would
expect is for methods of the trigger to get a struct spi_offload_trigger op=
aque
pointer. Then we provide a get_private kind of API for the private data. I =
guess you
want to avoid that but IMO it makes for neater API instead of getting void =
pointers.

Another thing is, can the above actually happen? We have the
spi_offload_triggers_lock grabbed and we got a match so the trigger should =
not be
able to go away (should block on the same lock).

> +
> +	if (trigger->ops->request) {
> +		ret =3D trigger->ops->request(trigger->priv, type, args.args,
> args.nargs);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	get_device(&trigger->dev);

try_module_get() would also make sense...

...

>=20
> +struct spi_offload_trigger
> +*devm_spi_offload_trigger_alloc(struct device *dev,
> +				struct spi_offload_trigger_info *info)
> +{
> +	struct spi_offload_trigger *trigger;
> +	int ret;
> +
> +	trigger =3D kzalloc(sizeof(*trigger), GFP_KERNEL);
> +	if (!trigger)
> +		return ERR_PTR(-ENOMEM);
> +
> +	device_initialize(&trigger->dev);

Do we really need the full struct device and the overhead of adding it to t=
he driver
core? AFAICT, we're using it only for refcouting so we could use a plain kr=
ef for
that matter. It would make things simpler. Or do you envision an future use=
case as
this might matter? Like allowing userspace to set some controls on the trig=
ger (I
would expect to be done through consumers though)?

> +	trigger->dev.parent =3D info->parent;
> +	trigger->dev.fwnode =3D info->fwnode;
> +	trigger->dev.of_node =3D of_node_get(to_of_node(trigger->dev.fwnode));
> +	trigger->dev.of_node_reused =3D true;
> +	trigger->dev.release =3D spi_offload_trigger_dev_release;
> +
> +	mutex_init(&trigger->lock);
> +	trigger->ops =3D info->ops;
> +
> +	ret =3D devm_add_action_or_reset(dev, spi_offload_trigger_put, trigger)=
;
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ret =3D dev_set_name(&trigger->dev, "%s-%d", info->name, info->id);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return trigger;
> +}
> +EXPORT_SYMBOL_GPL(devm_spi_offload_trigger_alloc);
> +
> +static void spi_offload_trigger_unregister(void *data)
> +{
> +	struct spi_offload_trigger *trigger =3D data;
> +
> +	scoped_guard(mutex, &spi_offload_triggers_lock)
> +		list_del(&trigger->list);
> +
> +	guard(mutex)(&trigger->lock);
> +	trigger->priv =3D NULL;

nit: I guess this is a good as anything else but *ops could also be a good =
fit to
nullify :)

> +	device_del(&trigger->dev);
> +}
> +
> +int devm_spi_offload_trigger_register(struct device *dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_offload_trigger *trigger,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *priv)
> +{
> +	int ret;
> +
> +	ret =3D device_add(&trigger->dev);
> +	if (ret)
> +		return ret;
> +
> +	trigger->priv =3D priv;
> +
> +	guard(mutex)(&spi_offload_triggers_lock);
> +	list_add_tail(&trigger->list, &spi_offload_triggers);
> +
> +	ret =3D devm_add_action_or_reset(dev, spi_offload_trigger_unregister,
> trigger);
> +	if (ret)
> +		return ret;
>=20

return devm_add_action_or_reset()?

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_spi_offload_trigger_register);
> diff --git a/include/linux/spi/spi-offload.h b/include/linux/spi/spi-offl=
oad.h
> index 92a557533b83..561cc1fb6f35 100644
> --- a/include/linux/spi/spi-offload.h
> +++ b/include/linux/spi/spi-offload.h
> @@ -22,6 +22,7 @@
> =C2=A0MODULE_IMPORT_NS(SPI_OFFLOAD);
> =C2=A0
> =C2=A0struct device;
> +struct fwnode_handle;
> =C2=A0struct spi_device;
> =C2=A0
> =C2=A0/* Offload can be triggered by external hardware event. */
> @@ -53,6 +54,43 @@ struct spi_offload {
> =C2=A0	struct spi_device *spi;
> =C2=A0	/** @priv: provider driver private data */
> =C2=A0	void *priv;
> +	/** @ops: callbacks for offload support */
> +	const struct spi_offload_ops *ops;
> +};
> +
> +enum spi_offload_trigger_type {
> +	/* Indication from SPI peripheral that data is read to read. */
> +	SPI_OFFLOAD_TRIGGER_DATA_READY,
> +	/* Trigger comes from a periodic source such as a clock. */
> +	SPI_OFFLOAD_TRIGGER_PERIODIC,
> +};
> +
> +struct spi_offload_trigger_periodic {
> +	u64 frequency_hz;
> +};
> +
> +struct spi_offload_trigger_config {
> +	/** @type: type discriminator for union */
> +	enum spi_offload_trigger_type type;
> +	union {
> +		struct spi_offload_trigger_periodic periodic;
> +	};
> +};
> +
> +/**
> + * struct spi_offload_ops - callbacks implemented by offload providers
> + */
> +struct spi_offload_ops {
> +	/**
> +	 * @trigger_enable: Optional callback to enable the trigger for the
> +	 * given offload instance.
> +	 */
> +	int (*trigger_enable)(struct spi_offload *offload);
> +	/**
> +	 * @trigger_disable: Optional callback to disable the trigger for the
> +	 * given offload instance.
> +	 */
> +	void (*trigger_disable)(struct spi_offload *offload);
> =C2=A0};
> =C2=A0
> =C2=A0struct spi_offload *devm_spi_offload_alloc(struct device *dev,
> @@ -61,4 +99,44 @@ struct spi_offload *devm_spi_offload_alloc(struct devi=
ce *dev,
> =C2=A0struct spi_offload *devm_spi_offload_get(struct device *dev, struct=
 spi_device
> *spi,
> =C2=A0					 const struct spi_offload_config *config);
> =C2=A0
> +struct spi_offload_trigger
> +*devm_spi_offload_trigger_get(struct device *dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_offload *offload,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum spi_offload_trigger_type type);
> +int spi_offload_trigger_validate(struct spi_offload_trigger *trigger,
> +				 struct spi_offload_trigger_config *config);
> +int spi_offload_trigger_enable(struct spi_offload *offload,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_offload_trigger *trig=
ger,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_offload_trigger_confi=
g *config);
> +void spi_offload_trigger_disable(struct spi_offload *offload,
> +				 struct spi_offload_trigger *trigger);
> +
> +/* Trigger providers */
> +
> +struct spi_offload_trigger;
> +
> +struct spi_offload_trigger_ops {
> +	bool (*match)(void *priv, enum spi_offload_trigger_type type, u64 *args=
,
> u32 nargs);
> +	int (*request)(void *priv, enum spi_offload_trigger_type type, u64 *arg=
s,
> u32 nargs);
> +	void (*release)(void *priv);
> +	int (*validate)(void *priv, struct spi_offload_trigger_config *config);
> +	int (*enable)(void *priv, struct spi_offload_trigger_config *config);
> +	void (*disable)(void *priv);
> +};

Yeah, as I said... not a fan of the void *priv thing

- Nuno S=C3=A1


