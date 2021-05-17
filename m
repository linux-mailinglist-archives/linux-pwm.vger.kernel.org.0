Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C323B383300
	for <lists+linux-pwm@lfdr.de>; Mon, 17 May 2021 16:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbhEQOxO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 May 2021 10:53:14 -0400
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com ([40.107.244.54]:11624
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241178AbhEQOvM (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 17 May 2021 10:51:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQZaZRXjVPjemgRGoanYcPZ4L9GiJgmyguH5GWpD6k9DS0uhYHEnQxfVmkzOROsSfy+GcTX1UQLwP1A54XnbyO3dHlpoyraRWdWrgB5kD6hWNDqNmZaFj9Ve770abzjW+roq9cAaQ67X0ATgA3zRQQMc3ylei7N9kQwr44UzV0f3UYtuD/nBTpSxLFUsf6rK4c0EcMIfX9tdjs6N1eKwG7GKKkJoe4LZHHITyZj1aF0v0nJ5MY7NNCCdcztTMgw1lmUTV+rECwyoSM7gC62WeqZFkxYo0Qs2PT4++Fuj1J3ABYheLH9+7JLXdvt5+wH17ebjx6QEomvZTTvoyZm4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZAEWNNR0JULK0bV1dYi/UR2RMJsDrgpA7M1tuGe6pQ=;
 b=ZrCfF/Et9PlDHOlDc017S3gqJYM4rRkL5VfvfIGNF/yvU7i8gerqUIpPAR52H8cylRR1mb0jdtVXByfzEWBKQU6G+fxdR0njk2XYrDxqMSSTFPxEHBOSmUVKkEF4XsB2xKdAaaGK2v43UykWZYx3IGiLdpt2jC/rvBGAkbbjainKrZaJMdGBJSd6H9Hz+XCCsizV7XmaMWnKNtg0Zfum0VViYK3kQEwepscybRKFBM7raMQtDf8FQCdlthFbjIbTMArGBW9EZ7K+NuKe12i57BaYahL5CjBvdh1Rx5tD97oGJcHuDusziwNftv6hmPT+E2zDQu97ksTT7eN+6JdygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZAEWNNR0JULK0bV1dYi/UR2RMJsDrgpA7M1tuGe6pQ=;
 b=ZE9Czvi4a59/j4pR9dBcUEqVz3PAI98F+nAg5fQhuIiazBqe9zT3ng2/35Gaqj6KTmNkO2q1AU5jumeycnYzzy3mN9asBR8lIN4L/8lw6UAufuAEi3jLPqz7hfka3NdeNyuLqaURMR6yjyJlyFD2Hp9IPMEcgawDFE6NfFhNS/s=
Received: from BN6PR22CA0029.namprd22.prod.outlook.com (2603:10b6:404:37::15)
 by BY5PR02MB7089.namprd02.prod.outlook.com (2603:10b6:a03:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 14:49:54 +0000
Received: from BN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::22) by BN6PR22CA0029.outlook.office365.com
 (2603:10b6:404:37::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 14:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT038.mail.protection.outlook.com (10.13.2.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Mon, 17 May 2021 14:49:53 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 07:49:52 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 17 May 2021 07:49:52 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 alvaro.gamez@hazent.com,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 robh@kernel.org,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=54636)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lieZ5-0003pg-Jb; Mon, 17 May 2021 07:49:52 -0700
To:     Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>
CC:     Linux PWM List <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20210511191239.774570-1-sean.anderson@seco.com>
 <20210513021631.GA878860@robh.at.kernel.org>
 <f9165937-c578-d225-9f5e-d964367c4711@seco.com>
 <70176596-2250-8ae1-912a-9f9c30694e7d@seco.com>
 <CAL_JsqJY1W=t-gYYt+iTPgF7e9yJqzYFYGSJNrA4BNhAY+va8Q@mail.gmail.com>
 <9cf3a580-e4d3-07fc-956f-dc5c84802d93@xilinx.com>
 <87b31b06-9b81-5743-e3a8-50c255c0a83c@seco.com>
 <141399b7-db9c-45e1-f743-9e3bc5e6f9fd@xilinx.com>
 <5b038a5a-9aed-7810-66d0-128e586283e4@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
Message-ID: <170a62b1-c56f-d393-adfd-7064cb0ec9d5@xilinx.com>
Date:   Mon, 17 May 2021 16:49:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5b038a5a-9aed-7810-66d0-128e586283e4@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51c803a6-4fac-445d-89de-08d919430825
X-MS-TrafficTypeDiagnostic: BY5PR02MB7089:
X-Microsoft-Antispam-PRVS: <BY5PR02MB708963085CE872F5EAFD7C35C62D9@BY5PR02MB7089.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfUc0wkMrcLuT9qSgrKDELMjGlvKrsdaiijJAWbtPKSoyTaE7C2FWuFuAQucTM5qI8N8MlNOLuVyhVOJvj+ry2nYxrkXyYvDSiI7rN0wsjWVgd0HlzHvaDMS/WIzaWXSM9cy54XoMq9sdYAJbTHNbhFBcn+LEZzXpqkwheIV72qZeDHTM9GmM10ZV8f2dqcCO6xN0B/S8RdkvzQl7pn6JZCOZO6uGxY7QVFJr3sM95v6uMPOmgBiMsYea3t8Yrgoq1mDLgwTL+vBBjc5EQ6dM3xwc59ZVHPd2t1uV+iQMp8LF4iBIKJh3NGGZju3aD2Lat9PWx072OLBBk4VNdr5FrUclj95Ze+tQ/svsv2QPbGctgqCSv5GoWhKaRiZjqeYh1Fxbi/DfhDCZ3wsufACuDn13FOmr26HpCbr4tqlQp7qpKOR6PyNHXB6BRwtN3sXD91Aj+V0DYYY5GAW6UNEGwpOhW5WEE7iwOfdDHFVrIHGuye4AagY9RdhRwqiUYB2/CBxwhyXCC1bcu4ptG12YsU0DsTbM2AMak5rP85Zi0ptrh+owG71/CD6mFu3E0+T//sMg39LlDHLskq2ljtK+FTb2iMzp/hSu6YFIWQpp0a2zqauVJr6omEZznnZpJAtkh8pLMz47pUUP5e1Hpqh2iD6XZNEDOivOwzUpDu6nxYZt4+b130o8d6KRUruIypV8etjHBCB1198bSoe1VrBhQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39840400004)(346002)(136003)(36840700001)(46966006)(8936002)(83380400001)(356005)(70586007)(8676002)(31696002)(9786002)(54906003)(4326008)(70206006)(7636003)(186003)(110136005)(426003)(2906002)(478600001)(2616005)(36860700001)(316002)(26005)(36906005)(6666004)(44832011)(30864003)(82310400003)(36756003)(5660300002)(47076005)(53546011)(336012)(31686004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:49:53.8337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c803a6-4fac-445d-89de-08d919430825
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7089
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/17/21 4:40 PM, Sean Anderson wrote:
> 
> 
> On 5/17/21 4:28 AM, Michal Simek wrote:
>>
>>
>> On 5/14/21 7:13 PM, Sean Anderson wrote:
>>>
>>>
>>> On 5/14/21 4:50 AM, Michal Simek wrote:
>>>>
>>>>
>>>> On 5/13/21 10:43 PM, Rob Herring wrote:
>>>>> On Thu, May 13, 2021 at 10:28 AM Sean Anderson
>>> <sean.anderson@seco.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 5/13/21 10:33 AM, Sean Anderson wrote:
>>>>>>     >
>>>>>>     >
>>>>>>     > On 5/12/21 10:16 PM, Rob Herring wrote:
>>>>>>     >  > On Tue, May 11, 2021 at 03:12:37PM -0400, Sean Anderson
> wrote:
>>>>>>     >  >> This adds a binding for the Xilinx LogiCORE IP AXI Timer.
>>> This device is
>>>>>>     >  >> a "soft" block, so it has many parameters which would
> not be
>>>>>>     >  >> configurable in most hardware. This binding is usually
>>> automatically
>>>>>>     >  >> generated by Xilinx's tools, so the names and values of
> some
>>> properties
>>>>>>     >  >> must be kept as they are. Replacement properties have been
>>> provided for
>>>>>>     >  >> new device trees.
>>>>>>     >  >
>>>>>>     >  > Because you have some tool generating properties is not a
>>> reason we have
>>>>>>     >  > to accept them upstream.
>>>>>>     >
>>>>>>     > These properties are already in
>>> arch/microblaze/boot/dts/system.dts and
>>>>>>     > in the devicetree supplied to Linux by qemu. Removing these
>>> properties
>>>>>>     > will break existing setups, which I would like to avoid.
>>>>>
>>>>> Already in use in upstream dts files is different than just
>>>>> 'automatically generated' by vendor tools.
>>>>>
>>>>>>     >
>>>>>>     >  > 'deprecated' is for what *we* have deprecated.
>>>>>>     >
>>>>>>     > Ok. I will remove that then.
>>>>>>     >
>>>>>>     >  >
>>>>>>     >  > In this case, I don't really see the point in defining new
>>> properties
>>>>>>     >  > just to have bool.
>>>>>>     >
>>>>>>     > I don't either, but it was requested, by Michal...
>>>>>>
>>>>>> Err, your comment on the original bindings was
>>>>>>
>>>>>>     > Can't all these be boolean?
>>>>>
>>>>> With no other context, yes that's what I would ask. Now you've given
>>>>> me some context, between using the existing ones and 2 sets of
>>>>> properties to maintain, I choose the former.
>>>>>
>>>>>> And Michal commented
>>>>>>
>>>>>>     > I think in this case you should described what it is used by
>>> current
>>>>>>     > driver in Microblaze and these options are required. The rest
>>> are by
>>>>>>     > design optional.
>>>>>>     > If you want to change them to different value then current
> binding
>>>>>>     > should be deprecated and have any transition time with code
>>> alignment.
>>>>>>
>>>>>> So that is what I tried to accomplish with this revision. I also
> tried
>>>>>> allowing something like
>>>>>>
>>>>>>            xlnx,one-timer-only = <0>; /* two timers */
>>>>>>            xlnx,one-timer-only = <1>; /* one timer  */
>>>>>>            xlnx,one-timer-only; /* one timer */
>>>>>>            /* property absent means two timers */
>>>>>>
>>>>>> but I was unable to figure out how to express this with
> json-schema. I
>>>>>> don't think it's the best design either...
>>>>>
>>>>> json-schema would certainly let you, but generally we don't want
>>>>> properties to have more than 1 type.
>>>>
>>>> One thing is what it is in system.dts file which was committed in 2009
>>>> and there are just small alignments there. But none is really using it.
>>>> Maybe I should just delete it.
>>>> And this version was generated by Xilinx ancient tools at that time.
> All
>>>> parameters there are fully describing HW and they are not changing.
> Only
>>>> new one can be added.
>>>>
>>>>    From the current microblaze code you can see which properties are
> really
>>>> used.
>>>>
>>>> reg
>>>> interrupts
>>>> xlnx,one-timer-only
>>>> clocks
>>>> clock-frequency
>>>
>>> There is also an implicit dependency on xlnx,count-width. Several times
>>> the existing driver assumes the counter width is 32, but this should
>>> instead be discovered from the devicetree.
>>
>> For me it is important what it is used now. Which is not
>> xlnx,count-width. That's why if you want to add it you can as optional
>> property.
> 
> At the very least we should sanity check it. E.g. check that it is 32
> and return -EINVAL if it is not.

I have not a problem with it but make sure that the check is there only
when property is present not to break all current users.


>>
>>>
>>>> It means from my point of view these should be listed in the binding.
>>>> clock-frequency is optional by code when clock is defined.
>>>>
>>>> All other properties listed in system.dts are from my perspective
>>>> optional and that's how it should be.
>>>
>>> Here is the situation as I understand it
>>>
>>> * This device has existed for around 15 years (since 2006)
>>> * Because it is a soft device, there are several configurable parameters
>>> * Although all of these parameters must be known for a complete
>>>    implementation of this device, some are unnecessary if onlu reduced
>>>    functionality is needed.
>>> * A de facto devicetree binding for this device has existed for at least
>>>    12 years (since 2009), but likely for as long as the device itself
> has
>>>    existed. This binding has not changed substantially during this time.
>>
>> note: IP itself is even much older.
>>
>>> * This binding is present in devicetrees from the Linux kernel, from
>>>    qemu, in other existing systems, and in devicetrees generated by
>>>    Xilinx's toolset.
>>
>> Only from Linux. Qemu is trying to reuse the same properties but it can
>> also add own one. They are trying to be aligned as much as possible but
>> there are a lot of cases where Qemu requires much more information. (I
>> am not saying in this timer case but in general).
>>
>>
>>> * Because the existing driver for this device does not implement all
>>>    functionality for this device, not all properties in the devicetree
>>>    binding are used. In fact, there is (as noted above) one property
>>>    which should be in use but is not because the current driver
>>>    (implicitly) does not support some hardware configurations.
>>> * To support additional functionality, it is necessary to
>>>    use hardware parameters which were not previously necessary.
>>>
>>> Based on the above, we can classify the properties of this binding into
>>> several categories.
>>>
>>> * Those which are currently read by the driver.
>>>    * compatible
>>>    * reg
>>>    * clocks
>>>    * clock-frequency
>>>    * interrupts
>>>    * xlnx,one-timer-only
>>>
>>> * Those which reflect hardware parameters which are currently explicitly
>>>    or implicitly relied upon by the driver.
>>>    * reg
>>>    * clocks
>>>    * clock-frequency
>>>    * interrupts
>>>    * xlnx,counter-width
>>>    * xlnx,one-timer-only
>>>
>>> * Those which are currently present in device trees.
>>>    * compatible
>>>    * reg
>>>    * interrupts
>>>    * clocks
>>>    * clock-frequency
>>>    * xlnx,count-width
>>>    * xlnx,one-timer-only
>>>    * xlnx,trig0-assert
>>>    * xlnx,trig1-assert
>>>    * xlnx,gen0-assert
>>>    * xlnx,gen1-assert
>>>
>>> When choosing what properties to use, we must consider what the impact
>>> of our changes will be on not just the kernel but also on existing users
>>> of this binding:
>>
>> I don't think that this is valid. Rob is asking for adding #pwm-cells
>> which is purely Linux binding. We also don't know what properties are
>> used by others projects not just Linux or Qemu. Also required properties
>> in Linux doesn't need to be required in U-Boot for example even we are
>> trying to aligned all of them. Another case are others RTOSes, etc.
> 
> Here I do not see a way around this. Any way we do it we will need to
> have some new binding. However, as noted below, adding a new binding for
> configuration is easier than exposing properties in new ways.

please look below.


>>> * To use properties currently present in device trees, we just need to
>>>    modify the kernel driver.
>>> * To add additional properties (such as e.g. '#pwm-cells'), we must
>>>    modify the kernel driver. In addition, users who would like to use
>>>    these new properties must add them to their device trees. This may be
>>>    done in a mechanical way using e.g. overlays.
>>> * To deprecate existing properties and introduce new properties to
>>>    expose the same underlying hardware parameters, we must modify the
>>>    kernel driver. However, this has a large impact on existing users.
>>>    They must modify their tools to generate this information in a
>>>    different format. When this information is generated by upstream
> tools
>>>    this may require updating a core part of their build system. For many
>>>    projects, this may happen very infrequently because of the risk that
>>>    such an upgrade will break things. Even if you suggest that Xilinx
> can
>>>    easily modify its tools to generate any sort of output, the time for
>>>    this upgrade to be deployed/adopted may be significantly longer.
>>
>>  From Xilinx perspective it would be ideal to use only properties which
>> fully describe HW in the form how they are generated today. They are
>> stable for a lot of years and as I said only new one are added.
>> But this alignment wasn't accepted long time ago and we have been asked
>> to start to align these properties with similar HW done by others.
>> And truth is that in a lot of cases there is clear 1:1 mapping and
>> generic properties can be simply use. This mapping ends in Xilinx device
>> tree generator.
>> Back to your point. Required properties are required by Linux driver
>> only. This driver is around for quite a long time where certain policies
>> haven't been setup/used/enforced (Microblaze is 2nd architecture which
>> started to use device tree).
>> We should create DT binding doc at that time but in 2009 it wasn't
>> standard practice. In 2007 Grant was adding support for Xilinx PPC
>> platform also without any DT binding document too.
>>
>> That's why we need to review current unwritten DT binding based on code
>> requirements and look at it how to fix it (if needed) and then add PWM
>> support on the top of it.
>> If something needs to be deprecated, let's deprecate it and have
>> transition time for a year or so to adapt to it.
>>
>> Rob knows much better than I how this should be handled.
>>
>> Based on your list:
>>    * compatible
>>    * reg
>>    * clocks
>>    * clock-frequency
>>    * interrupts
>>    * xlnx,one-timer-only
>>
>> all of these are required property in new DT binding.
>>
>> xlnx,counter-width is optional if you want to use.
> 
> Again, for the existing driver this should at least be sanity-checked so
> we fail noisily instead of buggily.

Till now for 10+ years none reported any issue with it that's why I
don't think this is a big problem.

> This is the situation for the generate polarity as well. The driver will
> work fine, but you will not have PWM output and there will be no
> indication why. This is why I think we should start with supporting the
> existing output. This is used to ensure the device will work as
> configured. We can also add support for different properties exposing
> the same information, but to support only new properties is not very
> useful.

Binding can enforce properties to be required for PWM only and that's
totally okay. And because this is new feature and Rob don't need to like
that new properties they can be aligned. I also have preference to be as
much aligned with HW parameters but if they have to change then let's
change it and I will ensure that Xilinx DTG will generate them as they
were described to be aligned.

Thanks,
Michal
