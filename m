Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720195738D8
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jul 2022 16:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbiGMOaM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jul 2022 10:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiGMOaL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jul 2022 10:30:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3B5357E2
        for <linux-pwm@vger.kernel.org>; Wed, 13 Jul 2022 07:30:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d16so15745591wrv.10
        for <linux-pwm@vger.kernel.org>; Wed, 13 Jul 2022 07:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vr7v5OA4OBuFn4xzfn7voat0f0rlZBh//6y8zR8UEcQ=;
        b=LtGaDNd02/pBkiCw4rEu+Gg/LmhFDe5JyvbuCpuQz0R0RLL0zwI0IqV7m1KqKHGYq9
         DHg6KR2gh+D3zbOwOr8Gp4JNhU8p+8BGBrC+wTGOmFpYgLnhJH/66d3djS58eqCVb2gY
         iW1k/s2orJDLs2s4pQAox0fl6ytbUDHeGeL0f/TY5e9qA/H51tBJyzmmqffQumTA2QjX
         aOXkQruEVyHiK+R8eSBULNtiyVZf7VrP7/iwFyim1BZrEmJEJwRpe22Nzg58P7Lgc/S9
         3I3QC0vtUctDypg5meE2/CO8+SHH6ixssB0L6vseZscCk0ly/6meNrkXc3kG1oOU9k6Y
         +S7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vr7v5OA4OBuFn4xzfn7voat0f0rlZBh//6y8zR8UEcQ=;
        b=5NfQTPwKg4t9al+8JXk7wAYeS8Rk+6nB0dKsTVS/6IGgqWaJBG6a64Q2cxBgFmKHeK
         tNkk6WZsMhqlIjGdwnjoULj95EEhTeu9nJbPN2ulI7oK3kUp6Ao2hiIsossJ8GYOQ4W4
         n4i3JiFW1MKJl0ufR1AyiMNpuAFomfwBzyBb/4onKDryJVYEHEAW6a+NtnTD26mJLCYT
         dqjIFaczOzKmJrPrL3pBftpzGK1Hj8/5muW9QJvcjhE90XaZngr05rxSAcYk2VYCWb35
         tZmhv6qcjiNxHSOS8bxy3345HXshg9kRAT0qbbNBvOy6DmV6Pjvbv+D/oNJE/TScOcjJ
         UcjA==
X-Gm-Message-State: AJIora/ihsW9oCs7upAzp9NV3eEemeFgY8I4BeJW9o9bJ6s2lUrWxZ+x
        txjj4yOpjswBXltB6/5Kmy2gdQ==
X-Google-Smtp-Source: AGRyM1ucGrsnIOn+8xcBsGNx/uvSJl2zH2BOQbgbn2UCEBQxGPft+r17LbuIlwfpB09Pv8tj1i3Gog==
X-Received: by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP id a4-20020adffb84000000b0021a10f21661mr3629310wrr.2.1657722609075;
        Wed, 13 Jul 2022 07:30:09 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id f11-20020adfe90b000000b0021d7b41255esm11100425wrm.98.2022.07.13.07.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 07:30:08 -0700 (PDT)
Message-ID: <7999fec2-847a-86ce-ed78-d2a9008bf654@sifive.com>
Date:   Wed, 13 Jul 2022 15:30:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/7] pwm: dwc: add of/platform support
Content-Language: en-GB
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-4-ben.dooks@sifive.com>
 <20220712221715.GT1823936-robh@kernel.org>
 <feaacf44-f9a8-b892-d8ba-8a396b49d56b@sifive.com>
 <20220713135230.gjbd3v6iih2uicpu@pengutronix.de>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20220713135230.gjbd3v6iih2uicpu@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 13/07/2022 14:52, Uwe Kleine-König wrote:
> On Wed, Jul 13, 2022 at 12:56:55PM +0100, Ben Dooks wrote:
>> On 12/07/2022 23:17, Rob Herring wrote:
>>> On Tue, Jul 12, 2022 at 11:01:09AM +0100, Ben Dooks wrote:
>>>> The dwc pwm controller can be used in non-PCI systems, so allow
>>>> either platform or OF based probing.
>>>>
>>>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>

[snip]

>>>> +properties:
>>>> +  "#pwm-cells":
>>>> +    description: |
>>>> +      See pwm.yaml in this directory for a description of the cells format.
>>>
>>> pwm.yaml doesn't define how many cells. You need to. And you don't need
>>> generic descriptions.
>>
>>   "#pwm-cells":
>>      const: 1
>>
>> should be sufficient then?
> 
> I would expect a value of (at least) 2 or (better) 3.

OOPS, forgot the phandle.

I will have to check if we have any support yet for dealing
with any of the pwm flags yet.

> Best regards
> Uwe
> 

