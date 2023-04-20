Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A742D6E98BF
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Apr 2023 17:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjDTPuI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Apr 2023 11:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjDTPuH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Apr 2023 11:50:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D77E53
        for <linux-pwm@vger.kernel.org>; Thu, 20 Apr 2023 08:50:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kt6so7637704ejb.0
        for <linux-pwm@vger.kernel.org>; Thu, 20 Apr 2023 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682005803; x=1684597803;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUjeJFJdOehqKEp3EDu0sSCTfsxNh9OJznbyLrn6SLw=;
        b=m1uCicstQI0hGkjAbWwIjd6vTdAVf/qeZzy2/WT9nB1gaGJ9o3ZqJPJmXWHfBHS1VJ
         3NsRzNmjx9ceKmK3fkJ9sDCBkMYhsIGmtCH25In5054W972Ukpvzh7O/qgdXGM/hkE41
         /17KDplrFzJ1ZoNlsFQUo1AxzDXRMFX6DnlVstd73ClggwDM+BlTOxAyOYeuWV1ZJqAs
         8nY6t14Q1+BTBF9UkHCyCC1FVIzqIX0JjWiNtg4FZII1mMhufsmrOxPf8lvHf16cN6yi
         hKsIZ0g7PCGyMrR4XOkoz3/X4z8D4KnJx+VgEoAeDs1sX+noLysE/wYOiZz8Sc5Uzp7+
         Sc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682005803; x=1684597803;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUjeJFJdOehqKEp3EDu0sSCTfsxNh9OJznbyLrn6SLw=;
        b=Pep+KfsKd4DEVic61tIvHY7p2vvbcl7dHgTrqSQ4gmZqH+JqetV50B+mbmbA04wwmW
         yZHO4Sb7G9ofTmBr/MUpN+T8l5gZU/OL5oxLTOfPbcNxQ85iPK+hqpk7S8RVxd83zWbu
         PBm9++rvmjpEqLw+LDdB/vryc0Y7iEbhkEZ2oXsygcA8oSFezKDWKALmbbQ0vhkk3Je4
         ACJTWXkheAtQY6KpmtjfFGlNQK9IY4a2BJX9MMUWpPk17Qlxw5a4WsbS6wA1AA8HO3Xr
         xSGa9jq3cnPZcJIn143jGsN5/q17HPLETYZe9E5ehWUHDhNPBZkCx0GlRzYWfnjUdBG1
         4qag==
X-Gm-Message-State: AAQBX9fTVCFXON7lCd2xBjl0upvhP+/yuucYryWGlTRpsqatkXZbDK52
        UxEA3hN6LBX6VzLizh9o/y+oYw==
X-Google-Smtp-Source: AKy350YDaBKhwl+5wu1izAvYdwnvSzsDrXYRCK39dnDeHVpecX+2NV53mczkEOPg1LURkaolRvl+xw==
X-Received: by 2002:a17:906:b20c:b0:94f:3804:5cd6 with SMTP id p12-20020a170906b20c00b0094f38045cd6mr1813554ejz.66.1682005802986;
        Thu, 20 Apr 2023 08:50:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bcb8:77e6:8f45:4771? ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id qn7-20020a170907210700b0094e44899367sm838732ejb.101.2023.04.20.08.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 08:50:02 -0700 (PDT)
Message-ID: <2adfd25a-c4f0-db3f-2148-5fd150a6a49e@linaro.org>
Date:   Thu, 20 Apr 2023 17:50:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings: pwm: mediatek: Add mediatek,mt7981
 compatible
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        John Crispin <john@phrozen.org>
References: <cover.1681932165.git.daniel@makrotopia.org>
 <4877689269af862ea9ddd199d8aa96b2d7fcf6fe.1681932165.git.daniel@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4877689269af862ea9ddd199d8aa96b2d7fcf6fe.1681932165.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 19/04/2023 21:24, Daniel Golle wrote:
> Add compatible string for the PWM unit found of the MediaTek MT7981 SoC.
> This is in preparation to adding support in the pwm-mediatek.c driver.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

