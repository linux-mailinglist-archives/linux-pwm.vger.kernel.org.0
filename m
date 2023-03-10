Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07AF6B390F
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Mar 2023 09:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCJIpB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Mar 2023 03:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCJIoP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Mar 2023 03:44:15 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A203F10D774
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 00:41:54 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i34so17407604eda.7
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 00:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678437713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jY19RBdXGErSuK96SQ9CO/VfqzR61PSiwucTWNRVDbE=;
        b=ZdR6O1tBpHF+lilFpQQlvhYUaj1uscCMv151wALtJiKxx7nhMroGk7Zx2dHnMxKrHy
         UBAiF40+9XQLG7M5KcFaMhqxRjOdmpJvsgHFOXkNg+MgU8aGx8qWtNy9Qn3/8E4o4TF6
         mbeqrU7JwF0dVu2x6LVeN2wbGOkHfYwdvH2eS8RZwUyYbxkoTh0aziit6x9MCaerboWJ
         K5iMFTV4m96ZEdgcv/OagZ5f9ZKR9pUjcSiLywCJcIQthGgrnbxDQ2IwcUBv4D3qfNRx
         0iCsNZifm1/3Ej2552eb7fjQv/mbyIUpOsDK/UxUnoNQlJlEd30jLxn8KKAEiUCvCzCs
         5BoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678437713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jY19RBdXGErSuK96SQ9CO/VfqzR61PSiwucTWNRVDbE=;
        b=WpKgu5lUUsZ2JYvrH+tVdvGEIcMNbxr8Vw8jIKxkzv7VvaS5mE5nL45JzVS0494AyC
         ruuuzBxW+d4HjD8ut4AmZex+rLUCyyMDXr0nLU+WatrvCYH7Cwo5ri62+DekmhxX18XD
         1RZEOTB+FWsZau+zidiH3oOsw1oYrrE3O2xHHSuLnQQlG4HEU0RDAJFGKIYR1Q/7XQOE
         wiGm2VGB7MOQlG34xtVyO7ZBSnHgwY5KDCo647jOgp/kbZ/sUW7/XleZo0lApfsjTOaC
         dyqJUaQo9nO+z9ubTgtN6qvTTzSqvgo2+qJOPxhkI7dEV6WvxoCb7nrp5yBOcgF4x3T8
         5IZg==
X-Gm-Message-State: AO0yUKWlozHxjvzuVsBVlF2ABbWVLK2ChGhhJ5iS9ALr8lobI4OM4WGP
        S0kayggQseOvSPkb/NWwGc91Sg==
X-Google-Smtp-Source: AK7set/wf4w9jzDPoANKQB4e+0Ofo51LjennRsoVP/tsxVTpy93y5J3W+5W5VhClHpcVl0kpfmkn7A==
X-Received: by 2002:a17:906:9c8b:b0:8b1:76dd:f5ef with SMTP id fj11-20020a1709069c8b00b008b176ddf5efmr25974741ejc.5.1678437713153;
        Fri, 10 Mar 2023 00:41:53 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id m9-20020a170906720900b008b133f9b33dsm665646ejk.169.2023.03.10.00.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:41:52 -0800 (PST)
Message-ID: <02174928-2071-512a-3cc6-d24bcc75cc32@linaro.org>
Date:   Fri, 10 Mar 2023 09:41:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/21] dt-bindings: display: mediatek: aal: add binding
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
 <20230220-display-v1-1-45cbc68e188b@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220-display-v1-1-45cbc68e188b@baylibre.com>
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
> Display Adaptive Ambient Light for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8183 SoC.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

