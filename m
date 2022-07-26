Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22F45810CC
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Jul 2022 12:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiGZKI0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 Jul 2022 06:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiGZKIZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 Jul 2022 06:08:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DF4EE1F
        for <linux-pwm@vger.kernel.org>; Tue, 26 Jul 2022 03:08:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w15so13888174lft.11
        for <linux-pwm@vger.kernel.org>; Tue, 26 Jul 2022 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ojyQ+PqrBED/t+SyNTD5eQfcGUJ/2jWYDAqwjA90+Dg=;
        b=KSYw/sS1ZIaAzFICjc+coAWpU38KFcf7YQ7tVCLB9t6ZqjWBYIe+RyFSm6+EDXb/vo
         k6OJ1tn/VDioRkMAvuTkxArqROpCYZCvqiF+Ybzii0DaQraJ587KGvv1QZ0K+tC/fp3b
         QEok5SX/JMaqzC3b2znbhZOADRbtuP+5pA/8i0Mgu1/fRmsOD8xXhSseh4OiFQ0uEyv+
         EU30e6vxXYD4bLcVzRWEE/+0GW9RD0Hjp+yqc1oePfurnmensGzWX1A0xiN3GtKd+YVB
         CSD2IP477jOFTgLSkN8ijnpDK9QQnlmD/Z/ARNP00EX40SVR9busPpVPmE7OA8PJI2Tm
         f3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ojyQ+PqrBED/t+SyNTD5eQfcGUJ/2jWYDAqwjA90+Dg=;
        b=zKzp/5O0Zfu7yodaRUMzHteKbOoxD3XexmP2h6bAI4DmkuqcE/wpS1fH4+VPAH4Ymj
         Z2015ic2VXJ+o4VQFQZIPMMvJMzfUiDKR21K1BlkKk5E0kLUdLk89C0exXilwYLFV80/
         cLPvApas4nojtkfTaLlrxNo5tJnkwc2lq+rpRDXKLHJnrngju4HWhOKYBobvTMb64bYM
         SwTkPYmO/j7BkqsJ974oica69gAacKNQ0Xnz1R+q5JRv/we0u++0Jc6lxSknf3QKwZ5i
         quaiWXQt1RrOqd+5IPUyZx/+74KdcGCfxD05O9agE2e+ssLFjLEDbnw5dJTSwAjuMN8/
         XLsA==
X-Gm-Message-State: AJIora/hTEzBOMzTLku8YwXC7nHrdely05QIoImBITQeJ9g7G5EjpUow
        mtz9urzTOOMjZdZgj+WVNNcqqw==
X-Google-Smtp-Source: AGRyM1uxPeD7ZsMKAfaSCSOhZK+89Wta+C27PW+mKfAPqnNH0k3b5cg9ab2b7VD9mjiAyzx8QgV8Ug==
X-Received: by 2002:a05:6512:1598:b0:48a:7733:2dd2 with SMTP id bp24-20020a056512159800b0048a77332dd2mr5769981lfb.288.1658830101798;
        Tue, 26 Jul 2022 03:08:21 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id d25-20020a196b19000000b0047255d211b2sm3111442lfa.225.2022.07.26.03.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 03:08:21 -0700 (PDT)
Message-ID: <308d6189-c100-e9fc-e4b2-0639d993e436@linaro.org>
Date:   Tue, 26 Jul 2022 12:08:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [[PATCH v2] 2/9] dt-bindings: pwm: snps,pwm add pwm number
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
 <20220725212140.741644-2-ben.dooks@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220725212140.741644-2-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 25/07/2022 23:21, Ben Dooks wrote:
> Add snps,pwm-number property to indicate if the block does not have
> all 8 of the PWM blocks.
> 
> Not sure if this should be a general PWM property consider optional
> for all PWM types, so have added a specific one here (there is only
> one other controller with a property for PWM count at the moment)
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  Documentation/devicetree/bindings/pwm/snps,pwm.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/snps,pwm.yaml b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
> index 594085e5e26f..e95f518b3974 100644
> --- a/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
> @@ -30,11 +30,16 @@ properties:
>        - const: bus
>        - const: timer
>  
> +  snps,pwm-number:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'

1. No quotes
2. Add minimum and maximum (it looks like there are such).

> +    description: u32 value representing the number of PWM devices


Best regards,
Krzysztof
