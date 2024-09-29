Return-Path: <linux-pwm+bounces-3394-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61C8989577
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 14:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72742284FD2
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 12:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4869517A583;
	Sun, 29 Sep 2024 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2+fJ7Nu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F2513D628;
	Sun, 29 Sep 2024 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727613865; cv=none; b=sRyjD6K+wytxOLmgyqdt8Kmuc3tmiUG+8tKI4RBlAEwYu/aqCfjgu5ASAn2covWEtcg4rXck5y2FeN/a4X6nhIt8vcwMeK8k5aS9YxZN92l/7uXPUCPwhRpsuSJinJHHZAtHEHt/2nEgXaZYnov0tQXo+Qaqy8XC6Z7wHCMvPN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727613865; c=relaxed/simple;
	bh=qfmndiMcuS46oIy5h8MpGUoUhNcdGqbPPViTuEb+qpM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFJ77cLnCCPmUUWJLbDGUWI1hGqPn/wDt3ci1QcMtshECKLOgVq1wIEpROdbyyStbeyIFlHzam01mml2iX0oucRAmgd0o+l70WXkdHgcNZFCG2VGY0zJLtyXSsdouQG+zWHAwUpWi4+n73bxE9xdvZbrjhleHrux9pylhgNbAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2+fJ7Nu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F189C4CEC5;
	Sun, 29 Sep 2024 12:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727613864;
	bh=qfmndiMcuS46oIy5h8MpGUoUhNcdGqbPPViTuEb+qpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R2+fJ7NuY6oRtg/dPRBGkcdrOQt1jry9oFrEjY3IVJaS9ID5KhI7JHVupnWNHx2gF
	 DW+8i15TujirgDq97woEczoG7qpvdrjINfKQ2ShDeilB4P6l3EtxU0MIPU2dAkCcat
	 leuWMXnLJVLpPcC1tOZJXe0KyLOYuf7xtsXrtb1L/nNz+7fG1qIahlZ9GTSEMHEV8v
	 9MuZ1HuGeBctYKLzni9YW/DhH/ndmj9tORVmsDUEXVr10aG0NQvW0QwK6koZ2vKEeN
	 4xO6XN+piuc/rRYhhHx/7Ab3rH53oYgIWPQG+9jrsd/mG+exkxBy/XbNEOcD7+CZpz
	 7r+rq2cBn23tw==
Date: Sun, 29 Sep 2024 13:44:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michal Marek
 <mmarek@suse.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com
Subject: Re: [PATCH v2 07/10] iio: adc: ad7606: Add compatibility to
 fw_nodes
Message-ID: <20240929134412.506998db@jic23-huawei>
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-7-0e78782ae7d0@baylibre.com>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
	<20240920-ad7606_add_iio_backend_support-v2-7-0e78782ae7d0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Sep 2024 17:33:27 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> On the parallel version, the current implementation is only compatible
> with id tables and won't work with fw_nodes, this commit intends to fix
> it.
> 
> Also, chip info is moved in the .h file so to be accessible to all the

chip info is not moved (I was going to say no to that) but an
extern is used to make it available. So say that rather than moved here.

> driver files that can set a pointer to the corresponding chip as the
> driver data.
> 

>  
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index c13dda444526..18c87fe9a41a 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -38,8 +38,19 @@
>  	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
>  		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
>  
> +enum ad7606_supported_device_ids {
> +	ID_AD7605_4,
> +	ID_AD7606_8,
> +	ID_AD7606_6,
> +	ID_AD7606_4,
> +	ID_AD7606B,
> +	ID_AD7616,
> +};
> +
>  /**
>   * struct ad7606_chip_info - chip specific information
> + * @name		device name
> + * @id			device id

ID in chip info normally indicates something bad in the design. In that somewhere
we have code that is ID dependent rather than all such code / data being
found directly in this structure (or callbacks found from here).
Can we avoid it here?

>   * @channels:		channel specification
>   * @num_channels:	number of channels
>   * @oversampling_avail	pointer to the array which stores the available
> @@ -50,6 +61,8 @@

...

> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
> index d651639c45eb..7bac39033955 100644
> --- a/drivers/iio/adc/ad7606_par.c
> +++ b/drivers/iio/adc/ad7606_par.c
> @@ -11,6 +11,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/types.h>
>  
>  #include <linux/iio/iio.h>
> @@ -89,12 +90,20 @@ static const struct ad7606_bus_ops ad7606_par8_bops = {
>  
>  static int ad7606_par_probe(struct platform_device *pdev)
>  {
> -	const struct platform_device_id *id = platform_get_device_id(pdev);
> +	const struct ad7606_chip_info *chip_info;
> +	const struct platform_device_id *id;
>  	struct resource *res;
>  	void __iomem *addr;
>  	resource_size_t remap_size;
>  	int irq;
>  
> +	if (dev_fwnode(&pdev->dev)) {
> +		chip_info = device_get_match_data(&pdev->dev);
> +	} else {
> +		id = platform_get_device_id(pdev);
> +		chip_info = (const struct ad7606_chip_info *)id->driver_data;
> +	}
> +
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
> @@ -106,25 +115,25 @@ static int ad7606_par_probe(struct platform_device *pdev)
>  	remap_size = resource_size(res);
>  
>  	return ad7606_probe(&pdev->dev, irq, addr,
> -			    id->name, id->driver_data,
Rewrap to move chip_info up a line perhaps.

> +			    chip_info,
>  			    remap_size > 1 ? &ad7606_par16_bops :
>  			    &ad7606_par8_bops);


