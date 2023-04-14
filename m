Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D844F6E1EA8
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Apr 2023 10:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDNIpU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Apr 2023 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDNIpT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Apr 2023 04:45:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AA693C9
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 01:44:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id xd13so9910133ejb.4
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 01:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681461894; x=1684053894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtGg6EdeR1iWsnKc8ccT9EWwvpg7Ri/EQo7i3jzR82I=;
        b=GM+UDgoKcnPK8SHmTatJJx43LucAVS7eKRP+/RJCszUCg+G+h0XPrpc2YD5/twU/OS
         XB1UYwwnW70pmmAfHfR28SphT/wfRQ15XUOjkDUCPTAp6gyEtMu5S/EjTk4CgRnkwJNg
         1orOetsMl8CDhec+QN1Ho6A8xMz1nKy0gKiLvOqsZeV1mWHRbVxeesSYjRt/x0whfHu5
         OtPxCJPuSujQnoEwZHS3o8T8ta9Ed2TNsgcK6oYRzdVnHpfqGO8EkrKdVoxFNYWyNlHd
         lNo19R0QHQKXkt1D5C9xjSjGMOgzKAUmVLJuxXt3oP8V3JBDXx0XzWCso9gFimPT4yhA
         2ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681461894; x=1684053894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtGg6EdeR1iWsnKc8ccT9EWwvpg7Ri/EQo7i3jzR82I=;
        b=XWmBFCaYY/iMTRcx6PHPvEp/2VARvvxZhvgUV033aftir+7IZSYqHjK5aM+EXezTCS
         IgEjxkXGitJ9CMRJJuK6ma6J9TqMLE1V5mCfOqO2vbBMgdebs9KMtfJugI/i3WCteBsV
         R+BTvP+Yfi5EfwF8eHuHGY7OziaA5yReXx0xxH7ujrisb60z/wS5QP98PiideoVni3uZ
         O0iLC6SSYLaJZ2U217z/BgNyKS1oLtw8BG2Su7tHpO4mz1d2T+OlDg8diGv0fjGkrxya
         qNwv/wlZ5b9xaKP6u8HruxeZlTWeil0dQDbFZxTlXHnqdaojv82K1HguJ6N1Tjdft9fK
         cWGA==
X-Gm-Message-State: AAQBX9cAhJUIZpL6yAVY21xD4Py1H9fuZo2VnkLwdRh18tsf7G1wCHvh
        N6fP5xzv1GLRzWig0J0kTpG8BQ==
X-Google-Smtp-Source: AKy350bppkIKeZhMXxNfJXXhoU40HL1EErpbeLF0AASH4hRQhWNhkTORoqb1Eg5v87PLoc5nZR1Nnw==
X-Received: by 2002:a17:906:3e86:b0:94a:8ead:c7f with SMTP id a6-20020a1709063e8600b0094a8ead0c7fmr5983777ejj.23.1681461894550;
        Fri, 14 Apr 2023 01:44:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id y15-20020a170906524f00b0094e1026bc66sm2146939ejm.140.2023.04.14.01.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:44:54 -0700 (PDT)
Message-ID: <d3846ac0-973e-e96f-7bb3-dec0237b795a@linaro.org>
Date:   Fri, 14 Apr 2023 10:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 13/27] dt-bindings: display: mediatek: ufoe: Add
 compatible for MediaTek MT6795
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
 <20230412112739.160376-14-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412112739.160376-14-angelogioacchino.delregno@collabora.com>
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
> Add a compatible string for MediaTek Helio X10 MT6795's UFOE block: this
> is the same as MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,ufoe.yaml    | 3 +++
>  1 file changed, 3 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

