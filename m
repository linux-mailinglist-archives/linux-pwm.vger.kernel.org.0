Return-Path: <linux-pwm+bounces-3944-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D29B3232
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 14:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3788B1F22750
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC171DD544;
	Mon, 28 Oct 2024 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfFamqFM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94CD1DCB2D;
	Mon, 28 Oct 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123606; cv=none; b=aChzGxN/Ok+uECa0z/a3XWmN7Pv6xjuayNTUDESt80PDgSVrr9sZt96Wk5prTqTGSPaYzOSavnOBxz0e+TOxVVJk660XVYt8HLgfPl0ssIAmU3bCluOk6IJevGzEqdjmJ5yESuSE3gpeKJJx3yfEid7DAn953MX/bSNhNTyf4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123606; c=relaxed/simple;
	bh=orYoOb0PmFCMKs6zKV3ZspOVuIPZfGmFBRU1NfgSRYY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a9kGZlrmWwrZxQxEe0xVrut0fIkELSOkt+tEu+ruq7I2EhDbdK08GlgGWaZwSHrHEbLcPCXDivoHKxU6qJikxOg1IQVZWG+QmzCp+NIlq7Qnez3GnyhKoN/R9/QeWz6K78CDNf+6w9Az6ard/K/aufKFdJ5FsTCOa60pFcSdyto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfFamqFM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4fd00574so2719307f8f.0;
        Mon, 28 Oct 2024 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730123602; x=1730728402; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UnpS4n/DKmtkwfuiUFj7ITS7TWiEPQaGr/Pr1wLnPKA=;
        b=bfFamqFM+wKUdWX+Hufk58+rqAyZReBMUHuV9dTttXfRrai+YpSsednCdHCFeMBsS5
         CmeFjL1e5RomJmJS59BOlh20Jrv5o2NrmFfC2VVkQNRd0fmgpdmnc9WRJvqYU4SxT6HV
         qxZrvJtmWWUD3LUj43MJJXJoqlFplYPn606pEeUX6KgLHhQ+LxpkcCHkBbo7YqHcBYVN
         V/U3EHmiUqUXaj7V+rHtAWVsVMvPrgxEnbsU7vkMhoEl2vAs/6vGMqlK3LAxHMjZKubW
         7AOXnpMFEHV9l87bv9uRKwAwvb7mE1TVFu5PVJXSb+igtCnKG92Fh2DtlALXCpc0Dsfa
         K/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123602; x=1730728402;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnpS4n/DKmtkwfuiUFj7ITS7TWiEPQaGr/Pr1wLnPKA=;
        b=B7Ma1EkRj1J0mJw+R+61vXJsskuRgIH4Jz2Em2uIPUJ5xHJXn+fPzPBXN1M3QAluGa
         URHRks/yPXMtph6TcjuuhgOOAK6VZPumhUDax6nL6GhI1gOlR4YmThDkFguMDLf3WIIy
         vh5N0ABLab8NgDwAuuWZYZxtbago+jKfve9BmknnzrWqB0SUCjvG14BVKDhBQpHD7dLQ
         DgCi2EyleQ417Rr00uztNnMUOToUePLLVe4gzHIcWHfZoAppvBUuwWYCsdYLgu8mY3jT
         tgCNWgknuXJVahnOhHzo+E7wqIrfVqZ5m5yV5on9tml6ovLBwYVrrJVPIKNk2JQSZ5dM
         QnxA==
X-Forwarded-Encrypted: i=1; AJvYcCUc7qmcZ+TALz1i2ThnOCZVQJvcejLxAQt7Z1WdPuN445U8vtAcekQ/mXwEwf+Va4g65yOoaGd0nZFj@vger.kernel.org, AJvYcCVU2fQI/w8bBJpalBGj9VGX9xyjLLKP9gGZVQHeCBd6Va9Wii9gybXDER7o8G8J83gHKRsBdJTw5u94@vger.kernel.org, AJvYcCVv+UHpzx158dUVmhKOuPAOxTnPk9U/7GLv28oy4kR23oN0zXY2Z4njlAk4Q5OiT8yVoofX7+SR7flH@vger.kernel.org, AJvYcCVylvK+ynoXjsk1sdWyYpGtnw+wP3MhsWarOyYOs6pHIXGMicVRiDglj+gqe/CiZIAEKHZ3uQe2hIkj@vger.kernel.org, AJvYcCXq6AfwKw7f/Il+Ve4aXxu0t7+AhsNZShfixnQ2lt5Cjt7bEo2pky9AVpdfdDUciELT4rWviL11GKn5USRM@vger.kernel.org
X-Gm-Message-State: AOJu0YwQElQ+gpwp3PZICM8O/vnu7iZgkCm0GL63u13FTiThqa9y4cX7
	UbMmX33SfUfyO4qOLbrbwW1bg0i12q1cXMHLTSsbpbefgtGV4jE7
X-Google-Smtp-Source: AGHT+IHkcLZhGy5M/4RIf4rL/dun6wBoqsc3l9UyXwzDGDVkpfbQMVxIX6i4F3wOTvkthzu7Wt0UBQ==
X-Received: by 2002:a5d:434e:0:b0:37d:3780:31d2 with SMTP id ffacd0b85a97d-3803ac49d09mr11052735f8f.15.1730123601903;
        Mon, 28 Oct 2024 06:53:21 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bde6sm9552606f8f.40.2024.10.28.06.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:53:21 -0700 (PDT)
Message-ID: <b24383def7b637d81553b5a806e382f70f84b8c6.camel@gmail.com>
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
Date: Mon, 28 Oct 2024 14:53:20 +0100
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-3-f8125b99f5a1@baylibre.com>
References: 
	<20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	 <20241023-dlech-mainline-spi-engine-offload-2-v4-3-f8125b99f5a1@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
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

device_match_fwnode()

- Nuno S=C3=A1



