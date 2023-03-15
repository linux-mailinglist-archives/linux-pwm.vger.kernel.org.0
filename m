Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3146BB46D
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Mar 2023 14:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjCONWf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Mar 2023 09:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjCONWd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Mar 2023 09:22:33 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A7C7B13A
        for <linux-pwm@vger.kernel.org>; Wed, 15 Mar 2023 06:22:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id fd5so41586596edb.7
        for <linux-pwm@vger.kernel.org>; Wed, 15 Mar 2023 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678886534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/cG1woHh53iE47t9IaTZRCKGzkSSa7msGm/VhK5acs=;
        b=Pow9GvwqHtlC0BOvs0ezBbgaYHV1fPye+3TLKkG54DJjkKbhnZ0jvlBHw2AU7b8xk+
         xlyLpnuvF6TO4/Xlw3hjx/D9jn9U7lh1TOA1VhYXCwT/ENqpDfkaXE7uTOM0lEPv8BY0
         X9hSLHtDIH1hLGjLbyDwUMNaL6t86ek10Oh2x2ou4ZAG31I9uaPyQUD82MQdcHZb5nrQ
         y0pe/Wjfscfxi1+n0D8qW/ARD3wKOPhonm6yf60hUOlHOAQR8EE1RtDTN9czBoMNJDoy
         uwl9HTafH1IbiWmNx7Eh9Xl9w4Ko+C6+AiB1IvBGOriWO7bHbDy7EVEpCj+Fz6GIQYA3
         2LdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678886534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/cG1woHh53iE47t9IaTZRCKGzkSSa7msGm/VhK5acs=;
        b=UFGBoh8ll5OSpnUd+RHNcdDrixqbqmMJJ3tCexGzSPHumwpltRr5B0nUm2ZBsiHbrU
         fg0DyohV8RIjiuMWALyqif3jFDxiAyK4YWM2Nb3TZYOC8nRdB/dQiwD4abskKNXij60c
         Sz+L3CG9ExFVe1VxzgAJgZjKlVtxcgtjkHmo3667Q+kCRk+jEaqg968zKP6k6Lp4JhN1
         YtliOqPEB+CGT6aEmqS9rTzLfGzUwnNAxWQDIw2W64hH6rv7aP3oICmPWVhXj2nIbH5j
         2CLCydT2gnCqOswMq47B9LPtTXcAn/06mW9j4CDU99PAInSioLm7B3g0atQi1AmIYhTa
         CjhQ==
X-Gm-Message-State: AO0yUKVcY822ju9KVpeED695pOU29W7qJ0IqT6CePhPkjViAOb+ZDJw2
        lfMsBsjp3wGkBRADGVZUNPTAyA==
X-Google-Smtp-Source: AK7set9OR91fwXBsgIoFh/ZQ0DkKpqVOc2a+qrrIMeS4gnjZr0ycWRM6ou2nEein8GfBPtd1Otjl3w==
X-Received: by 2002:a17:906:4ecc:b0:91f:9cab:3edc with SMTP id i12-20020a1709064ecc00b0091f9cab3edcmr5490125ejv.51.1678886533882;
        Wed, 15 Mar 2023 06:22:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id v10-20020a170906858a00b008d173604d72sm2534521ejx.174.2023.03.15.06.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 06:22:13 -0700 (PDT)
Message-ID: <d356f2b4-354a-d4de-6e7a-6392d1943cdc@linaro.org>
Date:   Wed, 15 Mar 2023 14:22:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 15/21] dt-bindings: soc: mediatek: add display mutex for
 MT8365 SoC
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
 <20230220-display-v1-15-45cbc68e188b@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220-display-v1-15-45cbc68e188b@baylibre.com>
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

On 09/03/2023 15:23, Alexandre Mergnat wrote:
> Add compatible for the MT8365 SoC.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

