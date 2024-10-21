Return-Path: <linux-pwm+bounces-3739-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0DE9A72C6
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2024 21:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373C31F23E89
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2024 19:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445101CF7CC;
	Mon, 21 Oct 2024 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icgPAVVX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0771946CA;
	Mon, 21 Oct 2024 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537255; cv=none; b=gTlKRT/toSzSK9uL2xHauTeBAF+LnhiCIHOoUc3yysVBsFOfQIcpwjMfqR8AnvT3WrUsTUl3lBK3nh5vmzvo94R6GWVNJnd2JTtX2Ieryu9XSmJRigemSFTaOadIsTBc3N2kHnN3s9St5MrGLWlDUGkWL3jeRysj0EpXLc1FAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537255; c=relaxed/simple;
	bh=1+aoPMboBygEKxSiE2RfvUpJhAyTmUBmlDBCyeFerjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaFh+0Th3+YtkpXJjNEN2rWjhcSeOaphQ2Zys7gtQvPaIiiKV4BNrBI+Iad7LV9k6wJVjk6LpUzobZbrX9MexsURLXdsd32vdC48qNo/rsggHVT10Llw1QDoMeNDUoQmvFNTnS2xvJ7rK04VasXwTwfjJFq3YMkyaBOwvXqNKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icgPAVVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926FBC4CEC3;
	Mon, 21 Oct 2024 19:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729537254;
	bh=1+aoPMboBygEKxSiE2RfvUpJhAyTmUBmlDBCyeFerjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icgPAVVXlk6ddNz9xJzZvxK/DPaJsvzTm14oIho8L9m9tLjg319wkKZdoaxtgLxoK
	 37eH1zOC0gR8TjASQnE12VPKk9/PdhqHK2tDJv3tJ1cnNIZ5dZIColv+r/Yf1UD6Oi
	 wViN7kj5oEIQlfaaGXucGgBSbr/83h7u7A+kRu+D1TZrfezD+K8w/VukbAZfaBVK38
	 CgoXjLDJHisxPBCm9Ye5IP9f4YisRueBkVuNacxEw9ObIho1kmnusc5Kcm4V57toMn
	 uExRsrOoowdJ+KOEscH2AvGj2IqH/TBrWYn2dkqkaFpafnYlHjrI/PPmZazp+e37Y3
	 U5lzqboplqgmw==
Date: Mon, 21 Oct 2024 14:00:53 -0500
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v8 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
Message-ID: <20241021190053.GA948525-robh@kernel.org>
References: <20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org>
 <20241018-en7581-pinctrl-v8-3-b676b966a1d1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-en7581-pinctrl-v8-3-b676b966a1d1@kernel.org>

On Fri, Oct 18, 2024 at 03:19:04PM +0200, Lorenzo Bianconi wrote:
> Introduce device-tree binding documentation for Airoha EN7581 pwm
> controller.
> 
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../devicetree/bindings/pwm/airoha,en7581-pwm.yaml | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..fb68c10b037b840a571a2ceee57f13cbae78da66
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/airoha,en7581-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha EN7581 PWM Controller
> +
> +maintainers:
> +  - Lorenzo Bianconi <lorenzo@kernel.org>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: airoha,en7581-pwm
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +  airoha,74hc595-mode:
> +    description: Set the PWM to handle attached shift register chip 74HC595.
> +
> +      With this disabled, PWM assume a 74HC164 chip attached.
> +
> +      The main difference between the 2 chip is the presence of a latch pin
> +      that needs to triggered to apply the configuration and PWM needs to
> +      account for that.
> +    type: boolean
> +
> +  airoha,sipo-clock-divisor:
> +    description: Declare Shift Register chip clock divisor (clock source is
> +      from SoC APB Clock)

Where is the clock source defined?

You can specify the PWM frequency in PWM cells and should be able to get 
the APB Clock frequency. Then you can calculate the divider.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 32
> +    enum: [4, 8, 16, 32]
> +
> +  airoha,sipo-clock-delay:
> +    description: Declare Serial GPIO Clock delay.
> +      This can be needed to permit the attached shift register to correctly
> +      setup and apply settings. Value must NOT be greater than
> +      "airoha,sipo-clock-divisor" / 2
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 1
> +    minimum: 1
> +    maximum: 16
> +
> +required:
> +  - compatible
> +  - "#pwm-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm {
> +      compatible = "airoha,en7581-pwm";
> +
> +      #pwm-cells = <3>;
> +    };
> 
> -- 
> 2.47.0
> 

