Return-Path: <linux-pwm+bounces-6039-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD0EABF0F7
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 12:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5653B2B62
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 10:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711C254869;
	Wed, 21 May 2025 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htFnLCJQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0989F23D285;
	Wed, 21 May 2025 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822146; cv=none; b=Y0/KcQg9UjvpN9h9pUwTKjKFk/nFb/YDvArqAIulpEX6lBiztQoIySkyrp7XdlTdzHPksLd16AmvIXXx58PRamQsNBaQ/eD4+LbP5AdYSwzTAxGoB4QGnFCySlRdfO9reoe3UieISSErkXmZaDmy5kohh+1MHmnHrzXiRcEiYvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822146; c=relaxed/simple;
	bh=9JoOH2EMuN4WA0lSEFqYdASBKHeA8IOS1B0EtdwpIWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ/qoLbHNlW4RaJ2MyNxlYFoJh47EAMISvvLuyJ4Zk0slThj54zEeYQLvSRE7tt7fcy+oXznWwi4iXsRdPmbn9J72RDt5ss836Fzca9AdiycvX1TRYvZrdneJgypX2mt0Z1L7lKclI+p7JduA2rgS+FMm43C/ipauV+lbyrJiDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htFnLCJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E23C4CEE4;
	Wed, 21 May 2025 10:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747822145;
	bh=9JoOH2EMuN4WA0lSEFqYdASBKHeA8IOS1B0EtdwpIWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htFnLCJQWg0GhEfrR0igwtUXsaXz5b5U/3Kd8SP6+Zba9X4OaViT9bbGM7G+yCPxT
	 cE5bDadyeaHMfH/0hIxNPRSQj6Q47fsJlpx5HbCBDgftTzSrICNL/vUM6Wco6WS8rH
	 vlrL+gJ/kL9EhgSEMVsShjF9em+pyq8mNrU+GPXHa1/b4s279T/n25/VJ8pcaq3E1o
	 pMWb/Nkl0Ylg0989UUDlitmzPgEfxkoRIFARrWAQhzCSNMcC5CA6rK8DihRl74vmkU
	 u2Fn6PcJi7nb8P/0C+eouw71OqjgXusaGUuvVUh3ZKvbM+XQ59/zvR+PfZ1EAzLNEr
	 OX+2IxHCHyTKw==
Date: Wed, 21 May 2025 12:09:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: pwm: adi,axi-pwmgen: add external clock
Message-ID: <20250521-tidy-heron-of-genius-4dc9a1@kuoka>
References: <20250520-pwm-axi-pwmgen-add-external-clock-v1-0-6cd63cc001c8@baylibre.com>
 <20250520-pwm-axi-pwmgen-add-external-clock-v1-2-6cd63cc001c8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250520-pwm-axi-pwmgen-add-external-clock-v1-2-6cd63cc001c8@baylibre.com>

On Tue, May 20, 2025 at 04:00:45PM GMT, David Lechner wrote:
> Add external clock to the schema.
> 
> The AXI PWMGEN IP block has a compile option ASYNC_CLK_EN that allows
> the use of an external clock for the PWM output separate from the AXI
> clock that runs the peripheral.
> 
> In these cases, we should specify both clocks in the device tree. The
> intention here is that if you specify both clocks, then you include the
> clock-names property and if you don't have an external clock, then you
> omit the clock-names property.
> 
> There can't be more than one allOf: in the top level of the schema, so
> it is stolen from $ref since it isn't needed there and used for the
> more typical case of the if statement (even though technically it isn't
> needed there either at this time).
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  .../devicetree/bindings/pwm/adi,axi-pwmgen.yaml    | 26 ++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> index bc44381692054f647a160a6573dae4cff2ee3f31..90f702a5cd80bd7d62e2436b2eed44314ab4fd53 100644
> --- a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> +++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
> @@ -16,8 +16,7 @@ description:
>  
>    https://analogdevicesinc.github.io/hdl/library/axi_pwm_gen/index.html
>  
> -allOf:
> -  - $ref: pwm.yaml#
> +$ref: pwm.yaml#
>  
>  properties:
>    compatible:
> @@ -30,7 +29,13 @@ properties:
>      const: 3
>  
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: axi
> +      - const: ext
>  
>  required:
>    - reg
> @@ -38,11 +43,24 @@ required:
>  
>  unevaluatedProperties: false
>  
> +allOf:
> +  - if:
> +      required: [clock-names]


No, don't do that. If you want clock-names, just add them for both
cases. Otherwise, just describe items in clocks and no need for
clock-names.



> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +
>  examples:
>    - |
>      pwm@44b00000 {
>          compatible = "adi,axi-pwmgen-2.00.a";
>          reg = <0x44b00000 0x1000>;
> -        clocks = <&spi_clk>;
> +        clocks = <&fpga_clk>, <&spi_clk>;

What was the clock[0] before? Axi, right, so SPI_CLK. Now FPGA is the
AXI_CLK? This feels like clock order reversed.

Best regards,
Krzysztof


