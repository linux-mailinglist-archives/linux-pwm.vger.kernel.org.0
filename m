Return-Path: <linux-pwm+bounces-3031-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F1395589F
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Aug 2024 17:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8E02826AE
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Aug 2024 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B23627735;
	Sat, 17 Aug 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjVNVhU1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619D8C0B;
	Sat, 17 Aug 2024 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723907950; cv=none; b=pmm1P9Rh898Hkg0ajhmm05b0CNOgquUWk9FRYMWseVQSEWxUlOUteDaos8L7IMZFOrbPFvEqA7K1tLJ2HpAUpuC0tRcLQvNz9NARjgRaS8+0Zmih3MM87Gql1TMcjTHCzlnRA4uiYEwtkUJk4iCzRDB0L1nVLAdX93tY3sXJk4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723907950; c=relaxed/simple;
	bh=rnPfDtCHCBHIbR+ymgFphW97czO9N4w1uU0i56yHB9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEZKtp1+N3A4sXVU2PCgguzxp3G6yNLFHkplzJSa4PhUdHHyrM16ogX9aXlH1BXJYv5l5hz+/QBdaDjKNcTK6a5pj7EuubejdHyIV4dlxHfc1tI5cBFq+AXhesNjNeX78JNHBUo6ECy+N+4Tc5znwW0oiAkJ/Jo1ZT5unL/D+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjVNVhU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A90EC116B1;
	Sat, 17 Aug 2024 15:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723907949;
	bh=rnPfDtCHCBHIbR+ymgFphW97czO9N4w1uU0i56yHB9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jjVNVhU1Bw9FBulL8rpdN7Ptz+aAwdOPpDCEcrlLf18r8coO1gKnUAbI6/ZNT5EgK
	 RFLFsejT5jejzOpUeuaHALwKu/u2UvsDVYTlAJaqlmrG6Fvl4ggmKJbVRUs0RjOOkH
	 Yefgrl+/wrRAdf/nHRCtX3xoj2yo5v7GQkERnDr1VdazoTgUfVhKZD1WxaiuTtfIui
	 cZciXDm8U//h63/6uxs8WL2dBh6Bx+MCQIl2t8vnWuxbu++/54wjJrkCXy823fEHeT
	 Cjvl5yoCds55roHsgkhB6V57sJKfDrPQGTYQzVoKcGJPZNq/4diniELufwGmQ/n4MJ
	 YGBtfFFgYsmZQ==
Date: Sat, 17 Aug 2024 16:18:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com
Subject: Re: [PATCH 5/8] platform: add platform_get_device_match_data()
 helper
Message-ID: <20240817161859.3fef7a8d@jic23-huawei>
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-5-cea3e11b1aa4@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
	<20240815-ad7606_add_iio_backend_support-v1-5-cea3e11b1aa4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 12:11:59 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Inspired from spi_get_device_match_data() helper: if OF or ACPI driver
> data is available, platform_get_device_id will return NULL because
> platform_match_id is not called, and pdev->id_entry is never populated.
> This helper function checks if match data is available, and otherwise
> returns the ID table data.

Likely no one will read the patch description but for these it's worth
some scary text to point out that the driver_data must be a pointer.
If people use an enum we need to do a dance to avoid the value 0.

We get quite a few buggy conversions of i2c/spi drivers as a result
of that little gotcha.

Otherwise this seems like a sensible addition to me.

Potentially worth pulling out as a precursor series with a few examples
of how it saves on repeating this same code block in a bunch
of existing drivers.  Up to GregKH I think for how he'd like this
(assuming he approves!)


Jonathan


> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  drivers/base/platform.c         | 12 ++++++++++++
>  include/linux/platform_device.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 4c3ee6521ba5..26e9a026eb05 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1090,6 +1090,18 @@ static const struct platform_device_id *platform_match_id(
>  	return NULL;
>  }
>  
> +const void *platform_get_device_match_data(const struct platform_device *pdev)
> +{
> +	const struct platform_device_id *match;
> +
> +	match = device_get_match_data(&pdev->dev);
> +	if (match)
> +		return match;
> +
> +	return (const void *)platform_get_device_id(pdev)->driver_data;
> +}
> +EXPORT_SYMBOL_GPL(platform_get_device_match_data);
> +
>  #ifdef CONFIG_PM_SLEEP
>  
>  static int platform_legacy_suspend(struct device *dev, pm_message_t mesg)
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index d422db6eec63..e2cc09ecc447 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -45,6 +45,7 @@ struct platform_device {
>  };
>  
>  #define platform_get_device_id(pdev)	((pdev)->id_entry)
> +extern const void *platform_get_device_match_data(const struct platform_device *pdev);
>  
>  #define dev_is_platform(dev) ((dev)->bus == &platform_bus_type)
>  #define to_platform_device(x) container_of((x), struct platform_device, dev)
> 


