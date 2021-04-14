Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7035FD9E
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Apr 2021 00:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhDNWQR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Apr 2021 18:16:17 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:34574 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhDNWQR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Apr 2021 18:16:17 -0400
Received: by mail-ot1-f50.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so20817285otn.1;
        Wed, 14 Apr 2021 15:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F07gtHUJwY/w7iuYzdTNfY1HnMAu4hugjUa0Lgoy7/U=;
        b=NsJMRPRosVt9CSm4SZ3LQE3Znv1fU6h3h2NsIbySrrlTBEu6s29AL7n6u57KrQ6VzJ
         Yo+0ApRlF1Wmq35IzeQbgNSqMs0vBS90BjZcWctwOL2fKq4VJvgyICbwUa1kNsAgSEyd
         MKI8ev31WxSpnT+UuKA5CmBnYOr5AWMMuvJ4yh2Mbb/Xt7mx2VIztLa6rxxhSCYiJYh/
         cEWukY0RAA0KYZWeS4O5W2ltp43j8pKvgCuuAR2QJs/WgJIkgqsvXAnbfj0eZV/3el1L
         39qhGy8XbAS1QFjJTsgxDkCdIXtzKGRsBYHJy5OH0KYpBHumS0JL7YbQvTG/j9B7dmrt
         wybA==
X-Gm-Message-State: AOAM531F/yjwkSnznJOcQhgqNotqfdLtW1u7DohsH8z6VOQFrmaVJpor
        XNsVpB73GpRywnig4v6yiw==
X-Google-Smtp-Source: ABdhPJwQ/l5ePXdK2531ARA8Lyb1Lw/ISWyLZmahs26BmVT5HGe9aezzG+AecBIPDpM7O6nek5tzSQ==
X-Received: by 2002:a9d:4911:: with SMTP id e17mr223342otf.38.1618438555210;
        Wed, 14 Apr 2021 15:15:55 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o2sm205446oti.30.2021.04.14.15.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 15:15:54 -0700 (PDT)
Received: (nullmailer pid 63091 invoked by uid 1000);
        Wed, 14 Apr 2021 22:15:53 -0000
Date:   Wed, 14 Apr 2021 17:15:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     lee.jones@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [v2 1/2] dt-bindings: Add bindings for aspeed pwm-tach and pwm.
Message-ID: <20210414221553.GA56046@robh.at.kernel.org>
References: <20210414104939.1093-1-billy_tsai@aspeedtech.com>
 <20210414104939.1093-2-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414104939.1093-2-billy_tsai@aspeedtech.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 14, 2021 at 06:49:38PM +0800, Billy Tsai wrote:
> This patch adds device bindings for aspeed pwm-tach device which is a
> multi-function device include pwn and tach function and pwm device which
> should be the sub-node of pwm-tach device.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Change-Id: I18d9dea14c3a04e1b7e38ffecd49d45917b9b545

Drop

> ---
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 60 +++++++++++++++++++
>  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 44 ++++++++++++++
>  2 files changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> new file mode 100644
> index 000000000000..eaf8bdf8d44e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> @@ -0,0 +1,60 @@
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

But is it really? A PWM and tach sounds like a fan controller. Look at 
other existing PWM+tach bindings we have for fans.

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
> +  "#address-cells":
> +    const: 1
> +  "#size-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties:
> +  type: object

As you know the 2 node names, they should be documented. However, see 
below.

> +
> +examples:
> +  - |
> +    pwm_tach: pwm_tach@1e610000 {
> +      compatible = "aspeed,ast2600-pwm-tach", "syscon", "simple-mfd";
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      reg = <0x1e610000 0x100>;
> +
> +      pwm: pwm@0 {
> +        compatible = "aspeed,ast2600-pwm";
> +        #pwm-cells = <3>;
> +        reg = <0x0 0x100>;
> +      };
> +
> +      tach: tach@1 {
> +        compatible = "aspeed,ast2600-tach";
> +        reg = <0x0 0x100>;

You have 2 nodes at the same address. Not valid.

> +      };

There's no real need for 2 child nodes. The parent node can be a PWM 
provider.

> +    };
> diff --git a/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> new file mode 100644
> index 000000000000..97923e68ccb9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 ASPEED, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/aspeed,ast2600-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED AST2600 PWM controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The ASPEED PWM controller can support upto 16 PWM outputs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-pwm
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +  reg:
> +    maxItems: 1
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    // The PWM should be a subnode of a "aspeed,ast2600-pwm-tach" compatible
> +    // node.
> +    pwm_tach: pwm_tach@1e610000 {
> +      compatible = "aspeed,ast2600-pwm-tach", "syscon", "simple-mfd";
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      reg = <0x1e610000 0x100>;
> +
> +      pwm: pwm@0 {
> +        compatible = "aspeed,ast2600-pwm";
> +        #pwm-cells = <3>;
> +        reg = <0x0 0x100>;
> +      };
> +    };
> -- 
> 2.25.1
> 
