Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB615716CF
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Jul 2022 12:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiGLKKf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Jul 2022 06:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiGLKKK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Jul 2022 06:10:10 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65A2ACEE4
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jul 2022 03:09:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bf9so13074948lfb.13
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jul 2022 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uZ6PBg0k+LNPWSahV/wsPmCFTFziNXNqJA+X92tR5lQ=;
        b=UZrkexqe1KGcx9tnd0D+7tFUi+wtQiLe/TNBgXWXfjPGLfg4I7N9pJ/RGRzi116K6v
         UKQ0tcnDgaKSykVeXiPij9NY4YpLftWsujncRv+jB8/9IkGvMQX8jL2CDb5eWC4gR4ub
         +o/RnygqEVN+B8RhvTEDTe8XHx/oZzaPrA3vxPoCeC1SL82egNRsbAewlsVKMwCjE5bQ
         CAAeA97lPuaI9Oq/G8nacQ6DtFIgEKQJICeBHR/lymHt2CXiI7UrX5M/5ReEZliZASrX
         7924c5RalRb3ZHBnkJCp+1HVK616mUo/ceMPsA4p/69OpuhFM5W1ddfjUt5H3p7fcBkb
         q1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uZ6PBg0k+LNPWSahV/wsPmCFTFziNXNqJA+X92tR5lQ=;
        b=yVYFH003FxgYQaNJZ1UHP5B6226Jk2Nww0pd+akfXYWIAcBmsYw2IBEJnlxEiYCtTM
         wf6kyrxVO3utqqRtOBhok0XckLJuj6RBexa7OsJ/ni5vmhE0eXJ6aENL1RZxUeAa8TUf
         nT3jNmTU6sxTW9TjErlYGW5Si3U7jipjmIuo+g3owUBLVtYrJJ3vA846di6U0VakPzpw
         nYX6L1qXDox+6Sgy1ebWUCFo8k4wjCwKlzo99c2nNIFruLPFa6JQMSnDQtLdRu4PABFY
         +I32/ICWaZhPgrUYsJuWJ81WTBiuBhh2l3ie7z9ToxZhwKpJAh+GKY6pAbKZOeJFlrBs
         d/og==
X-Gm-Message-State: AJIora/Vw7mXoLLpDOycCXta/6bPmYSucGjc7ptDab2eMsn7kveHaS1i
        M+rV2dvyt0e8bCQxwDCiLDcGhA==
X-Google-Smtp-Source: AGRyM1spzIn1kXom2zh22zmT5Aqy5fffNoevGip0xPBZELGAE86f4I3+XEfcAKDHmEN9HsrJ303VvQ==
X-Received: by 2002:a05:6512:3c86:b0:489:cef9:18bd with SMTP id h6-20020a0565123c8600b00489cef918bdmr9827225lfv.386.1657620583031;
        Tue, 12 Jul 2022 03:09:43 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id m4-20020a056512358400b00489cfd58ef6sm1885307lfr.88.2022.07.12.03.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 03:09:42 -0700 (PDT)
Message-ID: <a6534fdc-a21c-5784-8eb7-ee892275fc0a@linaro.org>
Date:   Tue, 12 Jul 2022 12:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 7/7] pwm: dwc: add snps,pwm-number to limit pwm count
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-8-ben.dooks@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712100113.569042-8-ben.dooks@sifive.com>
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

On 12/07/2022 12:01, Ben Dooks wrote:
> Add snps,pwm-number property to indicate if the block does not have
> all 8 of the PWM blocks.
> 
> Not sure if this should be a general PWM property consider optional
> for all PWM types, so have added a specific one here (there is only
> one other controller with a property for PWM count at the moment)
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-synposys.yaml | 5 +++++

No. Please do not hide bindings patches in the code. They must be
separate and checkpatch complains about it, so please be sure you run
checkpatch.


Best regards,
Krzysztof
