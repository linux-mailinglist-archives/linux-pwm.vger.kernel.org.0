Return-Path: <linux-pwm+bounces-4109-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BBB9D2B88
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 17:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F15B0B2B2A9
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394D11CF2B6;
	Tue, 19 Nov 2024 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRdZc9Dz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0118A1CC88B;
	Tue, 19 Nov 2024 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034253; cv=none; b=CeW9IH1Kfmty+M12K2hgQ2K2oE7w2evGWvUZsLm0fDYJxlYAQ4mPKbrL6Ny3FSnCJ40bRG8hzUA0I7yf2eMrU4rwMsNFZqC4Tv57H8aRYWh9LxLhv8NkcrJsNlJ0txmkrWgdpHuclzSTvEOXvnz/PRbkRJcP4+cp9l4m2kg3ZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034253; c=relaxed/simple;
	bh=sNdvLbL4aOxoLXjKy6ZHtsflibffPE5ejyEc/6CBqQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sw1ka888kP4DhJSDX1sgmVO91EfRmFuufJvkezaSIzFIYzl80hfZ8zb6BFYEfX7zV1/9ICJnNDWkyRTIzMAnuCv86/HvU6d/EUm+UrgOMgp/A6jF1/FGfxjvtgJqwS+dTvZMt9pBn1FOL/7bSLdKZWQjlhtWLz0Dud9LcVO8vE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRdZc9Dz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F96C4CECF;
	Tue, 19 Nov 2024 16:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732034252;
	bh=sNdvLbL4aOxoLXjKy6ZHtsflibffPE5ejyEc/6CBqQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRdZc9Dzr2TU8yxwhV7GmeRRFrwpeJw7tyrGYfywrJdZPzKMD5ifZ/yBfEJOQBcc8
	 VdOfu7KUthV+STeNtq65wmAEHjaDVOwjOGGTa36pX5LWnw0hH94lLyjByYFSOpApi/
	 pW0rrsUQxs+fka+2IqWQg1ja7JBoEg1mYFziLiWFqLfiMGZwH015PAuqniiEj2oZbz
	 596h8vJHbyiRDeWBHqo6HdLf9KTrvctu5gO9gtTcSdRjFwre5Vd+/uCA0E55mD9U6u
	 Q1lxeyreOxHp5tav/WXd6WQAKKNz9eJvCbci6lGSLNyib43LglkIqsf50oeHPqWYRH
	 J4Sn78PFubj+Q==
Date: Tue, 19 Nov 2024 10:37:31 -0600
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
Subject: Re: [PATCH v5 04/16] spi: dt-bindings: add PWM SPI offload trigger
Message-ID: <20241119163731.GA1769375-robh@kernel.org>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
 <20241115-dlech-mainline-spi-engine-offload-2-v5-4-bea815bd5ea5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-4-bea815bd5ea5@baylibre.com>

On Fri, Nov 15, 2024 at 02:18:43PM -0600, David Lechner wrote:
> Add a new binding for using a PWM signal as a trigger for SPI offloads.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v5 changes:
> * Add MAINTAINERS entry
> 
> v4 changes: new patch in v4
> ---
>  .../devicetree/bindings/spi/trigger-pwm.yaml       | 39 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 40 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/trigger-pwm.yaml b/Documentation/devicetree/bindings/spi/trigger-pwm.yaml
> new file mode 100644
> index 000000000000..987638aa4732
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/trigger-pwm.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/trigger-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic SPI offload trigger using PWM

Not really anything specific to SPI offload here.

I think this should be moved to 
bindings/trigger-source/trigger-pwm.yaml.


> +
> +description: Remaps a PWM channel as a trigger source.
> +
> +maintainers:
> +  - David Lechner <dlechner@baylibre.com>
> +
> +$ref: /schemas/spi/trigger-source.yaml#

Including this doesn't really do anything. Will add more detail in its 
patch.

> +
> +properties:
> +  compatible:
> +    const: trigger-pwm
> +
> +  '#trigger-source-cells':
> +    const: 0
> +
> +  pwms:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - '#trigger-source-cells'
> +  - pwms
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    trigger {
> +        compatible = "trigger-pwm";
> +        #trigger-source-cells = <0>;
> +        pwms = <&pwm 0 1000000 0>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 91a4a7eb6194..a43532a1edde 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22021,6 +22021,7 @@ F:	include/linux/mtd/spi-nor.h
>  
>  SPI OFFLOAD
>  R:	David Lechner <dlechner@baylibre.com>
> +F:	Documentation/devicetree/bindings/spi/trigger-pwm.yaml
>  F:	Documentation/devicetree/bindings/spi/trigger-source.yaml
>  F:	drivers/spi/spi-offload.c
>  F:	include/linux/spi/spi-offload.h
> 
> -- 
> 2.43.0
> 

