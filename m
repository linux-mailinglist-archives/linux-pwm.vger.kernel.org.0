Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E554C0D09
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Feb 2022 08:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiBWHKS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Feb 2022 02:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiBWHKR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Feb 2022 02:10:17 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4776E3C48C
        for <linux-pwm@vger.kernel.org>; Tue, 22 Feb 2022 23:09:50 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F1664407C7
        for <linux-pwm@vger.kernel.org>; Wed, 23 Feb 2022 07:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645600181;
        bh=nimhNkIt7mdxahM9C8qO53ZAeN7FCRJYbKKsVkt4SHg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=h22+cI+gAEjcbUMBp5foBzMgjpbik0QosKLk8iA6qSbP193D3ZB7Ch+BKmCelnwWZ
         KWPZZckeyOOtt9zTioOo8u38Vi1w+M9xCTwa2QrlIldjVrSitzbnqcq8qMR91DBKjL
         zey3nC/jSa5bJfz0e/0HuR/Mx2aVEB683H0aYYk4YEvNR9HTzdy390LU/OxOk5K9hG
         9DEVtMqzMHH1rLhPQThZfmPfe8dfzsFtNBk0chsdMN5V4eH44uFIGqHyxsorynKIGg
         zsHX8C/juRLqSHrR0jnDaJ1Us1XF6MSZpLCBaCX+pPtQsAlv4/6Um/ChLKKYKROqW+
         XqHsOhBq4KgpQ==
Received: by mail-ed1-f70.google.com with SMTP id b13-20020a056402278d00b0041311e02a9bso3968928ede.13
        for <linux-pwm@vger.kernel.org>; Tue, 22 Feb 2022 23:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nimhNkIt7mdxahM9C8qO53ZAeN7FCRJYbKKsVkt4SHg=;
        b=1K0UHozyXL6T9iVYU26mem6JpkpE72WW4KKrE86IT5c6GkfI7s5RSEObSt4gsezNLo
         SVQRXcXqY300XmAT1HWB3u1abiXyA7UkoTNCdHkK23QQK64NMpnluRozGLqwKEByyLr8
         vbM5UU2tOLg8GxColWqZfaYGUbZIBrF15BT2Vkvs3CPfG9sw9nzh+DcIKac+RmxQG8Ef
         r0og2SiPaSYeF9NCETF0NBzQFdTXMRZqVUr92is2JgbskQQ5j2B/85BrREGGkl9HaNfK
         oHOviL1wmYszK1QkmuLwqECdIQAa/926crdfe4aVcjhCoHzoU3WYnoNXrb6BSJ8oC8dd
         MMjw==
X-Gm-Message-State: AOAM533j4TNS+VcvWQjRjOEZRToob6M7oq5w/fMd48U80bk6Fk8Bdj5H
        PcXO4yYZ/mVFz6Zo8Mx2LJEeIOntADzcM+Ai5fzIOSXxCAO78GzPlAHwx3MbIQEviZ2xeHDspFQ
        bi2pTFVwvjZsAW6/V4MhJsALAQMFSTotmJyyAdA==
X-Received: by 2002:aa7:dd9a:0:b0:410:b875:ab95 with SMTP id g26-20020aa7dd9a000000b00410b875ab95mr29494442edv.248.1645600181671;
        Tue, 22 Feb 2022 23:09:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzCfvOZRfs9gbRYzkE2QJAiHsybZmRR4vAzmtPrnH3egKFJYppepwp/EaGxvawIkcSpK6J/A==
X-Received: by 2002:aa7:dd9a:0:b0:410:b875:ab95 with SMTP id g26-20020aa7dd9a000000b00410b875ab95mr29494428edv.248.1645600181505;
        Tue, 22 Feb 2022 23:09:41 -0800 (PST)
Received: from [192.168.0.124] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id kw5sm7198688ejc.140.2022.02.22.23.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 23:09:40 -0800 (PST)
Message-ID: <18bdf4ae-c445-ad10-b344-324436cbe445@canonical.com>
Date:   Wed, 23 Feb 2022 08:09:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: (subset) [PATCH 0/4] mfd/pwm: dt-bindings: google, cros-ec:
 include generic pwm schema
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-mediatek@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        linux-arm-msm@vger.kernel.org, chrome-platform@lists.linux.dev,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
 <164557235424.1264579.14486504733557463529.b4-ty@sntech.de>
 <20220223062233.4m2xejozz4d47gmo@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220223062233.4m2xejozz4d47gmo@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 23/02/2022 07:22, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Feb 23, 2022 at 12:27:08AM +0100, Heiko Stuebner wrote:
>> On Mon, 14 Feb 2022 09:19:12 +0100, Krzysztof Kozlowski wrote:
>>> DTS patches are independent. Not tested, but I really hope no downstream kernel
>>> depends on pwm node naming... If it does, please change it to compatible. :)
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>> Krzysztof Kozlowski (4):
>>>   dt-bindings: pwm: google,cros-ec: include generic pwm schema
>>>   arm64: dts: mt8183: align Google CROS EC PWM node name with dtschema
>>>   arm64: dts: qcom: align Google CROS EC PWM node name with dtschema
>>>   arm64: dts: rk3399: align Google CROS EC PWM node name with dtschema
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [4/4] arm64: dts: rk3399: align Google CROS EC PWM node name with dtschema
>>       commit: 474a84be692d893f45a54b405dcbc137cbf77949
> 
> I expected that all patches in this series go in together via an ARM
> tree. Or are there expectations that this goes via PWM?

I would propose to pick individual patches by each maintainer. bindings
by PWM tree (Rob acked it) and DTS via each SoC tree.

Such approach gives flexibility, although `make dtbs_check` will spot
the new errors when run in PWM tree. Next will be fine, though.

Best regards,
Krzysztof
