Return-Path: <linux-pwm+bounces-3735-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 117BD9A6AB9
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2024 15:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95E91F22501
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2024 13:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419511F9AA9;
	Mon, 21 Oct 2024 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qqHi8+4Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2A41F941F;
	Mon, 21 Oct 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518160; cv=none; b=kOZqWcXB05m+WpU0M+YoO9uCSnYxZ2jaVCXlOkf3gUhQqc7Xd9iIwJjB2V/aArBBNEdYRC3LUUOwbkxZxPCqsQKjbTHH/f7LV8iGPytAZxxyN3OqB1FlG4teVT1EEc0SnMHfjStON8TVZrKWitKXlN+qsHs/QaQTsrkazDxUnaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518160; c=relaxed/simple;
	bh=n5HI7q6/qnPaMy91MkXSVS3aseOGNcwWR8cS2NJnzds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIsncjOW6c0cOm4Ej26ef69BAfWKHbZrL4hDoD5i1u90/s+7EEBMVNoPEEDW+m89tMnRIfjMGAxtndFL2UwT2X5w+OWWudRaCXwzACmfFY1aMKaxFpgz97EAyH6SoShvFtHcx2V1ijPtZKKdc2Uk9lxTPL31+nrRTVTAsvizS1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qqHi8+4Y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729518155;
	bh=n5HI7q6/qnPaMy91MkXSVS3aseOGNcwWR8cS2NJnzds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qqHi8+4YbupJzReCJyWP/vsWSVsihO8SUuyYAr4mbkvwY0lJuR2MzI1vI67cP0FuP
	 WcAuGxAia/JPCOBQ4pifUH/Xrnn2KME5t+PJRnA7OZd3GgHwh6Lsm3ASOTF0mEwhRb
	 DCcyOosiIhVAeqiQfV5YmStTskt7PKsp0FlQ8xmZe4i+D1JvKBvshYWAxiTrdMT80d
	 nj9rzUgLJ92exsOUqk6RSyBDVqi9daa67bqCWDftVYISEJyWQNml7mRd/k+RKMhyNR
	 06k0Mv7kh9a/okax2vbdLWGzL8kS8sHpvOnqbRs5aE9oK8b8xYolUxJXFyp+xp6ZjN
	 ePE9a1yKJpWoA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 226EC17E3619;
	Mon, 21 Oct 2024 15:42:35 +0200 (CEST)
Message-ID: <53a22d98-e369-4ca5-ae0b-bddd42d539b1@collabora.com>
Date: Mon, 21 Oct 2024 15:42:34 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com,
 linux-pwm@vger.kernel.org
References: <20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org>
 <20241018-en7581-pinctrl-v8-3-b676b966a1d1@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241018-en7581-pinctrl-v8-3-b676b966a1d1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/10/24 15:19, Lorenzo Bianconi ha scritto:
> Introduce device-tree binding documentation for Airoha EN7581 pwm
> controller.
> 
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   .../devicetree/bindings/pwm/airoha,en7581-pwm.yaml | 61 ++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
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

I think that you can either indent your description or you just don't; this
means that - if you don't - you shouldn't add extra blank lines.

In any case, that's left for the bindings maintainer to check - as for the
missing new properties I complained about in the previous version, you can
get my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

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


