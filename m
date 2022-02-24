Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59154C361D
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Feb 2022 20:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiBXTt0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Feb 2022 14:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiBXTtZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Feb 2022 14:49:25 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A035254543
        for <linux-pwm@vger.kernel.org>; Thu, 24 Feb 2022 11:48:54 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id j24so4510034oii.11
        for <linux-pwm@vger.kernel.org>; Thu, 24 Feb 2022 11:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YpCPN12fmyvtZ3VxGfCIknwO/QSMW1ppj6lyaT35Vx4=;
        b=pK19w9BTReh2iS/hVdIV2GaNUrOGpjc4L69qtRJOPPfr/BiDh2FLe64nCxdJqhA8Wu
         3/Adks73h/3ybVh6pMLtOj5Rlt5pkOUUj3YA1vj2HGImylA0gbGBg5aPYXJFKqQo6yun
         EMrxE65v/RHEZ0fOMJa8J2HlmBFKD9hSfbe46xWK13a69K2oRfMQGCAeTWXl57MqXn/p
         A6BVUdxy++vBh04rxe72suQaBVkTEM04uVxQoZUGmXKWA+Y49Q6YHXt5g8DhGAyMUgFi
         D/Vayc8QHg4BCz24ntf1vLT+/aaHIj68xC1KNZq99Z3CaklVCKLNNfwOnFXlc+4jmfln
         J9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YpCPN12fmyvtZ3VxGfCIknwO/QSMW1ppj6lyaT35Vx4=;
        b=zW2UcNjFQ9qnLj387rHAwwhtGkKRMkNLxD71nCa4LBVwpPXjo3H6R+Q9kc0TSFOyMB
         ASLxqG1Pe+7GjJMAxFjosP4ozm8th4C+3k1DHsCNW+NLVUGxSqcNGZauQau5y/R+aCvM
         JZp8kI3sfJFsFtQ1J2KP++JTBcdW4LnRc8y3kgJirH6eAZUKR1vg4bbHLrcZCjYlJcrh
         tLe3y+XZFMnSKfU/UywpaFRmHkFjI5u+xnCFOKVknfrfVOYQVp72mBmxJBPXtj24sse4
         xYcQt9+AWqYDk06NZW7VA+aybwuVwYLNAfaOd1SCtiIfufLfNasirVcJ27At9Qrmw4mp
         c0Yw==
X-Gm-Message-State: AOAM532oRuLuodr719CQiPFcrBQ8BsVjT35fqy6UNQapzz5cuTvVcuUk
        ZQbK0n3t/RH7mAM6o20qUHkCrg==
X-Google-Smtp-Source: ABdhPJzKeCMq10+IjJPvyVIa2uOMWEU2rndAS06yEdTPF6U16PF6kORu+SzOAcMwVifHKbtDyUiFTA==
X-Received: by 2002:a05:6870:2418:b0:d3:1052:aac0 with SMTP id n24-20020a056870241800b000d31052aac0mr1919223oap.80.1645732133566;
        Thu, 24 Feb 2022 11:48:53 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id bl16-20020a056808309000b002d43b28a8bdsm241679oib.14.2022.02.24.11.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:48:53 -0800 (PST)
Date:   Thu, 24 Feb 2022 13:48:51 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Baruch Siach <baruch.siach@siklu.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] dt-bindings: pwm: add IPQ6018 binding
Message-ID: <YhfhIyRKwl1bJObC@builder.lan>
References: <17dd231f496d09ed8502bdd505eaa77bb6637e4b.1644226245.git.baruch@tkos.co.il>
 <dee024e7add1b2c919b23472c90391239a0a2572.1644226245.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dee024e7add1b2c919b23472c90391239a0a2572.1644226245.git.baruch@tkos.co.il>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon 07 Feb 03:30 CST 2022, Baruch Siach wrote:

> From: Baruch Siach <baruch.siach@siklu.com>
> 
> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> 
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> This series does not convert the TCSR binding documentation to YAML. As
> a result, this commit adds a new dt_binding_check warning:
> 
> /example-0/syscon@1937000: failed to match any schema with compatible: ['qcom,tcsr-ipq 6018', 'syscon', 'simple-mfd']
> 
> If that is a blocker to IPQ6018 PWM support, so be it. Patches will wait
> for someone else to push them further.
> 
> v10:
> 
>   No change
> 
> v9:
> 
>   Add 'ranges' property to example (Rob)
> 
>   Drop label in example (Rob)
> 
> v8:
> 
>   Add size cell to 'reg' (Rob)
> 
> v7:
> 
>   Use 'reg' instead of 'offset' (Rob)
> 
>   Drop 'clock-names' and 'assigned-clock*' (Bjorn)
> 
>   Use single cell address/size in example node (Bjorn)
> 
>   Move '#pwm-cells' lower in example node (Bjorn)
> 
>   List 'reg' as required
> 
> v6:
> 
>   Device node is child of TCSR; remove phandle (Rob Herring)
> 
>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)
> 
> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
>     Andersson, Kathiravan T)
> 
> v4: Update the binding example node as well (Rob Herring's bot)
> 
> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
> 
> v2: Make #pwm-cells const (Rob Herring)
> ---
>  .../devicetree/bindings/pwm/ipq-pwm.yaml      | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> new file mode 100644
> index 000000000000..857086ad539e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/ipq-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm IPQ6018 PWM controller
> +
> +maintainers:
> +  - Baruch Siach <baruch@tkos.co.il>
> +
> +properties:
> +  "#pwm-cells":
> +    const: 2
> +
> +  compatible:
> +    const: qcom,ipq6018-pwm
> +
> +  reg:
> +    description: Offset of PWM register in the TCSR block.
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#pwm-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
> +
> +    syscon@1937000 {
> +        compatible = "qcom,tcsr-ipq6018", "syscon", "simple-mfd";
> +        reg = <0x01937000 0x21000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0 0x1937000 0x21000>;
> +
> +        pwm: pwm@a010 {
> +            compatible = "qcom,ipq6018-pwm";
> +            reg = <0xa010 0x20>;
> +            clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +            assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
> +            assigned-clock-rates = <100000000>;
> +            #pwm-cells = <2>;
> +        };
> +    };
> -- 
> 2.34.1
> 
