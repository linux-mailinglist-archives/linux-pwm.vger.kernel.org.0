Return-Path: <linux-pwm+bounces-5139-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A952AA5E37A
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 19:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2FE189C14C
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C854C2571CD;
	Wed, 12 Mar 2025 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="iEquGJ60";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="Cuboc5Sl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCEF256C62;
	Wed, 12 Mar 2025 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802968; cv=none; b=IEqOr2ykvTVJyGq0gAJj0Ct/vX4HQvgb9eZ5SUVEfqJtAoaZlvkoUijC6AIBLZnM/DbdGqAO+e15n2TgNJvBu2n2TTrmMQZcWiISTlChpEW/z36xqmUVN0XFyZHiS03+KwNNE6rGwr+tGA569NRG51eW408zMfp73U1WUP2kpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802968; c=relaxed/simple;
	bh=XvrF3yVE/G56SwGUDsatfsDt/hGysLL5ZnG+rclTcPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMMimM6BYogAaXpDj8YCAeDK0XIxjt7IiMUl84hh583LGfKWGi8AO+LLfVuMxlnGpiYwFUMnzxgVYuOsHbWjKVGhROLzDybHiRQ+fscNb1ea7IksY2toS8N8Z7gVrk0FktAN8oqi3XmIu/ZNL1lLn+9yAzpU2yBHuSStr3+//Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=iEquGJ60; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=Cuboc5Sl; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1741802366; bh=XvrF3yVE/G56SwGUDsatfsDt/hGysLL5ZnG+rclTcPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iEquGJ608MXIhmBzMIp3HJ5OnIyCEK/PSn4JQTrOyTqydjE//gNb8KWbt040NjPqf
	 8WT+C3BkM12w1O0s3i408LG+nKQF66SpcEwuDL5RhIJK1UDw4EGs4oAD5+irZ/+bWh
	 3Ei4vMdSAHbB+7cro6QE1Sg1yd67aKVflNG3Cr1tlcWZ4rlHgV3ZuG0P+tT179eZMr
	 PtMK3ARcv+qsKXGMbXdCJf6VMIDa3xKFNKt8Hxl2or630SpmAUPE9s9f4bLUM0lslA
	 jZFenTmU3O+2LCq5muvEUiQ6yKNUvA41FYyLtlSXXuGAGr9onx2u5x+v/zEhDsDb15
	 M85ErSBwOWfGw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 0BCCC3A8907;
	Wed, 12 Mar 2025 17:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1741802365; bh=XvrF3yVE/G56SwGUDsatfsDt/hGysLL5ZnG+rclTcPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cuboc5SlGsRp6FT/y7LhbsQjWc4HOSl86dMHlOApVkyHygph78l4/0ko/v58ziuT9
	 WHsMHoJ8WgMqZvXNpncpVbq1DetkzymXnry/xat45BXOReL6OMVmK39IhzqOGDeA9W
	 w9BK9jujkPEC9O+6JkzF3OEZSdo3bQz+zsS4hix2MpfvkiBS2E35zbB8vHuzo06pw/
	 7d4g3aI+vXdj7yTitXZtrOuM3UNed4wWDY9rJcrPMP6NYFO2RJbAAoPMQLuQpCP4Nw
	 98tQ0pWSaZqaGwfyTOdJQVE3AlRYVVvJCP9WXAotIjSEK0rxHGOMyY4mtnu80jPBlf
	 hlxJ2PtcQdbOw==
Received: from [192.168.1.228] (74-111-126-194.sta.estpak.ee [194.126.111.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id E524B3A86E9;
	Wed, 12 Mar 2025 17:59:23 +0000 (UTC)
Message-ID: <57ae63a2-544b-4241-a54d-8fa9917c1e44@mleia.com>
Date: Wed, 12 Mar 2025 19:59:21 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: pwm: Convert lpc32xx-pwm.txt to YAML
Content-Language: ru-RU
To: Purva Yeshi <purvayeshi550@gmail.com>, ukleinek@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 piotr.wojtaszczyk@timesys.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250312122750.6391-1-purvayeshi550@gmail.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20250312122750.6391-1-purvayeshi550@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20250312_175926_066546_4494210E 
X-CRM114-Status: GOOD (  17.83  )

Hello Purva.

Thank you for your contribution.

On 3/12/25 14:27, Purva Yeshi wrote:
> Convert the existing `lpc32xx-pwm.txt` bindings documentation into a
> YAML schema (`nxp,lpc3220-pwm.yaml`).
> 
> Set `"#pwm-cells"` to `const: 3` for expected PWM cell properties.

Actually it shall be set to 1.

> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
> V1 - https://lore.kernel.org/all/20250311125756.24064-1-purvayeshi550@gmail.com/
> V2 - Correct filename to match the compatible string, remove unnecessary
> quotes in maintainers, and refine commit message.
> 
>   .../devicetree/bindings/pwm/lpc32xx-pwm.txt   | 17 ---------
>   .../bindings/pwm/nxp,lpc3220-pwm.yaml         | 38 +++++++++++++++++++
>   2 files changed, 38 insertions(+), 17 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
>   create mode 100644 Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> deleted file mode 100644
> index 74b5bc5dd..000000000
> --- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -LPC32XX PWM controller
> -
> -Required properties:
> -- compatible: should be "nxp,lpc3220-pwm"
> -- reg: physical base address and length of the controller's registers
> -
> -Examples:
> -
> -pwm@4005c000 {
> -	compatible = "nxp,lpc3220-pwm";
> -	reg = <0x4005c000 0x4>;
> -};
> -
> -pwm@4005c004 {
> -	compatible = "nxp,lpc3220-pwm";
> -	reg = <0x4005c004 0x4>;
> -};
> diff --git a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> new file mode 100644
> index 000000000..432a5e9d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/nxp,lpc3220-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LPC32XX PWM controller
> +
> +maintainers:
> +  - Vladimir Zapolskiy <vz@mleia.com>
> +  - Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: nxp,lpc3220-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3

It shall be 1.

> +
> +required:
> +  - compatible
> +  - reg
> +

There is an error in the original lpc32xx-pwm.txt file, one more property
"clocks" is strictly required, please add it along with the conversion.

Thank you!

> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pwm@4005c000 {
> +        compatible = "nxp,lpc3220-pwm";
> +        reg = <0x4005c000 0x4>;
> +        #pwm-cells = <3>;
> +    };

--
Best wishes,
Vladimir

