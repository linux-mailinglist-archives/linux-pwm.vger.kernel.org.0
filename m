Return-Path: <linux-pwm+bounces-3913-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59049B18FF
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 17:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6516A2829FC
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA9354277;
	Sat, 26 Oct 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqdarPTe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EC3481D5;
	Sat, 26 Oct 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729955703; cv=none; b=OkMORceL4GI1En0edF4R36CGGELP7voQ2CM1xuYcFx1Eqs2uLRQJK0ZQNGhTH1B+lTQew94pCqvb0YdNR53m5VBI4StNhaW7ubhGZ9Pk63cJXa/GjtiztFgBDiAzqxaY3g23gTEMroLrPRS7F25PZf56RRkijO+/DcYNmFk5hxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729955703; c=relaxed/simple;
	bh=f8ihYcg9ZE/zGjDssFsyikFZDikuCIebgyEbtBR/D68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2W0u1Hk028yHfnbid0JWtSorlMZd3jukmVwniYO/VreMeW+tUD0Hd2Qv7qofkRM2cqa4AU8naRfO8RE/KFDqRv49TcMp78fybrG5AashxLNutsz0oM4usnSiZohZrD7/O0uQixeYIqt3oBwoU3i80w5I//tAoLKRmj3XsVszd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqdarPTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11531C4CECC;
	Sat, 26 Oct 2024 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729955702;
	bh=f8ihYcg9ZE/zGjDssFsyikFZDikuCIebgyEbtBR/D68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RqdarPTeQZE5uKFj35gQh0dw5zCz/3QYPvEVpxIkag+o7IoXcQyts2IjYfjvDQbR9
	 Hb7U50/ZreSWq2qj9b35wNXKVlSKLsTfFH042F8AL8lV9NNjeFZSIK4tTALbQPq4O8
	 H3XVBEGQAqX96c6gxZdJivpacifivG9sLRZ5kRkoRW+an7ZZa3d3UcCy+3fG3kzUjM
	 uuPl1cgCXh21rdYuvsIoezA2wgG8kLJWuMVfesnC+IJkfb4AkHi1NcNOqObyoLbxaV
	 CcWBVEQqwNDXNFcZ6Zp5eVCqzYopkUZjm3/1+xXYb11uWyUXKRLB5T9kLymGHSrSQ9
	 FTdneMIyxZdjg==
Date: Sat, 26 Oct 2024 16:14:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH RFC v4 03/15] spi: offload: add support for hardware
 triggers
Message-ID: <20241026161404.1749c2d3@jic23-huawei>
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-3-f8125b99f5a1@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	<20241023-dlech-mainline-spi-engine-offload-2-v4-3-f8125b99f5a1@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 15:59:10 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Extend SPI offloading to support hardware triggers.
> 
> This allows an arbitrary hardware trigger to be used to start a SPI
> transfer that was previously set up with spi_optimize_message().
> 
> A new struct spi_offload_trigger is introduced that can be used to
> configure any type of trigger. It has a type discriminator and a union
> to allow it to be extended in the future. Two trigger types are defined
> to start with. One is a trigger that indicates that the SPI peripheral
> is ready to read or write data. The other is a periodic trigger to
> repeat a SPI message at a fixed rate.
> 
> There is also a spi_offload_hw_trigger_validate() function that works
> similar to clk_round_rate(). It basically asks the question of if we
> enabled the hardware trigger what would the actual parameters be. This
> can be used to test if the requested trigger type is actually supported
> by the hardware and for periodic triggers, it can be used to find the
> actual rate that the hardware is capable of.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
A few generic comments inline.

Jonathan

> ---
> 
> In previous versions, we locked the SPI bus when the hardware trigger
> was enabled, but we found this to be too restrictive. In one use case,
> to avoid a race condition, we need to enable the SPI offload via a
> hardware trigger, then write a SPI message to the peripheral to place
> it into a mode that will generate the trigger. If we did it the other
> way around, we could miss the first trigger.
> 
> Another likely use case will be enabling two offloads/triggers at one
> time on the same device, e.g. a read trigger and a write trigger. So
> the exclusive bus lock for a single trigger would be too restrictive in
> this case too.
> 
> So for now, I'm going with Nuno's suggestion to leave any locking up to
> the individual controller driver. If we do find we need something more
> generic in the future, we could add a new spi_bus_lock_exclusive() API
> that causes spi_bus_lock() to fail instead of waiting and add "locked"
> versions of trigger enable functions. This would allow a peripheral to
> claim exclusive use of the bus indefinitely while still being able to
> do any SPI messaging that it needs.
> 
> v4 changes:
> * Added new struct spi_offload_trigger that is a generic struct for any
>   hardware trigger rather than returning a struct clk.
> * Added new spi_offload_hw_trigger_validate() function.
> * Dropped extra locking since it was too restrictive.
> 
> v3 changes:
> * renamed enable/disable functions to spi_offload_hw_trigger_*mode*_...
> * added spi_offload_hw_trigger_get_clk() function
> * fixed missing EXPORT_SYMBOL_GPL
> 
> v2 changes:
> * This is split out from "spi: add core support for controllers with
>   offload capabilities".
> * Added locking for offload trigger to claim exclusive use of the SPI
>   bus.
> ---
>  drivers/spi/spi-offload.c       | 266 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/spi-offload.h |  78 ++++++++++++
>  2 files changed, 344 insertions(+)
> 
> diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> index c344cbf50bdb..2a1f9587f27a 100644
> --- a/drivers/spi/spi-offload.c
> +++ b/drivers/spi/spi-offload.c
> @@ -9,12 +9,26 @@
>  #include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
> +#include <linux/list.h>
>  #include <linux/mutex.h>
> +#include <linux/of.h>
>  #include <linux/property.h>
>  #include <linux/spi/spi-offload.h>
>  #include <linux/spi/spi.h>
>  #include <linux/types.h>
>  
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
>  /**
>   * devm_spi_offload_alloc() - Allocate offload instances
>   * @dev: Device for devm purposes
> @@ -102,3 +116,255 @@ struct spi_offload *devm_spi_offload_get(struct device *dev,
>  	return offload;
>  }
>  EXPORT_SYMBOL_GPL(devm_spi_offload_get);
> +
> +static void spi_offload_trigger_release(void *data)
> +{
> +	struct spi_offload_trigger *trigger = data;
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
> +			      struct spi_offload *offload,
> +			      enum spi_offload_trigger_type type)
> +{
> +	struct spi_offload_trigger *trigger;
> +	struct fwnode_reference_args args;
> +	bool match = false;
> +	int ret;
> +
> +	ret = fwnode_property_get_reference_args(dev_fwnode(offload->provider_dev),
> +						 "trigger-sources",
> +						 "#trigger-source-cells", 0, 0,
> +						 &args);
> +	if (ret)
> +		return ERR_PTR(ret);
> +

> +	struct fwnode_handle *trigger_fwnode __free(fwnode_handle) = args.fwnode;
I'm not fond of __free usage like this because code could get added above
this line and it wouldn't be obvious that it doesn't release the handle.

Annoying though it is, maybe just do manual release of the fwnode.  Ora
factor out the next chunk to a helper function so you can just put the fwnode after
that is called.


> +
> +	guard(mutex)(&spi_offload_triggers_lock);
> +
> +	list_for_each_entry(trigger, &spi_offload_triggers, list) {
> +		if (trigger->dev.fwnode != args.fwnode)
> +			continue;
> +
> +		match = trigger->ops->match(trigger->priv, type, args.args, args.nargs);
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
> +
> +	if (trigger->ops->request) {
> +		ret = trigger->ops->request(trigger->priv, type, args.args, args.nargs);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	get_device(&trigger->dev);
> +
> +	ret = devm_add_action_or_reset(dev, spi_offload_trigger_release, trigger);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return trigger;
> +}
> +EXPORT_SYMBOL_GPL(devm_spi_offload_trigger_get);

> +int devm_spi_offload_trigger_register(struct device *dev,
> +				      struct spi_offload_trigger *trigger,
> +				      void *priv)
> +{
> +	int ret;
> +
> +	ret = device_add(&trigger->dev);
> +	if (ret)
> +		return ret;
> +
> +	trigger->priv = priv;
> +
> +	guard(mutex)(&spi_offload_triggers_lock);
> +	list_add_tail(&trigger->list, &spi_offload_triggers);
> +
> +	ret = devm_add_action_or_reset(dev, spi_offload_trigger_unregister, trigger);
I guess there may be more here later in the series, but if not.

	return devm_add_...

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_spi_offload_trigger_register);

