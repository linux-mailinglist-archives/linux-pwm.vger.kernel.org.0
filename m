Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5615963C5ED
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Nov 2022 18:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiK2RAQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Nov 2022 12:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbiK2Q74 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Nov 2022 11:59:56 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070B66D95C
        for <linux-pwm@vger.kernel.org>; Tue, 29 Nov 2022 08:55:33 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q12so10180017pfn.10
        for <linux-pwm@vger.kernel.org>; Tue, 29 Nov 2022 08:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZHZ3xLER05lERGmVtojr5I/PMD3IeMahsWj4IK2BO4=;
        b=FLTqGfw883rvILtX1vl/qcfz1Uk0n8/VtcJ2aZ0sHZFcTaQtSJ7UE2CtgeDaKMfls4
         45iltsi9nBcj+Gh9BuC6PSJh7YBtViexq6xQLKPimOPClsBFkr1ORh2K7uQujzCI2rll
         MeDZIdgeDj9Z9FY73QnYgc7D3YcVfK90kszlBRAdwYla21DuHzGBezFPqAk05eO4xlt/
         +raaZN7pphXcggRvP9rGR2mZB2fhesGTObt5wFziFx955KsqVdWGtzWjsLOkA3dTSdS2
         iIFLIKm7aDmGTWaG2w/wrvgriSo48nNyZDod5ZzuX+fdc3blyx0JbPCKq85ZrcI+C5KK
         2btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZHZ3xLER05lERGmVtojr5I/PMD3IeMahsWj4IK2BO4=;
        b=V7eTX0DeBk9APbt4Ds0sNpd6FLWWoC3NXBW5QwyBZCvIH3h987QyTuZ8YgBzFWRy4N
         8Rfvlcp560hduIX/AaM3KfFBVWqWS2t48xtZeE6lKXSu90vi9SZ5t4qJaIfK5t5fiTwz
         xZvDP/tor3pEOcA3BbGo6pSKVv3I2/YGJJ8UP11JAVdJFcLbIeshtfvFc1ofpa+WX421
         HL9/QEJ6+t+A18qtktkmAM63w/57Yatv7hNlRX0b4tA18DrdzC6ToF372RAnmBBpmZGk
         tJkteJzad2fBQ2IhHpV9rJpU6wyCyISqmgLDE79p2+PBqcy7U4SG4/94dKQg7WPDyOny
         J0Bg==
X-Gm-Message-State: ANoB5pnLDoCj7qp6kmEjVU0aeTv+BgqbxBQ8ecEO6evsh+mNB/MBgFpQ
        PZrB9NDjnDRZeAbABLEzPUWG4g==
X-Google-Smtp-Source: AA0mqf4zbadJGZLXlVcQk6yMXvQO5BV+w3tjYzjLIuoy8pYCkzrKq7A/sFqwdEXyzNbFUYLr4fSDxw==
X-Received: by 2002:a62:e717:0:b0:572:df9e:d57d with SMTP id s23-20020a62e717000000b00572df9ed57dmr61064060pfh.10.1669740932564;
        Tue, 29 Nov 2022 08:55:32 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902d2c700b0018997f6fc88sm2234583plc.34.2022.11.29.08.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 08:55:32 -0800 (PST)
Message-ID: <3faaa168-9802-9773-aa10-ee8ff0447d97@9elements.com>
Date:   Tue, 29 Nov 2022 22:25:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v8 4/4] hwmon: (max6639) Add pwm support
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Rob Herring <robh@kernel.org>
References: <20221129161134.2672474-1-Naresh.Solanki@9elements.com>
 <20221129161134.2672474-5-Naresh.Solanki@9elements.com>
 <20221129163427.dxnqfay6ur6mvivu@pengutronix.de>
 <d2d54a34-56dc-df83-5fde-ad0a9a73a9e0@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <d2d54a34-56dc-df83-5fde-ad0a9a73a9e0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi

On 29-11-2022 10:11 pm, Guenter Roeck wrote:
> On 11/29/22 08:34, Uwe Kleine-König wrote:
>> On Tue, Nov 29, 2022 at 05:11:34PM +0100, Naresh Solanki wrote:
>>> Add pwm support for max6639. Also configure pwm fan speed based on pwm
>>> provided in DT.
>>
>> Did you do anything to resolve the questions I had in reply to v5? If
>> yes, I must have missed it.
I did split the patch to separate dt changes & pwm specific changes.
>>
> 
> I don't see a response to my concerns either, especially regarding fan mode
> (dc vs. pwm) in the bindings. For that reason, I won't even look at the 
> series.

I intend to use max6639 driver but with DT support.
Did additional changes(like using PWM provider) based on feedback I 
received.

> 
> Guenter
> 
>> Note that maintainer time is scarce and with sending new versions of a
>> patch with no sign that you improved in the aspects that were critized
>> before, you're burning that scarce time and loosing the good will of the
>> responsible maintainers.
>>
>> Best regards
>> Uwe
>>
> 
Regards,
Naresh
