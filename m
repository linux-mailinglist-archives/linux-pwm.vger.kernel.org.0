Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E161C635264
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Nov 2022 09:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiKWIYm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Nov 2022 03:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236403AbiKWIYj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Nov 2022 03:24:39 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AF1FC70E
        for <linux-pwm@vger.kernel.org>; Wed, 23 Nov 2022 00:24:38 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id t10so20618818ljj.0
        for <linux-pwm@vger.kernel.org>; Wed, 23 Nov 2022 00:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQrDHCXSqC/XpmgwTdQyvmX254FcV0tmVuSLVUTqodg=;
        b=iAB9ioyFKLlNCgKnD6q3l2t859zPNg4auZGsr2Rg5VGBclq0WCjr3EQb0wMWVg22j9
         UhlgN0IWOGV8Kh5mD/w0pVAMssS9mmhYioVWsmF3g1b07uSH/a0Gmycjw3hGXC/CJvVR
         voCFLtfj3bYYPgeOuNT/ARyXty0hTIT+rEtUbQYC6YRJgYQB8WuyqwQCacGgsIjZv2sY
         eDyGI/j/dqPaDd/KQPdJf8ADy3PbJeeAa9wgZiJcIZWzlaZd1VNfIQ30jNdTK6Ov/QPZ
         jbn8FF1tj8XKvRFIUUGqv2VaMLznuoEreBdkOWFwFHE0VQ+S7ZSQoXQ3GS+Ae8KcJCFt
         VqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQrDHCXSqC/XpmgwTdQyvmX254FcV0tmVuSLVUTqodg=;
        b=cfZbQecZNzKbHsEQcce3XvIWh9l+HhqyfZh6ch8KXGU7LEf3KlPw+9H7JRq5nPGIbD
         Op7rR27+9PoPECididWFttJJ4qbxEboQumAz11PCupkC/q7gRNET0LRmtjIpHQvLaxsT
         Pz+u4A4UPl/oVdYj+PrWq4pN1/QKNPnjXFU0MwlxsE3XavHhVJko+fUe9G6+0XVxRzaC
         O4gQ6cFcu4Ean8/1TdI7J8zk47iKXykbHQAjhR+8DwzBWCYw+csVhnpqmfds/Dm9PoRl
         l693qCu4R7NuQuQxGG0D87xOwSgS+KnL1FwdwCGEnumrHqAcHJSrcgo2OQZVk28CxWoQ
         zvdw==
X-Gm-Message-State: ANoB5pkAQLqQ0Hbh3v/f5fe1GHHXeSIaXtGkd47Qew9Bm86T7naXT1ES
        yd7dsMsd57WSQ5UcIIbTvN+Imw==
X-Google-Smtp-Source: AA0mqf6iwY1eT/pvUtAt3GMkQhHH6pJs3Gapli4TS8EaFHzKoaH3BxsLR6VynPRL9UadZ7c1M9Qsgw==
X-Received: by 2002:a05:651c:10a2:b0:279:e41:1481 with SMTP id k2-20020a05651c10a200b002790e411481mr3606750ljn.184.1669191876623;
        Wed, 23 Nov 2022 00:24:36 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v3-20020a056512348300b004b4b5da5f80sm2791751lfr.219.2022.11.23.00.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:24:36 -0800 (PST)
Message-ID: <c4b188b1-06a4-3cb0-a758-e12942e1f67b@linaro.org>
Date:   Wed, 23 Nov 2022 09:24:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        lee@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, corbet@lwn.net,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-2-billy_tsai@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221123061635.32025-2-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 23/11/2022 07:16, Billy Tsai wrote:
> Add device binding for aspeed pwm-tach device which is a multi-function
> device include pwm and tach function.

Subject: drop second, redundant "bindings".
Also use proper PATCH prefix.

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> new file mode 100644
> index 000000000000..e2a7be2e0a18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/aspeed,ast2600-pwm-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PWM Tach controller
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
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1

If this is simple-mfd then it cannot take clocks or resets.  Usually the
recommendation for such case is: This is not simple-mfd, drop it. Drop
also syscon and make a proper device.

However I am surprised to see such change, so I have no clue why this
was done.

> +
> +  pwm:
> +    type: object
> +    $ref: "/schemas/pwm/aspeed,ast2600-pwm.yaml"

Drop quotes.

There is no such file. Are you sure you ordered the patches correctly?

> +
> +  tach:
> +    type: object
> +    $ref: "/schemas/hwmon/aspeed,ast2600-tach.yaml"

Drop quotes.

There is no such file.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets

Best regards,
Krzysztof

