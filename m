Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BDB6E1E1E
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Apr 2023 10:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjDNIZM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Apr 2023 04:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjDNIY5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Apr 2023 04:24:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5011B4
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 01:24:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id rp27so6707681ejb.12
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 01:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681460674; x=1684052674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2Jcp3MHbUi0An/a7aTvvHXRZrnAjkyy08HzPYUNJaQ=;
        b=rOK4LSiTwFa45v7CqOu0/5w1TpdCvImZLKI0EreaaDS4Qt8uwnG/N6J8+2tejZ0Ncx
         Vu2pwvpPgpVPBZq0kLQBHW6NYYiF5FVcS0HyUTJqmrdDJrKW7ItcUjIC4JkDbd5VLnjK
         jQPtltLGQj9//1ahJFAjqgXcv5ZN0eTiR4+ifdVmQRSoodnUG9sBuhBHSnJGoC8lSra4
         z21dv4CWbcfcU15KeXgSir6XRYKF+TPCryNDhGOOI68A844uJlTWWJzf6D7mT2tRgvuX
         e9ohtOXM0207XaiaLqe6FZHBL1QoaUkHNH+IvgYyuQNxKFlk9QbNq5rZ1AE9zbbsKyRM
         UtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681460674; x=1684052674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2Jcp3MHbUi0An/a7aTvvHXRZrnAjkyy08HzPYUNJaQ=;
        b=hlT4MykPoe7JS/WuNdoHhO5wZzd9wv+eSymIY0z0kYWX+N+NMqFDCIdNHwOk0p2KuO
         oP4c8tscS38sYfNlYorxTRghLDMT/0YTfYD3x7ZxT6CtNxbo0D7O10S4o1nZnllvFr3Y
         fVERghJMo+O/AmzM52iIoxLZI9KwF/Giqb80nrPWsECeK5yl1WGBJY9cm/RHQ+rzfsTt
         MPe2+VxWDyVBU6AOqWfCMXCd7tGK9xVBwcbZuPvN9/MJFFUlHZ6GdUgscv3mVfFqp9vv
         bl/YSqcayof8EtnwNiYesVtqnPYbyEM3a4C6UZlyezNJjfdtv3c66Fh3AS/Sgr3iqCwf
         8NyQ==
X-Gm-Message-State: AAQBX9ffzL3MQd9y00dGBcnFEx6lFufLXkv0o+cvwyWYmMBiGxr/lvnv
        aoZU0NKW/0F4U+RzFvgcedDJYg==
X-Google-Smtp-Source: AKy350aZW4Ylqj7ITSxe6hxQlasg4qhTISV9/uV8NXP7fxhQ71VUUtZk6WFshZK1/CWOD71AeHcviw==
X-Received: by 2002:a17:906:4312:b0:8ae:11ca:81de with SMTP id j18-20020a170906431200b008ae11ca81demr5357467ejm.34.1681460674536;
        Fri, 14 Apr 2023 01:24:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id h7-20020a170906584700b0094e597f0e4dsm2062292ejs.121.2023.04.14.01.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:24:34 -0700 (PDT)
Message-ID: <fb79c6df-6a7a-7988-0c3f-6fbdc05a593a@linaro.org>
Date:   Fri, 14 Apr 2023 10:24:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 05/27] dt-bindings: display: mediatek: dsi: Add compatible
 for MediaTek MT6795
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
 <20230412112739.160376-6-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412112739.160376-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795, using the same
> DSI block as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,dsi.yaml        | 19 ++++++++++++-------

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

