Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FBC4B5CE3
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 22:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiBNVfN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 16:35:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiBNVe6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 16:34:58 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0DD157207
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 13:32:13 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 163D440335
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 21:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644874332;
        bh=Vpk09spyV9imDGj1kfUzd1GTJIyfhaN7DgNwXJd/bD0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=e60NqLzyZV697QIjr9gD8+zn8IrsHL1ZzR6zifawktptCcEAwwDezFbPv/rcvfegL
         YHjZz6Dw8tLgtclLzCOSJqnt30ciTOGqIiNVlF3DF1Fx+sNCDy7y6DK6zASXPn59Rq
         UDJ9x3W+rG1I8PtUxFafBIt/A3N/rqOtVA1uD2gADBmCSY4UFBp8/nWHPGR3f+KrBQ
         /vcskUVtn82dBXNBbURNNUi2AOna799rPxsKglqCdd2DLbzEAkT2H8ZfpZ0f6vDzEd
         zyKBiOVn49p1jweSKCySzJNzypXS30DfRy6i9RGaMkoLQjv7g5pjyQnfn4D5+JL0Q1
         zgCEro8Lz4MvQ==
Received: by mail-ed1-f72.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso11068381edt.20
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 13:32:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vpk09spyV9imDGj1kfUzd1GTJIyfhaN7DgNwXJd/bD0=;
        b=Lk9tARyad/G38NW58csg58Hhp+oWKLmqjoYlfjMjgjGAmdGZ1oyr9PVZ31nDun32Kh
         jmz8FbcbT66HcSArZvU+1d1x84mszeC903vSfVLIibklDWAUbjzOXWxHRTpaIsJDGf15
         Ly/zis2t4e3qvKqZSH10yUJAvZpuv3DXi69/BblR2snppheY+hqHr3nwS1appsMwot7+
         aHaK9LwkQotQP+ADWUsy0OdGrOcmIMlMVuandgwOsPTlJPjqoWV/x+Y84khJOjDjgNil
         XWyner9UcZOpvRScZ1RhShVneDD4ftRj7Hb2Q+T+ziA/eRq18GWxLfb5fgEZCVHx/uIu
         eG0Q==
X-Gm-Message-State: AOAM530icyUXNYHg4YFKrbjOjRa6stQqknhoyTSUG58b3+vNpCJuOdiJ
        PESXQi4Cf923Iay6461iZUk5sSYhd6xh/gLATtH0KLKq4ueIErl5b9OxIdN7Nz/i8K9VV3824sp
        zUCeo9kxYShkC3OXP6A7psMaYYSY/4Z8SaCqEUg==
X-Received: by 2002:a17:907:9687:: with SMTP id hd7mr561418ejc.715.1644874331565;
        Mon, 14 Feb 2022 13:32:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqnjThzRbcUFM+c4bi7NwvMvdAFVVUVTZmoKvJUlbWhdI51H+3uTCCB+/iNFrzs2cm1lQjfg==
X-Received: by 2002:a17:907:9687:: with SMTP id hd7mr561405ejc.715.1644874331369;
        Mon, 14 Feb 2022 13:32:11 -0800 (PST)
Received: from [192.168.0.106] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h11sm3910302edb.68.2022.02.14.13.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 13:32:10 -0800 (PST)
Message-ID: <af2405be-5af5-1e5b-66f2-93842eb8cde5@canonical.com>
Date:   Mon, 14 Feb 2022 22:32:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [1/1] dt-bindings: pwm:Convert pwm-mtk-disp.txt format file to
 pwm-mtk-disp.yaml format file
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1644847276-27622-1-git-send-email-xinlei.lee@mediatek.com>
 <1644847276-27622-2-git-send-email-xinlei.lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1644847276-27622-2-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 14/02/2022 15:01, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>

Commit msg is needed.

Subject - missing space after ':' and it is too long. No need to say
"format file" twice.

You miss "PATCH" in subject. Using `git format-patch` is the easiest way
to create proper patches.

> 
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
> ---
>  .../devicetree/bindings/pwm/pwm-mtk-disp.yaml      | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)

I do not see the conversion here... You only add one file. Where is the
removal?

>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
> new file mode 100644
> index 0000000..2f1183e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml

Let's name the file as with most bindings, so with vendor:
"mediatek,pwm-disp.yaml"

> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-mtk-disp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: mediatek PWM Controller Device Tree Bindings
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> +  - Lee Jones <lee.jones@linaro.org>
> +  - Rob Herring <robh+dt@kernel.org>
> +

allOf referencing pwm.yaml

> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt2701-disp-pwm
> +      - mediatek,mt6595-disp-pwm
> +      - mediatek,mt8173-disp-pwm
> +      - mediatek,mt8183-disp-pwm
> +      - mediatek,mt8186-disp-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Main Clock
> +      - description: Mm Clock
> +


This schema was not tested. Please run it against your DTS files (make
dtbs_check). You need pwm-cells and power-domains. Maybe more...

> +  clock-names:
> +    items:
> +      - const: main
> +      - const: mm

Blank line.

> +required:

"compatible" is required, put it first in the list.

> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8186-clk.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>

Blank line.

> +    disp_pwm: disp_pwm0@1100e000 {

node name: "pwm" (generic as schema and devicetree specification ask for).

> +        compatible = "mediatek,mt8183-disp-pwm";
> +        reg = <0x1100e000 0x1000>;
> +        interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&topckgen CLK_TOP_DISP_PWM>,
> +                 <&infracfg_ao CLK_INFRA_AO_DISP_PWM>;
> +        clock-names = "main", "mm";
> +        status = "okay";

No need for status.

> +    };
> \ No newline at end of file


Best regards,
Krzysztof
