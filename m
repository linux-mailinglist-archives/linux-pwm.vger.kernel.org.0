Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBA66B38D8
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Mar 2023 09:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCJIf5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Mar 2023 03:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjCJIfb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Mar 2023 03:35:31 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67084101135
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 00:35:18 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i34so17340811eda.7
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 00:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678437317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFsIUvQhnh2wbwHqMLG7mN4Mz01L3GW7UAQC2+jEkIo=;
        b=fYVytIbt0kRF0tnnLPcwQ7EF7XcCYv8OYZL5/yoNCRnv8tAcHblkanGpQ6JgV540qy
         WTNSxJfv8NIfoWNrswkv8xcwveQt7yMHOP1s+ei/Y1ocjefH37NAuC5JvViV8j8v3B7P
         pXbFsWMp8NFOeQOSBznsU208r6uF2UP2EyGv1Z6H8YCU17FOy5ja6t9TtuvLGnEaO5gq
         i/HzF9WKrQhg5ZcXC7dSpeJZrkSZfKGhQq5V/OL8HE7CqamcOR1WNRHUV7JnpeX+2p11
         vUNpFu4PHTU2z7DD5E13TkmCLb/1JM1gzQ4mY/VDbPwTxjfg5y/MkZl9Ce2W8iC0Ii2P
         ReOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFsIUvQhnh2wbwHqMLG7mN4Mz01L3GW7UAQC2+jEkIo=;
        b=bimG2gUjju67ivSRAx70QJY5NCz9ASRCRmARvT52+Lx+8VlSkovskuU9hbzxPEf62u
         EGNrn88ylEFF9+2Vo6TIgNPMQBw3rOUKcZodVkaE6NkPUOqfP07/E5SrA+WeUNX+cnIQ
         nUTy8hi2vHl8gY7t8+JCtFXALSAP/7uIFZ7uDxBD7FeY2klHkcCK4VAV9BQRV43k3B+V
         522jw1VmkSWMJGsseoobaSeIOaUcHwr3NtAKXV7QDQ1BEv3TE08Oh0YhUCl4Ye9rQ9RO
         1Q4v/arYAqRyZO5tDjdwoibOxVsdJFI7ETwEyrexfamkjmVNQ+1EwpKSQcwzka2NWENr
         Pviw==
X-Gm-Message-State: AO0yUKVITMitoNdrmzfthmA2PXICYbR8GpjbayvItpFs+9Gpt8Vmg3dc
        s9T7WXYY+yBpEDLgYjtmM6sT3g==
X-Google-Smtp-Source: AK7set9I5xoClWzOboxhwkIqcXcQKYAuUC4Krc6brpIBR2aX71Y2At8rBXzZdBkd+8bMsc88kMSK1g==
X-Received: by 2002:aa7:c153:0:b0:4ac:b614:dcfc with SMTP id r19-20020aa7c153000000b004acb614dcfcmr24012037edp.9.1678437317709;
        Fri, 10 Mar 2023 00:35:17 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id y94-20020a50bb67000000b004d47ce55e57sm541331ede.10.2023.03.10.00.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:35:17 -0800 (PST)
Message-ID: <81466b52-826f-b4ab-5a1d-d4d49381d7f7@linaro.org>
Date:   Fri, 10 Mar 2023 09:35:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/21] dt-bindings: display: mediatek: color: add binding
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
 <20230220-display-v1-3-45cbc68e188b@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220-display-v1-3-45cbc68e188b@baylibre.com>
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
> Display Color for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8183 SoC.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

