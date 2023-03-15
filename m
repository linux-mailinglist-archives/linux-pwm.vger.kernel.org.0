Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7749A6BB44F
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Mar 2023 14:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjCONRh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Mar 2023 09:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjCONR1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Mar 2023 09:17:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F26C2202B
        for <linux-pwm@vger.kernel.org>; Wed, 15 Mar 2023 06:17:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y4so45962697edo.2
        for <linux-pwm@vger.kernel.org>; Wed, 15 Mar 2023 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678886242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xb3QrMvZd6yXgo618qylfqMF5lEqCyijeAUK/t+b8pY=;
        b=tllWpTVkNiFevbCV6hrsro8EDioioGuXMk8U7uog+O3LTKQ+iwWPKkRrK2a6/gFt5T
         KwLk2WSdmaLSw+gfle9g2We2K7WaRPNyZefDvVsHAna15v3BHpv77DQTr9pWOkmNC4Fa
         /BgHTwnJJ9jluRuRVQULjJbYi5tK3ItpWVTJBKEmpsz/nkG3RIRNcGGKCsMrhxjGhIL1
         RXGOIpfj/3xbldFNygvv8MeKNPspTZ6uEJahOCtvAvU16zTpPJIFPt8K0LF8Rl3rOBrF
         4E9YCPTFe/5T1pbj4Z8UQEI0WAdq8sKV3npKVuuklm/+UvBjD02NfY57buCnifJZWVoW
         OQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678886242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xb3QrMvZd6yXgo618qylfqMF5lEqCyijeAUK/t+b8pY=;
        b=YN7sGPv3JBG9P1pWS0cGkm9Za4I112wh/A+fosweRVFdRBY+87YRqjYwzvisM2SXTu
         WWzA2LVNmAmLT4ZOQskNG/WRUVjYsE3PLvbSSqESKIQ4DWJ2bo9CUVYXXNX/cwXi0Y6P
         6N1TXl1jNjEuhwkxpkua4TlgHOG18T3gZ0Vl0/bRHcHFksz+qsHkt2eRlFjjAmDfKATX
         V++gduqZcdupDyyDSA0Q6CHXfFYl3OhubVcFIlLmkxwBsnTorkcxSzrFyxs42BsVtM5Z
         11BiBhsLF1JDBb2Gdih2bq/qneSAalWAfk01gcuBGRnTnMSSPfnTTP0XOUYrFqSDVJR7
         6lHg==
X-Gm-Message-State: AO0yUKUoqCON2N22LTzoDgeutjEQEY9ifNyxntyh7BUuKs0TN8Ooq34z
        LSE6GAdUF09zfYjEtvjWRrWRlg==
X-Google-Smtp-Source: AK7set8XLwvi0YYJ2zeYnMe04uDSQnmdw08tghX2TWXAj6C5xYII9tMdLb9fM2JagC5ZFNQlGrwrlA==
X-Received: by 2002:a05:6402:455:b0:4fc:b83d:c31f with SMTP id p21-20020a056402045500b004fcb83dc31fmr2560472edw.16.1678886242456;
        Wed, 15 Mar 2023 06:17:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id r9-20020a50c009000000b004c13fe8fabfsm2414078edb.84.2023.03.15.06.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 06:17:21 -0700 (PDT)
Message-ID: <37c2c7de-792e-0289-4551-24bbb9fe31d9@linaro.org>
Date:   Wed, 15 Mar 2023 14:17:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 15/21] dt-bindings: soc: mediatek: add display mutex for
 MT8365 SoC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Fabien Parent <fparent@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-15-45cbc68e188b@baylibre.com>
 <ea8aaec1-948d-832b-ff24-b35abd3a59a2@linaro.org>
 <CAFGrd9p0qmfypP2DDJN1vEhJYciVfgFXZWLmvQOdpE=qgSDvKQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFGrd9p0qmfypP2DDJN1vEhJYciVfgFXZWLmvQOdpE=qgSDvKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 15/03/2023 09:01, Alexandre Mergnat wrote:
> Le ven. 10 mars 2023 à 09:39, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> a écrit :
>>
>> On 09/03/2023 15:23, Alexandre Mergnat wrote:
>>> Add compatible for the MT8365 SoC.
>>>
>>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>>> ---
>>>  Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
>>> index ca0ca549257d..931d66893dff 100644
>>> --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
>>> @@ -34,6 +34,7 @@ properties:
>>>        - mediatek,mt8186-mdp3-mutex
>>>        - mediatek,mt8192-disp-mutex
>>>        - mediatek,mt8195-disp-mutex
>>> +      - mediatek,mt8365-disp-mutex
>>
>> All these look compatible. Either make mt8635 compatible with something
>> or even rework entire list and make everything compatible.
> 
> All of them use "mtk_mutec.c" but have specific data.
> 
>       .data = &mt8173_mutex_driver_data},
>     { .compatible = "mediatek,mt8183-disp-mutex",
>       .data = &mt8183_mutex_driver_data},
>     { .compatible = "mediatek,mt8186-disp-mutex",
>       .data = &mt8186_mutex_driver_data},
>     { .compatible = "mediatek,mt8186-mdp3-mutex",
>       .data = &mt8186_mdp_mutex_driver_data},
>     { .compatible = "mediatek,mt8192-disp-mutex",
>       .data = &mt8192_mutex_driver_data},
>     { .compatible = "mediatek,mt8195-disp-mutex",
>       .data = &mt8195_mutex_driver_data},
>     { .compatible = "mediatek,mt8365-disp-mutex",
>       .data = &mt8365_mutex_driver_data},
> 
> I don't see any SoC compatible with mt8635, and I have no idea which
> rework you have in mind. Can you please point me an example ?

You are right, I looked at wrong of_device_id.

Best regards,
Krzysztof

