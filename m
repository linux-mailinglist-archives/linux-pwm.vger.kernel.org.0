Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678CE518473
	for <lists+linux-pwm@lfdr.de>; Tue,  3 May 2022 14:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiECMlg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 May 2022 08:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiECMle (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 May 2022 08:41:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A283737BF4
        for <linux-pwm@vger.kernel.org>; Tue,  3 May 2022 05:38:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i19so33117540eja.11
        for <linux-pwm@vger.kernel.org>; Tue, 03 May 2022 05:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kcYyb33G4bTvlaxMALn1Ho4qits29no+2fDqO2JUvAw=;
        b=g8FlJj3K8F9qNqb9jdO0UJ9BwCvUYsjSNFUG+LZ4P2QrmBsGAvL6tm/JQgyo+t2wwJ
         dsxB0JrTDfK1upwB2PePTSp3qi10Zd5Bd7J0wQEXciAUt57FaYXLYXxmxUaAbF5V5zF0
         geoi1mCN8Eq7i6MTYDSGiO0CSo1jRr6Ax9aYGFNrSGAOQNazJcV7By0ogFqXYpDygygc
         3qJ7pFfmdqbpaxPcIvyhdRKw0LFRveQV9GOeXDI4+99BSzWSWEzeDakFZBg7MPruz146
         r+EKo6KtT6Qp+GboCtb8zTHXk7302mEu8RlTyrAfmif9RQP05IEglXwUWqgJp1j5EuDG
         QkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kcYyb33G4bTvlaxMALn1Ho4qits29no+2fDqO2JUvAw=;
        b=DvkoyEuOAV58ue7z5zJ0GwrthRyPwg1WS07Ww0ZHOswW/f7/0V8Lczur/nRAgoSpku
         kubiBign5bvgqNGlOwbTsoGr3wDqaP70B5ya1jd0x5LI4/95hXhdr6DuxqtZI8F3e01V
         7KbHhG63T4gzfuUh0btFZ6JLW8g4arcdMwph/zj/yBPe0hZbSFNZL7pOV0eqXA+g/SP8
         j2eXIuv5zsPBsRGGq/Be0N3yHh+QWrkKpl4m4RSksLjqjJ43xjnvxZoXjNDmntEose//
         W+YLGme6v5IA8vOFfYPiGCM4oRNv1vIQ8wsIU5FvQ4Vd2t1EJ4y++nFZ2cnbfXJj/i4O
         8OAg==
X-Gm-Message-State: AOAM532rJpexyi0Q1fXYkQMg4FvF17JlQ4crUlpDgsQPFdm9JLfj3Ggo
        1M5GfvEvcBU8daQ+BxzZ7JzTcQ==
X-Google-Smtp-Source: ABdhPJyYlWRKspdwM4OJukbNSv2LuGUD7TozjvJnFBcQnrINY5FjIDMDHwOPke7LgxKKRQqOXOZbcQ==
X-Received: by 2002:a17:906:9c82:b0:6e1:1d6c:914c with SMTP id fj2-20020a1709069c8200b006e11d6c914cmr15241412ejc.769.1651581480223;
        Tue, 03 May 2022 05:38:00 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jx8-20020a170907760800b006f3ef214e21sm4580816ejc.135.2022.05.03.05.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 05:37:59 -0700 (PDT)
Message-ID: <da9610ce-a534-fb8a-6677-dad320acc4d4@linaro.org>
Date:   Tue, 3 May 2022 14:37:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] dt-bindings: pwm: pwm-mediatek: Add documentation for
 MT6795 SoC
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
References: <20220503105405.54832-1-angelogioacchino.delregno@collabora.com>
 <20220503105405.54832-3-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503105405.54832-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 03/05/2022 12:54, AngeloGioacchino Del Regno wrote:
> Add binding documentation for the MT6795 Helio X10 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
