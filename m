Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18EB5BD6CC
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Sep 2022 00:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiISWG1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Sep 2022 18:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiISWG0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Sep 2022 18:06:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DEB49B54
        for <linux-pwm@vger.kernel.org>; Mon, 19 Sep 2022 15:06:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k9so1383830wri.0
        for <linux-pwm@vger.kernel.org>; Mon, 19 Sep 2022 15:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ixw7chpePOC+MLhrlMTpQHvviDIReReYqRXhDHS+LsE=;
        b=MTU+cL6hp6f9T9hHZK1qtBuS4UE3E75gmwhW8YWLDfnyfkP1ZKR7ntjgL9f0ZWI1Bq
         h4h6f8vzgNpa2NCsEFmvTDW7Kq/T1u03RvC+tw7QqBTnX7Z0nDH5FAm+U6asPpf8w2WS
         OBXDbSBf8oEB5Vjyp5az62OxCA9OfmgUUcmDFCXBC9wDo3r8XMj8N+6EX4IHYQu5Cj5S
         4vBKLvNSGuldmPRo6coz7S7mCgTq40Sni6ak5grfz2ir3PaPyjm5BcbMiA02hEJVU8tq
         dEFV87LXthpwMdUgc63el5Lf4vRgJM6Tmkw8YnCLpTmX3iU/seH7aJ6FCVAQF+98caCj
         UnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ixw7chpePOC+MLhrlMTpQHvviDIReReYqRXhDHS+LsE=;
        b=kgi9aUhuTmIbhS0KatfzR09LmosGVJReAJFCd5Zb2iVg9s7D55P3ET3X7OVdJrLzy0
         w+cV16D8rw4Rti02k0rpYYMJiNlPCtUzUyzRiM4DGRlwGUuT5VnKNcq7HYkKWuDgOwSv
         DDzcMkk8C82xGusRCO1WPpGybY4hBR9J/hM8yRnWNy+Om2ts1dLqOhwvTV/T9m/Qq40z
         7s7CMF/uf2cHwPO2qvvg0G8R8CzIkHoV7mH8O0Cr1c9mfV1EF6XsUA0seTQ2IUyFK0UP
         nu+67Jq6QdMDcxtFnEOCIQnCwGnP6x6oJUSYKvL4g+z9Pcxue3v+nsPw6fVxNzsZ24tf
         GBng==
X-Gm-Message-State: ACrzQf3h1j53Jkrsc0Edpdz6yYonBP2lFk1AHBbYH8byjH5RnPT71rav
        5G+a3GxNMlVC+eoLc1WF6tedkQ==
X-Google-Smtp-Source: AMsMyM6xghtZubWcuL/UbtqUKWsZPmma3Wxd7oe7RWho2DnwtH1o58uPfquQMMN7QbsOio3L8ivREA==
X-Received: by 2002:adf:d206:0:b0:228:64c1:c3fb with SMTP id j6-20020adfd206000000b0022864c1c3fbmr12014163wrh.260.1663625182237;
        Mon, 19 Sep 2022 15:06:22 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c351500b003b491f99a25sm16756983wmq.22.2022.09.19.15.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 15:06:21 -0700 (PDT)
Message-ID: <9d021e83-774f-3524-a65d-0ef0f74c8545@sifive.com>
Date:   Mon, 19 Sep 2022 23:06:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC v4 08/10] pwm: dwc: add of/platform support
Content-Language: en-GB
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
 <20220816211454.237751-9-ben.dooks@sifive.com>
 <20220915072430.bhpwk6iyqmyz6oie@pengutronix.de>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20220915072430.bhpwk6iyqmyz6oie@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 15/09/2022 08:24, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Aug 16, 2022 at 10:14:52PM +0100, Ben Dooks wrote:
>> The dwc pwm controller can be used in non-PCI systems, so allow
>> either platform or OF based probing.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>> v4:
>>   - split the of code out of the core
>>   - moved the compile test code earlier
>>   - fixed review comments
>>    - used NS_PER_SEC
>>    - use devm_clk_get_enabled
>> v3:
>>   - changed compatible name
>> ---
>>   drivers/pwm/Kconfig      |  9 +++++
>>   drivers/pwm/Makefile     |  1 +
>>   drivers/pwm/pwm-dwc-of.c | 78 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 88 insertions(+)
>>   create mode 100644 drivers/pwm/pwm-dwc-of.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index a9f1c554db2b..f1735653365f 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -192,6 +192,15 @@ config PWM_DWC_PCI
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called pwm-dwc-pci.
>>   
>> +config PWM_DWC_OF
>> +	tristate "DesignWare PWM Controller (OF bus)
> 
> There is a missing " which results in:
> 
> 	drivers/pwm/Kconfig:196:warning: multi-line strings not supported
> 
> Best regards
> Uwe

Thanks, fixed.

