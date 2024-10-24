Return-Path: <linux-pwm+bounces-3832-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15CA9AE9A7
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 17:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252CF1F23ED6
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 15:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB341E7668;
	Thu, 24 Oct 2024 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F2Q1qKjf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B583A14
	for <linux-pwm@vger.kernel.org>; Thu, 24 Oct 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782187; cv=none; b=ft6ZxB+dyTUwdcik2+6I6GcBvZAQxeWW75082+rDiFG9K2SCTjfVx4u1Xb1af3b90GA6O8QIVUA/3GViQtFfjOIhfmZfstiHRrD5HfEFXsRXT+WTAUjHfSQtW0hQrX3XZOkwp1ai4wuehyrygSE7IJBEDkz8uNIQ7t7F5L5P8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782187; c=relaxed/simple;
	bh=SFCdL5GCriNAvcLQo78wBP7l5QqgAYxBKpVa+oiS28Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwzB3Cg4/sPlcoCHpyQXlvA2hUr6Kn0KkQSdr0RGR5Eu9KSRQkYplJN7qy4Gc89C8hps3/SsRLqXFaITWW0Ez9p7NMX/89w7aIuWa/EDJOMwbU3Z7XTq4aDBqJsSPp65jqNQNGC9zaT4uSVm7l8HYNiwUlAwNuZ89tXKdEAhqu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F2Q1qKjf; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e605ffe10cso619198b6e.3
        for <linux-pwm@vger.kernel.org>; Thu, 24 Oct 2024 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729782182; x=1730386982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lw+zSJnzrNqCSHT1HVGgXzOqNxcf9oH83aOKEvogObw=;
        b=F2Q1qKjfmu4y9wdpoMefmg18X+S2DFm2ouoP6L21ZNrVPgfZ+TVDJUax5WnYb7hs4e
         XMPyE60/mHq029+azE9eQ4aMj6/pIXtjEntEBTGj2qga0HBWkxKTxTEh/kXSC0JnzR5e
         8IlfkyGqGImWA8wn3yUewd3nQPQSeDozaKxE/j+lG/+XDzkLu3A+iya1xmobxLPkT2he
         Wb+a8tr9PCFJE82xaw9LBypaSJ2zIEWAF0diAaChVPnSBrMS4iVOTpRXcsGMQannza0k
         k2M3h4QeJzmLzBvNeimfdvthNAzJ8FdLBffroZ2O19NGXw6sMg2QHuDxPSfwaWnLrClv
         NnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729782182; x=1730386982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lw+zSJnzrNqCSHT1HVGgXzOqNxcf9oH83aOKEvogObw=;
        b=hwCXQL2P88SluQagTHjqFygHd7aBdyhZEaxaJUO89hAOOE+ErXfGznWy3JVMHZfQSI
         esvlqJsoWKUIyZ4qNjp0kYg9CyuTkVH1LilZEqLW/W2p6tM6HLItTvf6avcDfLqU7AIr
         x00Aw2J1c5zfUd1ue/wAdyQbaZW5S5+hfHNJus+7mafsFvMkVTH6d1Ua28pjKPhpPPGL
         lD2z64ISf+h1Q+po9HSQPdOZz9pVNogXTX5u9obOr0LEYo2Got/J20deMUurZwkEjkK9
         8vQ2WtJsXfSoUFxS5JiVpmn3kXuDmpfzaf+B7POn9JeaTlfSb3TZNeJzpHThuKisOMdL
         +wUA==
X-Forwarded-Encrypted: i=1; AJvYcCUbVYtNAULzyaPmTQj1NV/dDPcH18ZNYsB95J2f73fXsEhBvNAp4wySRJsOK8sc9IqPQyxx005kfCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8Qtxtmg/W2/rFd66eJ23QjDyo+OhkLF3kUD5T6WX98i+uMRj
	kxP7SjZaVy75nLtnPikdrVZpm/N/K7cUSoXmKwSz/43DIyGIhJ9NyVtXBGmfV2I=
X-Google-Smtp-Source: AGHT+IGe5wQ2BpB0hosPe5xBOm3il4EuetYWdbJrO5GtrEKM+a114tHckeEQ1O1SMUzGwrFtHqd2cA==
X-Received: by 2002:a05:6808:10c7:b0:3e3:982c:eb2e with SMTP id 5614622812f47-3e624500bd1mr6934073b6e.10.1729782181821;
        Thu, 24 Oct 2024 08:03:01 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e61035f582sm2271168b6e.47.2024.10.24.08.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 08:03:00 -0700 (PDT)
Message-ID: <9d801823-aa90-4b15-9dbb-9da6ad2cb3e4@baylibre.com>
Date: Thu, 24 Oct 2024 10:02:58 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 03/15] spi: offload: add support for hardware
 triggers
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-3-f8125b99f5a1@baylibre.com>
 <9762d3f3d3a2e5fbe5e5041cbdc928a9ab24e40b.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <9762d3f3d3a2e5fbe5e5041cbdc928a9ab24e40b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/24/24 9:04 AM, Nuno Sá wrote:
> On Wed, 2024-10-23 at 15:59 -0500, David Lechner wrote:
>> Extend SPI offloading to support hardware triggers.
>>
>> This allows an arbitrary hardware trigger to be used to start a SPI
>> transfer that was previously set up with spi_optimize_message().
>>
>> A new struct spi_offload_trigger is introduced that can be used to
>> configure any type of trigger. It has a type discriminator and a union
>> to allow it to be extended in the future. Two trigger types are defined
>> to start with. One is a trigger that indicates that the SPI peripheral
>> is ready to read or write data. The other is a periodic trigger to
>> repeat a SPI message at a fixed rate.
>>
>> There is also a spi_offload_hw_trigger_validate() function that works
>> similar to clk_round_rate(). It basically asks the question of if we
>> enabled the hardware trigger what would the actual parameters be. This
>> can be used to test if the requested trigger type is actually supported
>> by the hardware and for periodic triggers, it can be used to find the
>> actual rate that the hardware is capable of.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
>> In previous versions, we locked the SPI bus when the hardware trigger
>> was enabled, but we found this to be too restrictive. In one use case,
>> to avoid a race condition, we need to enable the SPI offload via a
>> hardware trigger, then write a SPI message to the peripheral to place
>> it into a mode that will generate the trigger. If we did it the other
>> way around, we could miss the first trigger.
>>
>> Another likely use case will be enabling two offloads/triggers at one
>> time on the same device, e.g. a read trigger and a write trigger. So
>> the exclusive bus lock for a single trigger would be too restrictive in
>> this case too.
>>
>> So for now, I'm going with Nuno's suggestion to leave any locking up to
>> the individual controller driver. If we do find we need something more
>> generic in the future, we could add a new spi_bus_lock_exclusive() API
>> that causes spi_bus_lock() to fail instead of waiting and add "locked"
>> versions of trigger enable functions. This would allow a peripheral to
>> claim exclusive use of the bus indefinitely while still being able to
>> do any SPI messaging that it needs.
>>
>> v4 changes:
>> * Added new struct spi_offload_trigger that is a generic struct for any
>>   hardware trigger rather than returning a struct clk.
>> * Added new spi_offload_hw_trigger_validate() function.
>> * Dropped extra locking since it was too restrictive.
>>
>> v3 changes:
>> * renamed enable/disable functions to spi_offload_hw_trigger_*mode*_...
>> * added spi_offload_hw_trigger_get_clk() function
>> * fixed missing EXPORT_SYMBOL_GPL
>>
>> v2 changes:
>> * This is split out from "spi: add core support for controllers with
>>   offload capabilities".
>> * Added locking for offload trigger to claim exclusive use of the SPI
>>   bus.
>> ---
>>  drivers/spi/spi-offload.c       | 266 ++++++++++++++++++++++++++++++++++++++++
>>  include/linux/spi/spi-offload.h |  78 ++++++++++++
>>  2 files changed, 344 insertions(+)
>>
>> diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
>> index c344cbf50bdb..2a1f9587f27a 100644
>> --- a/drivers/spi/spi-offload.c
>> +++ b/drivers/spi/spi-offload.c
>> @@ -9,12 +9,26 @@
>>  #include <linux/cleanup.h>
>>  #include <linux/device.h>
>>  #include <linux/export.h>
>> +#include <linux/list.h>
>>  #include <linux/mutex.h>
>> +#include <linux/of.h>
>>  #include <linux/property.h>
>>  #include <linux/spi/spi-offload.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/types.h>
>>  
>> +struct spi_offload_trigger {
>> +	struct list_head list;
>> +	struct device dev;
>> +	/* synchronizes calling ops and driver registration */
>> +	struct mutex lock;
>> +	const struct spi_offload_trigger_ops *ops;
>> +	void *priv;
>> +};
>> +
>> +static LIST_HEAD(spi_offload_triggers);
>> +static DEFINE_MUTEX(spi_offload_triggers_lock);
>> +
>>  /**
>>   * devm_spi_offload_alloc() - Allocate offload instances
>>   * @dev: Device for devm purposes
>> @@ -102,3 +116,255 @@ struct spi_offload *devm_spi_offload_get(struct device *dev,
>>  	return offload;
>>  }
>>  EXPORT_SYMBOL_GPL(devm_spi_offload_get);
>> +
>> +static void spi_offload_trigger_release(void *data)
>> +{
>> +	struct spi_offload_trigger *trigger = data;
>> +
>> +	guard(mutex)(&trigger->lock);
>> +	if (trigger->priv && trigger->ops->release)
>> +		trigger->ops->release(trigger->priv);
>> +
>> +	put_device(&trigger->dev);
>> +}
>> +
>> +struct spi_offload_trigger
>> +*devm_spi_offload_trigger_get(struct device *dev,
>> +			      struct spi_offload *offload,
>> +			      enum spi_offload_trigger_type type)
>> +{
>> +	struct spi_offload_trigger *trigger;
>> +	struct fwnode_reference_args args;
>> +	bool match = false;
>> +	int ret;
>> +
>> +	ret = fwnode_property_get_reference_args(dev_fwnode(offload-
>>> provider_dev),
>> +						 "trigger-sources",
>> +						 "#trigger-source-cells", 0, 0,
>> +						 &args);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	struct fwnode_handle *trigger_fwnode __free(fwnode_handle) = args.fwnode;
>> +
>> +	guard(mutex)(&spi_offload_triggers_lock);
>> +
>> +	list_for_each_entry(trigger, &spi_offload_triggers, list) {
>> +		if (trigger->dev.fwnode != args.fwnode)
>> +			continue;
>> +
>> +		match = trigger->ops->match(trigger->priv, type, args.args,
>> args.nargs);
>> +		if (match)
>> +			break;
>> +	}
>> +
>> +	if (!match)
>> +		return ERR_PTR(-EPROBE_DEFER);
>> +
>> +	guard(mutex)(&trigger->lock);
>> +
>> +	if (!trigger->priv)
>> +		return ERR_PTR(-ENODEV);
> 
> This is a bit odd tbh. Not a real deal breaker for me but the typical pattern I would
> expect is for methods of the trigger to get a struct spi_offload_trigger opaque
> pointer. Then we provide a get_private kind of API for the private data. I guess you
> want to avoid that but IMO it makes for neater API instead of getting void pointers.

I was just trying to save a step of an extra call to get *priv
in each callback implementation, but yeah, no problem to change
it to something more "normal" looking.

> 
> Another thing is, can the above actually happen? We have the
> spi_offload_triggers_lock grabbed and we got a match so the trigger should not be
> able to go away (should block on the same lock).

The problem is that it could have gone away before we took the lock.

It could happen like this:

* Trigger driver registers trigger - sets *priv.
* SPI peripheral driver gets reference to trigger.
* Trigger driver unregisters trigger - removes *priv.
* SPI peripheral tries to call trigger function.

> 
>>
>> +struct spi_offload_trigger
>> +*devm_spi_offload_trigger_alloc(struct device *dev,
>> +				struct spi_offload_trigger_info *info)
>> +{
>> +	struct spi_offload_trigger *trigger;
>> +	int ret;
>> +
>> +	trigger = kzalloc(sizeof(*trigger), GFP_KERNEL);
>> +	if (!trigger)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	device_initialize(&trigger->dev);
> 
> Do we really need the full struct device and the overhead of adding it to the driver
> core? AFAICT, we're using it only for refcouting so we could use a plain kref for
> that matter. It would make things simpler. Or do you envision an future usecase as
> this might matter? Like allowing userspace to set some controls on the trigger (I
> would expect to be done through consumers though)?

Agreed. We should not need a device at this point.

> 
>> +	trigger->dev.parent = info->parent;
>> +	trigger->dev.fwnode = info->fwnode;
>> +	trigger->dev.of_node = of_node_get(to_of_node(trigger->dev.fwnode));
>> +	trigger->dev.of_node_reused = true;
>> +	trigger->dev.release = spi_offload_trigger_dev_release;
>> +
>> +	mutex_init(&trigger->lock);
>> +	trigger->ops = info->ops;
>> +
>> +	ret = devm_add_action_or_reset(dev, spi_offload_trigger_put, trigger);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	ret = dev_set_name(&trigger->dev, "%s-%d", info->name, info->id);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	return trigger;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_spi_offload_trigger_alloc);
>> +
>> +static void spi_offload_trigger_unregister(void *data)
>> +{
>> +	struct spi_offload_trigger *trigger = data;
>> +
>> +	scoped_guard(mutex, &spi_offload_triggers_lock)
>> +		list_del(&trigger->list);
>> +
>> +	guard(mutex)(&trigger->lock);
>> +	trigger->priv = NULL;
> 
> nit: I guess this is a good as anything else but *ops could also be a good fit to
> nullify :)

I debated between the two. :-)

But if I change the priv handling like you suggest, I think ops will make
more sense here.


