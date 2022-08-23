Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C039E59D7D2
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Aug 2022 12:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348024AbiHWJRK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Aug 2022 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349074AbiHWJOH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Aug 2022 05:14:07 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7106D9F3
        for <linux-pwm@vger.kernel.org>; Tue, 23 Aug 2022 01:32:01 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id l8so1161523lfc.12
        for <linux-pwm@vger.kernel.org>; Tue, 23 Aug 2022 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XvC1kycGZUq7/xp82owivjaLx63VVI1e7MB1fTwqes4=;
        b=tRRDfaCQb1mENGjxM705CgplM7USLUwT0ZYlO01ujs7tE2GjS9WX5DWJy6dbIHYrWb
         EwOlH6OfSrUB6FUZe7+v9LyBryuYpQL2XogLPvTZlIjYYI1YuXsa/QZ4isRkVqYJNPwg
         Rz8lKFVsCzNvUtOu+z5+qjmD0nnfo81avth65SF91g3mEXVxF4VhoYMJ+TwteW4iC2Bk
         bESzTdhgAf6cf726g87KbXUqR3WqEpCRNxbrWhYI2ODDq1lUtZgF65gdbkSl2ib5UjbD
         hnQYfUWqg+/rcpjki3HQfr/LUSSnh0o4CQoHbSS7aiIVvYaydktPrizG3kbEjQsfWV5G
         XU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XvC1kycGZUq7/xp82owivjaLx63VVI1e7MB1fTwqes4=;
        b=a9DrZ5WJxQAIlzj5P1n6h/HjjqScq/UQM4ZsoGHHALNugsGNznnSMj2B3n818fJgx3
         ZokUq3Vy3uPzjA30lWedV2Os96j0FaXMh6AJYfEf5W4jVuKEcibcMLwJQYNcm11iEQQb
         RLH7Lgc1L3Igw4M0RIq8tcoSWzTbgoUSgEqxCtUPH39gnbzfzg5NYxRyHr8D3+70E4+u
         xjKaGGo9hyIXnZUfkG0NNFkutvjubsCCcg8+BOBlc1jvsCd6DQAf2bGTfxNltmYMvzc+
         uZ38yP95nzhr3IYgouLT2WAlgEYeJBbxSWMWk/yGmaqgG0FTeCtU1Ov6Yu5HzxhXMlwO
         i0xw==
X-Gm-Message-State: ACgBeo2JDwxioiMHTV3fpSKSYYYq0JrR8QdFfduPYXeg0vr1HWIGvRV7
        zkTGVn6nbJ1b5kTO7jqcQVYH/w==
X-Google-Smtp-Source: AA6agR7aKl5wOZ3sSS/kNZcVIPkQYUN+thp3PfMhDVdyL3iVlU/KkhDk6u/PjJ7GFgmARdIS89q4oQ==
X-Received: by 2002:a05:6512:1045:b0:491:f371:ad5d with SMTP id c5-20020a056512104500b00491f371ad5dmr7760918lfb.425.1661243516070;
        Tue, 23 Aug 2022 01:31:56 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id t1-20020a056512208100b0048b28acab8csm2396695lfr.64.2022.08.23.01.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:31:55 -0700 (PDT)
Message-ID: <fd93efd4-30cf-f498-efe7-8db5b76167db@linaro.org>
Date:   Tue, 23 Aug 2022 11:31:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH,1/2] dt-bindings: pwm: Add compatible for Mediatek MT8188
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1661239875-19841-1-git-send-email-xinlei.lee@mediatek.com>
 <1661239875-19841-2-git-send-email-xinlei.lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1661239875-19841-2-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 23/08/2022 10:31, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of pwm for MediaTek MT8188 SoC.
> 
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
