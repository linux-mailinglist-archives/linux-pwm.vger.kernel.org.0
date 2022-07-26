Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73065810E6
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Jul 2022 12:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbiGZKNA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 Jul 2022 06:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbiGZKM5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 Jul 2022 06:12:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188FA31DE5
        for <linux-pwm@vger.kernel.org>; Tue, 26 Jul 2022 03:12:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h8so19450548wrw.1
        for <linux-pwm@vger.kernel.org>; Tue, 26 Jul 2022 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KpDJt7diBYhXqf86qTu6u3v0YKOMKpaah1tcpZNZNoI=;
        b=SQGWobCQ3gRFNB/U2WIAeeUF7tzqGOWJw+UhDq6jvws1FE9aaJ1cxmPWRujP/xSf9G
         eYYa9WJ+XPCIXYGi3RJI6mnYY9gLvLO5iHrSmMipte72d4E73h0UoNZfusBlbtYoABC3
         yRxOnnm1hdW9O6cDPaDADUDANJvdoo1LFAahSUrj5ixfoyE/HfehvalZET1SJihdGLpR
         yR7sjcQVP8jaUBvate/rRZCmylGwAs1NWH6rR4QUGvshyzFrFePTvgrynpOmmgEHHHQk
         7FG0OoTXd+VwYlLDJlLzdQIDuGDCOuhGjB9DSNgKsBRTeGtIbOtNkPZfDD1+ZJBckZ2l
         KUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KpDJt7diBYhXqf86qTu6u3v0YKOMKpaah1tcpZNZNoI=;
        b=59FsMvLL59SZHtxE2B0/TnQnyGo4+Zt6Uk2r1mfxIOkp+XU6Q/VxSMCIFgNqT0cqYG
         6xONnZbu5YDr6mdNF1a5ScK4miNv4XGoHF2TKwtOmb+YWQjrN0c7XuaYTfuULWLfJcDN
         klqgce09a9eDa9c38pNPHHiiyg92gike6rL2MJls8ogLq5QPVcRqmsJPcwn3RaCvXTsV
         Rsyp4ObGl6GL18VdkS3rzfT4C8d2ZaN8qVHB7rymmgow8pnrMwS4N8aHeqaRFZxYFb2S
         vUpvxCwGuaCnLNG9z41Rsqp7QRCgqN2q6V1/k+1AElqYU2osa/amjEQ5xnErJDGkYrV+
         NbzA==
X-Gm-Message-State: AJIora+YYbuVu7VeYI+CUFhQheZU529EXI8oMJjLgOzzwQyaH/RwJpBr
        JNjQj5c8UxUDQgYZH2UUp5Mciw==
X-Google-Smtp-Source: AGRyM1vy3qHffmr/ouCqUar69ahBui8gUY36JEptYA422eaHh/p2xV9rAKrICAXxxVmpkaPrVS3AHA==
X-Received: by 2002:a05:6000:18a2:b0:21d:c50a:7c9b with SMTP id b2-20020a05600018a200b0021dc50a7c9bmr10441543wri.511.1658830375374;
        Tue, 26 Jul 2022 03:12:55 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c00d000b003a31c4f6f74sm24686809wmm.32.2022.07.26.03.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 03:12:54 -0700 (PDT)
Message-ID: <10df6c1c-7e99-a036-6c84-8db36b727ce1@sifive.com>
Date:   Tue, 26 Jul 2022 11:12:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [[PATCH v2] 2/9] dt-bindings: pwm: snps,pwm add pwm number
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
 <20220725212140.741644-2-ben.dooks@sifive.com>
 <308d6189-c100-e9fc-e4b2-0639d993e436@linaro.org>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <308d6189-c100-e9fc-e4b2-0639d993e436@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 26/07/2022 11:08, Krzysztof Kozlowski wrote:
> On 25/07/2022 23:21, Ben Dooks wrote:
>> Add snps,pwm-number property to indicate if the block does not have
>> all 8 of the PWM blocks.
>>
>> Not sure if this should be a general PWM property consider optional
>> for all PWM types, so have added a specific one here (there is only
>> one other controller with a property for PWM count at the moment)
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>>   Documentation/devicetree/bindings/pwm/snps,pwm.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/snps,pwm.yaml b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>> index 594085e5e26f..e95f518b3974 100644
>> --- a/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
>> @@ -30,11 +30,16 @@ properties:
>>         - const: bus
>>         - const: timer
>>   
>> +  snps,pwm-number:
>> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> 
> 1. No quotes
> 2. Add minimum and maximum (it looks like there are such).
> 
>> +    description: u32 value representing the number of PWM devices
> 

ok, thanks.

