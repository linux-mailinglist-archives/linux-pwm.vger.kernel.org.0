Return-Path: <linux-pwm+bounces-1850-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50156895AE3
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Apr 2024 19:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC2D1F21DA2
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Apr 2024 17:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDB815A4A6;
	Tue,  2 Apr 2024 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0pxRBGC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248417BB7;
	Tue,  2 Apr 2024 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079654; cv=none; b=RPbURTwDGA3Ct3Qm7xCmliV7Hi2e/BKSHx31rEWnk2dywhf+LKHSYjkrZNyyhgAG4/sVC5yx/BdsMbLmhvzoy2RokEMMryxUx/D4G/rn3ZsqcWhDXcnxdlGrRq2GQMFO0WSD4NEuJ2Vm/CI+98QJgsg2499Ccd3Z3Vbtk/LUmxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079654; c=relaxed/simple;
	bh=rOoYl8MM4akGFWw4ON4nG8u58BI+J0+HplPfMqOklfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ud/ROIP0+Q/OFG7F+cuhDcNy50tAoz6oSMoNvydXBSsKfTsViw8BLEwPHTtfEMGE1u/epRh+vcAYzSA12pO/acXXhHHcnvZeQ0kH5Cg/0oRHs+2NxaqPD18PxzbbAPZQ/onYrvr5tiAB4S/5CAME8hoUN1FSr1us/Tm42YpDLd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0pxRBGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D083C433F1;
	Tue,  2 Apr 2024 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712079654;
	bh=rOoYl8MM4akGFWw4ON4nG8u58BI+J0+HplPfMqOklfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0pxRBGC5oYHJ1ujp6gXFafw41NnQ3jxoE26RW7RoSamIfbwFjR/Y33cs7/ybbFrj
	 RYFqFZVFcSeZUjVqhHspVQ/hCGu2y2Q6ppSe3EXI/7zHSjLfmI8J03/RCObfCD9Idz
	 IeliCtKmWfWexphwnK/mx2wLcd2DY7yIKCAs/PsMHH0/68PjMDXAe09wcfoWT9gy0V
	 8WTfWLie821GTLj6eOyHV+7HmdmPx3gmSU2bgKu3rmnCk8zcemevz4M6ewoQK2bXhX
	 4TVhCXuGvJOVzzZmqlg7UOAtOrU6T9FRYxlCQMB1chirNx/6X5mdKfIQzYbnEAsVZm
	 8zBSs0jtPDEjg==
Date: Tue, 2 Apr 2024 12:40:51 -0500
From: Rob Herring <robh@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	loongson-kernel@lists.loongnix.cn, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v1 1/5] dt-bindings: pwm: Add Loongson PWM controller
Message-ID: <20240402174051.GA324804-robh@kernel.org>
References: <cover.1711953223.git.zhoubinbin@loongson.cn>
 <edad2bb5b0045c633734c1499fb163c3c6776121.1711953223.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edad2bb5b0045c633734c1499fb163c3c6776121.1711953223.git.zhoubinbin@loongson.cn>

On Tue, Apr 02, 2024 at 03:58:38PM +0800, Binbin Zhou wrote:
> Add Loongson PWM controller binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../devicetree/bindings/pwm/pwm-loongson.yaml | 64 +++++++++++++++++++

Filename should match compatible.

>  MAINTAINERS                                   |  6 ++
>  2 files changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-loongson.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-loongson.yaml b/Documentation/devicetree/bindings/pwm/pwm-loongson.yaml
> new file mode 100644
> index 000000000000..d25904468353
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-loongson.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-loongson.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson PWM Controller
> +
> +maintainers:
> +  - Binbin Zhou <zhoubinbin@loongson.cn>
> +
> +description:
> +  It is the generic PWM framework driver for Loongson family.

That's describing the driver. Not really relevant to the binding.


> +  Each PWM has one pulse width output signal and one pulse input
> +  signal to be measured.
> +  It can be found on Loongson-2K series cpus and Loongson LS7A bridge chips.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: loongson,ls7a-pwm
> +      - items:
> +          - enum:
> +              - loongson,ls2k0500-pwm
> +              - loongson,ls2k1000-pwm
> +              - loongson,ls2k2000-pwm
> +          - const: loongson,ls7a-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#pwm-cells':
> +    const: 3

Please define what is in each cell. If there's only 2 signals, then the 
first cell defines the output or input (what value for which one?).

Really, the PWM binding is only for outputs, so is a cell even needed? I 
suppose we could use it for inputs too, but that's really "input 
capture" type operation that timers often have. I'll defer to the PWM 
maintainers...

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - '#pwm-cells'

pwm.yaml makes this required already.

Rob


