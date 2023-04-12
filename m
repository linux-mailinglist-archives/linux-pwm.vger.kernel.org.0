Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B36DF64D
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 14:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjDLM7b (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 08:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDLM73 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 08:59:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D73EA
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 05:59:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i8-20020a05600c354800b003ee93d2c914so7743425wmq.2
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 05:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681304366; x=1683896366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=erBuPeVrzFlZV2m3GTCAkkOKGldewGoCCeiRWUfnelM=;
        b=F3QYxAcPMEMt/kGu/5NByv+dQTgXrV0wu04xUscbtGXnLbiLeFOS1KcmYiIJBCWHYW
         7oGqnSz3qQQfm6CBdfszFSm6BbyNqp4yyoHQrIYbFACnz6HblmyOWwRe0nwB4lKOZQwy
         ZNcW4VyrkPYzIE/V5G0yoBj+CM/K7MeTre4/QK9FfLVkLXnUxrldAv2p93KDUBDQGTow
         wADA+CIo+H3OZrgzIEdbuB70UnXPDpErMTq2+KNu9gDKflwBNcOw+bDrQCvyHO2P3y9D
         8mgBG+FsHdrPy2AdWof8uN9KSgtRKoG+7Hr0aTXvEiWax2WW1iLo9S2QVEKHCYz5XyuI
         0Ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681304366; x=1683896366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erBuPeVrzFlZV2m3GTCAkkOKGldewGoCCeiRWUfnelM=;
        b=rWNtkCjfttjVtUcLDuHvJmx/pBce2IiU4HzJym8/opZnZItoKDGMy1ZJiitDKXaJ94
         uRGhg9AYDsio9TlGy8aVGig69/YVqQJ9otdWH9f8nnFx4EQ1BDRAY9pdmM9Q/dVzHqkB
         gSwirntQlrOQ+UVymF9PpvTU6sfN/z08jjgwAYprPStgTwzg+l2xIwLBR7d2cif27i+d
         MPt2ufHJIARlVWPwILej0aD063GI+7KkqKjqU60bmMLI7S0EdW63kOT5wVdxfWiLF1Xo
         AyMNYy90LEIO99942nHd5ymvdMB61PZLB7qWvVo33gk8iPcmZNtV1Yn+wDRiy4B8/6y/
         EOdQ==
X-Gm-Message-State: AAQBX9e02edXHSw7BokRRQZC1YPVhwF3HtH4Lx2EjHyjbGbKe0H5n9Ay
        AwlNZqDnQ8BF5mrPl+g1ucghHg==
X-Google-Smtp-Source: AKy350bzixhPofoYl7nQAhHg2btqGdbmFdg6kAkDkZeSl6i/hQ1NZTJGFcOxcJQxrOqLzKHQWAZ7Vg==
X-Received: by 2002:a05:600c:3ba8:b0:3f0:5ed7:f859 with SMTP id n40-20020a05600c3ba800b003f05ed7f859mr2135365wms.7.1681304366135;
        Wed, 12 Apr 2023 05:59:26 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c0b5700b003eeb1d6a470sm2305203wmr.13.2023.04.12.05.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 05:59:25 -0700 (PDT)
Message-ID: <20684378-cf3e-0299-d390-287b7bafbda5@baylibre.com>
Date:   Wed, 12 Apr 2023 14:59:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/27] dt-bindings: phy: mediatek,dsi-phy: Add compatible
 for MT6795 Helio X10
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-3-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230412112739.160376-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795: this SoC uses
> the same DSI PHY as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> index 26f2b887cfc1..a9f78344efdb 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> @@ -24,6 +24,10 @@ properties:
>             - enum:
>                 - mediatek,mt7623-mipi-tx
>             - const: mediatek,mt2701-mipi-tx
> +      - items:
> +          - enum:
> +              - mediatek,mt6795-mipi-tx
> +          - const: mediatek,mt8173-mipi-tx

AFAIK, it should be:
       - items:
           - const: mediatek,mt6795-mipi-tx
           - const: mediatek,mt8173-mipi-tx

Since it isn't respected above for mt7623, it may be tolerated.
Please, take this comment as a suggestion, isn't a NAK from me.

>         - items:
>             - enum:
>                 - mediatek,mt8365-mipi-tx

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

