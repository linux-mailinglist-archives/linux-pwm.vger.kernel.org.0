Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A733F4D0225
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Mar 2022 15:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiCGO4N (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Mar 2022 09:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbiCGO4M (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Mar 2022 09:56:12 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FFD8B6D4
        for <linux-pwm@vger.kernel.org>; Mon,  7 Mar 2022 06:55:17 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D18563F60F
        for <linux-pwm@vger.kernel.org>; Mon,  7 Mar 2022 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646664915;
        bh=C8pfnsecsrezK4Nb7IRuKxjSY5+ji8Ej5U+DGoorANw=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=WJt3+JH5GgdWW887A6G1YWpLfGkR0tH4I3f1/i69wAy/cgVWX1yWUUUK47vF4307+
         gizh6u1POkIM0+gaqLwqIyV+UOGh7wIfXYzB0lLKr/Icey16HXPyu+4TLSP118wr/R
         z+t+M7zvnnLln+JxLJhO213UNO56dtQtqolyfYIJnxBF7LWJOTlHvJSqDO+s7/dnLE
         w83+eeHrco70R9vTgyc5MaMABrlR36+50e3wFvVmtNUwWQFFLsFw4eGriduBtN7IQV
         BilMGPpmCYFzzvwE4IJ3ZADr/QQpd3yXR9WenIaM9AcK2aNLq/slyuJ1a57aUbrEvT
         +j8ZsjHZncAGw==
Received: by mail-ej1-f71.google.com with SMTP id i14-20020a17090639ce00b006dabe6a112fso3347365eje.13
        for <linux-pwm@vger.kernel.org>; Mon, 07 Mar 2022 06:55:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C8pfnsecsrezK4Nb7IRuKxjSY5+ji8Ej5U+DGoorANw=;
        b=6dSPxrB1zEUJPNo3RaN+T5S5bUnayAddycN46bdtdN5CvsIKdykdIb54X9EGb5MN6P
         u3IUu+qNYgic8wi6ZhvVLtIBmKZH3EKHj+GLjNpkv3jj1VCrL00VnUvUg0IcxLNJmo9t
         0773EzMt4nV8Fj4Z7WQzAW1EoAyiWXetVQHWm2mRV1BIvaNXQOW38VP99ghi0ZtCvk6N
         pcTqId421TYQIZtt2X+75j11+FkYxuItRwutAO1l3nZxeEvHWHYeizmiRiF2Zv22H52z
         yHCcZ8GYxhBqbAvyXGSBZaDZw/q54g4TMm7yPzddV5Dpd8EbZMn2kzLMBaSXV9fWPlDy
         ffUQ==
X-Gm-Message-State: AOAM531onJZVxxbVK653Z04beV46DvLOkrxAcjJa2ByCtpyskqxqWLw0
        sz9q/dnp3y7RB+vV7ddn+NemcFTjauOci+uRXWBEc+THnzIFMhqjy81kYZCknWl0k48/0cZ3rNH
        VBSk2jYGwtdQ/71t+iDVi8QvJz/e0zp2nobYYCg==
X-Received: by 2002:a17:906:6a0f:b0:6d7:1021:2bd2 with SMTP id qw15-20020a1709066a0f00b006d710212bd2mr9960421ejc.395.1646664915107;
        Mon, 07 Mar 2022 06:55:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0lnoIbRB64+BxucbKOyxrxZ+MR5/YF75HAstgYp2zaexCX+E0Y4T2gxNY+oCkTIf2TYVxVA==
X-Received: by 2002:a17:906:6a0f:b0:6d7:1021:2bd2 with SMTP id qw15-20020a1709066a0f00b006d710212bd2mr9960403ejc.395.1646664914823;
        Mon, 07 Mar 2022 06:55:14 -0800 (PST)
Received: from [192.168.0.142] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id z92-20020a509e65000000b00416466dc220sm1749452ede.87.2022.03.07.06.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 06:55:13 -0800 (PST)
Message-ID: <4e137401-4b8c-0abc-0c50-d784d579a991@canonical.com>
Date:   Mon, 7 Mar 2022 15:55:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: convert atmel pwm to json-schema
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>,
        claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220307144652.162706-1-sergiu.moga@microchip.com>
 <20220307144652.162706-2-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307144652.162706-2-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 07/03/2022 15:46, Sergiu Moga wrote:
> Convert PWM binding for Atmel/Microchip SoCs to Device Tree Schema
> format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../bindings/pwm/atmel,at91sam-pwm.yaml       | 42 +++++++++++++++++++
>  .../devicetree/bindings/pwm/atmel-pwm.txt     | 35 ----------------
>  2 files changed, 42 insertions(+), 35 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml b/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
> new file mode 100644
> index 000000000000..2d5dd51a6a55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/atmel,at91sam-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel/Microchip PWM controller
> +
> +allOf:
> +  - $ref: "pwm.yaml#"

allOf by convention should go between maintaners and properties.

> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at91sam9rl-pwm
> +      - atmel,sama5d3-pwm
> +      - atmel,sama5d2-pwm
> +      - microchip,sam9x60-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: true

This has to be either additionalProperties:false or
"unevaluatedProperties:false".

> +
> +examples:
> +  - |
> +        pwm0: pwm@f8034000 {
> +                compatible = "atmel,at91sam9rl-pwm";
> +                reg = <0xf8034000 0x400>;
> +                #pwm-cells = <3>;

Also please change indentation to 2 or 4 spaces (like we use for all DTS
examples). Four is preferred (only personally).

You also need to update the path in MAINTAINERS.

Best regards,
Krzysztof
