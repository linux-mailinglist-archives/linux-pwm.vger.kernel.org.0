Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0354C611B1D
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Oct 2022 21:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiJ1Trg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Oct 2022 15:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ1Trf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Oct 2022 15:47:35 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC81E241B07
        for <linux-pwm@vger.kernel.org>; Fri, 28 Oct 2022 12:47:33 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a27so835807qtw.10
        for <linux-pwm@vger.kernel.org>; Fri, 28 Oct 2022 12:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SuLQ4LGhTb9iEJLwlybh7NzL9tVrunJow2oZoFj99dQ=;
        b=Pjxp64dtv0DecR/RobHlhnBssFPkJpiIYdP9pzvHpW8KX1urKw17Q3/hVzO6xZuWU0
         ZEBP7vT3vkOpmYLoHdriGyrmvzZ7BkZmOWgPP3PV7bczMOcHweuS0/lffViCJIt/zuTh
         GQvoM9yVvq8QtBvga4RIfbp7cvVeoRvDUlevsM7b1/SnTgFsY/w9vPdcH/utytuS3kty
         Kx7tCElNtSa8/P9Rxw0cqhW4GGO0QGqALG5Zca8cMOvmrsjNKC7wqSTPQinjgA5BZ49S
         VYzbWWiza4Z/UtvQt2tUN89m0uFwB8WeQwLBW7M9W2qD4bih9ojfGr/pBjHHrpNO1ygV
         S4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuLQ4LGhTb9iEJLwlybh7NzL9tVrunJow2oZoFj99dQ=;
        b=WHKtu0Pf5kYl2VL2WO1RvUs7ZEcHtK32YEx2MWJMYDKas6KHQOGsErMgI0emNHFm/6
         sn9YSHurj7tMLVbDIesmekeCV0J8MaJ7QE9OxgX3vktNHVr9FNPqmYOmI6t8yovCKAnZ
         snfSjsGk5Vb4O9VRIVlKAmRmlCW1W9w5meLPGtT5eqROoFgFxJeGyr/8grKRFD0jVgW4
         2498wVmhks8m5yYCbtFfB++Ei82qWGoVqORdzq7OsJuHcwTHwvm6NpK5bM68w/2HcOAk
         jImbyOxG9SpbPGpeWl1teY0nXHPbj4TtFKgX/RZqykdyw4fHGv9rlet2e7eh4XVzSvZ4
         Tvsw==
X-Gm-Message-State: ACrzQf0CRTVEveNKWTFF/tG3HmZ1cc7QUwYA0bJ9B9qgn0V3zGQm6sOl
        mG3t7Nk1rCg+rJx+spamJEmDrA==
X-Google-Smtp-Source: AMsMyM6lrikoLcv6eLHGa7lpzNLbaHvBXJP/FuXl58MVeVcQpzV+fNRBVO9OTj27uH/gzSL/lvnmwQ==
X-Received: by 2002:ac8:5b81:0:b0:39c:b735:6b8b with SMTP id a1-20020ac85b81000000b0039cb7356b8bmr1011547qta.416.1666986453067;
        Fri, 28 Oct 2022 12:47:33 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id h24-20020ac85498000000b00399b73d06f0sm2842518qtq.38.2022.10.28.12.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 12:47:32 -0700 (PDT)
Message-ID: <498e6e3a-6391-c220-f7db-211aa415dde8@linaro.org>
Date:   Fri, 28 Oct 2022 15:47:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/4] dt-bindings: pwm: Add Apple PWM controller
Content-Language: en-US
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028165215.43662-1-fnkl.kernel@gmail.com>
 <20221028165215.43662-2-fnkl.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028165215.43662-2-fnkl.kernel@gmail.com>
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

On 28/10/2022 12:52, Sasha Finkelstein wrote:
> Apple SoCs such as the M1 contain a PWM controller used
> among other things to control the keyboard backlight.
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-apple.yaml    | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-apple.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-apple.yaml b/Documentation/devicetree/bindings/pwm/pwm-apple.yaml
> new file mode 100644
> index 000000000000..39dc32e00a3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-apple.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-apple.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple FPWM controller
> +
> +maintainers:
> +  - asahi@lists.linux.dev
> +  - Sasha Finkelstein <fnkl.kernel@gmail.com>
> +
> +description: |+
> +  PWM controller used for keyboard backlight on ARM Macs
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-fpwm
> +          - apple,t6000-fpwm
> +          - apple,t8112-fpwm
> +      - const: apple,s5l-fpwm

Missing blank line.

> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm: fpwm@235044000 {
> +      compatible = "apple,s5l-fpwm";

As Rob's bot pointed out, this does not match the bindings so you did
not test them before sending :(

Best regards,
Krzysztof

