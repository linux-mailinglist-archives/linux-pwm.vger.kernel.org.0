Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E16064B7
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Oct 2022 17:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJTPgj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Oct 2022 11:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiJTPgi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Oct 2022 11:36:38 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9421C070F
        for <linux-pwm@vger.kernel.org>; Thu, 20 Oct 2022 08:36:35 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id t25so145159qkm.2
        for <linux-pwm@vger.kernel.org>; Thu, 20 Oct 2022 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8eoY0I5X2Sipw0ooGhphn3tjUk+gvKWNqo8fyMAjhM=;
        b=eic3GDq4OJUmSYYvHL0oWXDL9lVOw11tLOJKO3ef1YNzKereUxNtFux4TdZPd3NZvp
         uNy2DRDUzs5T+18K/CnvJnbEHPou10yv3lcXYX++tpwUOhvgDF608RroFgjjzLqGfxia
         eMWg4eNHeOsdxpSkJCB1L26xljap9hADA6WC+4pcWlzgYFH8U6KDFDWwBkZszr2RU7TC
         cpiwaEtOVn25gwDzAC7s0CsWAKkSJeqjvSo3jWab/H5Jl9HIWahxceQKBy1BN2HLjJB5
         q+w4yqYgaD9KZH3068nlNXj4gBcV6lzbrlYzDYW+4yPB2TjTg18yvcHCPcHpxioNYFXc
         pCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8eoY0I5X2Sipw0ooGhphn3tjUk+gvKWNqo8fyMAjhM=;
        b=sw4iAgYWZm8eB5MPHvcCrQvljZ5o/oN0UeN4U/I2NOTmyp9PjRJrMaolyRlTKBVNLp
         H4DmEllWbEizgDCcfNcEMArBj0eNFjCP00Vrcfv+2NHdkOoMFtPjWIU7YkPUgx31O7Uo
         3Zubwzk0M6v7iWIrLr/lHAFzU6O34sL8qL4teXdMtgz+8de1oN2+KghXiJOoX3HrG57J
         rxSk6NlehHihKq2meUA8yAoCltV7kStUuzdSSfcSm2Fn4UVufN376Ig0b4egDlQqOhDT
         pzqfy2DUWB7jZuET18/JsCICzXdvDQkKF/P0yKhEEqj11e67O/0I5ig1aHIg+Mef7/YW
         d9XQ==
X-Gm-Message-State: ACrzQf2PDfnAwVPdhEM5Pxhc/tXS2TQHEK0cS7NVkKZHIB0JGqGlRjyi
        kpAW0/JvmpxBeJkvkk8/TrgdJoXuL36GRw==
X-Google-Smtp-Source: AMsMyM4VSBXCeZsMsTw/Ws3ddbjakxegDhi66swi/1jOVMiIPiNapMwXyWu2+hA7sRlGSn4PLy8h5A==
X-Received: by 2002:a37:f517:0:b0:6ea:11bd:fdd6 with SMTP id l23-20020a37f517000000b006ea11bdfdd6mr9408107qkk.447.1666280194999;
        Thu, 20 Oct 2022 08:36:34 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a414b00b006e99290e83fsm7682843qko.107.2022.10.20.08.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 08:36:34 -0700 (PDT)
Message-ID: <22c39fd8-e98a-a091-f2c8-12a235f7be8c@linaro.org>
Date:   Thu, 20 Oct 2022 11:36:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v6 01/10] dt-bindings: pwm: Document Synopsys DesignWare
 snps,pwm-dw-apb-timers-pwm2
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
 <20221020151610.59443-2-ben.dooks@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221020151610.59443-2-ben.dooks@sifive.com>
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

On 20/10/2022 11:16, Ben Dooks wrote:
> Add documentation for the bindings for Synopsys' DesignWare PWM block
> as we will be adding DT/platform support to the Linux driver soon.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
> v5:
>  - fixed order of properties
>  - corrected clock to two items

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

