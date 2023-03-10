Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814FB6B38FE
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Mar 2023 09:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjCJIl2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Mar 2023 03:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjCJIks (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Mar 2023 03:40:48 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D69E6817
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 00:38:33 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id cw28so17430027edb.5
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 00:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678437513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jX9C5jsC1gif4BoDiLkwtHT3RghH5PN+LBKh8t0wrg=;
        b=H4fQ7akqxIUQoaNTb9Z4JkcxVGx/bU51xZWjMh9utqF6N1ScpXGX/Y7B4b2C4y3B8b
         1uJPBbYC2c2YUS2GiJLOioYm6G6CPJI1ITJLrSU9I29w+1L/GUpNh2SRzhsj7NG+uFRk
         GvuIo/nk+w2M+2qg8loXiWlOUIiWhi6B4fv2uzaDSSj1XlmSeQCg6QVszBPLWvlvwvjr
         P+N+MDsGYbMW4r0//DEhFvj48XikhdRigGPvnBjVnpglazhH8bmz2GSr5ZS6B36iN+6e
         wfxBsQWkUG1D2ttnZe5O5xtk89yHTtINLvAp5MbYt46wDZhcYuZvd8L88YFLjcKkiKJi
         gUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jX9C5jsC1gif4BoDiLkwtHT3RghH5PN+LBKh8t0wrg=;
        b=WFzuB3f2tE03KiFzeL0Uthk8S448WCfY8Bm9Lt3hD2IPglRiFCmtC1LHaTP99IOTYi
         6ehX5uCrOr9Zb1Hg2FCqM9pMaAuz7fYFV2J1+FYdGbvbrhOkaRo1fJhBJJnlVdoAwrcn
         8MzY/xoeeq/lKAmZrifNOmtijwZnmd8gTzBZ6JqomhioWU/LNhmzqsNFkQbAvyux8ROW
         StmCYxfhRcrzja2aBMjSQtIlEbdiBpj5JsCwInml7L3t38aMwoT7cgTaf7KmvqYLyfGf
         LUKswWhyVaaJhxabE/pp1MpgSox+ujQS9k6uIFPdWK920xbEmSxisP5/4Z8KvgIelUni
         NfSg==
X-Gm-Message-State: AO0yUKWrPtGsz24iBj7vK8O6eCr6+Ma+9SfSikkiRCR6SrUg0CkxVzOD
        BbENSQSt5ao/AYvVR/UFgwlzNA==
X-Google-Smtp-Source: AK7set+gioboWv9qQuHDDci4UGzpTiLbVncpzdW857S5/NDplZRpEN/ZSe4nXeBw8pldZ2o3ycauOQ==
X-Received: by 2002:a17:907:5ce:b0:8ae:6b88:e52d with SMTP id wg14-20020a17090705ce00b008ae6b88e52dmr904091ejb.7.1678437512905;
        Fri, 10 Mar 2023 00:38:32 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id n18-20020a170906b31200b00914001c91fcsm673989ejz.86.2023.03.10.00.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:38:32 -0800 (PST)
Message-ID: <7b8d8c5d-493c-0785-832d-954af502fced@linaro.org>
Date:   Fri, 10 Mar 2023 09:38:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 10/21] dt-bindings: display: mediatek: rdma: add binding
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
 <20230220-display-v1-10-45cbc68e188b@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220-display-v1-10-45cbc68e188b@baylibre.com>
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
> Display Data Path Read DMA for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8183 SoC.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

