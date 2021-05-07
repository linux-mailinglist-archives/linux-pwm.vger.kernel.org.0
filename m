Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E2A375E35
	for <lists+linux-pwm@lfdr.de>; Fri,  7 May 2021 03:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhEGBJS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 May 2021 21:09:18 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41886 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbhEGBJP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 May 2021 21:09:15 -0400
Received: by mail-oi1-f176.google.com with SMTP id c3so7215399oic.8;
        Thu, 06 May 2021 18:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6W67RaksQjLOYNdnbdfa9p+lVZInKWZVCWpoKGgd/9A=;
        b=eT8157QS5BbAF525re8fPsiOf1Nf0zTnOcnXQ4u5jhLtH05kdlnfFctrlaoBgstVRq
         9IZYay/gPyirlbZTgSS+qXd1qppOgrHHQJyDDeTj44Hvls2mhfSiaT0nhS615bAVzeQN
         Rrhaab+6QvRE5cN3xoKaK0dpdeqdP9Kal0eP+VpyhtvCSPSPBkzoj/6kvvXzq6VzW3/E
         BnzvqTbiaqFsF+klGorPZF2hfzOwwE7MyvJlYuZdD1iACqe/TW6DrkKsCWgVgGXlL2ku
         2YTUEfNtWFPNltAPCj5BLxK8kNEYyeWA2f4EtbFE/Zy6DEeMkyvj1zkRDCfBDdgvRb8l
         mx6w==
X-Gm-Message-State: AOAM533aorK0w7x0//kb7SRrOe1sFXDkY8qdOdGWkwge5PRov28rkBY6
        yezPnzNoM/GnUEn9WDdqeg==
X-Google-Smtp-Source: ABdhPJydS+y6C4SE9bnB/eY0GFTj76KejxPRwA3cPRPWNm3aKDpDwriU4T1PtWSn1k5qw2lPTbQDWw==
X-Received: by 2002:a54:4d83:: with SMTP id y3mr13034438oix.97.1620349696505;
        Thu, 06 May 2021 18:08:16 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p65sm721005oia.46.2021.05.06.18.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 18:08:15 -0700 (PDT)
Received: (nullmailer pid 1118308 invoked by uid 1000);
        Fri, 07 May 2021 01:08:14 -0000
Date:   Thu, 6 May 2021 20:08:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     lee.jones@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [v3 1/2] dt-bindings: Add bindings for aspeed pwm-tach and pwm.
Message-ID: <20210507010814.GB1110621@robh.at.kernel.org>
References: <20210506061050.8001-1-billy_tsai@aspeedtech.com>
 <20210506061050.8001-2-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506061050.8001-2-billy_tsai@aspeedtech.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, May 06, 2021 at 02:10:49PM +0800, Billy Tsai wrote:
> This patch adds device bindings for aspeed pwm-tach device which is a
> multi-function device include pwn and tach function and pwm device which
> should be the sub-node of pwm-tach device.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 55 +++++++++++++++++++
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 41 ++++++++++++++
>  2 files changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> new file mode 100644
> index 000000000000..9626bbd50acd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 ASPEED, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/aspeed,ast2600-pwm-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PWM Tach controller Device Tree Bindings
> +
> +description: |
> +  The PWM Tach controller is represented as a multi-function device which
> +  includes:
> +    PWM
> +    Tach
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,ast2600-pwm-tach
> +      - const: syscon
> +      - const: simple-mfd
> +  reg:
> +    maxItems: 1
> +  clocks:
> +    maxItems: 1
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +
> +additionalProperties:
> +  type: object
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +    pwm_tach: pwm_tach@1e610000 {
> +      compatible = "aspeed,ast2600-pwm-tach", "syscon", "simple-mfd";
> +      reg = <0x1e610000 0x100>;
> +      clocks = <&syscon ASPEED_CLK_AHB>;
> +      resets = <&syscon ASPEED_RESET_PWM>;
> +
> +      pwm: pwm {
> +        compatible = "aspeed,ast2600-pwm";
> +        #pwm-cells = <3>;

There's no need for a child node here. Just put #pwm-cells in the 
parent node.

Of course this all looks incomplete if you ever plan to hook up fans and 
have more than 1 PWM and Tach signal.

> +      };
> +    };
