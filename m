Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E8B59D77C
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Aug 2022 11:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349042AbiHWJRZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Aug 2022 05:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349507AbiHWJQD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Aug 2022 05:16:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13727753AF
        for <linux-pwm@vger.kernel.org>; Tue, 23 Aug 2022 01:32:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m5so8021177lfj.4
        for <linux-pwm@vger.kernel.org>; Tue, 23 Aug 2022 01:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=F+5yVrf2toWobmjjbMycRUMUYr1HibosAX8wZbYW6I8=;
        b=ME5pga0xqukFaQ68m0vfi01ZcbRzB6yRE0fmlS7+txX0bQzWcwtEDRVyRioYOwi0MK
         78InqOKpEzQjwwoKp2jLetMmVf+U5kGfjAGpCioYESzh0Nn7R6NnQEhEpy83phb2wUBE
         vONvAXl1ssbqNdhWgsw2pgINK15PKwGEugYDYXQ0DvtuYmJnc+kHLoqrcq/t9TBGW18o
         dZU7d/N5EaKR+aOL8epf9dLFNAFMKp9E+bD7gskVr4SPbXoi96eOAvH4hzX2GgWwnC3o
         g1IWqumSlGK5va3jXsEv35nL23bMbFlCDl0w5NvXP0nYtKGxRoJwWq/DNhDBDzGG9reA
         nMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=F+5yVrf2toWobmjjbMycRUMUYr1HibosAX8wZbYW6I8=;
        b=2a7sFhl1mO/dFvjz4j78Wa2vtgWszxqsbgGGySodm5ojsaw+1K/8G8Xkn1xZAo/iqH
         L2TGl3mbGz6Iw1B95k/WJlltF5YuI8vShwq/Vw9Rk/od76n/xur2SRFtYp/b3BC6L4xP
         1J1JBXwEo+0X7leZOKg7Or6NQWSwzbDb2SkHHnj8MrQ22uUw/oyk9qODagNOncI62Kq5
         qe6HIZ/IduWbL4CjHrs36PxuHZB3S63jcyo1rfosHjntH3k//YKk6V9zOAsYjUOx8ehB
         vKtyxLBO/2fXYDZHuAyQ6TmWJ251GG7B4/lxWfiZFP0QLjIQ/9pkbB0+x/gKd7c2pAUK
         ElDg==
X-Gm-Message-State: ACgBeo1bSaA4qXkK7ZPu1Pv/RnKDsj6sLpPqImelrT47jo4zuyyvoi0x
        bnExbrU2bdI+qAgBiD8LNIu2TA==
X-Google-Smtp-Source: AA6agR5US57wd92jMkSXVjf68U7K8XzRGHmQSa/B4s1jL0IZJ4zZqecKAkNJuoKOArqf5pabIV5IRQ==
X-Received: by 2002:a05:6512:3d08:b0:48b:123e:fcf3 with SMTP id d8-20020a0565123d0800b0048b123efcf3mr8057965lfv.418.1661243543099;
        Tue, 23 Aug 2022 01:32:23 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id v20-20020a05651203b400b0048a83ab2d32sm1193907lfp.0.2022.08.23.01.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:32:22 -0700 (PDT)
Message-ID: <f621a841-593f-cfed-9560-64c011a00bdd@linaro.org>
Date:   Tue, 23 Aug 2022 11:32:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH,2/2] pwm: mtk-disp: Fix the parameters calculated by the
 enabled flag of disp_pwm.
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1661239875-19841-1-git-send-email-xinlei.lee@mediatek.com>
 <1661239875-19841-3-git-send-email-xinlei.lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1661239875-19841-3-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 23/08/2022 10:31, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
> 
> In the original mtk_disp_pwm_get_state() function, the result of reading
> con0 & BIT(0) is enabled as disp_pwm. 
> In order to conform to the register table, we should use the disp_pwm 
> base address as the enabled judgment.
> 
> Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>

This is a fix so not really related with the change adding new device.
Send them separately in the future.

Best regards,
Krzysztof
