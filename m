Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F74B6860BB
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Feb 2023 08:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBAHf6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Feb 2023 02:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjBAHf4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Feb 2023 02:35:56 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B4E5CE58
        for <linux-pwm@vger.kernel.org>; Tue, 31 Jan 2023 23:35:46 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so648722wmb.4
        for <linux-pwm@vger.kernel.org>; Tue, 31 Jan 2023 23:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zMO4O6XLeS+CmaJzPkiM5TKqYcGSkxjv6mv/iv+doFM=;
        b=BE7kDWz7n+PSYdH2iN/bRL9Yj3r9hEX7mC1i1JpjP3qijwDoncOQyuOQKXUjB3LWPf
         o0p6DsrqJbn51CiyvJBP51I60gtfqT8bVzLizs++wndzf3XqtvZ6i9buxRaZ7rrPg9wJ
         vkeLWVcBlAvWruSbadDs7ydy5N3L7l7QMg7rx5kV4SIO7kvJ2eZ84EQyftys1Xi9fPiO
         jhZQ9bXQHvifASMJnuhJrgTWkN/QBRd6FxrkBx+uPYlcc5tJlAP5e68o6j2bPO8O84V0
         kgXa7tim9VnqYP4gA5mM3CHuCSoXsf2JlY5W9gyBw8yXrv7XDTTXAqLMNY+TBWnWE670
         EDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMO4O6XLeS+CmaJzPkiM5TKqYcGSkxjv6mv/iv+doFM=;
        b=MYmPvCzms8Qx/WDE8qHMm/lSaKpAflL5P6+BXCul8X9Dy4dwybgPVWvOLW19E6H1s8
         W5Wb9ykqFQ27idB3FBRump6viPs+2PvOCcnG9ygh6X1oiBSg+0Huls2zewb6gWtnUHX0
         H/8x96XNuGVeOou2TSCBR9fyQb557oIqnLdw4fhb8qjVWu49Zvd0k5xpzBqeQ+880ugu
         ciHD3+jVT6wteK6p/S8xmTpUxG3XE4MJS4cIhCk6GIvR8IxNV0p9pZpzxzvj3NCunvmN
         n61e9OlyOmP5DiIA2B+oca9CC7DaXtVSLuZToZS5nxf7dMAkShehOdOKSu7PJf6Mf2J3
         zyzg==
X-Gm-Message-State: AO0yUKXm+B5N0lCKxo/5q+JShZBM7FgcH7jOFZcm1MGeX7oyHYeaFn5B
        EnPxWZmZMX4TzEqa8YdVPpdnGw==
X-Google-Smtp-Source: AK7set/lXNHxnDU1hTSORqG2FBydX0NnEOY9kA1Iw6Uh7VHpr2eLvUZ+/+3JSVisozXeJS/LSHrmJA==
X-Received: by 2002:a7b:c00d:0:b0:3da:f5d1:c677 with SMTP id c13-20020a7bc00d000000b003daf5d1c677mr688028wmb.35.1675236945369;
        Tue, 31 Jan 2023 23:35:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003dc54344764sm845248wmo.48.2023.01.31.23.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 23:35:44 -0800 (PST)
Message-ID: <58b7924e-07aa-fc62-d7a6-c5d453964486@linaro.org>
Date:   Wed, 1 Feb 2023 08:35:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] dt-bindings: pwm: Convert Amlogic Meson PWM binding
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
 <c92b9e51-bb69-0712-0b29-3db3c9a29f8b@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c92b9e51-bb69-0712-0b29-3db3c9a29f8b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 30/01/2023 21:34, Heiner Kallweit wrote:
> Convert Amlogic Meson PWM binding to yaml.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - fix clocks and clock-names
> - consider that more than one compatible may be set
> v3:
> - remove minItem/maxItem properties for compatible
> ---
>  .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 71 +++++++++++++++++++
>  .../devicetree/bindings/pwm/pwm-meson.txt     | 29 --------
>  2 files changed, 71 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> new file mode 100644
> index 000000000..750642e76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-amlogic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic PWM
> +
> +maintainers:
> +  - Heiner Kallweit <hkallweit1@gmail.com>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

Drop items

> +          - enum:
> +              - amlogic,meson8b-pwm
> +              - amlogic,meson-gxbb-pwm
> +              - amlogic,meson-gxbb-ao-pwm
> +              - amlogic,meson-axg-ee-pwm
> +              - amlogic,meson-axg-ao-pwm
> +              - amlogic,meson-g12a-ee-pwm
> +              - amlogic,meson-g12a-ao-pwm-ab
> +              - amlogic,meson-g12a-ao-pwm-cd
> +              - amlogic,meson-s4-pwm

Best regards,
Krzysztof

