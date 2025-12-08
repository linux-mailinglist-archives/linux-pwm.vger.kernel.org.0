Return-Path: <linux-pwm+bounces-7775-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6232CCAC3B8
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Dec 2025 07:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 977193063C12
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Dec 2025 06:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C916E23B63E;
	Mon,  8 Dec 2025 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYt9raRa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6D53E0B;
	Mon,  8 Dec 2025 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765176726; cv=none; b=dEw8Qbq308bnF4hFqGLhjIskHTN77NDW9xg6FDmFilxFvs4ck6xQDYlj4lgQ177mmy8L61QGjxdvuIKHrm4LYq00KrXtqkRJhdEHRGLdWK3MqsktWe4RBqqhMXgSDt3gqCoXmYkIGJfm5UppE2MzKdfviuMt9zpnCiamf9BV8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765176726; c=relaxed/simple;
	bh=WiykqAdfvwtZNBYSkcwFcQxsD9zJPgq+W1gZ+z+0c6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i18IUIgT79eSX4JYCikzt6UCccd+OdIrdFeEEf7bSvYRCUveszpnEVbNf4VPK8AW2ppcz8Vbk1g7uc+8QBmJnAVvr+0RgIkDl5jK60IxLFn32aByVCaeadAlh05kWbC89GzvvmL4fIAAN5KxHN6tEtLWE1tlt74kXP4YI4OaD+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYt9raRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A24C4CEF1;
	Mon,  8 Dec 2025 06:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765176725;
	bh=WiykqAdfvwtZNBYSkcwFcQxsD9zJPgq+W1gZ+z+0c6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYt9raRaVMXk/82ZXZgg+KIzuJk6kaFcjjmbzJhOFhDI4UnNS+t4mnbSZwobxIJuB
	 tJXwyNrkghr8pHCPLrP89DrEInA37Jitk0fANArNCa8X/jqAbj/eAGJtXJzkLByKWc
	 UOaCxuiNQ5zb5jvYZEKv0KudwMt1PNFYxmKLYmIcCaQDJXL3Vh3+yyKvAXlKsK0GFP
	 PEQJTRl5p5ab2eiCcUSUB+9j5g2UqqK3hdQrOIyxh5whymTbjEjMMKe3MrupjG811S
	 bR4v8cjcX/0Yzus/XLxqbj9vpuhQKwRscDEN0t8VFRzh5NskIT1bVe4tT3FAYEy264
	 r+2j6HhfUXusw==
Date: Mon, 8 Dec 2025 07:52:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: pwm: sunxi: add PWM controller for
 Allwinner H616
Message-ID: <20251208-gorgeous-capuchin-of-protection-4ad0c2@quoll>
References: <20251205100239.1563353-1-richard.genoud@bootlin.com>
 <20251205100239.1563353-2-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251205100239.1563353-2-richard.genoud@bootlin.com>

On Fri, Dec 05, 2025 at 11:02:36AM +0100, Richard Genoud wrote:
> Allwinner H616 SoC contains a PWM controller quite different from the A10.
> It has 6 channels than can generate PWM waveforms or clocks if bypass is
> enabled.
> 
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  .../pwm/allwinner,sun50i-h616-pwm.yaml        | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun50i-h616-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun50i-h616-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun50i-h616-pwm.yaml
> new file mode 100644
> index 000000000000..b89735ad3a43
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun50i-h616-pwm.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/allwinner,sun50i-h616-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner H616 PWM
> +
> +maintainers:
> +  - Richard Genoud <richard.genoud@bootlin.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Allwinner H616 PWM can generate standard PWM signals with variable pulse width
> +  and period.
> +  Also, instead of a PWM signal, a channel can be used to provide a clock.
> +
> +properties:
> +  compatible:
> +    const: allwinner,sun50i-h616-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Bus Clock
> +

Are you sure there is no first clock? Really, really sure? If you add it
later, I would be pretty sad, because that's unnecessary duplication of
binidngs....

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


