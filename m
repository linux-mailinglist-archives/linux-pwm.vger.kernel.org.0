Return-Path: <linux-pwm+bounces-3679-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A08F9A06F2
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 12:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB50BB25E46
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 10:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820E2206E84;
	Wed, 16 Oct 2024 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JXxINKBd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A13205E05;
	Wed, 16 Oct 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074055; cv=none; b=Fs7vMqVJJyqC/h2hLmiuX+JvW1Ude1ZocYpRFdZtXOVa30a41/C9pzsd8jQTo5x3HVKeN/quq1YHOChks+1bbvVAccJgXSkdaN/g5rYRlR97w4d5COTn8UEX8Cd05EGGZ9kJf8H+LWedx10K+TDW0fyG0yYE+BC357ENd6yvApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074055; c=relaxed/simple;
	bh=ENMUFRInE9klSlun29NmHuXOcxx7VuVD+PMep31qMtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LX7lk8I3sCDa9iRjw7SetBd8ff5ado3VxF9nLQ6uNa7WhoM5BiayMjg4JxneO2/OMhrfjKdQZWRXX6lXg9JDZ6lKxuRyEXEBTGjtkgSdmztjfooocW94hcOEkBGIDN/tOA5M4r2Q9j6E4/tuiUOjJY5tJ1qEqBhPddjvBgMQUCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JXxINKBd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729074051;
	bh=ENMUFRInE9klSlun29NmHuXOcxx7VuVD+PMep31qMtc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JXxINKBdcyqRvlIMKmEMBywhwxqapd9TW4+9nqiZi9Z5eu2+cug2QboOs8bpyHwVK
	 MdQq2r66x+5FFHmhUE7FyuWR8iTB565T/VMP9rr1UdBDTES09gJ+cJGHl0gqCrGgXw
	 IVNuBezuLi2gaTUzCkwmY4NpZbYldTfrrZXZRoT7WyVUMpR9CisoZN5/PEj/FWFGyC
	 1B4TSE8hYr5gAPy2HcGqV2BZ3TnpFTiC7OwO9f7LkT7qwIShZyc46VBhdgYfnM3XL2
	 e2JSyMimvySBOuuUzQW9DXw0+o/VJNxoPprImdukZmhXZYorUxF7INCGZvzVRq9wy1
	 drdB32bXizYoQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 04B3D17E1366;
	Wed, 16 Oct 2024 12:20:50 +0200 (CEST)
Message-ID: <834bfc12-4ce7-4ce1-a0c7-5bc8be3587b7@collabora.com>
Date: Wed, 16 Oct 2024 12:20:50 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
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
References: <20241016-en7581-pinctrl-v7-0-4ff611f263a7@kernel.org>
 <20241016-en7581-pinctrl-v7-3-4ff611f263a7@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241016-en7581-pinctrl-v7-3-4ff611f263a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/24 12:07, Lorenzo Bianconi ha scritto:
> Introduce device-tree binding documentation for Airoha EN7581 pwm
> controller.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   .../devicetree/bindings/pwm/airoha,en7581-pwm.yaml | 34 ++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..f36387572a9781636aeacdbcc8947017c7ca75a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
> @@ -0,0 +1,34 @@
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

There are undocumented properties that the driver tries to parse. Please fix.

Regards,
Angelo

