Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD61B5FB4E5
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Oct 2022 16:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJKOsH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Oct 2022 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJKOsG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Oct 2022 10:48:06 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64F15B078
        for <linux-pwm@vger.kernel.org>; Tue, 11 Oct 2022 07:48:02 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id f22so4399093qto.3
        for <linux-pwm@vger.kernel.org>; Tue, 11 Oct 2022 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNtqRYxDNEfihRF5QefJQz25yKJmze/w7Ghq2bpMKzQ=;
        b=A7Ebks0DDm8Brcx+96Mp6zlGn790bpTzawzPpZK/MMOgLbo+qTXBYfo2iCl8iG0sBr
         IZccMy7odYcxMae+hFQchhMS1Gfx0njxyw+NDEC1ONq60A4sRYQoEqWA1IvFymS2sRfs
         0evCtRJTKDm1hwId+phP/HoqvXnEmUZ46OcPDZWg/ORsWRXEfdvAnxJ67xlZYZAgsz6H
         1M8u1IqCggLVnyjsKUkVvhfTbTTj7Ju3ndiRi6GH4H17iVHzQqrT2X2uCIqRq7bnlmX6
         AThw43Y5NJMEa39MRR41Pr79z+mJ3P/WTBcHaC+9oNK1uciwQslk1ASiGZ3E57nl8lzU
         2Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNtqRYxDNEfihRF5QefJQz25yKJmze/w7Ghq2bpMKzQ=;
        b=pxzDh1usOnn9Fuq5kKN7laO9LKJQKv4HQ0AHd3yn0KpwWUJ7CQNWLKNICtXPlnGzT7
         rO/TqwWTAJumGYNhlHivnJnYr4SI6SnWjejr+m1ruXuANUgNSiLBVxr3S1rM0LEIUZtm
         B2TCR2i5AOWwPJV53Nd+NPwFm92Y9D77d6davP+1/erOYbb4w2xucpMx+2WjuiboA26r
         BqzhdIW/DgQmqa5E3pKGU0j7vEvxooIJdu/Vkfo60XAD+2YnHuTpmaXiSJWiD9DZolPE
         ygiG+t22sdVBs2N5A+kjBUguXQH3CR30eIRcOBpV2fdD3oFWeOO+1C9r6MrC+oeJyLYq
         9Szg==
X-Gm-Message-State: ACrzQf0okNpEEPlIShR4RXwuA41reIs2uUM+D81CS0cY/Ws5l9OfZc23
        HzDgwkjGjFwm0PPXboOtCF6W1w==
X-Google-Smtp-Source: AMsMyM4M/PsdaNdoSwh2bCfVsJEe9LHVxaQ4Xy4/bPTVGlg6k1gNq1gzkbwTIH06/KaPx4FH9j677w==
X-Received: by 2002:ac8:5fca:0:b0:35c:d2a:3d8a with SMTP id k10-20020ac85fca000000b0035c0d2a3d8amr19933012qta.460.1665499681730;
        Tue, 11 Oct 2022 07:48:01 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id w41-20020a05622a192900b0035d5e5660cbsm1789278qtc.59.2022.10.11.07.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 07:48:01 -0700 (PDT)
Message-ID: <8d6b8f0e-d9d7-0d77-aa99-379de768fd5d@linaro.org>
Date:   Tue, 11 Oct 2022 10:45:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-2-biju.das.jz@bp.renesas.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221010145222.1047748-2-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 10/10/2022 10:52, Biju Das wrote:
> The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded in
> the Renesas RZ/G2L family SoC's. It consists of eight 16-bit timer
> channels and one 32-bit timer channel. It supports the following
> functions
>  - Counter
>  - Timer
>  - PWM
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * Dropped counter and pwm compatibeles as they don't have any resources.
>  * Made rz-mtu3 as pwm provider.
>  * Updated the example and description.
> v2->v3:
>  * Dropped counter bindings and integrated with mfd as it has only one property.
>  * Removed "#address-cells" and "#size-cells" as it do not have children with
>    unit addresses.
>  * Removed quotes from counter and pwm.
>  * Provided full path for pwm bindings.
>  * Updated the example.
> v1->v2:
>  * Modelled counter and pwm as a single device that handles
>    multiple channels.
>  * Moved counter and pwm bindings to respective subsystems
>  * Dropped 'bindings' from MFD binding title.
>  * Updated the example
>  * Changed the compatible names.
> ---
>  .../bindings/mfd/renesas,rz-mtu3.yaml         | 305 ++++++++++++++++++
>  1 file changed, 305 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml

This should not be in MFD. Just because some device has few features,
does not mean it should go to MFD... Choose either timer or pwm.


> 
> diff --git a/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> new file mode 100644
> index 000000000000..1b0be9f5cd18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
> @@ -0,0 +1,305 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/renesas,rz-mtu3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G2L Multi-Function Timer Pulse Unit 3 (MTU3a)
> +
> +maintainers:
> +  - Biju Das <biju.das.jz@bp.renesas.com>
> +
> +description: |
> +  This hardware block pconsisting of eight 16-bit timer channels and one

"This hardware block consists of..."

> +  32- bit timer channel. It supports the following specifications:
> +    - Pulse input/output: 28 lines max.
> +    - Pulse input 3 lines
> +    - Count clock 11 clocks for each channel (14 clocks for MTU0, 12 clocks
> +      for MTU2, and 10 clocks for MTU5, four clocks for MTU1-MTU2 combination
> +      (when LWA = 1))
> +    - Operating frequency Up to 100 MHz

Best regards,
Krzysztof

