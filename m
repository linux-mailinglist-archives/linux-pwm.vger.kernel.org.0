Return-Path: <linux-pwm+bounces-6523-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 186FFAE73E0
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 02:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E8617B3DB
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 00:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A798470813;
	Wed, 25 Jun 2025 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="FNQwi2Mw";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="FNQwi2Mw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0B82B9A5;
	Wed, 25 Jun 2025 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750811874; cv=none; b=K29IYWgwBVNnAj67cyCYW6auGSL0z8KDFHVZDaG4bKCmnopSzk9PKMYcdvrKBJZewHfr+DvPby60imnjblHAU7LSBwFWp6L8V4iqyWu7ab7BQbYNkofrLN4Hg16klHicQ+Xvze2aL0nBFJEtvB7I8mIkk+YrNN1jA2rzWmSu7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750811874; c=relaxed/simple;
	bh=uAdDQOZBr2xxgHWEJYA1qKLjMi1UEW7xBPT8xSxiCLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIpjUXLreAzfLbw8ynwiAkyIBDQXx6HQkfp6lkkRW51X5mgqeM0GB1cyLQynJGuaNy0SBbFWOGBxqB8O1fdfqt3Et1HURvFkrzb0YVgIDilErK/6/6+c3oOnBdBvCTJimNICXVG1muD7Ea+bP6Y8npoMtaVOjl++g7uUzaWfS6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=FNQwi2Mw; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=FNQwi2Mw; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1750811870; bh=uAdDQOZBr2xxgHWEJYA1qKLjMi1UEW7xBPT8xSxiCLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FNQwi2Mw3fcOJsFaMm6tl2xSstff+1H9QgLAn5FoEqRG96wCy4iELWkbXjzJwGn3E
	 LRVCdmVOI3BebMrxRMTaofBOf6Jff5IkPdyKsVH5T8WBoHZkBWUvo0atJ+w5mQMwbC
	 0Slg4d0rfDOEcnOKJdJhc/9hmUrCjZSrXLQjJ3j86LK/LkM6SUpTw9WY8L/nkpPpZS
	 Fu4gudcYi8gUnoXvdIrc+FPge1zMXOrnxasWrPP6CawAo0/Hi5LbVZDLcxUsHsmPZq
	 QGhhvfyFo3J09H253PB+06UlC2ZBHvtBRYTK3+ejCRKnsLOXdqF8a+hT1ZGI3CEz1X
	 UIABdMs8K8IDw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id C429E3C43A8;
	Wed, 25 Jun 2025 00:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1750811870; bh=uAdDQOZBr2xxgHWEJYA1qKLjMi1UEW7xBPT8xSxiCLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FNQwi2Mw3fcOJsFaMm6tl2xSstff+1H9QgLAn5FoEqRG96wCy4iELWkbXjzJwGn3E
	 LRVCdmVOI3BebMrxRMTaofBOf6Jff5IkPdyKsVH5T8WBoHZkBWUvo0atJ+w5mQMwbC
	 0Slg4d0rfDOEcnOKJdJhc/9hmUrCjZSrXLQjJ3j86LK/LkM6SUpTw9WY8L/nkpPpZS
	 Fu4gudcYi8gUnoXvdIrc+FPge1zMXOrnxasWrPP6CawAo0/Hi5LbVZDLcxUsHsmPZq
	 QGhhvfyFo3J09H253PB+06UlC2ZBHvtBRYTK3+ejCRKnsLOXdqF8a+hT1ZGI3CEz1X
	 UIABdMs8K8IDw==
Message-ID: <94e42d9b-fae3-4e3a-a72f-dc284d0b4abc@mleia.com>
Date: Wed, 25 Jun 2025 03:37:49 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: pwm: convert lpc32xx-pwm.txt to yaml
 format
To: Frank Li <Frank.Li@nxp.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/LPC32XX SOC SUPPORT"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20250624200955.2514896-1-Frank.Li@nxp.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20250624200955.2514896-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20250625_003750_821844_CBF1CDBA 
X-CRM114-Status: GOOD (  16.68  )

On 6/24/25 23:09, Frank Li wrote:
> Convert pc32xx-pwm.txt to yaml format.
> 
> Additional changes:
> - add ref to pwm.yaml
> - restrict #pwm-cells to 3
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   .../devicetree/bindings/pwm/lpc32xx-pwm.txt   | 17 --------
>   .../bindings/pwm/nxp,lpc3220-pwm.yaml         | 41 +++++++++++++++++++
>   2 files changed, 41 insertions(+), 17 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
>   create mode 100644 Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> deleted file mode 100644
> index 74b5bc5dd19ac..0000000000000
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
> index 0000000000000..b82d52f583df8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/nxp,lpc3220-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP LPC32XX PWM controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,lpc3220-pwm
> +      - nxp,lpc3220-motor-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#pwm-cells':
> +    const: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#pwm-cells'
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pwm@4005c000 {
> +        compatible = "nxp,lpc3220-pwm";
> +        reg = <0x4005c000 0x4>;
> +        #pwm-cells = <3>;
> +    };
> +

"clocks" and "assigned-clock-parents" properties are required.

Please fix the old .txt scheme, or the new one.

I will have to NAK any converted yaml file, if there is a clear
difference between the actual and proper description of controllers
from lpc32xx.dtsi and new proposed schemes.

-- 
Best wishes,
Vladimir

