Return-Path: <linux-pwm+bounces-4112-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6F29D2CE1
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 18:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9395FB398F5
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5B91D1F73;
	Tue, 19 Nov 2024 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KifdsZm5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F861CCB4E;
	Tue, 19 Nov 2024 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035495; cv=none; b=W3l0l3UJeyDJNig2AVtlWbD5UBjz2CUnYDhPGyUDHQW2s45EUY0f8MeeDx4OZF09n7f8a55TVYjMCISsG238nggAg4NHr0LHfanDjCkyKr0ICwYqg19AtChCsGXhQX4hGkoPHtyRprzGA+BOF470V2eCfn7RHTJZfF/xuHH/Bds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035495; c=relaxed/simple;
	bh=z11CsHgeatOeQbBfb9g6txoshHC37gyk3mW02xh8UOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfptlYEO+H4h7FHOdXf4W/B7FLXJFFOknpDgjVdAX2vLTcp7vfUwWIwPLpbluUd153SbRgWVHaQDfA3t6ubzxWfTcRDz05XQV+VIJpze0xlpM6g01vTROKbz7MU9GVztLrVd/QPfAS0xCK8lYZK/fdLxcXkScM/mZe8fYzfE2v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KifdsZm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD6BC4CECF;
	Tue, 19 Nov 2024 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732035494;
	bh=z11CsHgeatOeQbBfb9g6txoshHC37gyk3mW02xh8UOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KifdsZm5RJh53lt8/I0uKRX8lonGHO8RAHshhzUGEzpnYJXU+Qomrz4RUurTleRdV
	 z8gCTPK0vIwV5D1J0UxTl5lNqULo9LiQpc7o7LmZ2HrxZ6meQB+/YyuA/Qd2yjU10a
	 pijqYMlMNceZ0W+YW+6s69kKXkdGjOpEtFH2sjLK6UfM4HFowcvnLozbkx2ZcM1sM4
	 04pr4tndUEUYuf4sAC1UEuJT1BZ1jPTZqletnjbI+R1OoQS1FNiLgRqWtpxht/5Z4V
	 TiFQcJqvGImQo6aw0KBeXyY+TOwHJ+b+deQsVA5CAoUPybsduDsIaCtmgPLLQdkBRX
	 DN+Iz3lfjdobQ==
Date: Tue, 19 Nov 2024 10:58:12 -0600
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
Subject: Re: [PATCH v5 14/16] dt-bindings: iio: adc: adi,ad4695: add SPI
 offload properties
Message-ID: <20241119165812.GA1801845-robh@kernel.org>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
 <20241115-dlech-mainline-spi-engine-offload-2-v5-14-bea815bd5ea5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-14-bea815bd5ea5@baylibre.com>

On Fri, Nov 15, 2024 at 02:18:53PM -0600, David Lechner wrote:
> Add a pwms property to the adi,ad4695 binding to specify an optional PWM
> output connected to the CNV pin on the ADC.
> 
> Also add #trigger-source-cells property to allow the BUSY output to be
> used as a SPI offload trigger source to indicate when a sample is ready
> to be read.
> 
> Macros are added to adi,ad4695.h for the cell values to help with
> readability since they are arbitrary values.
> 
> The $ref for spi-peripheral-props.yaml is moved to keep similar $refs
> grouped together.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v5 changes:
> * Added macros for cell values
> 
> v4 changes: new patch in v4
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4695.yaml          | 16 ++++++++++++++--
>  include/dt-bindings/iio/adc/adi,ad4695.h                 |  7 +++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
> index 7d2229dee444..c0d4e4ff62a4 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
> @@ -18,8 +18,6 @@ description: |
>    * https://www.analog.com/en/products/ad4697.html
>    * https://www.analog.com/en/products/ad4698.html
>  
> -$ref: /schemas/spi/spi-peripheral-props.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -84,6 +82,9 @@ properties:
>      description: The Reset Input (RESET). Should be configured GPIO_ACTIVE_LOW.
>      maxItems: 1
>  
> +  pwms:
> +    description: PWM signal connected to the CNV pin.

maxItems: 1

> +
>    interrupts:
>      minItems: 1
>      items:
> @@ -106,6 +107,15 @@ properties:
>        The first cell is the GPn number: 0 to 3.
>        The second cell takes standard GPIO flags.
>  
> +  '#trigger-source-cells':
> +    description: |
> +      First cell indicates the output signal: 0 = BUSY, 1 = ALERT.
> +      Second cell indicates which GPn pin is used: 0, 2 or 3.
> +
> +      For convenience, macros for these values are available in
> +      dt-bindings/iio/adc/adi,ad4695.h.
> +    const: 2
> +
>    "#address-cells":
>      const: 1
>  
> @@ -166,6 +176,8 @@ required:
>    - vio-supply
>  
>  allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - $ref: /schemas/spi/trigger-source.yaml#

This can be dropped.

>    - oneOf:
>        - required:
>            - ldo-in-supply
> diff --git a/include/dt-bindings/iio/adc/adi,ad4695.h b/include/dt-bindings/iio/adc/adi,ad4695.h
> index 9fbef542bf67..fea4525d2710 100644
> --- a/include/dt-bindings/iio/adc/adi,ad4695.h
> +++ b/include/dt-bindings/iio/adc/adi,ad4695.h
> @@ -6,4 +6,11 @@
>  #define AD4695_COMMON_MODE_REFGND	0xFF
>  #define AD4695_COMMON_MODE_COM		0xFE
>  
> +#define AD4695_TRIGGER_EVENT_BUSY	0
> +#define AD4695_TRIGGER_EVENT_ALERT	1
> +
> +#define AD4695_TRIGGER_PIN_GP0		0
> +#define AD4695_TRIGGER_PIN_GP2		2
> +#define AD4695_TRIGGER_PIN_GP3		3
> +
>  #endif /* _DT_BINDINGS_ADI_AD4695_H */
> 
> -- 
> 2.43.0
> 

