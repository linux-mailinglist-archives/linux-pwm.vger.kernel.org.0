Return-Path: <linux-pwm+bounces-3900-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851A99B0A1D
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 18:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F291F216C6
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 16:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B3018C000;
	Fri, 25 Oct 2024 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USzG6PJF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7C71865ED;
	Fri, 25 Oct 2024 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874377; cv=none; b=IxyegiiBh16i1+hDpBwKc3IvLgbu+JqOSm81wY5jwzYduRSL0Y4eDDXkNMKA39Rm5dB6RUerL31gQDmxHT+W2nhSvyi929jVOFRQCeHs0d+fQp805sUR6FdOgd7L6RRLo5p6bNT37fzi6fIrVvyuAZab10xPgz2gVlL3m8IgVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874377; c=relaxed/simple;
	bh=OUERxqQyEYWblfGloFUtJrSp6SgR/w6k0b5sEG86kmQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=iim2OZQdUaz0Yp0RZDOS5i9JwpRDnn4VPjRxYcXiK0bT2j+DZWQd7vkXS/cx9w/3/CdAgpfFTPU3TIbWQ2pWI1GzoSD9bFsLnnHGgyIOylCYwmuUX3ZYgNkWSO/jY2T4pmR0EwCwYuxz416quo4YAAdWKj8jQEkGvr8EtkxhTJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USzG6PJF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ec4e349f4so1600107f8f.0;
        Fri, 25 Oct 2024 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729874373; x=1730479173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUERxqQyEYWblfGloFUtJrSp6SgR/w6k0b5sEG86kmQ=;
        b=USzG6PJFy4ISZyVmDnu7pKhZAYHkoR2NEZZ8UnjvlHeGzJq39NWe8oUq7SgXULVHiY
         bAWJpUFmkxscHo77EmVjzeSTeH7ejL6RB/d1iTim4vcMEy879MbarYLkf9oo3kPgSrAY
         ra6QRxMDh+qfX3jqDk4F4N/LNPU5yGGDYvLFVjv6DE7W12I4euifpzFCS6mExZegKjwi
         9x5HN89fkqjV1imMI95o7v+M56AU7hbDC0j409qksQHM18DfXwoRIiL69LljpTiraHiJ
         X6C7otWgijcpc2FZqbrl3HzLb6nWL0NZ4s3Hi/KjXvZkAhNzRB9wujF887axmZNrCnfr
         HwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729874373; x=1730479173;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OUERxqQyEYWblfGloFUtJrSp6SgR/w6k0b5sEG86kmQ=;
        b=j1mXn9veSkQuTeQHL/2v5Cd4bkWO+SEHHbA0HDNKRO+Ev06MIL9SurX/fadpxHufs7
         afTkJLqx1bpALD177T+oSwxRJEYjP2WtbcY5cCzLbOf1fqxqQ1u7vTjC7aAxVFaskpKe
         cHx9NZWTOtUX4dwnB9h4DQcu6CoxzErFhJYbdeB++FQRpHaamw4yf8XCwGDTsFRCoINt
         YEFk1es5Hng2FUzcH3d6sTUNhEc2qYu6DXAqWxrv6BJQZ5zJzjH7q+TrkOHf+YfzWVRS
         mtQax+BJADEXcv6WAPczh1mc/088c0+LqwGjt6x+33cNVHHOsuCkB2OcPZFsIqhj14Cl
         ttLg==
X-Forwarded-Encrypted: i=1; AJvYcCUK7E8E1p0FUhuQlAF3GpDZAGRTzRQpMltEZWkfBWHdUdtRMjEwEgzal7aNY/SMSNBWdP90SGIPvgMGhIKY@vger.kernel.org, AJvYcCUOCP2ovorDPRwfpGRxuwBFFg9QNjgTBgL4hW8z/fv8hxpDbmdZHQ5ai+QRxqF3VTQ2HdOzMuPcqW5n@vger.kernel.org, AJvYcCVK4EHEv7GEhE49FBczPAyv9d3HP5P1Vf57wn9EyjbrfQep3X9496zwQkT9gGevfWaQixVtvI9HyCC2@vger.kernel.org, AJvYcCW+RivHH03/rJexTuFrXbtqdProx+6Cd4wp1Ck8zjk1vvsamjo5MSAjKMyDcpPvgb5VGO71vDC1ZGMy@vger.kernel.org, AJvYcCXlX9mfeRc7xRv3CP03v+waOoWcmtvdbhNj2GFXcOaLdCw8AWYdmDiPUC/TpF2MoBSrg5lC3kTzslb7@vger.kernel.org
X-Gm-Message-State: AOJu0YwsIb9fdqirDsiaKqnjD7xqRQGk2/kp9Jk6gX+Hj2zfutBDmWIt
	LDrr2Sfv7O6bDBo8BJl1xwIjLvN0pGHHFcds2jSGHi/UFaSafz15
X-Google-Smtp-Source: AGHT+IF7mUu4D0gTAUMp2X2NSGjwA0z6THJvOylLp36ha1J/e3xi9eZS1iByL3Dh90RMYVl+7urcjw==
X-Received: by 2002:a5d:51c4:0:b0:37d:377f:51e6 with SMTP id ffacd0b85a97d-3806120aa9dmr20863f8f.56.1729874372794;
        Fri, 25 Oct 2024 09:39:32 -0700 (PDT)
Received: from [127.0.0.1] (aftr-62-216-210-211.dynamic.mnet-online.de. [62.216.210.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70f25sm1962438f8f.67.2024.10.25.09.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 09:39:32 -0700 (PDT)
Date: Fri, 25 Oct 2024 18:39:33 +0200 (GMT+02:00)
From: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Message-ID: <b8a54ec7-5c8f-422b-92cf-ece744073868@gmail.com>
In-Reply-To: <2cec766bb77ef245f34e213f081b5e27b489aff7.camel@gmail.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com> <20241023-dlech-mainline-spi-engine-offload-2-v4-2-f8125b99f5a1@baylibre.com> <2cec766bb77ef245f34e213f081b5e27b489aff7.camel@gmail.com>
Subject: Re: [PATCH RFC v4 02/15] spi: add basic support for SPI offloading
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <b8a54ec7-5c8f-422b-92cf-ece744073868@gmail.com>

Oct 25, 2024 14:59:20 Nuno S=C3=A1 <noname.nuno@gmail.com>:

> On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
>> Add the basic infrastructure to support SPI offload providers and
>> consumers.
>>
>> SPI offloading is a feature that allows the SPI controller to perform
>> transfers without any CPU intervention. This is useful, e.g. for
>> high-speed data acquisition.
>>
>> SPI controllers with offload support need to implement the get_offload
>> callback and can use the devm_spi_offload_alloc() to allocate offload
>> instances.
>>
>> SPI peripheral drivers will call devm_spi_offload_get() to get a
>> reference to the matching offload instance. This offload instance can
>> then be attached to a SPI message to request offloading that message.
>>
>> It is expected that SPI controllers with offload support will check for
>> the offload instance in the SPI message in the optimize_message()
>> callback and handle it accordingly.
>>
>> CONFIG_SPI_OFFLOAD is intended to be a select-only option. Both
>> consumer and provider drivers should `select SPI_OFFLOAD` in their
>> Kconfig to ensure that the SPI core is built with offload support.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
>> v4 changes:
>> * SPI offload functions moved to a separate file instead of spi.c
>> =C2=A0 (spi.c is already too long).
>> * struct spi_offload and devm_spi_offload_get() are back, similar to
>> =C2=A0 but improved over v1. This avoids having to pass the function ID
>> =C2=A0 string to every function call and re-lookup the offload instance.
>> * offload message prepare/unprepare functions are removed. Instead the
>> =C2=A0 existing optimize/unoptimize functions should be used. Setting
>> =C2=A0 spi_message::offload pointer is used as a flag to differentiate
>> =C2=A0 between an offloaded message and a regular message.
>>
>> v3 changes:
>> * Minor changes to doc comments.
>> * Changed to use phandle array for spi-offloads.
>> * Changed id to string to make use of spi-offload-names.
>>
>> v2 changes:
>> * This is a rework of "spi: add core support for controllers with offloa=
d
>> =C2=A0 capabilities" from v1.
>> * The spi_offload_get() function that Nuno didn't like is gone. Instead,
>> =C2=A0 there is now a mapping callback that uses the new generic devicet=
ree
>> =C2=A0 binding to request resources automatically when a SPI device is p=
robed.
>> * The spi_offload_enable/disable() functions for dealing with hardware
>> =C2=A0 triggers are deferred to a separate patch.
>> * This leaves adding spi_offload_prepare/unprepare() which have been
>> =C2=A0 reworked to be a bit more robust.
>> ---
>> =C2=A0drivers/spi/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 ++
>> =C2=A0drivers/spi/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0drivers/spi/spi-offload.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10=
4 ++++++++++++++++++++++++++++++++++++++++
>> =C2=A0include/linux/spi/spi-offload.h |=C2=A0 64 +++++++++++++++++++++++=
++
>> =C2=A0include/linux/spi/spi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 16 +++++++
>> =C2=A05 files changed, 188 insertions(+)
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index 823797217404..d65074b85f62 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -55,6 +55,9 @@ config SPI_MEM
>> =C2=A0=C2=A0=C2=A0 =C2=A0 This extension is meant to simplify interactio=
n with SPI memories
>> =C2=A0=C2=A0=C2=A0 =C2=A0 by providing a high-level interface to send me=
mory-like commands.
>> =C2=A0
>> +config SPI_OFFLOAD
>> +=C2=A0=C2=A0 bool
>> +
>> =C2=A0comment "SPI Master Controller Drivers"
>> =C2=A0
>> =C2=A0config SPI_AIROHA_SNFI
>> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
>> index a9b1bc259b68..6a470eb475a2 100644
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -10,6 +10,7 @@ ccflags-$(CONFIG_SPI_DEBUG) :=3D -DDEBUG
>> =C2=A0obj-$(CONFIG_SPI_MASTER)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D =
spi.o
>> =C2=A0obj-$(CONFIG_SPI_MEM)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 +=3D spi-mem.o
>> =C2=A0obj-$(CONFIG_SPI_MUX)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 +=3D spi-mux.o
>> +obj-$(CONFIG_SPI_OFFLOAD)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D spi-offloa=
d.o
>> =C2=A0obj-$(CONFIG_SPI_SPIDEV)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D =
spidev.o
>> =C2=A0obj-$(CONFIG_SPI_LOOPBACK_TEST)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 +=3D spi-loopback-test.o
>> =C2=A0
>> diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
>> new file mode 100644
>> index 000000000000..c344cbf50bdb
>> --- /dev/null
>> +++ b/drivers/spi/spi-offload.c
>> @@ -0,0 +1,104 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2024 Analog Devices Inc.
>> + * Copyright (C) 2024 BayLibre, SAS
>> + */
>> +
>> +#define DEFAULT_SYMBOL_NAMESPACE SPI_OFFLOAD
>> +
>> +#include <linux/cleanup.h>
>> +#include <linux/device.h>
>> +#include <linux/export.h>
>> +#include <linux/mutex.h>
>> +#include <linux/property.h>
>> +#include <linux/spi/spi-offload.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/types.h>
>> +
>> +/**
>> + * devm_spi_offload_alloc() - Allocate offload instances
>> + * @dev: Device for devm purposes
>> + * @num_offloads: Number of offloads to allocate
>> + * @priv_size: Size of private data to allocate for each offload
>> + *
>> + * Offload providers should use this to allocate offload instances.
>> + *
>> + * Return: Pointer to array of offloads or error on failure.
>> + */
>> +struct spi_offload *devm_spi_offload_alloc(struct device *dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 size_t num_offloads,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 size_t priv_size)
>> +{
>> +=C2=A0=C2=A0 struct spi_offload *offloads;
>> +=C2=A0=C2=A0 void *privs;
>> +=C2=A0=C2=A0 size_t i;
>> +
>> +=C2=A0=C2=A0 offloads =3D devm_kcalloc(dev, num_offloads, sizeof(*offlo=
ads) + priv_size,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 GFP_KERNEL);
>> +=C2=A0=C2=A0 if (!offloads)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(-ENOMEM);
>> +
>> +=C2=A0=C2=A0 privs =3D (void *)(offloads + num_offloads);
>> +
>> +=C2=A0=C2=A0 for (i =3D 0; i < num_offloads; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_offload *offload =3D of=
floads + i;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *priv =3D privs + i * priv_si=
ze;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offload->provider_dev =3D dev;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offload->priv =3D priv;
>> +=C2=A0=C2=A0 }
>
> Hmm looking at the spi_engine implementation, got me thinking about this.=
 I think
> like this we might mess up with natural alignments which can be pretty na=
sty. Maybe
> do something like devres [1] (I guess we do not need the flex array thoug=
h)?
>

Actually we should use the flex array or something similar to what IIO does=
.

PS: just trying some email client from my phone so hopefully this is not to=
o messed up.

- Nuno S=C3=A1



