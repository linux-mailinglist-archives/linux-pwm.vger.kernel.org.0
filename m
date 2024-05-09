Return-Path: <linux-pwm+bounces-2168-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B92E68C1795
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2024 22:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE2A1C21D6E
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2024 20:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7B8D2E6;
	Thu,  9 May 2024 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf+P/ziF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D4376;
	Thu,  9 May 2024 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715286742; cv=none; b=pZj7tj2O5f3uzla+9vlzGIXpaFpqFY8ZCfcBcSdflOcs3N/XenrvaH96NDqTwfFbXiHPPP+QQrCIAtZJNLIGLJL6AYFjUEpL8QlHVYVPooadb7+ncecWhVzT7FctCXnVMEEiBIpEJAr6540JCxsmbrB+BNgNyoKZ3KlyvK2fq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715286742; c=relaxed/simple;
	bh=4N+RQzYmeQqh9vU7WAmaNZWG6yhK/KPp2rXeuqU3JCo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=og+CVPbwNmhjqnZB4NXV6h3Cxxeq9NIDqQgssBLhd3LfeXnsrK8hNDMlcY95Nutyw+bCLJquE21ePvoVUF6la8udKeyl363PqeMvYLc1xlZLkV+SxY9iY6lXKmgi0ujcfX47wtnismatZ0CIkHaNdR44yhkdXqXeMxsBwCv75iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cf+P/ziF; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ed3587b93bso739863a34.1;
        Thu, 09 May 2024 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715286739; x=1715891539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WgzIChNHOybB6YvtmtKRO5fmRYHJDfezozAjqZ0oqsY=;
        b=Cf+P/ziF6w5eVVm805Bzryvqzf1u5E5ZIxpnzNeRp610rSKBy10L4Anv8bglvPoqnY
         wDgBWpIMcU3UYfs777T+G1T7/d0/40473WeTmND3GcqERp3zYIzmz994gWEg8p5yI8qm
         hkCUsTW4ObNxJUdAzZbMka6wEWuwbIOvLnq4LRhv+YTM4Xl+LpM/Cr8pFZnBwbo11amX
         mZOW/miNnl6ye129Jxg/EkZLmnj6/ZtPcgKQ3wF17S7Rp5qbW+xT0EkL4jPCvzFJbfjT
         ukOXHRbgIe4hVcR+dMwGaZZZWbF0UHSW5undTYzSssah+gZ+LipwWL/ToTeC7javWwpv
         mg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715286739; x=1715891539;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgzIChNHOybB6YvtmtKRO5fmRYHJDfezozAjqZ0oqsY=;
        b=Jrb6kn9DjiCOshJ4yM9mqQOhGP5Sfdh/8y8Y6yNnTd++WKVsVF3WLDU9a7jsgm0L4A
         aFc9bKZ8n1RTeuBIDJEYE00Qx0Fk0XXF68omrM+M0o7gouRfWkEy2IT5+AYAQrQ06Mk7
         j08jVbji/nrRGPyPQVXwdnKbbXbMKlOs7NQbZKmsUArNS2k+X7SMzBuB51dvgQeR62uS
         4ND4KhRttxiEEGu4swMz5r6UVft2FMXom7lOqA6AhBPJ0Mq1rkFZWORYgVHhIR/q/tSm
         OaLL8tAm7jd3fUeRXgNmN3sNBsBFrTNHfLGnz5smVxlL7p5TGLzGALV/Oib0uSjGg0YX
         eg6g==
X-Forwarded-Encrypted: i=1; AJvYcCX9UGsB+5aaFwyoS7/sNAnARlUSnx9PugMGWqRhVHBxdQBlqzDeYEYda8Hi63Z0NP1wWOeGNtPMIP+4Z/mg9tKFy1b9daM3TE1NNUhq2dKhiQoRlDMt+cJRHvXKlMCWb94W7LblEw==
X-Gm-Message-State: AOJu0YxxhsMSs9a/kYYvsq2y1oy97cHficHlT8IGT10xGCVmnhkNQmtk
	H3VBeKMdXs5k0sM8EMY/43Wn22OHrpv9cM+x5h6kLJvtO34dD2eV
X-Google-Smtp-Source: AGHT+IHEGJhWWa1e30aGL5DnsTEpJiTDTXaGIBCDX2v7pHa+Npm+d4Q9LH1hhmRiUUPUezlEhErNEA==
X-Received: by 2002:a05:6830:14ce:b0:6f0:417d:5167 with SMTP id 46e09a7af769-6f0e9109a0bmr697703a34.7.1715286739471;
        Thu, 09 May 2024 13:32:19 -0700 (PDT)
Received: from neuromancer. ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b26de89545sm379650eaf.34.2024.05.09.13.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 13:32:18 -0700 (PDT)
Message-ID: <663d32d2.4a0a0220.e5dc.2304@mx.google.com>
X-Google-Original-Message-ID: <Zj0y0D/2P2W6heiu@neuromancer.>
Date: Thu, 9 May 2024 15:32:16 -0500
From: Chris Morgan <macroalpha82@gmail.com>
To: Aleksandr Shubin <privatesub2@gmail.com>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	John Watts <contact@jookia.org>,
	Cheo Fusi <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
References: <20240131125920.2879433-1-privatesub2@gmail.com>
 <20240131125920.2879433-2-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131125920.2879433-2-privatesub2@gmail.com>

On Wed, Jan 31, 2024 at 03:59:14PM +0300, Aleksandr Shubin wrote:
> Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> controller witch is different from the previous pwm-sun4i.
> 
> The D1 and T113 are identical in terms of peripherals,
> they differ only in the architecture of the CPU core, and
> even share the majority of their DT. Because of that,
> using the same compatible makes sense.
> The R329 is a different SoC though, and should have
> a different compatible string added, especially as there
> is a difference in the number of channels.
> 
> D1 and T113s SoCs have one PWM controller with 8 channels.
> R329 SoC has two PWM controllers in both power domains, one of
> them has 9 channels (CPUX one) and the other has 6 (CPUS one).
> 
> Add a device tree binding for them.
> 
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> new file mode 100644
> index 000000000000..716f75776006
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner D1, T113-S3 and R329 PWM
> +
> +maintainers:
> +  - Aleksandr Shubin <privatesub2@gmail.com>
> +  - Brandon Cheo Fusi <fusibrandon13@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: allwinner,sun20i-d1-pwm
> +      - items:
> +          - const: allwinner,sun20i-r329-pwm
> +          - const: allwinner,sun20i-d1-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +  clocks:
> +    items:
> +      - description: Bus clock
> +      - description: 24 MHz oscillator
> +      - description: APB0 clock
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +      - const: hosc
> +      - const: apb0

Sorry for being late to the party, but I'm starting to look at the
PWM controller for the H700 (H616/T507 are compatible I believe) and
for those devices they use apb1. Would it be possible to just name this
clock "apb" and note it's just the "APB clock"?

Thank you.

> +
> +  resets:
> +    maxItems: 1
> +
> +  allwinner,pwm-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The number of PWM channels configured for this instance
> +    enum: [6, 9]
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun20i-r329-pwm
> +
> +    then:
> +      required:
> +        - allwinner,pwm-channels
> +
> +    else:
> +      properties:
> +        allwinner,pwm-channels: false
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#pwm-cells"
> +  - clocks
> +  - clock-names
> +  - resets
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sun20i-d1-ccu.h>
> +    #include <dt-bindings/reset/sun20i-d1-ccu.h>
> +
> +    pwm: pwm@2000c00 {
> +      compatible = "allwinner,sun20i-d1-pwm";
> +      reg = <0x02000c00 0x400>;
> +      clocks = <&ccu CLK_BUS_PWM>, <&dcxo>, <&ccu CLK_APB0>;
> +      clock-names = "bus", "hosc", "apb0";
> +      resets = <&ccu RST_BUS_PWM>;
> +      #pwm-cells = <0x3>;
> +    };
> +
> +...
> -- 
> 2.25.1
> 

