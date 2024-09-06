Return-Path: <linux-pwm+bounces-3121-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE49F96F180
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 12:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592171F22369
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 10:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4936F18893F;
	Fri,  6 Sep 2024 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgJJBX9y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200F513AD2F;
	Fri,  6 Sep 2024 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618684; cv=none; b=o20q/Kkymcy3ssVi7WEiMoIwgKwvaBCMbYMdnLNGhYpN4VvNdtunfD3eobPwXUKd2V0YNct940SigQVCV+wv2AYjdSqh7KEvQliYCzcscixXnAgk27m/8jlWrSTRQYv42XEQwEx5Prk51SFgUiYfM+y6zSHwyL3s+YcKs2isnfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618684; c=relaxed/simple;
	bh=A4c7deV6ZIknQWmVX7wV7TaEk2v1931J+nZxYnmgi2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFCoWEUweDIJiBYPBVipkIRL4o2cZJolFhv2DXDYzj9cKc8g7Oe1T37mnXcQXggEe0QeYeeeHcT/4YCwWqtF24cPOzlPv5VSq86+mdrarIqRxyVLnsmWaOshFLBnwszziRVRnZz0bgLoL4Cv++D2YiIs/4rpT+wAU/ZPf5vzfaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgJJBX9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80830C4CEC4;
	Fri,  6 Sep 2024 10:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725618683;
	bh=A4c7deV6ZIknQWmVX7wV7TaEk2v1931J+nZxYnmgi2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgJJBX9yutVEx2zdLpiQZ2XQR223NBTCKqOzD/EVInroPSXC0eiTARgNwfrTqntzP
	 WlA6C8USra4b3+cTyHa7+mEpqse4xOvnlX/XWmKYDcnjH0Yy4/BkZQApgM77iAfUYZ
	 SWOxV8pFHG98kEc0zsyhcDaxiylu5sUbORDBj6eiN2bXod5OgU8PVch4zKlDbkjbVE
	 FRmisOnwqWp6RLolWa0UjhJbibizzbvfx4KbkHSaVEBAiI/snda7N8fALES0FFCxUm
	 xfLuLGrQQx2qzfGmAjlz+Ud4baHyszNeuzsMOU2KJVeDOqlGzDYn8/p6YJbK4HGKYL
	 0BX2kWu7UoUiQ==
Date: Fri, 6 Sep 2024 12:31:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, unicorn_wang@outlook.com, inochiama@outlook.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com, haijiao.liu@sophgo.com, 
	xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com
Subject: Re: [PATCH 1/2] dt-bindings: pwm: sophgo: add bindings for sg2042
Message-ID: <clq2dwmsks56553cythofgd3x5sw4t6pss7cxup2hrvj2n563g@3ishagojtabx>
References: <cover.1725536870.git.unicorn_wang@outlook.com>
 <6e5fb37472b916cb9d9abfbe3bea702d8d0d9737.1725536870.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e5fb37472b916cb9d9abfbe3bea702d8d0d9737.1725536870.git.unicorn_wang@outlook.com>

On Thu, Sep 05, 2024 at 08:10:25PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add binding document for sophgo,sg2042-pwm.

A nit, subject: drop second/last, redundant "bindings for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Say something useful about hardware instead. The same in commit msg -
you keep saying obvious and duplicated commit subject.

> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../bindings/pwm/sophgo,sg2042-pwm.yaml       | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> new file mode 100644
> index 000000000000..10212694dd41
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/sophgo,sg2042-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2042 PWM controller
> +
> +maintainers:
> +  - Chen Wang <unicorn_wang@outlook.com>
> +
> +description: |

drop |

> +  This controller contains 4 channels which can generate PWM waveforms.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2042-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +
> +  "#pwm-cells":
> +    # See pwm.yaml in this directory for a description of the cells format.

Drop

> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false

unevaluatedProperties instead

Best regards,
Krzysztof


