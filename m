Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2305062471E
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Nov 2022 17:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiKJQgB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Nov 2022 11:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiKJQgA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Nov 2022 11:36:00 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD51C0
        for <linux-pwm@vger.kernel.org>; Thu, 10 Nov 2022 08:35:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id t4so1475136wmj.5
        for <linux-pwm@vger.kernel.org>; Thu, 10 Nov 2022 08:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DxRg+We1Jfo3KNNWsBKpsPFSIt0ISOfnz+fH4QI3w44=;
        b=iYXUM64KfadAB+un82C8evFBDhaPK1vpfaqnQOUuwQYZBgds9TFOoau/7iFk3qiXwC
         X6ZremmkI1Rv6w6ELmdATzhoH+xB4Huf+r+7ao2fpQRb4HZGj4kp54PRAEK7TE6WTpCl
         MxHg3G+LJHQoZQykofWhntPE9gq28+8fworAKRIwBAT4JeIRKZJQ0r+kYX/VTZK84KwX
         ZeLr8x8DFQ3qT/fvORQ2biCqJhXp6wYSXa9PQp6CMW6Fx+Chl2gbjBtJbVc1jrQ6dfVP
         vtW4UUbWaXzuugLIjpz7r9bUu54lK3YPTnnrcNsUNDZ9rQj2NMwWbRIOSpCyvgSDHWm5
         d2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxRg+We1Jfo3KNNWsBKpsPFSIt0ISOfnz+fH4QI3w44=;
        b=qwczSca7zb5HfWC/7tc6V5rbyPjsT5v/KAHJKhn5XUtF5LnEMrRHssjov1SGT/fRPI
         tJZxnPNPowTox+DGs75x1Zr9l8WymkGHN1sHEpZNE0C5OAL7OXvqo/l7+IJ3m8mSOtJV
         bLQSROr/chutT+SYot5iEAK+ZoiGfV454pOehZijhtNjGYabjNLyvEd/bQQO31DuSCRa
         i1UyOkRPYGRv+Gi30UO2Cp8d/zgEX4uONSmJhJbQEUfpDdQ5amVYboVsOVIxbn1VlJIc
         jtBE+I9TnEZfrNxIkp20g2zesSAvtP0gEN+5RuQTia+d4ivxhjJ+lZPBDewOH/wrbAx0
         6SZQ==
X-Gm-Message-State: ACrzQf2gaW3JGuAvI17hlILeNHPep97713HkE5JHxGYDeMqlMkEm4nsD
        NR42jDNi2h8yvgOdxuzwhJJCfA==
X-Google-Smtp-Source: AMsMyM4E5fkgo5vxoaEuShLwhw9YNjWEwSseKuWUSv1w9zKmyVWGXxWeWW6VokK6T6eIJ2NhkyLd0g==
X-Received: by 2002:a05:600c:500e:b0:3cf:89c5:c233 with SMTP id n14-20020a05600c500e00b003cf89c5c233mr28329008wmr.28.1668098157726;
        Thu, 10 Nov 2022 08:35:57 -0800 (PST)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id k7-20020a05600c1c8700b003c6b7f5567csm9030315wms.0.2022.11.10.08.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 08:35:57 -0800 (PST)
Message-ID: <75853d42-faf4-b406-f54e-71871143d61a@sifive.com>
Date:   Thu, 10 Nov 2022 16:35:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6 06/10] pwm: dwc: split pci out of core driver
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
References: <20221020151610.59443-1-ben.dooks@sifive.com>
 <20221020151610.59443-7-ben.dooks@sifive.com>
 <20221110152927.olg3oqcnqvskbsli@pengutronix.de>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20221110152927.olg3oqcnqvskbsli@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 10/11/2022 15:29, Uwe Kleine-König wrote:
> On Thu, Oct 20, 2022 at 04:16:06PM +0100, Ben Dooks wrote:
>> Moving towards adding non-pci support for the driver, move the pci
>> parts out of the core into their own module. This is partly due to
>> the module_driver() code only being allowed once in a module and also
>> to avoid a number of #ifdef if we build a single file in a system
>> without pci support.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>> v6:
>>   - put DWC_PERIOD_NS back to avoid bisect issues
>> v4:
>>   - removed DWC_PERIOD_NS as not needed
>> ---
>>   drivers/pwm/Kconfig       |  14 +++-
>>   drivers/pwm/Makefile      |   1 +
>>   drivers/pwm/pwm-dwc-pci.c | 133 ++++++++++++++++++++++++++++++++
>>   drivers/pwm/pwm-dwc.c     | 158 +-------------------------------------
>>   drivers/pwm/pwm-dwc.h     |  58 ++++++++++++++
>>   5 files changed, 207 insertions(+), 157 deletions(-)
>>   create mode 100644 drivers/pwm/pwm-dwc-pci.c
>>   create mode 100644 drivers/pwm/pwm-dwc.h
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 3f3c53af4a56..a9f1c554db2b 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -175,15 +175,23 @@ config PWM_CROS_EC
>>   	  Controller.
>>   
>>   config PWM_DWC
>> -	tristate "DesignWare PWM Controller"
>> -	depends on PCI || COMPILE_TEST
>> +	tristate "DesignWare PWM Controller core"
>>   	depends on HAS_IOMEM
>>   	help
>> -	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
>> +	  PWM driver for Synopsys DWC PWM Controller.
> 
> Currently pwm-dwc doesn't contain a driver but is only a library used by
> pwm-dwc-pci (and later the of driver). As such it doesn't make sense to
> be user-selectible, does it? 

I suppose the PWM_DWC should select the original driver an a new
PWM_DW_CORE should build the actual core driver.

-- 
Ben


