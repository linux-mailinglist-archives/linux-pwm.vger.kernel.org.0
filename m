Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B020357325A
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jul 2022 11:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbiGMJV1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jul 2022 05:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbiGMJV1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jul 2022 05:21:27 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FD7F2E0B
        for <linux-pwm@vger.kernel.org>; Wed, 13 Jul 2022 02:21:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o4so14628852wrh.3
        for <linux-pwm@vger.kernel.org>; Wed, 13 Jul 2022 02:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EuZkOhoO/lITrLjgkVjvwTGd6HeRto8WBI5Hh6eby/E=;
        b=lxpzLzJ2shualTR8sKZ9gN8OZks8zFo0iRo8BFAcwp2FMZRwgNsO18oikVjYyQKAgo
         rMuIfcGIahdIM7l57u7/mG2Gyfbio0+KR1Oz7FgpVdxwH1ipuYjoMqUEprcgbshmg9rv
         ELVKBizg2Y4CeidKhYIpjGaHNID9oH+ewrBMb593FOh+UJzGP1hL5cYBTi+mzIKN+sOT
         F9WCYfbuxv0iLvoi0ehIrM9WMzNkqKLSDIMeLxG6xGLvevHOPaEeuGHX3N4ajNUMwzi7
         jSAiaKaAwlIEyUsWxYZelMhXFi396sA+dTWjbi/W9Ex/hsM24+LrcVFxpicpVyV32ny2
         NnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EuZkOhoO/lITrLjgkVjvwTGd6HeRto8WBI5Hh6eby/E=;
        b=EqWidWPZ+Yv23Qt50x0SEj7pMaDX6PaCR+c72oWMVQpC2W6fMe/zxyeE6YZO1Z0Pbv
         L9SuA9P+n/x8q3RKITHvBdVTPFxSB7UxyzMeFcZnHn+L8C/bVWcywXTdgP456pOtrKHm
         7tXM4eOo577ptykYM3hl6mdL4lYqnJtCuuzQtZmcSN63Ud7/Sy+W9oHLEDQ0dv9OgFYk
         dRTzLQOCF3IErGMus+Y2aFviXbTBxpaHl9JFBD9jR9YuWRVLyy2CXZIZC1Fz6T+nB61W
         1fu1omUaxiGZ6gAHhfWyuefBlcvzMjuN6R8sBYSe4+uCu5VjTET+mqPwVx95d3F/cM7s
         coZg==
X-Gm-Message-State: AJIora+wilchelVNH8iNo6U28tBeAjUE0Os08h1wOATGyPesh1nRRU9W
        syy1wZ0Sfmsb+wdAeI69YVM6WA==
X-Google-Smtp-Source: AGRyM1uJ6l9+mYRUMQdWMVEP6Jn6AiXmM/gA+u1wvU08eiSPFXbHEqDDa7FPwtSdpFEBibAvtahShg==
X-Received: by 2002:a5d:588b:0:b0:21d:a918:65a5 with SMTP id n11-20020a5d588b000000b0021da91865a5mr2285506wrf.210.1657704084868;
        Wed, 13 Jul 2022 02:21:24 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id j25-20020adfd219000000b0021d7122ab80sm10359669wrh.110.2022.07.13.02.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 02:21:24 -0700 (PDT)
Message-ID: <3a1eea1f-b598-58ad-60a6-c76b77cb08c4@sifive.com>
Date:   Wed, 13 Jul 2022 10:21:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/7] pwm: dwc: add of/platform support
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pwm@vger.kernel.org
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
 <20220712100113.569042-4-ben.dooks@sifive.com>
 <fdef31b4-9c27-ddda-f1e5-ee881812aa4e@linaro.org>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <fdef31b4-9c27-ddda-f1e5-ee881812aa4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 12/07/2022 11:08, Krzysztof Kozlowski wrote:
> On 12/07/2022 12:01, Ben Dooks wrote:
>> The dwc pwm controller can be used in non-PCI systems, so allow
>> either platform or OF based probing.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>>   .../devicetree/bindings/pwm/pwm-synposys.yaml | 40 ++++++++++++++
> 
> Bindings must be a separate patch. Preferably first in the series. Use
> proper subject prefix matching the subsystem.
> 
> Best regards,
> Krzysztof

Thanks, seems counter-intuitive that one change is split up like that.

-- 
Ben
