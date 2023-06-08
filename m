Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2FD727775
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jun 2023 08:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjFHGkP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Jun 2023 02:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjFHGkK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Jun 2023 02:40:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604EE2120
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jun 2023 23:40:08 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977d7bdde43so64928066b.0
        for <linux-pwm@vger.kernel.org>; Wed, 07 Jun 2023 23:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686206407; x=1688798407;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVRZfjPusUlMd2YSAWkUFw8x4CXFJxYh+aCGHiCjN5A=;
        b=xqI+reGDDN9cNUgG8bBTYU3s/nwG1PuvXOzHTpns4U2llK/sWtFsXu4o2iTRqW4nko
         2cdhmsc4/LtNfg3u/NU3tA7N3vf3bh8GCoYVjdffQjmRW4hV5zq41p2HxgflyOADfA5H
         ndTJJnG1CHYwzWyDHOG3XSqa0VoUJYcOls4so/APVmpetMjI5U1Sc+iAd9HK14dtEMZF
         4JcJy4NSNowUarzzT65nN0OytYabtvVXzMcvm5WKRYrR9iV+zJomX4j9SQ20L0d0l+07
         Sk1hhQslbx6Bpfd62KwUXXE7GSNs6cBTl38hGJJXWtJy+mRXCImcErhmqxG3SIwESpee
         uMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686206407; x=1688798407;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVRZfjPusUlMd2YSAWkUFw8x4CXFJxYh+aCGHiCjN5A=;
        b=RqVXKt8VK95De3xST0Yn3UR+gSW3InrjgKQyDTZh8L73oRjgPCZSypz9zvamo6ABpx
         5RWDfwAvhgZky5t4dNwdIYS+9onJ3to6AAn2JiP5e7y+3rkc7NbqU+HLYFXUfVlgPIS2
         4lgNfPKG/NVk231KhUIhULgXbQ0lnICZVTlAflzSN93SgbzcSTIOT1mn+zi7t1rj0LX0
         /BKRX/Ic5HKzTbTR6Xi5NqYddvZlmv49BESzrncqGhH2GaPNQR8WpakFIa674yVfYBDp
         I7Y6+9eW405mWMlfgFSe7iTJK6wJwcuoo3TQ4T49x/e36VU7TxjQu0EWe8qnz0/qvK7V
         Rhjg==
X-Gm-Message-State: AC+VfDzNANaIl6EnEa4llkEXlqUIFggJogaW9pcywq0tVAhG9g+cZnBu
        zxH6mKtGBNF1d0O/y3UkUBnvWg==
X-Google-Smtp-Source: ACHHUZ7Y49qxpbARq0/PESo5rGH/0TBRzIPZEdIk349An/yWXAvAuSNvyKVBJn4VTWgCDaiQFX9UyA==
X-Received: by 2002:a17:907:9404:b0:977:e8ca:ab34 with SMTP id dk4-20020a170907940400b00977e8caab34mr1008654ejc.22.1686206406850;
        Wed, 07 Jun 2023 23:40:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e26-20020a170906249a00b009662c57b4ffsm273586ejb.96.2023.06.07.23.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 23:40:06 -0700 (PDT)
Message-ID: <becd5ac7-a9ea-c63e-5716-316a8e705104@linaro.org>
Date:   Thu, 8 Jun 2023 08:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        corbet@lwn.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        patrick@stwcx.xyz
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
 <20230608021839.12769-3-billy_tsai@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230608021839.12769-3-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 08/06/2023 04:18, Billy Tsai wrote:
> Document the compatible for aspeed,ast2600-tach device.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> new file mode 100644
> index 000000000000..627aa00f2e92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Ast2600 Tach controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The Aspeed Tach controller can support upto 1 fan input.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-tach
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1

NAK, not true based on previous discussions. Device does not come with
resets and clocks.


Best regards,
Krzysztof

