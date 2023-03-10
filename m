Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641896B38E2
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Mar 2023 09:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCJIhb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Mar 2023 03:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCJIg4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Mar 2023 03:36:56 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A4710A139
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 00:35:57 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ec29so17367095edb.6
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 00:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678437355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mn1vLNX458kljHD+DHfjvMGt/le6hUqQgMBvdIhJEsY=;
        b=yRSFe7BvYv8hMAHXJ5/M6DA42nlT3ofi5LpTrmTGQbyGZXNYW/pN5FxD/7Ff+wkdOL
         uIUFfyL5W2t836jKHk11QHvarM59ZWADcKpc7Ektb8AMzpj9NlUf9Q9KRKsZbhey6l4m
         wwQgDjyXllRc+eA5ipo6kjojzkWoKilJIvdq5uU8erql+I4c6KI8O9b4UZ+g99ZYAZ0/
         URDnvz0c2J92xxkbheSnP3LIKX27MkRq8PjzN5tUMHTo5fpOdpVaMncSoYTfuyG0H/NL
         w0iKYcQWClqhTzPChCtCd9gL/HdanmcbfPdrFYSiXOMT3+po3Qff+FcTBnDFEA7tSSXS
         Dzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn1vLNX458kljHD+DHfjvMGt/le6hUqQgMBvdIhJEsY=;
        b=H7dIz4uRLuUoqNn4hT+ZNxlZ8F1vCaDx7DBzmJknPPIlL09jXRJdAqxqO3dS0fXrug
         +2DvD8CHL3RjTjZk51QpWqewVxqm+tMqvWXF/4eV05MH8Yo3IWgDKAY/LO3m7TXkdHnH
         t989IAcWJz9NZFZsPIp/fncSLyTS6C9akQ0oPPkx1no4ZiAtnaOq8jxkfAwZW4Dp58D0
         jTqqFB/RTNM9lY2r90TlCqSv009ORL+pNLvWYSt2VNcyu1UORkbqy0R4Mc1Oxk4CyhF2
         r60RZsmKPJbvnEshCamscWCjokbkqBnP78Fj0yypisHHqYQBRpi7R1pU6/MCe4d/l2zw
         yTSA==
X-Gm-Message-State: AO0yUKXwZww5lO1YsKCFrLcuw+BDmzDFh5nmrswoWUF5NLASc9nHa0lH
        j+G101vTS6h5PTZ9YuksgKBa7Q==
X-Google-Smtp-Source: AK7set+B8T3dy99CLujhhEDzNKkfET67hYpQvpYTs6C0Ur74VsFLFiujwxN190X58NvvhEJms9qBIA==
X-Received: by 2002:a17:906:dacd:b0:88d:ba89:1837 with SMTP id xi13-20020a170906dacd00b0088dba891837mr1006039ejb.8.1678437355374;
        Fri, 10 Mar 2023 00:35:55 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id z14-20020a170906240e00b008b1779ba3c1sm667385eja.115.2023.03.10.00.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:35:54 -0800 (PST)
Message-ID: <eef712f9-43c6-d6ba-3ad7-3aff7542bf27@linaro.org>
Date:   Fri, 10 Mar 2023 09:35:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 05/21] dt-bindings: display: mediatek: dsi: add binding
 for MT8365 SoC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
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
        Xinlei Lee <xinlei.lee@mediatek.com>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Fabien Parent <fparent@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-5-45cbc68e188b@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220-display-v1-5-45cbc68e188b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 09/03/2023 15:22, Alexandre Mergnat wrote:
> Display Serial Interface for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8183 SoC.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../bindings/display/mediatek/mediatek,dsi.yaml       | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

