Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D1F6E1E64
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Apr 2023 10:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDNIeM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Apr 2023 04:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDNIeL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Apr 2023 04:34:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A7C7698
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 01:34:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kt6so5599297ejb.0
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 01:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681461246; x=1684053246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YETSwyP9KyJmIykjMyk1TM49CieBNMVHrTzyPxKcTSk=;
        b=FkQzqgIFOAMsY5C49r1vVB/ZlzTMvC6eoeJBVcpcCRatuAaj6EIDAzi3hygq5+Ij1g
         JBGhZBFMX7pINFHlQiMdv7hC22MjElW2vDWKKVX/MSzTmcHGS5Gow/BGmXAiYyXVt3Rc
         TwHLdDfG5VUJBs7kKpL0yZtdBIOgMc27tvQabifkeXgBXMFPRAaCDM7iXEOBED/IWt/y
         NmIFWcjRsMtBhqMZwvLbe3ORStBZA417ZS8RGIc3ZE0/2GEdnH753mli+ov6NbQ1UAV0
         2miw7dNFMmbmugoxca3FDGb1jnUPzAQcjAd4BRyShkqiZf8yTad3RCKAOBWa8ejhn2ha
         LbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681461246; x=1684053246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YETSwyP9KyJmIykjMyk1TM49CieBNMVHrTzyPxKcTSk=;
        b=XspeUuvFm5n9KGkjrgWLaSD6Y3CUB9g8E0WUm2O/s3j593egA5TXpzrsodc9sSpZfW
         vIQJ4oGUE2l7veNQEuWozSCzutY1d9ToEMQgsa0i7QYP85L3891EFy0YCVfe9GIUZUM9
         4SM6hB2JvVX/NBsXdlr6XcMtjCwtGWxC4ir/Uy6HtzWQaXJfqOhy0hK6S3EHjJuJtm5x
         TSlaAooy8KEsbRHwyzKylYdEBBZ22HpbuPGH1vkN92ApChk0fWGejJxCEo1rStjJ46yO
         5UwVNnN0czkECE9OIRUUou5HgfLgGCksDheZq3kM+GocL4frvHVX8MOVkvldIe1pHS83
         RPWw==
X-Gm-Message-State: AAQBX9cpV9KDmBwvTReUHM0TgT7xjrQ0rOvsh8FVk8TY0yjRWwAe4Cs1
        I2xWj1bpih3y2M3d2EsHL85CmQ==
X-Google-Smtp-Source: AKy350Z7uaDB4GQxOP+F7tcD8R2KCxU2CUl3f5Uqi9jTZYCUHl43i3I1xzx6+MrjdoI2Do1jwFgUmg==
X-Received: by 2002:a17:907:1b1b:b0:94a:68a9:b399 with SMTP id mp27-20020a1709071b1b00b0094a68a9b399mr6056042ejc.53.1681461246577;
        Fri, 14 Apr 2023 01:34:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id jt6-20020a170906dfc600b0094e6c45b117sm2106215ejc.168.2023.04.14.01.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:34:06 -0700 (PDT)
Message-ID: <8349f5c1-36fe-802b-2a36-acb9c6eb6d8e@linaro.org>
Date:   Fri, 14 Apr 2023 10:34:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 12/27] dt-bindings: display: mediatek: split: Add
 compatible for MediaTek MT6795
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
 <20230412112739.160376-13-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412112739.160376-13-angelogioacchino.delregno@collabora.com>
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
> Add a compatible string for MediaTek Helio X10 MT6795's SPLIT block: this
> is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,split.yaml   | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

