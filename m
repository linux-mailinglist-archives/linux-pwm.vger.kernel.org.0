Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF156E1E60
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Apr 2023 10:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDNId7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Apr 2023 04:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNId6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Apr 2023 04:33:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8E035B1
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 01:33:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5066ce4f725so1281174a12.1
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681461236; x=1684053236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NpwShvISTcTE3K551Ap7usqhXOxNcMryVkJfhLZoUUQ=;
        b=gsiPpWBp2wpRZMjngR/LlRcMXgtQhIJMpe1zxLflCmmCEgZt1OKJwCaaOuy1DRfeG4
         8Btrq6P7SzcRIEwS+LzlJZ7Xy8WKZllnDewpxsObInwk1yG9iMGXgLwLfVQrVvsmQ3l8
         GRnVASeSZv/aJAIJZcH2Tq5EIEKvmGeMwVpgmsKj2nG6SkyJk6BLzVeqL1fq/ClPJpAL
         D2HXXK5q+Sm/lZ+t6o/2LhFPgSoeb9zXxR7qfaDZKOqyccvzAfDms7EFm1rUOy0oT0pa
         S8ZqPM1ighYnFYjjvIwJuXJL4VsoiUOYj9wFcvl7d5v+aT2h15sOyAHO8r3o7TYGV/L8
         GreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681461236; x=1684053236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpwShvISTcTE3K551Ap7usqhXOxNcMryVkJfhLZoUUQ=;
        b=bIV6ceVtF/MvFG0biQuRIuzlflFprIBMTlGoFOT+bo6M81h5Bwq6uqMf0fMyDSh4ou
         pJwXAYzyMOzEPWBbABjGTgjUM5bCOjjJQLe+LzXc1J742c6i8sHKsuUL2aYw+P9yzzhJ
         82KiEn18Z+PItYjedXmAXmuskqsEyKNjaL8zsIt8nYCb3lCjcufWO+6eAr9TjSjoOOFb
         hvOTMiuFVdogsSzcybyKKo/Gfrlebql6s8FXeWx+IKyjQxjGKOXUf2NiTCQDG0vFvu2B
         CgzR2AkddktaicVRokzasZvs7WMxc/MUbqJrheFyR/nMUo4lDeECkZMRVT026PiYh7vJ
         3a/w==
X-Gm-Message-State: AAQBX9dgAqzQOPCwF0jSV9W/RNJybTekU+683DjTsAslCmcLhYFypu+E
        RCQ4N6TTlUVCqfigl8guLKhUGQ==
X-Google-Smtp-Source: AKy350ak3cqtwXDorNJtScCLcUQuNv92fnfl8eFxO84dV/0O6W4+Gjg7xHm2TDj2lqckrpNVg9kccw==
X-Received: by 2002:aa7:c7d4:0:b0:506:8470:c323 with SMTP id o20-20020aa7c7d4000000b005068470c323mr823188eds.24.1681461236235;
        Fri, 14 Apr 2023 01:33:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906208f00b0094a511b9e6csm2117677ejq.139.2023.04.14.01.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:33:55 -0700 (PDT)
Message-ID: <b573ddb8-3909-998d-f051-6a3c4af1c629@linaro.org>
Date:   Fri, 14 Apr 2023 10:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 11/27] dt-bindings: display: mediatek: merge: Add
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
 <20230412112739.160376-12-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412112739.160376-12-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795's MERGE block: this
> is the same as MT8173.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

