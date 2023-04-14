Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBBB6E1E02
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Apr 2023 10:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDNIWs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Apr 2023 04:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjDNIWp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Apr 2023 04:22:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303405BAE
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 01:22:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id xi5so43687390ejb.13
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 01:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681460561; x=1684052561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fw2soPX7gkqG1zLnlaxy4FPoDJm7h7PV5yPHWD0C8dE=;
        b=FrBtZn2JPfKSOizoc16x5zv6L6PMF/VKB3Zn5fwahF9n7Jh1kc0XqQRTqeKxD9x9MS
         3uUfhNpR4PY5Kx29WjjWcfkqmKDBR94YExPe0ZH82Vf5ApF1qG2Ln4aRvBFZysOhrsSz
         cp9lzWGm/qZIsDkxdC/6azitmGvqhEEhiGtu2Tp26b1y9oIoMgyuyekv6/h9SCepMtLG
         64hYxN8UllvZXSxqrgG4JOHoHVHRxyZY+HaYyquJuxGIltrOgiwix7JcE/jmYz1AbghW
         uEYXHqWhsbwiGhusGQgkORggwjpKOyE2AFwQp2bR6w3KIy7eWhE1jCL1KENx2B5S5BnO
         OTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681460561; x=1684052561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fw2soPX7gkqG1zLnlaxy4FPoDJm7h7PV5yPHWD0C8dE=;
        b=bY4ci0Mh53rb/zr97RlEye6RckrSjUDFcnXJUbbaoeW9fwjz//jCRXUjIbvwx5mhDc
         Od8BGwsy0WCm2/Snz3WcwhIVhCkdjCAYEeoXmIr7UOTRUoHDAa3Xh9JQadlRya2+oaWu
         RbeuWNStjHzeiWAiCDlr3cdm7ZHGR/ozDqp1K19bkQPcQU83pAl6V4fC9ZBiXYW2gNJC
         dQJTLtUSsUFiyucgOSH0uaCjHoaL+adxzG97tKKBHqJLjH/wv+m50m1fb+ndJoNDZdDg
         tiIO43Lv+KNgwGjxCWuYXsoG35LO1NwdRQY5Hqhk7s+cHkvF6xiOZcE7W5VYlC7FX+Eu
         /kXg==
X-Gm-Message-State: AAQBX9d/WzhMHpV4WpB3+RrRAVxkQRriGtdn4FqbxHQD3A0NimHCyCEo
        R38vTemqeDJBjIbyg86cjlNXrg==
X-Google-Smtp-Source: AKy350ZR6VwGjvDTaRekH/cO9thuWBVNaSAvMXwGsd/aK6bK6v5XYCzSR5T9UaWUz/jtJ7hPHs8cFg==
X-Received: by 2002:a17:906:925a:b0:94a:a77b:363a with SMTP id c26-20020a170906925a00b0094aa77b363amr5558646ejx.3.1681460561618;
        Fri, 14 Apr 2023 01:22:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id oz19-20020a1709077d9300b0094ebd376fadsm1486449ejc.144.2023.04.14.01.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:22:41 -0700 (PDT)
Message-ID: <223fcf60-25aa-e45d-159e-6290eeeb6a55@linaro.org>
Date:   Fri, 14 Apr 2023 10:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 02/27] dt-bindings: phy: mediatek,dsi-phy: Add compatible
 for MT6795 Helio X10
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
 <20230412112739.160376-3-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412112739.160376-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795: this SoC uses
> the same DSI PHY as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

