Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E474B8567
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Feb 2022 11:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiBPKTS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Feb 2022 05:19:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiBPKTR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Feb 2022 05:19:17 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AED6C330B
        for <linux-pwm@vger.kernel.org>; Wed, 16 Feb 2022 02:19:05 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5972C3F4B4
        for <linux-pwm@vger.kernel.org>; Wed, 16 Feb 2022 10:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645006744;
        bh=8OOLa17szhk6+Vg3+wnuFFLqwR9SvrL1rcWwTRV4DbU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=htIqduRfNPLGakhWqjq+bjoNyrWsFizYekim73QO3lxdeOTN6BgQeSImCJTWx6q7B
         tTXwcTDO2ba2u2sTpESCJ5CToMOcph4g5MqYsyguuz2pTF8mColQbMQy/1bIqmeeEX
         Xiay8AWBi4cVKVRGXCyOhqQSb8eQWXdXjsq1oNA6JVadErIOUocx0VX6715gH4HzNJ
         mUI95nqcwTZG7NGFjsdJmp0x2joRpDp1LJjHa10gbm4rtwu3G+B6JZHUkYfWwv9P9A
         ZlfrkeB6t4uEpyq+QrNnHOH5WumViIoBBXTDqHOHXuCL+k6h7lMSRyiMdRVM9gV4Rk
         Q/wkHhGDdUayA==
Received: by mail-wm1-f72.google.com with SMTP id p2-20020a05600c430200b0037bb72b5865so117829wme.8
        for <linux-pwm@vger.kernel.org>; Wed, 16 Feb 2022 02:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8OOLa17szhk6+Vg3+wnuFFLqwR9SvrL1rcWwTRV4DbU=;
        b=jo8oDkSdzij99gxUgK8y9zbBLtKV63ZaXpu0Kq4Lbx1UW8f/pJQ1jYbmMmNq6Qd4z7
         rQmYRAKuISaeKXcycFA81/I2zSOwrofxdJSTZVtQSMXXhBeKyxtxIteYMAMI3sTNlD/S
         +gNS2rddycE65tUI3FqnCeFbgKyMwVYLS1Mk1YBrOvb6alMRq7MX8WAJsi5k0BpSHNyM
         GsQUVezgldwRmh8wtrr37CZ9TtkecD3UcSR816HZi0InLr50Igbymw3g7pZxczKLjErD
         ecibiwnSOi/2m+i7fZPjM/zsvlmrTBNHjVpmWSYpstjnJ/BTwcsmTFz6Hll/36+5mMHH
         ximw==
X-Gm-Message-State: AOAM530Zm5YkueeaWtEOrH4WIAQ/5iwsSOP2vinWaFT6QZzlkcnebRYx
        YIgMI0StHXoyUVaiI0O4McRrta7Qlsk+o8LHoeVv/WrzEeBDsaE37zGUdseLreUVCUPOhtA7toI
        O3AyHmOvJuep+7YDYcrK7Uzn5ZvJq7ufyKwVciA==
X-Received: by 2002:a05:600c:3b21:b0:37b:c3e4:2118 with SMTP id m33-20020a05600c3b2100b0037bc3e42118mr881927wms.66.1645006744068;
        Wed, 16 Feb 2022 02:19:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyf3UFTJ+JYq+/ZRJoOM/VuEU5pVmkXnms6laAM61/FvU71Sbs3F8qYgMoSzDOxd4nUeQxZAg==
X-Received: by 2002:a05:600c:3b21:b0:37b:c3e4:2118 with SMTP id m33-20020a05600c3b2100b0037bc3e42118mr881894wms.66.1645006743894;
        Wed, 16 Feb 2022 02:19:03 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id n6sm17765250wru.114.2022.02.16.02.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 02:19:03 -0800 (PST)
Message-ID: <06c1d3f1-3c12-815d-27d1-7ef3efb22877@canonical.com>
Date:   Wed, 16 Feb 2022 11:19:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [v2,0/4] Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml
 format
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>, xinlei.lee@mediatek.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com
Cc:     allen-kh.cheng@mediatek.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
References: <1645003971-16908-1-git-send-email-xinlei.lee@mediatek.com>
 <7d54ecb2-bb7a-ab3d-9e29-fa2541ec549d@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <7d54ecb2-bb7a-ab3d-9e29-fa2541ec549d@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 16/02/2022 10:47, Macpaul Lin wrote:
> 
> 
> On 2/16/22 5:32 PM, xinlei.lee@mediatek.com wrote:
>> From: Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
>>
>> Changes since v1:
>> 1. Fixed formatting issues mentioned in the v1.
>> 2. Delete pwm-mtk-disp.txt.
>> 3. Add mtk_pwm dt_maintainers.
>> 4. Add "#pwm-cells" & power-domains properties.
>> 5. Make dt_checking successful.
>>
>> Xinlei Lee (4):
>>    dt-bindings: pwm: Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml
>>      format
>>    dt-bindings: pwm: Add compatible for MediaTek MT8192
>>    dt-bindings: pwm: Add compatible for MediaTek MT8195
>>    dt-bindings: pwm: Add compatible for MediaTek MT8186
>>
>>   .../bindings/pwm/mediatek,pwm-disp.yaml       | 74 +++++++++++++++++++
>>   .../devicetree/bindings/pwm/pwm-mtk-disp.txt  | 44 -----------
>>   2 files changed, 74 insertions(+), 44 deletions(-)
>>   create mode 100755 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
>>
> 
> Why did you drop [PATCH] tag in the subject of your patch series?
> Please keep it for distinguishing it from RFC/RESEND and other 
> meaningful tags next time.


I also asked for this in v1 patchset, so it's a pity my suggestion was
not listened to.

Best regards,
Krzysztof
