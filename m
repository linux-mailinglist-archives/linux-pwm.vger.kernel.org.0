Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4344D4EE298
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Mar 2022 22:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbiCaU1f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 31 Mar 2022 16:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbiCaU1e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 31 Mar 2022 16:27:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA4A231AFB
        for <linux-pwm@vger.kernel.org>; Thu, 31 Mar 2022 13:25:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so1646194ejc.7
        for <linux-pwm@vger.kernel.org>; Thu, 31 Mar 2022 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IVwmuWYXmc6PxSc6Y/RgcIvWvdH6cabgH6Cbl/2NYsE=;
        b=qF1s2bsIkIkwALQQbK9phUTbyM7EQv/ZWribu1fYZe3qcD+6pENraSXcfDi7Gsops2
         CQniF0O01DTnl+EvGvsYDnCmA0wDOeZ991a08nCzNXOrpQ4CmMeyqYDzYeYW6xfzu7qi
         IchxzVai5NYInNPiUMH/jxV9n4O21Af99bwvbreSxnqKu2bbClO7f86Idh/ySc3nwWxW
         oARRdSXUeNLuTwTUSakS+3uEmkRAUR0gGNE1UgnESoK555OamB0qws9A3e5Ef46bazfg
         UYb564kg6cW+DR2WDXgNZG9MA5qK66Vuk+u7RsiqTXNtLaSiw0Zz0yiWb/cUxFZUQz6N
         Fw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IVwmuWYXmc6PxSc6Y/RgcIvWvdH6cabgH6Cbl/2NYsE=;
        b=nqMf0+n0nvP1ygJ3ranClKyKaDzi2oemaNYI7h6ysTCil9BIh9jgSBxD8mrhLmTkh5
         Nt7t5o+pr9WMUK1ljTMlbrDgnqG2k0iDOI+VwjltP5IHC+jpEgmwiB9ibKDVdHLR2NKL
         Zjkp6UUed3Scv36NP5kwUeyb4Zq92bcB5sx9UbO1DXh/N1z/CkeLvhGoEZdhjF+webCB
         Dr/oi2+qzCSl/VOTJkv7rLExS8jgH1jWjRPmL8dWApXNJ/bB8kA03CCNFkiOrqjlS+6A
         o8/AM1Hht/FVZW2jLU9BP61Vqf4r8FOMkC61VHQjQjGrb9se5gN8pCPn3ZtjFqIlzqLp
         zMTQ==
X-Gm-Message-State: AOAM531xn1qPE40M1F0wdDIvIIek0uZujw38T/SQqnUPEO8U2VB8Ge54
        b2nNYJzw02J8Sqhhlmo5+tO8tQ==
X-Google-Smtp-Source: ABdhPJzqQfEiQzRkvUB5+kDvhz2zj/QNg7xQta5N/nDJPmJJUTp0RbFPzOZLHRrPo7zDeKR3V1WGag==
X-Received: by 2002:a17:907:2cc6:b0:6e0:1ae5:d762 with SMTP id hg6-20020a1709072cc600b006e01ae5d762mr6610402ejc.291.1648758345516;
        Thu, 31 Mar 2022 13:25:45 -0700 (PDT)
Received: from [192.168.0.168] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id k19-20020a1709062a5300b006c75a94c587sm175359eje.65.2022.03.31.13.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 13:25:45 -0700 (PDT)
Message-ID: <1aee818a-ca5f-098f-c549-4d500630c777@linaro.org>
Date:   Thu, 31 Mar 2022 22:25:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5,3/4] dt-bindings: pwm: Add compatible for MediaTek
 MT8195
Content-Language: en-US
To:     xinlei.lee@mediatek.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        rex-bc.chen@mediatek.com, jitao.shi@mediatek.com
References: <1648730873-18505-1-git-send-email-xinlei.lee@mediatek.com>
 <1648730873-18505-4-git-send-email-xinlei.lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1648730873-18505-4-git-send-email-xinlei.lee@mediatek.com>
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

On 31/03/2022 14:47, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add dt-binding documentation of pwm for MediaTek MT8195 SoC.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
