Return-Path: <linux-pwm+bounces-4110-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD839D2C5C
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 18:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92344B35087
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 16:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5489E1D2B3C;
	Tue, 19 Nov 2024 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtfkJnbO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26814A639;
	Tue, 19 Nov 2024 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034672; cv=none; b=ijN0SswG6T3cjou3FFETbmhYtENY9JysCfoNi84GVXUmLp3F8SYVBS5gab/id0BLVUk9SxyN2NyhLDSco4zBTQ8oBi3aRs7/XoCcwAB3Wh9CQohLy0OesaBI2rLJ8yE3fjwkeDvljkBA9qotTPw6SG8saNwzm0lduKQ/54B4CVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034672; c=relaxed/simple;
	bh=vh/rQMmWsW0eC5ZiMITfWaU9DUli0B1GXm34M8YFvSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efdyZcxjkBV/Zzg0awzIoTq5AmCJ5ppfTvIV/FFyy2ioBG5KUBeH1t+N4t1Wk9rjftcQPTDbFEScG4qXYAoQLck1pO/afTNjZMSOXoU72cZdSe8I2QBrJ01j8hXz9FPnCfPscmCswwD8iqPenFrDQ+0w0kB8kkKRZ6qsUY6dOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtfkJnbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8208FC4CECF;
	Tue, 19 Nov 2024 16:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732034671;
	bh=vh/rQMmWsW0eC5ZiMITfWaU9DUli0B1GXm34M8YFvSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WtfkJnbOJCF/JI0XQtHtwo9j8x5uWWgD4w2/haWwAqzx44sXThCn8lzUK3iFQjIsY
	 eos7cAcYbkafsZSpzs9tqKPuSfRZgNJ+glswzwAbOsZhN3JCrSMga5g9DJV998OwX7
	 jh/gJBbCi085yOlTeYZu7FlHSMLAOOn2jx2WAJZSEQ4xmujJPUoFtb0n5tPmdqqWil
	 sKTb+kDH70tNSg0etWKTnjPbX9JVgrkbVbm25tXdRru5o4Kp+roDG2GlEWxWneEanJ
	 LGruxQKB1hExKjMcMgiqkbMhq9VYwUrhleSsffVGe3XaeOkXfn4eHv8K+jdXx6WrHU
	 cYK1UWusjJQGQ==
Date: Tue, 19 Nov 2024 10:44:29 -0600
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
Subject: Re: [PATCH v5 03/16] spi: dt-bindings: add trigger-source.yaml
Message-ID: <20241119164429.GB1769375-robh@kernel.org>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
 <20241115-dlech-mainline-spi-engine-offload-2-v5-3-bea815bd5ea5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-3-bea815bd5ea5@baylibre.com>

On Fri, Nov 15, 2024 at 02:18:42PM -0600, David Lechner wrote:
> Add a new binding for SPI offload trigger sources.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v5 changes:
> * Add MAINTAINERS entry.
> 
> v4 changes: new patch in v4.
> 
> FWIW, this is essentially identical to the leds trigger-source binding.
> ---
>  .../devicetree/bindings/spi/trigger-source.yaml    | 28 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 29 insertions(+)

This should go into dtschema instead and not be just for SPI.

> 
> diff --git a/Documentation/devicetree/bindings/spi/trigger-source.yaml b/Documentation/devicetree/bindings/spi/trigger-source.yaml
> new file mode 100644
> index 000000000000..d64367726af2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/trigger-source.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/trigger-source.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Trigger source providers for SPI offloads
> +
> +maintainers:
> +  - David Lechner <dlechner@baylibre.com>
> +
> +description:
> +  Each trigger source provider should be represented by a device tree node. It
> +  may be e.g. a SPI peripheral chip or a clock source.

select: true

So the schema is always applied.

> +
> +properties:
> +  '#trigger-source-cells':
> +    description:
> +      Number of cells in a source trigger. Typically 0 for nodes of simple
> +      trigger sources. For nodes with more than one output signal, the first
> +      cell be used to specify which output signal to use. If the same signal is
> +      available on more than one pin, the second cell can be used to specify
> +      which pin to use.
> +    enum: [ 0, 1, 2 ]

Not sure it's worth defining how many cells here since the specific 
providers have to define the exact number of cells and their use.

Add "trigger-sources" here with it's type. See other simple 
provider/consumer schemas which have both properties in one schema.

Then when you use trigger-sources in a specific binding, you just need 
to define the entries like clocks, interrupts, resets, etc.


And eventually any types defined in the kernel can be dropped, but that 
should wait a bit since older dtschema won't have them.

Rob

