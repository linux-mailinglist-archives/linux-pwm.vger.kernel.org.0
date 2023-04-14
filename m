Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C106E1E16
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Apr 2023 10:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDNIYm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Apr 2023 04:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjDNIY2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Apr 2023 04:24:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51517ED8
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 01:23:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id q23so34223462ejz.3
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 01:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681460634; x=1684052634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HlmjkGlmEwPeG1vyNfy2LB3FLh3g3BVhfM8XvqJ5230=;
        b=QVQr2FnlD4RjAAT+O04gy+/OhztUE5CI1IOw03DdQeNErGKtZQ0QNmWPYJRhXAi/qZ
         rmEwmQflx7w+RXnfLh61kVd7/iWTKr/P8th0I6NycDg6WsYSLsUmohzDXBFB5MSvH58e
         SkWMdUoHcH8tnFI1NEIXNVAkvhlfoDup1i7u5U/dbf5Fdiq4R2tSFqATAfYIqHRLcoYy
         QE5SQsRQB4q33v+Xwz7TTh0OG6vu/o6ux78k8Dj5EkI97XpQZ8ecHx17F8rOcRu73+Bl
         +FQENJm7GHhO7PzDvr7n/Pzdv+AnsGK10INAN/iBbYfrgUCOHDmhx3Q4QQrfcMFrDFgr
         9Img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681460634; x=1684052634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlmjkGlmEwPeG1vyNfy2LB3FLh3g3BVhfM8XvqJ5230=;
        b=LPVTOt0a5K2JwUQ8VfD3zUqegtSHawVElBT2s0sUTjXGvbcFalbaR8e68+CvaLS7wb
         POwEllSEMDJtzPJOrh3pdmeO0jxVYILnBqbaCAHRcivpw76dbQKjlOKB6X1r1zw+Pqs2
         zXd2Jdu9fgSSUB5GldkidTZ6u8XyKP73BCq0gPAVV8n6b1hSn8tx3jM0w46BgH2BP+aF
         aFDFEH8QkAK9OwkMUcU9Qmcb+bPJLeyDHBlBViGTKTe4h9CeXFiSl4GDdumGsjQ7iTkl
         Sngf+E5pXeQt5eB4FjyV0pXakia9zPHqtnUsOmcN162uaIO2omdlns8MexfKBhzno5zw
         r5TQ==
X-Gm-Message-State: AAQBX9fKI2wZwYx3gMUE9O979RVHgNQics/uvzupklsDvRPLs9vkWmfW
        83cBbi7TBmDtaYH63ZX1SEVekQ==
X-Google-Smtp-Source: AKy350YDDfm28Hr4Wu9pej6rnmmCl1oHhpNzr5ms7AHGJkI6pneNOhN5mTSgVEdO2HuvAbf8V5rPPA==
X-Received: by 2002:a17:907:3a03:b0:94c:784f:7569 with SMTP id fb3-20020a1709073a0300b0094c784f7569mr5193398ejc.30.1681460633867;
        Fri, 14 Apr 2023 01:23:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id l12-20020a056402344c00b00504803f4071sm1843079edc.44.2023.04.14.01.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:23:53 -0700 (PDT)
Message-ID: <18a7f165-592c-8443-c661-6b0345a6cd00@linaro.org>
Date:   Fri, 14 Apr 2023 10:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 03/27] dt-bindings: display: mediatek: dpi: Add compatible
 for MediaTek MT6795
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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
 <20230412112739.160376-4-angelogioacchino.delregno@collabora.com>
 <0416a00e-b567-1ae4-c49c-ec21e024ab0f@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0416a00e-b567-1ae4-c49c-ec21e024ab0f@gmail.com>
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

On 12/04/2023 14:35, Matthias Brugger wrote:
> 
> 
> On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
>> Add a compatible string for the MediaTek Helio X10 MT6795 SoC, using
>> the same parameters as MT8183.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../display/mediatek/mediatek,dpi.yaml        | 23 +++++++++++--------
>>   1 file changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> index d976380801e3..803c00f26206 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
>> @@ -17,15 +17,20 @@ description: |
>>   
>>   properties:
>>     compatible:
>> -    enum:
>> -      - mediatek,mt2701-dpi
>> -      - mediatek,mt7623-dpi
>> -      - mediatek,mt8173-dpi
>> -      - mediatek,mt8183-dpi
>> -      - mediatek,mt8186-dpi
>> -      - mediatek,mt8188-dp-intf
>> -      - mediatek,mt8192-dpi
>> -      - mediatek,mt8195-dp-intf
>> +    oneOf:
>> +      - enum:
>> +          - mediatek,mt2701-dpi
>> +          - mediatek,mt7623-dpi
>> +          - mediatek,mt8173-dpi
>> +          - mediatek,mt8183-dpi
>> +          - mediatek,mt8186-dpi
>> +          - mediatek,mt8188-dp-intf
>> +          - mediatek,mt8192-dpi
>> +          - mediatek,mt8195-dp-intf
>> +      - items:
>> +          - enum:
>> +              - mediatek,mt6795-dpi
>> +          - const: mediatek,mt8183-dpi
> 
> Shouldn't we declare both const: ?

I assume it is likely the enum will grow. If this is reasonably
anticipated, keep enum.

Best regards,
Krzysztof

