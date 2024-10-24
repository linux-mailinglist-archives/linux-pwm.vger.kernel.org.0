Return-Path: <linux-pwm+bounces-3826-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA09AE842
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 16:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACF81C22B62
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 14:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615301F76DC;
	Thu, 24 Oct 2024 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaXSy15T"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A11E5714;
	Thu, 24 Oct 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779053; cv=none; b=ZYBCcoTsXYayFQdYce0jaWxqjkx2FzbGSPEMExHi7pNj9L8FydjWn3iFWNF/kIr4bBeKsj52JffdAsruqHjvMzGge6aY0A5badeTqKEWFCrVvlgCM9yVTPh9LYq1gMilkzoIIdBbJAnHSyb7Oki2DnXrTv4I9g5HTc7GK9eDeS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779053; c=relaxed/simple;
	bh=krhQtm4zm/FOYnIE/tGTH1SAlqRa2tX6XY57qn26xao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T21duchDOeVfpP0QfOiScf4DVlEEej3HJicdcoWUiNLOW5MCTQ7PZ4rBYCA4G7R008B6HcgMwNBZwBcVmKPewAqcHnGIbr45zcx9kvTSyclkLbDz89I24XN2dlol7J2fYBVvcxz7E/Odv5lpkBtSN60yORf4ZP0cRmHLS7O9h4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaXSy15T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C82EC4CEC7;
	Thu, 24 Oct 2024 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729779052;
	bh=krhQtm4zm/FOYnIE/tGTH1SAlqRa2tX6XY57qn26xao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZaXSy15To3yTWqZHs3NhtB2LSgH6UAKPlDgAu9RHa7JIE32YuivGXDueV4FJsc0Tw
	 lRqaPHtdG3qBZYD5Qa1rFHI60A/Ycbt1R3a0Tvi4UHj/XI79cjebGX+eXnhOtMxebT
	 LoVkkICu07poQAwYKfRkUyk5ghneAKiIaEcs7Y5cUeRXiNWO8eTopBCuATsoWN8OuE
	 3htET69XX7c7wzvKmIDpHgkiikShCdERETvy10+a/a4DeA1uG3N4db1hJ5VMJ3olRw
	 kH3yqNZuYnYbEr90UV3GeLXvIRW3KNvQZ740p0vydbItEgdY/nMt1vF2bvHHOnMyUn
	 ZO8TO5vQq8cwQ==
Date: Thu, 24 Oct 2024 09:10:50 -0500
From: Rob Herring <robh@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	ukleinek@kernel.org, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v1 1/2] hwmon: (aspeed-g6-pwm-tacho): Extend the
 #pwm-cells to 4
Message-ID: <20241024141050.GA246869-robh@kernel.org>
References: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
 <20241024071548.3370363-2-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024071548.3370363-2-billy_tsai@aspeedtech.com>

On Thu, Oct 24, 2024 at 03:15:47PM +0800, Billy Tsai wrote:
> Add an option to support #pwm-cells up to 4. The additional cell is used
> to enable the WDT reset feature, which is specific to the ASPEED PWM
> controller.

Use subject prefixes matching the subsystem.

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Change-Id: Iefcc9622ac3dc684441d3e77aeb53c00f2ce4097

Drop.

> ---
>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 25 ++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> index 9e5ed901ae54..0cc92ce29ece 100644
> --- a/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
> @@ -31,7 +31,11 @@ properties:
>      maxItems: 1
>  
>    "#pwm-cells":
> -    const: 3
> +    enum: [3, 4]
> +    description: |
> +      The value should be 4 to enable the WDT reload feature, which will change the duty cycle to
> +      a preprogrammed value after WDT/EXTRST#.
> +      The range for the fourth cell value supported by this binding is 0 to 255.

Wrap lines at 80.

>  
>  patternProperties:
>    "^fan-[0-9]+$":
> @@ -69,3 +73,22 @@ examples:
>          pwms = <&pwm_tach 1 40000 0>;
>        };
>      };
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    pwm_tach: pwm-tach-controller@1e610000 {
> +      compatible = "aspeed,ast2600-pwm-tach";
> +      reg = <0x1e610000 0x100>;
> +      clocks = <&syscon ASPEED_CLK_AHB>;
> +      resets = <&syscon ASPEED_RESET_PWM>;
> +      #pwm-cells = <4>;
> +
> +      fan-0 {
> +        tach-ch = /bits/ 8 <0x0>;
> +        pwms = <&pwm_tach 0 40000 0 128>;
> +      };
> +
> +      fan-1 {
> +        tach-ch = /bits/ 8 <0x1 0x2>;
> +        pwms = <&pwm_tach 1 40000 0 160>;
> +      };
> +    };
> -- 
> 2.25.1
> 

