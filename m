Return-Path: <linux-pwm+bounces-4147-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4B79D8E13
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Nov 2024 22:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A065EB289C4
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Nov 2024 21:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DC919066E;
	Mon, 25 Nov 2024 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSjwt2+Z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A858188010;
	Mon, 25 Nov 2024 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570205; cv=none; b=Q5CLMeU9ZCrgiIyny2ZhiA1OmCRKShCRmSlauOneBAi4rEhvMFyTupQUQQF/uIObmR2igXQ/De7qMOQSgy4Uhu6wcrlXNxxf8dhpEmT+yUA/0Zq1WnhlV3OCA/1jFCIv6nZFx0rJxnjlnOfASAHIslk/kNdsH1MNSjm44eK3MTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570205; c=relaxed/simple;
	bh=ccHnVZ69+9d59Nu5DADSW7/w79ZvzuCfeu6NFvAXE/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCL8jRpPr2+7IGqLMbZMq9zvp4CtECceZ/uCtv1qNdwchNR1HolF2GdeV/KAgFdqTV42GXhbWKX50EuSHCrHf87y1URTK+NQsTXsWKf+mfCHuiB80hUfX1LtySrqVvbeLqY+c0N6V2ATq+7cP9wfYYcy0Cqb6l9j9HLnmRHf2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSjwt2+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A667AC4CECE;
	Mon, 25 Nov 2024 21:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732570204;
	bh=ccHnVZ69+9d59Nu5DADSW7/w79ZvzuCfeu6NFvAXE/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oSjwt2+ZOZ6O1jAZJI0LTdhB8bPA0PY6hApxfzOQarKjkY9AA4vmW+vfq/RfFe/qJ
	 COvPy/Ho5Q9/hNsKHSh5+GtvpgGdg+iT8ayXuihLmIoTQ/gMn9gFvPCyg8BHwcGWuG
	 Veh51KCIrmOYRss8J8PspxI/NLco+18JMKgvUEEFxlVhixjOlwL/Hi+I5MKibOKwNo
	 EjJIuBbfmvt3eLEE7v5wYcDHHXmSRnA7fraJwbJ4qgllVXoTi6mP6pyKG+O++iIyyL
	 j4hXUvmuJ9dNEAj8b1torJDZdxy4IwLQ4obcb5/xjL53SDO+CQwXKVzh+ePk7OOLmH
	 lek7+t3ptIyeQ==
Date: Mon, 25 Nov 2024 21:29:55 +0000
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
Subject: Re: [PATCH v5 01/16] spi: add basic support for SPI offloading
Message-ID: <20241125212955.6d5748b5@jic23-huawei>
In-Reply-To: <22bc45a0-9d14-480a-bcce-bae394166967@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
	<20241115-dlech-mainline-spi-engine-offload-2-v5-1-bea815bd5ea5@baylibre.com>
	<20241124163241.4699161f@jic23-huawei>
	<22bc45a0-9d14-480a-bcce-bae394166967@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Nov 2024 12:01:23 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 11/24/24 10:32 AM, Jonathan Cameron wrote:
> > On Fri, 15 Nov 2024 14:18:40 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> Add the basic infrastructure to support SPI offload providers and
> >> consumers.
> >>  
> 
> ...
> 
> >> +	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
> >> +	if (!resource)
> >> +		return ERR_PTR(-ENOMEM);
> >> +
> >> +	resource->controller = spi->controller;
> >> +	resource->offload = spi->controller->get_offload(spi, config);
> >> +	ret = PTR_ERR_OR_ZERO(resource->offload);
> >> +	if (ret) {  
> > Why not simply
> > 	if (IS_ERR(resource->offload) {
> > 		kfree(resource);
> > 		return resource->offload;
> > 	}  
> >> +		kfree(resource);
> >> +		return ERR_PTR(ret);
> >> +	}  
> 
> Hmm... maybe somewhere along the way ret was being checked again
> after this, but doesn't to be the case anymore.
> 
> >> +
> >> +	ret = devm_add_action_or_reset(dev, spi_offload_put, resource);
> >> +	if (ret)
> >> +		return ERR_PTR(ret);
> >> +
> >> +	return resource->offload;
> >> +}
> >> +EXPORT_SYMBOL_GPL(devm_spi_offload_get);  
> >   
> >> diff --git a/include/linux/spi/spi-offload.h b/include/linux/spi/spi-offload.h
> >> new file mode 100644
> >> index 000000000000..81b115fc89bf
> >> --- /dev/null
> >> +++ b/include/linux/spi/spi-offload.h  
> >   
> >> +
> >> +MODULE_IMPORT_NS(SPI_OFFLOAD);  
> > 
> > This is rarely done in headers. (only pwm.h does it I think)
> > I'd push it down into code that uses this.  
> 
> Yes, it was Uwe that suggested that I put it in the header. :-)
> 
> Are there any unwanted side effects of having it in the header?
Reviewer surprise?
:)

Up to Mark as he gets to enjoy this code for ever.

> 
> > 
> > It might be worth splitting the header into a spi-offload-provider.h
> > and spi-offload-consumer.h with a common spi-offload-types.h included
> > by both.
> >   


