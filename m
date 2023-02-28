Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C78A6A5A8D
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Feb 2023 15:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjB1OIE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Feb 2023 09:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjB1OH7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Feb 2023 09:07:59 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A4A3C31
        for <linux-pwm@vger.kernel.org>; Tue, 28 Feb 2023 06:07:55 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bw19so9849486wrb.13
        for <linux-pwm@vger.kernel.org>; Tue, 28 Feb 2023 06:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677593274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5g9gRNHIe9JMT0MKnpe3X0cE+DT49kStiSxHxV8NkU=;
        b=SlOXtBadlVZhKdyBnuAL+2dZjVpCsR9qXYhOw2/4mso9B4v1GpvUQXfMrDSKdt3X3X
         wYesoUEYCQ2aunQVGa4uoRcawDEu8bKZBqAwyK6XTSygWjPFerwkQIn4he3W8hDJUd6w
         krcOUC0cDouy4ckO2VYYSXPyoBo9zSF1cKIhG6xMNxiAtSMCbYVBzASP1n9vYlPfviJt
         PvfSEHN5pSJ4OKjB7ePJ8iMWboVkZMk2RWdTj8+5TZLzbt5JFhYiGJVsDw2vdB7ypc6d
         GMTAoDyw3L0UWohXusJy2OObLH5prrRacRSotf5PM7FdGtaRexoGssic1doZN+fWVCKn
         A5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677593274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5g9gRNHIe9JMT0MKnpe3X0cE+DT49kStiSxHxV8NkU=;
        b=emCMlfz0lmxpON+O2WPHS506yW/NFFdz+4/GGMbU42hMh5aQo+ajRgU+JSXRb+jpA4
         fsUFYEmRX/HGLFhn0xTno81uLibdj7DdsgC6iDPdjrT2lM/fkyLPQD/MEBtko78FWKU8
         6lGnvSiQcpRziP46a8PTf7yi4velZXkJynEMszHF3u+2tQahlIsLmmsveWZ1ny0McXG6
         tu5CJ5YbDNAVROor4uLZV4PUhb/mvWHW5iXBZQgDUXe3ZREzi9c7/o5+DC9ftPrpCd6A
         Fg1KUI7B0j6NFXnRPVW7J6y50FLMacd96GX0yfbQjN4+9CenfxUsTN5Dp/3pAwSuvcpS
         heXg==
X-Gm-Message-State: AO0yUKXMoQ+f5CehwLvX3CuYSI8yqaaJjzJ0qDzGdZ4hY+rjtI7XwngQ
        TZgxl8AU4ZBoOMfEsdAgcmSY5w==
X-Google-Smtp-Source: AK7set+0gLAM9jPhV4ksrdAN0umrBuavGvvynU37/a3Q6DC3f0MdezS08WF9nEf8RzgiBqAqGEsSEw==
X-Received: by 2002:adf:e88b:0:b0:2cc:5ee8:feee with SMTP id d11-20020adfe88b000000b002cc5ee8feeemr2472469wrm.33.1677593273978;
        Tue, 28 Feb 2023 06:07:53 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q10-20020adfea0a000000b002c567b58e9asm9984551wrm.56.2023.02.28.06.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 06:07:53 -0800 (PST)
Message-ID: <af5fa75b-1831-67cc-f644-33adfd2e1031@linaro.org>
Date:   Tue, 28 Feb 2023 15:07:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/2] dt-bindings: PWM: Add StarFive PWM module
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hal Feng <hal.feng@starfivetech.com>
References: <20230228091345.70515-1-william.qiu@starfivetech.com>
 <20230228091345.70515-2-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230228091345.70515-2-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 28/02/2023 10:13, William Qiu wrote:
> Add documentation to describe StarFive Pulse Width Modulation
> controller driver.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../devicetree/bindings/pwm/pwm-starfive.yaml | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-starfive.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-starfive.yaml b/Documentation/devicetree/bindings/pwm/pwm-starfive.yaml
> new file mode 100644
> index 000000000000..4ba2a8cc5344
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-starfive.yaml

Filename based on compatible, so starfive,jh7110-pwm.yaml

> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-starfive.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive PWM controller
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +description:
> +  StarFive SoCs contain PWM and when operating in PWM mode, the PTC core generates
> +  binary signal with user-programmable low and high periods. Clock source for the
> +  PWM can be either system clockor external clock. Each PWM timer block provides 8
> +  PWM channels.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    items:

Drop items, not a list in your case.

> +      - const: starfive,jh7110-pwm
> +


Best regards,
Krzysztof

