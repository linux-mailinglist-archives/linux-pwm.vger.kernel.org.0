Return-Path: <linux-pwm+bounces-4111-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 533B19D2BE9
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 17:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199C5288993
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2321D0E04;
	Tue, 19 Nov 2024 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTr9ceoR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860E1CDA0E;
	Tue, 19 Nov 2024 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035409; cv=none; b=Ic9c0J3DqCD19WovnXQ026BQJxotXnFPKqGEKyzRG2Xo5gCtTwY+zXK+VRIAeHee9U/9BgZPuaiEba0qBgTAUC59WuIE/laaWym1ug1MZRkAQr0KJgvZCaQUFzo8zxyIp58ltSK8ja/f3WMmsQXWGDO/NiduBtQWf57Xy3HmEOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035409; c=relaxed/simple;
	bh=isudyVi77+zwnwPMjfIQ8wkyDG+TjsAPlDa6nBHA3cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBOwJpsQCabWuz+Uy9vg1Zkm3kwKNHOMU1L8JoiwKMq9p9koYKf5qXWJNXsBNtLkv91TJyEt2/AQQMffv6WCBbzpZdWdf0jote4SwSkSEGH2QWyScgfAIZCwplTF9GctgRUuiBlB3OtkdroDenoFJo4q/Pn41fXsFdmlFwUa2js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTr9ceoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357A6C4CECF;
	Tue, 19 Nov 2024 16:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732035408;
	bh=isudyVi77+zwnwPMjfIQ8wkyDG+TjsAPlDa6nBHA3cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTr9ceoRAGjMZDaNnHya2rPgnEdk06WNbbTGAUXbzrKBN9oKtC3YP1k77snS319eh
	 OynTKRxdj8wwco9xNZLz+9hS5GoioDX3eecv8stH/1tPohkuaLvD6CJBPHSdgw0Z5D
	 zPVNXHcv0AtdQJt8OH4Tu60km35S7ZpTZOAuIWybFn9Y4tJdnJbT7/IgCRe2bYxpWC
	 KUxlgEQ2S7q3wWRyhLCKN8NGLXpYwGAm3WYw8EVHcctGKkaVngRSvz2lRZBMrHIH9o
	 hX8rOCY0UkGLTlm4f9Ykd09RTWgGz89/sWw6+q4Mr52GP05GfMwT6/hpulqQ7e56DJ
	 owAhuBs/rC93Q==
Date: Tue, 19 Nov 2024 10:56:46 -0600
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 07/16] spi: dt-bindings: axi-spi-engine: add SPI
 offload properties
Message-ID: <20241119165646.GA1798301-robh@kernel.org>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
 <20241115-dlech-mainline-spi-engine-offload-2-v5-7-bea815bd5ea5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-7-bea815bd5ea5@baylibre.com>

On Fri, Nov 15, 2024 at 02:18:46PM -0600, David Lechner wrote:
> The AXI SPI Engine has support for hardware offloading capabilities.
> This includes a connection to a DMA controller for streaming RX data
> and a trigger input for starting execution of the SPI message programmed
> in the offload.
> 
> Each SPI Engine may have up to 1 offload. The spec actually says that
> it could support up to 32, so we are using an index number in the
> dma-names (e.g. offload0-rx) to allow for this possibility in the
> future.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v5 changes:
> * Also document offload0-tx DMA names since the hardware can support
>   that now.
> * Limit the number of offloads to 1 for now since it would require
>   significant hardware changes to actually support more than that.
> 
> v4 changes:
> * Dropped #spi-offload-cells property.
> * Changed subject line.
> 
> v3 changes:
> * Added #spi-offload-cells property.
> * Added properties for triggers and RX data stream connected to DMA.
> 
> v2 changes:
> * This is basically a new patch. It partially replaces "dt-bindings:
>   iio: offload: add binding for PWM/DMA triggered buffer".
> * The controller no longer has an offloads object node and the
>   spi-offloads property is now a standard SPI peripheral property.
> ---
>  .../bindings/spi/adi,axi-spi-engine.yaml           | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> index d48faa42d025..d703b47eb498 100644
> --- a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> +++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> @@ -41,6 +41,26 @@ properties:
>        - const: s_axi_aclk
>        - const: spi_clk
>  
> +  trigger-sources:
> +    description:
> +      An array of trigger source phandles for offload instances. The index in
> +      the array corresponds to the offload instance number.

How can you have an index when you only allow 1 entry (other than 0 of 
course)?

> +    $ref: /schemas/types.yaml#/definitions/phandle-array

With my other comments implemented, this should be dropped.

> +    maxItems: 1
> +
> +  dmas:
> +    description:
> +      DMA channels connected to the input or output stream interface of an
> +      offload instance.
> +    minItems: 1
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      pattern: "^offload0-[tr]x$"

Do you expect an offload1 or something?

> +    minItems: 1
> +    maxItems: 2
> +
>  required:
>    - compatible
>    - reg
> @@ -59,6 +79,10 @@ examples:
>          clocks = <&clkc 15>, <&clkc 15>;
>          clock-names = "s_axi_aclk", "spi_clk";
>  
> +        trigger-sources = <&trigger_clock>;
> +        dmas = <&dma 0>;
> +        dma-names = "offload0-rx";
> +
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> 
> -- 
> 2.43.0
> 

