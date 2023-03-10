Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0746B38F7
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Mar 2023 09:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjCJIlM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Mar 2023 03:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjCJIkg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Mar 2023 03:40:36 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84451DBB51
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 00:38:21 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id a25so17578026edb.0
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 00:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678437500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8P0RjPPjJ6gDx/O+UOt7XYuZJFBYo2c+dJvtzrcfc8=;
        b=Qm6w9iISowR+oMVJYM/hQSnZ4JRKkanoVQFKUhlTESl8dqbNr4Qghw4HziigDxrHb+
         3uCO8RrB0vZVGj3UAekguMmehIXsYMTd1fjEMpnGTvZWSntMe9MxdJc9TCxeN1qRnss1
         9x/nQEu0IpMw3T+pD7CKP1FZIqqKK3F54sneBXx1k+LoI2TVcVgBMOdtduWQIqOMNt5E
         F8xY8xlmYVP+l3SrXc3O9D7anX14xNKTDiBvRrCnIK91MDso/N8+UvT+qJ1iwRDjSu9E
         h+xcHj5cMsZYP8lylmurMTu8vfkN8t8MS0IluatHJWeHR8WkV+ikebzhhc6GDU/bIGIg
         StaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8P0RjPPjJ6gDx/O+UOt7XYuZJFBYo2c+dJvtzrcfc8=;
        b=OZGoXdVrOSCkvEHSahBBzPjlq3ZCZhAYVMIUdDxljp2BHoiqwcXs5zXMN6B1WDvHh6
         EszpTDu9Y5ZvJ1Ljcovhn+Cuv1TstRNp/lbGq+6kfT4QWp+T+PmGpbVPZr6LG4OtgZAW
         NjQEoO9+84Fo/o/8NxDciOtOpVS0Rh0FrDQmWJ/G8dEze1WE5q6RcZw28EcAIUVLeGkx
         wW5K4mhrsulQ316T0/AjGl2TSs86rfKXJk4VuMj0MloDhNWkdvIMkg7IATBEyhQlxzYU
         Y/uoMlJ/k+9MuzMdC4rrcSD2jJ09Xqy7oB/Z+Ppii7f465WD4+v17uDTZ9CCtvNVJLeF
         s51w==
X-Gm-Message-State: AO0yUKXp8R4F/heyvf6uFkR6Rs+Qh/WQB671Z/G6vBJZbLSLl0wxIO2d
        HTXk7jPbCXO0EYi6d84cnZ9IXA==
X-Google-Smtp-Source: AK7set9lDeUYOs5nAUvtFokDH1WpVjNALEB4b0oSQYXxs4FuVsLXJyZ8SKM7u+8wBouXS4esT6UkBQ==
X-Received: by 2002:a17:906:2a55:b0:878:66bc:2280 with SMTP id k21-20020a1709062a5500b0087866bc2280mr24741630eje.12.1678437500095;
        Fri, 10 Mar 2023 00:38:20 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090668c500b008ee64893786sm681605ejr.99.2023.03.10.00.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:38:19 -0800 (PST)
Message-ID: <89e8b1a4-8063-da12-1b91-a9d7bf82fcde@linaro.org>
Date:   Fri, 10 Mar 2023 09:38:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/21] dt-bindings: display: mediatek: gamma: add binding
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
 <20230220-display-v1-8-45cbc68e188b@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220-display-v1-8-45cbc68e188b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 09/03/2023 15:22, Alexandre Mergnat wrote:
> Display GAMMA for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8183 SoC.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

