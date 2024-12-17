Return-Path: <linux-pwm+bounces-4361-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CFA9F49C5
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 12:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00E81667A1
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 11:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEDB1EBFE1;
	Tue, 17 Dec 2024 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8BPrwD3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B9F50276;
	Tue, 17 Dec 2024 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434770; cv=none; b=BuJL0EjtzeyznV+5vCSwGOMaMOnlFLi59qjPGQ1JX5QTdHq4n84nX97Q3529fh7AXFo8fM0F1bYPIl4OAL64VE8bA3YxMWFm1zQwBbnFTRgNgI9644XPop5ck6AulJgdbzrAeu+kacAQoFA/FHmhEkU4D87peuiWmJLmyw7ELYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434770; c=relaxed/simple;
	bh=1EO9YtKGid6Z+Vz3j+sWcAxZquFKHmYAwSTPvy4C9cY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yj3C9GrioQWXH4hYO+HrZcctiRUPl6/+fPVb7qMmZjrA+hZAHnUkYyOi2YUaFJ5RTNJpW6cp7x5GXVSpP7y+dWCoXryDOpH9QeEGbraieVrqrb5rTWB/c3s2nBxoDxyaEo+auEVuJ/Zh6VRjWQoRvwlnFLrRnA0Remy45Op5ty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8BPrwD3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso726520266b.2;
        Tue, 17 Dec 2024 03:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734434767; x=1735039567; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T5Cj0ct81l3Dm35lHnAswcwIvDciNyrYMREfJHBYsrg=;
        b=N8BPrwD32Se+PhW9s81HxrNEY1X/cvrsfg115pNzwO+E6yn7ToE7kSxeZOo2xzg/4g
         vNHUffGN9QhhIofCStUBvNYRnfnhpVbz/SzspgkPY4K9PXl+PZ/kvkdvCpi81X4UHkid
         ThhF9nenZARYiCnBkV0eGIefaFypEVLZfBq2XmuAfCc62jhW+7UYVO7y4a9rxQtE8wCZ
         Zfaa9of/84z1avoggiWXJeCcD448h5A9al1gcXC7ZHaBsZjwMn3ExjntwGGeSbvHQtrd
         gNCJO6fpQ0S3L+ClBFuHFk+rfLuxGS5S00niz52dlrPalknwXwBm99baxy8wqfpBNicI
         11ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734434767; x=1735039567;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5Cj0ct81l3Dm35lHnAswcwIvDciNyrYMREfJHBYsrg=;
        b=Eu2JjqsPKZXoEsGMW8y/inzOFOXwTz+Gu9jx4ZdXq/LshEupf0L4zI/3e8vPS65mRt
         qn1OG2kdiyChY2xr7Q9ipQRMcePSyxntNAeGAQhXJ5mCS7/WZM1K5yO9jusv0iW+Q1So
         CJ/l3DWkGG6Mo78vcuY0zQhY9PiPZjhxda0P/jtJmHeA3uyqglQNwpydj1Rjr/rhUsvz
         QXawkBAQZowziKWyMCsUBZ3lGuN4/kZ5NxJ7pM/S+luFbr+9FYlE4fFOs00sq1BWl3+8
         r4FeVPaxX+zRj6nyQaP8/MP6JnVGcLU7rRsPDtfvrlp2fF4NcUmJLzfVakVOjLukFcG3
         Fwgg==
X-Forwarded-Encrypted: i=1; AJvYcCUxVmKoXf15bYdupRokI2hUIJtIUgg13Sbjzg+6oHFRefNAxDfnIVD8R1FARWNmo026CkRH5DHg+yfyExR8@vger.kernel.org, AJvYcCVDpV6yP7ai3uOZksSwzlA4aeuvAOJcMxqCJO/tI8BjIHxNlx4Iuo6MlYMYOEbkNmhwu8zTsOX21KXP@vger.kernel.org, AJvYcCVhvamK7LAfxWqD6eEdhlHS0Nj0NHC+t1pGplVt02FwjQwkyu6k5Z/kwyW6Pm2nRFMuyB9KiVfY1vdd@vger.kernel.org, AJvYcCWiFkEbRH0Kiq52ObPfaX6YrzZvkvGCOLN+r4mS3+VL1/owlZHbFReh2Lvt9bjOJAeEY4UWnZjefurS@vger.kernel.org, AJvYcCXhXRib5sx+u1bc46fZ/8FzLCoTMcj7PItFUPPyivJ6G5M6/AluCTsdOzGkLSIvH77mqasAMAZpKPPi@vger.kernel.org
X-Gm-Message-State: AOJu0YwMoYwRQs26bzolU9+hM6L2g/6FfpIEudJnEK31CDarwLpBvH5X
	t0u+t4xd0xyutNy6uWikUeA4+SPKSZvLvZHd2PjAmo5ETxZuvEFo
X-Gm-Gg: ASbGncv9HW89y0Ya5G5RAw0cs+vIQ0BHDvGSEgEWNHLSycKP323gXsnAFyn3dd/uVDN
	l2R2bzbuiY/GwA1u1BL2bAexuOf8S0LVKGZ6OKnPsF0/GL6iRn5gfpTclAtVH5rJ2QJTCRsovq5
	cpA3vy75WIQMJhlzA/DwjiVBnOE55SzY2kSXYmektNELaHLQk4cJQl9R+lTveHvrH02Z+SgRvzx
	Lgbdh9GMEQ9Dt9z936UgSFjaDYev+uiwDFMLeqPIkpv6HJonV4p6dNL0w6f9hiz4J4qDORUOM0H
	dl7GXOIWSZ/wnwbwlQ7HTLewttpcqmAdnQ7f2YMxTcQRduyGMf7+KDrdK0R3ZEMpEYePbbMmnf2
	c1ZD9b1VCgGlydA==
X-Google-Smtp-Source: AGHT+IGeJysPicSr5wfxVTnoBXhJZ9XckK3QDyAJM8olyjlPY4MNt76VjZ7vzE5pDV/2/kuwEsR13g==
X-Received: by 2002:a17:907:2d9f:b0:aa6:81dc:6635 with SMTP id a640c23a62f3a-aab77907995mr1530863366b.18.1734434766710;
        Tue, 17 Dec 2024 03:26:06 -0800 (PST)
Received: from ?IPv6:2003:f6:ef10:f100:a045:a7a7:11d0:8676? (p200300f6ef10f100a045a7a711d08676.dip0.t-ipconnect.de. [2003:f6:ef10:f100:a045:a7a7:11d0:8676])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96391366sm434480666b.167.2024.12.17.03.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:26:06 -0800 (PST)
Message-ID: <225da1bc0f0b9407c3f7b3374cbbbf6cc6b43aa6.camel@gmail.com>
Subject: Re: [PATCH v6 02/17] spi: offload: add support for hardware triggers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, David Jander	 <david@protonic.nl>, Martin Sperl
 <kernel@martin.sperl.org>, 	linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-pwm@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Tue, 17 Dec 2024 12:30:37 +0100
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-2-88ee574d5d03@baylibre.com>
References: 
	<20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
	 <20241211-dlech-mainline-spi-engine-offload-2-v6-2-88ee574d5d03@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-11 at 14:54 -0600, David Lechner wrote:
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
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20

One minor comment (and another suggestion) inline...

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> v6 changes:
> * Updated for header file split.
>=20
> v5 changes:
> * Use struct kref instead of struct dev for trigger lifetime management.
> * Don't use __free() for args.fwnode.
> * Pass *trigger instead of *priv to all callbacks.
> * Add new *spi_offload_trigger_get_priv() function.
> * Use ops instead of priv for "provider is gone" flag.
> * Combine devm_spi_offload_trigger_alloc() and
> =C2=A0 devm_spi_offload_trigger_register() into one function.
> * Add kernel-doc comments for public functions.
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
> =C2=A0drivers/spi/spi-offload.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 281
> +++++++++++++++++++++++++++++++++++
> =C2=A0include/linux/spi/offload/consumer.h |=C2=A0 12 ++
> =C2=A0include/linux/spi/offload/provider.h |=C2=A0 28 ++++
> =C2=A0include/linux/spi/offload/types.h=C2=A0=C2=A0=C2=A0 |=C2=A0 37 ++++=
+
> =C2=A04 files changed, 358 insertions(+)
>=20
> diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> index
> 3a40ef30debf09c6fd7b2c14526f3e5976e2b21f..43582e50e279c4b1b958765fec556aa=
a9118
> 0e55 100644
> --- a/drivers/spi/spi-offload.c
> +++ b/drivers/spi/spi-offload.c
> @@ -19,7 +19,11 @@
> =C2=A0#include <linux/cleanup.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/export.h>
> +#include <linux/kref.h>
> +#include <linux/list.h>
> =C2=A0#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
> =C2=A0#include <linux/spi/offload/consumer.h>
> =C2=A0#include <linux/spi/offload/provider.h>
> =C2=A0#include <linux/spi/offload/types.h>
> @@ -31,6 +35,23 @@ struct spi_controller_and_offload {
> =C2=A0	struct spi_offload *offload;
> =C2=A0};
> =C2=A0
> +struct spi_offload_trigger {
> +	struct list_head list;
> +	struct kref ref;
> +	struct fwnode_handle *fwnode;
> +	/* synchronizes calling ops and driver registration */
> +	struct mutex lock;
> +	/*
> +	 * If the provider goes away while the consumer still has a
> reference,
> +	 * ops and priv will be set to NULL and all calls will fail with -
> ENODEV.
> +	 */
> +	const struct spi_offload_trigger_ops *ops;
> +	void *priv;
> +};
> +
> +static LIST_HEAD(spi_offload_triggers);
> +static DEFINE_MUTEX(spi_offload_triggers_lock);
> +
> =C2=A0/**
> =C2=A0 * devm_spi_offload_alloc() - Allocate offload instance
> =C2=A0 * @dev: Device for devm purposes and assigned to &struct
> spi_offload.provider_dev
> @@ -112,3 +133,263 @@ struct spi_offload *devm_spi_offload_get(struct dev=
ice
> *dev,
> =C2=A0	return resource->offload;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(devm_spi_offload_get);
> +
> +static void spi_offload_trigger_free(struct kref *ref)
> +{
> +	struct spi_offload_trigger *trigger =3D
> +		container_of(ref, struct spi_offload_trigger, ref);
> +
> +	mutex_destroy(&trigger->lock);
> +	fwnode_handle_put(trigger->fwnode);
> +	kfree(trigger);
> +}
> +
> +static void spi_offload_trigger_put(void *data)
> +{
> +	struct spi_offload_trigger *trigger =3D data;
> +
> +	scoped_guard(mutex, &trigger->lock)
> +		if (trigger->ops && trigger->ops->release)
> +			trigger->ops->release(trigger);
> +
> +	kref_put(&trigger->ref, spi_offload_trigger_free);
> +}
> +
> +static struct spi_offload_trigger
> +*spi_offload_trigger_get(enum spi_offload_trigger_type type,
> +			 struct fwnode_reference_args *args)
> +{
> +	struct spi_offload_trigger *trigger;
> +	bool match =3D false;
> +	int ret;
> +
> +	guard(mutex)(&spi_offload_triggers_lock);
> +
> +	list_for_each_entry(trigger, &spi_offload_triggers, list) {
> +		if (trigger->fwnode !=3D args->fwnode)
> +			continue;
> +
> +		match =3D trigger->ops->match(trigger, type, args->args, args-
> >nargs);
> +		if (match)
> +			break;
> +	}
> +
> +	if (!match)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	guard(mutex)(&trigger->lock);
> +
> +	if (!trigger->ops)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (trigger->ops->request) {
> +		ret =3D trigger->ops->request(trigger, type, args->args, args-
> >nargs);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	kref_get(&trigger->ref);

maybe try_module_get() would also make sense...

> +
> +	return trigger;
> +}
> +
> +/**
> + * devm_spi_offload_trigger_get() - Get an offload trigger instance
> + * @dev: Device for devm purposes.
> + * @offload: Offload instance connected to a trigger.
> + * @type: Trigger type to get.
> + *
> + * Return: Offload trigger instance or error on failure.
> + */
> +struct spi_offload_trigger
> +*devm_spi_offload_trigger_get(struct device *dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_offload *offload,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum spi_offload_trigger_type type)
> +{
> +	struct spi_offload_trigger *trigger;
> +	struct fwnode_reference_args args;
> +	int ret;
> +
> +	ret =3D fwnode_property_get_reference_args(dev_fwnode(offload-
> >provider_dev),
> +						 "trigger-sources",
> +						 "#trigger-source-cells", 0,
> 0,
> +						 &args);

I guess at some point we can add these to fwlinks?

- Nuno S=C3=A1



