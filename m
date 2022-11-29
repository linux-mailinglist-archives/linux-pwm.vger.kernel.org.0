Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004EC63C190
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Nov 2022 14:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiK2N64 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Nov 2022 08:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiK2N6w (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Nov 2022 08:58:52 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF1E2AE1D
        for <linux-pwm@vger.kernel.org>; Tue, 29 Nov 2022 05:58:50 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id r8so17181748ljn.8
        for <linux-pwm@vger.kernel.org>; Tue, 29 Nov 2022 05:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2pPVev3RCLudXV+llX32MLBUni5nh/cZHxB+M0bkvM=;
        b=waDyAGc0fv9NY23aBVzUNd67+z6i2Ph8TR02pjEtX5Gw3qHQxpk4I+q34Asfp8aKNJ
         K+p4L/Ml0yzueqtCa9osb/bhNa/kqof6YmJg2Q5S8Y+0DICAkYA8fMfbkRI8ZnSxYkM4
         InYBUxsj890TCUfs+3S7EDh/6ReIQeF8cKTBHCMk/oaNxo9cWTdc+fxUVG/bOiC6Kiw2
         rgsvViSG2SjV9iykoPSrywu5EBj8dGiO7TYJaJ9JKlPrBdzkxakmpzU0fcl/SVySif7y
         2ZfIsW9Tg0qlbX0ag0PrmhQjv0R9em3kkW1j9A/CTsecvxMHbOKX+DBlFKq36PmtG5EH
         BnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2pPVev3RCLudXV+llX32MLBUni5nh/cZHxB+M0bkvM=;
        b=UJa+hgXGUS6s8Z5VQzoZhlJeIpKFAxtYSqUy1bJb8HRTULq9L+RKE2jSz/9lYWrCD7
         RFrBSCcliqrncSV0zXddYrw359c1sZWliOwAPVHlzo43dO3B7gH3lC92Zem8B4oKeakt
         SxeFPZ9SSpjKmanSuOx/TUN2JrYbmEU2IJaEJNUqsq1upvX8OnZ/jrCM1lNvQRRd4vwK
         iAt/dmY3GPkTFSs7KKO0XVQWbBdVdwwOqHWPyggYEIviLsG3TfrCEW37KpzNxsBAiFbv
         TOHfyim9kErXeVUyLXKFtBcX/E+8U2YAPB91gU/RiS4EgFHuc4mAAkTiO3HXEuPO9dAO
         sEPw==
X-Gm-Message-State: ANoB5plroRo4ZGFIYGcMmJEEl2hadMrL0wmg3KJBlud+tWTovokkcjR8
        rVTQoV9GmnyenhWEhdd3pvh7gA==
X-Google-Smtp-Source: AA0mqf5RacO/5cMNhLm9XvyvLvezEAskC3Cmkn9WrJJSxE0ZF2oNEfvjLLTyegDa4KnVOBnfDjlaqw==
X-Received: by 2002:a05:6512:13a5:b0:4ad:70f0:c7c with SMTP id p37-20020a05651213a500b004ad70f00c7cmr17467048lfa.190.1669730329197;
        Tue, 29 Nov 2022 05:58:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0026fc8855c20sm1548349ljc.19.2022.11.29.05.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:58:48 -0800 (PST)
Message-ID: <bf91aac5-7d9a-245f-7c97-b8be901cf538@linaro.org>
Date:   Tue, 29 Nov 2022 14:58:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 2/2] dt-bindings: pwm: mediatek: Convert pwm-mediatek
 to dt schema
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, matthias.bgg@gmail.com, john@phrozen.org,
        sean.wang@mediatek.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221128112028.58021-1-angelogioacchino.delregno@collabora.com>
 <20221128112028.58021-3-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128112028.58021-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 28/11/2022 12:20, AngeloGioacchino Del Regno wrote:
> This converts pwm-mediatek.txt to mediatek,mt2712-pwm.yaml schema;
> while at it, the clock names were clarified as previously they were
> documented as "pwmX-Y", but valid names are "pwmN" only.
> Also, the example was changed to use "mediatek,mt2712-pwm" instead
> for consistency with the schema filename.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

