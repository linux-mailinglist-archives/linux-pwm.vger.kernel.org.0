Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F20F35C4A3
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 13:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbhDLLFV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 07:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbhDLLFV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 07:05:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A55C061574;
        Mon, 12 Apr 2021 04:05:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a7so19591686eju.1;
        Mon, 12 Apr 2021 04:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V5dAFJoIeEivVJOccQwSPrrQGKQJ4TPKYt0s4Azreuk=;
        b=WpZOT4czFb+ue9BhLqO4BESVZOKjpFHKWUuMOcecZg/Zux/ABOGfnDTuefIrNX4e1z
         e07IpVVvfD61lTV/eywC0cIkd42hFcy1gQ6rqxf8YxsszKXU+zvU942Pnyt7+QlUrrP2
         G+CHfI2pK1x9oXCham+hXnZyV45UjSuIxRuwxeN/AxTtdFTEwFycJRw09wTUrlryB1VK
         mhC7ISCEIX6pWyFg91bHeQpZ3ig/qjHOnzpBJaL2aN3rn0MT83TN/zHkFOOLBcqWE5vc
         dyLcCZBebyEdNHG8wVRtuIXxpi642tHJekUW4v3N/9s3BXl2uhy77Z+9E838TIrhDcxG
         bO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V5dAFJoIeEivVJOccQwSPrrQGKQJ4TPKYt0s4Azreuk=;
        b=SeVW7AeVBZRpn14uCJprRDdmBKjZVkDBR/1wu3onVBwdgrOQ2uucHX+uYTI3ohXF6u
         oesxvGXj2hsrFRyIF877FmK+U14X/VJUXpRyRrhdjZgh9E0BTXvOFDZBAnzfoLcQofUY
         +onKYtKvPPnZ16jQbU3TQSke8sGItncEFsez1/eciHMmpaY5mndO9wQV4HX6XoUtMtES
         /L/k5btYDiFNfkvikCws/FUsa/cp7uJe8UUMnGvBHLunvpatZCbyVS7jWwQJ0tkbK9Vl
         qPRFl0tTrS+BVzNZP8Zsl2N7afKZzPFiDsjZPjHRzGiT1Hp4txMn2x6HHGSo5CUkI1X5
         CiHA==
X-Gm-Message-State: AOAM5302STRk/iKNXOOtjK/2tJa4Y1Zg6ogQjah4LM3gESE33IgbpLE0
        KeWFzG5ynO/emHLv/7V8ylA5Fr6P0QDrWQ==
X-Google-Smtp-Source: ABdhPJyrVvWEYe2udlW1YYznobtl8vNAIfN1JQMcOPAuk2XUccouqVMNk50JwIdog8Ndgw2sIaLukA==
X-Received: by 2002:a17:906:5487:: with SMTP id r7mr26039455ejo.550.1618225501490;
        Mon, 12 Apr 2021 04:05:01 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a9sm6327241eds.33.2021.04.12.04.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 04:05:01 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] ARM: dts: rockchip: remove interrupts properties
 from pwm nodes rv1108.dtsi
To:     wens@kernel.org
Cc:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210411131007.21757-1-jbx6244@gmail.com>
 <20210411131007.21757-3-jbx6244@gmail.com>
 <CAGb2v67s7a4GARfAnROKS40kaYQpdW_qWX=HX6GU09jV9wrbXw@mail.gmail.com>
 <31b5ff50-afe5-b446-7d3c-943d148814d8@gmail.com>
 <CAGb2v65+A402jCPVRJdDBdxqAEYOJmFTkKB4LJCvnW89hXb8QA@mail.gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <20b7c702-9412-93b4-3174-e8633bc413d7@gmail.com>
Date:   Mon, 12 Apr 2021 13:04:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v65+A402jCPVRJdDBdxqAEYOJmFTkKB4LJCvnW89hXb8QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 4/12/21 12:33 PM, Chen-Yu Tsai wrote:
> On Mon, Apr 12, 2021 at 6:03 PM Johan Jonker <jbx6244@gmail.com> wrote:
>>
>> On 4/12/21 5:15 AM, Chen-Yu Tsai wrote:
>>> On Sun, Apr 11, 2021 at 9:11 PM Johan Jonker <jbx6244@gmail.com> wrote:
>>>>
>>>> A test with the command below gives this error:
>>>>
>>>> /arch/arm/boot/dts/rv1108-evb.dt.yaml:
>>>> pwm@10280000: 'interrupts' does not match any of the regexes:
>>>> 'pinctrl-[0-9]+'
>>>>
>>>> "interrupts" is an undocumented property, so remove them
>>>> from pwm nodes in rv1108.dtsi.
>>>>
>>>> make ARCH=arm dtbs_check
>>>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
>>>>
>>>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>>
>>> Given that the interrupts were specified, meaning they are wired up in hardware,
>>> shouldn't the solution be to add the interrupts property to the binding instead?
>>>
>>> After all, the device tree describes the actual hardware, not just what the
>>> implementations need.
>>>
>>> ChenYu
>>>
>>
>> Hi,
>>
>> The question of what to do with it was asked in version 1, but no answer
>> was given, so I made a proposal.
>> The device tree description should be complete, but also as lean as
>> possible. If someone manages to sneak in undocumented properties without
>> reason then the ultimate consequence should be removal I think.
>>
>> Not sure about the (missing?) rv1108 TRM, but for rk3328 the interrupt
>> is used for:
>>
>> PWM_INTSTS 0x0040 W 0x00000000 Interrupt Status Register
>>   Channel Interrupt Polarity Flag
>>     This bit is used in capture mode in order to identify the
>>     transition of the input waveform when interrupt is generated.
>>   Channel Interrupt Status
>>     Interrupt generated
>>
>> PWM_INT_EN 0x0044 W 0x00000000 Interrupt Enable Register
>>   Channel Interrupt Enable
>>
>> Is there any current realistic use/setup for it to convince rob+dt this
>> should be added to pwm-rockchip.yaml?

Found:
pwm3 combined with ir uses a irq. Keep that as it is for now.

https://github.com/rockchip-linux/kernel/blob/develop-4.19/drivers/input/remotectl/rockchip_pwm_remotectl.c

> 
> Well, the PWM core has capture support, and pwm-sti implements it with
> interrupt support, so I guess there's at least a legitimate case for
> adding that to the binding. Whether someone has an actual use case for
> it and adds code to implement it is another story.
> 
>> The rk3328 interrupt rkpwm_int seems shared between channels, but only
>> included to pwm3. What is the proper way for that?
> 
> I guess the bigger question is why was the PWM controller split into
> four device nodes, instead of just one encompassing the whole block.
> Now we'd have to introduce a new binding to support capture mode and
> interrupts.
> 
> In that case I agree with dropping the interrupts for now, as it just
> won't fit. But I would add this additional information to the commit
> message.

Will wait with adding "interrupts" to pwm-rockchip.yaml till someone
makes a solution for the whole block. Convert only current
document/binding to reduce notifications.

For Heiko: patch 3 + 5 can go in the garbage bin:
[PATCH v2 3/6] ARM: dts: rockchip: remove interrupts properties from pwm
nodes rv1108.dtsi
[PATCH v2 5/6] arm64: dts: rockchip: remove interrupts properties from
pwm nodes rk3328.dtsi

Johan

> 
> 
> Regards
> ChenYu
> 

