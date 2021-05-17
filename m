Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342AF3826FE
	for <lists+linux-pwm@lfdr.de>; Mon, 17 May 2021 10:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhEQI3k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 May 2021 04:29:40 -0400
Received: from mail-sn1anam02on2040.outbound.protection.outlook.com ([40.107.96.40]:53455
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230011AbhEQI3j (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 17 May 2021 04:29:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKK77IrbB17c3HcA99epwERStcDKOnDRwbTHxDGiXVIB+msBzBxXDt/S2aM3JeqgH3gFJ2+rzwBES6qELV35zIfJ6yZXghXo9IVAqH8pDCNmlRf/pRkAnmGwC0kLazE7iVGDS7PT5XwCs4PIM+rH/U/Cdy9lxgzGsK+/u69XBdE9DqqnSEuH0zZGnqGHsGBPzpkePTaGUzy5Fg6RcXBAV2K5IEypGrAajT0a9H5BI/JYIc68RYl0DNgLDYuaOw/tLK5/I5jC5vEaZi+ELMBeChVvbphYqEDtBL6IMj9vW8UAo4bfnoMQf2rD+9pnTJhZtw2B5Cef4pJRuCI86OoWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol5KXD9kAi3ap4FD1Le6gXcSWhVw5izXiiITxvM85iU=;
 b=WsuXLdwRk7UvI0drSMq6DJc0Iwf2kXFe1ZUHsOZGyxqIAiM6xFp9qyED/Q/tefTeBjg2smJKqX3awca5ejw0yyLJRTld1rpMpHBmLlh/8tO+Ss/xSvzXpzx+F3omEI37jAFXC8+Iuw7prFcVrP+P42OV4kdohq+0BDIN8/XXDIq0nXq7tmaDXKaVuHJcef7i+WdoeBj9ISCOXucPArmhWVwLhFEwU9fyCQhO/QqFcLOLHSvvHAh1mM+V1zp5dK6UDrWqxJR5VL3bMqD2tl8tNBphxbbH4yJvaATPfrMesMeY5PpXXbRpQS/3XgCtgUJ5/fnUi3yhFbbMSBCQHqH8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol5KXD9kAi3ap4FD1Le6gXcSWhVw5izXiiITxvM85iU=;
 b=U52Ub6QMXGtklSu2rhCa3IuSUIXzk13xoK7O9TJKZglHAC8euvU9c2Ms5b02BEyB2s3nrH+PprelV8Q+hPQGmRrGZybb3ca2XhzYxS7T1bw4hfAUuzDrpIRua6f5EOVhAVzIT9GeOAupUki4d5s4HXy2vbecj5WjlofX5jsZNH8=
Received: from SN6PR01CA0022.prod.exchangelabs.com (2603:10b6:805:b6::35) by
 DM6PR02MB7002.namprd02.prod.outlook.com (2603:10b6:5:250::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Mon, 17 May 2021 08:28:21 +0000
Received: from SN1NAM02FT0022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:b6:cafe::1e) by SN6PR01CA0022.outlook.office365.com
 (2603:10b6:805:b6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 08:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0022.mail.protection.outlook.com (10.97.5.0) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Mon, 17 May 2021 08:28:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 01:28:18 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 17 May 2021 01:28:18 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 alvaro.gamez@hazent.com,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 robh@kernel.org,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=52570)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1liYbq-0003KZ-8J; Mon, 17 May 2021 01:28:18 -0700
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
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
Message-ID: <141399b7-db9c-45e1-f743-9e3bc5e6f9fd@xilinx.com>
Date:   Mon, 17 May 2021 10:28:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87b31b06-9b81-5743-e3a8-50c255c0a83c@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f37a989b-e94f-43e0-f588-08d9190dbb04
X-MS-TrafficTypeDiagnostic: DM6PR02MB7002:
X-Microsoft-Antispam-PRVS: <DM6PR02MB700239AB3E4A120B409F4330C62D9@DM6PR02MB7002.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MpXlCJmv5nV/zz8mB/ReXNMONBr96oNBllMSrVdwgfuN/4cdw+qIol6lNL5g9xsx2sOuR9OIQf310oHGpj1TXzmLEsC+BZkDXYqdhMK9n697djOGgopo3+B6b6Y0j5hypQEvAK62TNekBPIv554C4iTGisYlpsWR/fSmMBJUZqfPIjo1s0MSa0AxXry4THPVvvtUGghHnV8ws7uMMUnX5YljIGXQgrRyBIHdCWw2qJK8vHNMs0Yl7kHhF/Xx+kPtAG6WTxZCe+iCToZhhm+p3w4M6lrijUsrPk7M8lcVtK6kRi38CIOa1Eg2f2pI5ffOj9uDYP7j+4EdhOn935oyPQ84EbFWga12Y2JUKvIyoMSTJNaBfk1dKRDltziaSEUC3Mnn3xtdQGngNjMSdkGdsxc6ldI3P4GK2yPmgydRqda9zcbHyY+Z4joK/SisVCYuS3mD3KOMwDGMafVaJCoitaRiJvJjkLO1fZkVXRe9rBKUQ6cS5L7w4hBpAMYPElZgB4zHKWEJLQYftYU5wrGflaagNJVAVTP1Im9oLN/G6/IOZQ34z04R6R6iGMTqwfC5rWKd7/r8I1ED5adxCdFgJZzFR/fWiDofgR+3blHiFQiu7ftYHmzcx79jhBGpsw5Z/37/+ijR0T2e0oKglM3mjBk0vYRcfEM0P+5HgRG6BW9PBBYAsil3MUP4J30ZvMJbMIHwppUBJNjUCOKGje9FSw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(136003)(376002)(46966006)(36840700001)(53546011)(5660300002)(83380400001)(70206006)(2616005)(426003)(70586007)(82740400003)(7636003)(4326008)(356005)(31686004)(54906003)(2906002)(8676002)(6666004)(44832011)(9786002)(47076005)(478600001)(31696002)(36860700001)(36906005)(316002)(82310400003)(336012)(110136005)(36756003)(8936002)(186003)(26005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 08:28:21.1769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f37a989b-e94f-43e0-f588-08d9190dbb04
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7002
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/14/21 7:13 PM, Sean Anderson wrote:
> 
> 
> On 5/14/21 4:50 AM, Michal Simek wrote:
>>
>>
>> On 5/13/21 10:43 PM, Rob Herring wrote:
>>> On Thu, May 13, 2021 at 10:28 AM Sean Anderson
> <sean.anderson@seco.com> wrote:
>>>>
>>>>
>>>>
>>>> On 5/13/21 10:33 AM, Sean Anderson wrote:
>>>>   >
>>>>   >
>>>>   > On 5/12/21 10:16 PM, Rob Herring wrote:
>>>>   >  > On Tue, May 11, 2021 at 03:12:37PM -0400, Sean Anderson wrote:
>>>>   >  >> This adds a binding for the Xilinx LogiCORE IP AXI Timer.
> This device is
>>>>   >  >> a "soft" block, so it has many parameters which would not be
>>>>   >  >> configurable in most hardware. This binding is usually
> automatically
>>>>   >  >> generated by Xilinx's tools, so the names and values of some
> properties
>>>>   >  >> must be kept as they are. Replacement properties have been
> provided for
>>>>   >  >> new device trees.
>>>>   >  >
>>>>   >  > Because you have some tool generating properties is not a
> reason we have
>>>>   >  > to accept them upstream.
>>>>   >
>>>>   > These properties are already in
> arch/microblaze/boot/dts/system.dts and
>>>>   > in the devicetree supplied to Linux by qemu. Removing these
> properties
>>>>   > will break existing setups, which I would like to avoid.
>>>
>>> Already in use in upstream dts files is different than just
>>> 'automatically generated' by vendor tools.
>>>
>>>>   >
>>>>   >  > 'deprecated' is for what *we* have deprecated.
>>>>   >
>>>>   > Ok. I will remove that then.
>>>>   >
>>>>   >  >
>>>>   >  > In this case, I don't really see the point in defining new
> properties
>>>>   >  > just to have bool.
>>>>   >
>>>>   > I don't either, but it was requested, by Michal...
>>>>
>>>> Err, your comment on the original bindings was
>>>>
>>>>   > Can't all these be boolean?
>>>
>>> With no other context, yes that's what I would ask. Now you've given
>>> me some context, between using the existing ones and 2 sets of
>>> properties to maintain, I choose the former.
>>>
>>>> And Michal commented
>>>>
>>>>   > I think in this case you should described what it is used by
> current
>>>>   > driver in Microblaze and these options are required. The rest
> are by
>>>>   > design optional.
>>>>   > If you want to change them to different value then current binding
>>>>   > should be deprecated and have any transition time with code
> alignment.
>>>>
>>>> So that is what I tried to accomplish with this revision. I also tried
>>>> allowing something like
>>>>
>>>>          xlnx,one-timer-only = <0>; /* two timers */
>>>>          xlnx,one-timer-only = <1>; /* one timer  */
>>>>          xlnx,one-timer-only; /* one timer */
>>>>          /* property absent means two timers */
>>>>
>>>> but I was unable to figure out how to express this with json-schema. I
>>>> don't think it's the best design either...
>>>
>>> json-schema would certainly let you, but generally we don't want
>>> properties to have more than 1 type.
>>
>> One thing is what it is in system.dts file which was committed in 2009
>> and there are just small alignments there. But none is really using it.
>> Maybe I should just delete it.
>> And this version was generated by Xilinx ancient tools at that time. All
>> parameters there are fully describing HW and they are not changing. Only
>> new one can be added.
>>
>>  From the current microblaze code you can see which properties are really
>> used.
>>
>> reg
>> interrupts
>> xlnx,one-timer-only
>> clocks
>> clock-frequency
> 
> There is also an implicit dependency on xlnx,count-width. Several times
> the existing driver assumes the counter width is 32, but this should
> instead be discovered from the devicetree.

For me it is important what it is used now. Which is not
xlnx,count-width. That's why if you want to add it you can as optional
property.

> 
>> It means from my point of view these should be listed in the binding.
>> clock-frequency is optional by code when clock is defined.
>>
>> All other properties listed in system.dts are from my perspective
>> optional and that's how it should be.
> 
> Here is the situation as I understand it
> 
> * This device has existed for around 15 years (since 2006)
> * Because it is a soft device, there are several configurable parameters
> * Although all of these parameters must be known for a complete
>   implementation of this device, some are unnecessary if onlu reduced
>   functionality is needed.
> * A de facto devicetree binding for this device has existed for at least
>   12 years (since 2009), but likely for as long as the device itself has
>   existed. This binding has not changed substantially during this time.

note: IP itself is even much older.

> * This binding is present in devicetrees from the Linux kernel, from
>   qemu, in other existing systems, and in devicetrees generated by
>   Xilinx's toolset.

Only from Linux. Qemu is trying to reuse the same properties but it can
also add own one. They are trying to be aligned as much as possible but
there are a lot of cases where Qemu requires much more information. (I
am not saying in this timer case but in general).


> * Because the existing driver for this device does not implement all
>   functionality for this device, not all properties in the devicetree
>   binding are used. In fact, there is (as noted above) one property
>   which should be in use but is not because the current driver
>   (implicitly) does not support some hardware configurations.
> * To support additional functionality, it is necessary to
>   use hardware parameters which were not previously necessary.
> 
> Based on the above, we can classify the properties of this binding into
> several categories.
> 
> * Those which are currently read by the driver.
>   * compatible
>   * reg
>   * clocks
>   * clock-frequency
>   * interrupts
>   * xlnx,one-timer-only
> 
> * Those which reflect hardware parameters which are currently explicitly
>   or implicitly relied upon by the driver.
>   * reg
>   * clocks
>   * clock-frequency
>   * interrupts
>   * xlnx,counter-width
>   * xlnx,one-timer-only
> 
> * Those which are currently present in device trees.
>   * compatible
>   * reg
>   * interrupts
>   * clocks
>   * clock-frequency
>   * xlnx,count-width
>   * xlnx,one-timer-only
>   * xlnx,trig0-assert
>   * xlnx,trig1-assert
>   * xlnx,gen0-assert
>   * xlnx,gen1-assert
> 
> When choosing what properties to use, we must consider what the impact
> of our changes will be on not just the kernel but also on existing users
> of this binding:

I don't think that this is valid. Rob is asking for adding #pwm-cells
which is purely Linux binding. We also don't know what properties are
used by others projects not just Linux or Qemu. Also required properties
in Linux doesn't need to be required in U-Boot for example even we are
trying to aligned all of them. Another case are others RTOSes, etc.


> * To use properties currently present in device trees, we just need to
>   modify the kernel driver.
> * To add additional properties (such as e.g. '#pwm-cells'), we must
>   modify the kernel driver. In addition, users who would like to use
>   these new properties must add them to their device trees. This may be
>   done in a mechanical way using e.g. overlays.
> * To deprecate existing properties and introduce new properties to
>   expose the same underlying hardware parameters, we must modify the
>   kernel driver. However, this has a large impact on existing users.
>   They must modify their tools to generate this information in a
>   different format. When this information is generated by upstream tools
>   this may require updating a core part of their build system. For many
>   projects, this may happen very infrequently because of the risk that
>   such an upgrade will break things. Even if you suggest that Xilinx can
>   easily modify its tools to generate any sort of output, the time for
>   this upgrade to be deployed/adopted may be significantly longer.

From Xilinx perspective it would be ideal to use only properties which
fully describe HW in the form how they are generated today. They are
stable for a lot of years and as I said only new one are added.
But this alignment wasn't accepted long time ago and we have been asked
to start to align these properties with similar HW done by others.
And truth is that in a lot of cases there is clear 1:1 mapping and
generic properties can be simply use. This mapping ends in Xilinx device
tree generator.
Back to your point. Required properties are required by Linux driver
only. This driver is around for quite a long time where certain policies
haven't been setup/used/enforced (Microblaze is 2nd architecture which
started to use device tree).
We should create DT binding doc at that time but in 2009 it wasn't
standard practice. In 2007 Grant was adding support for Xilinx PPC
platform also without any DT binding document too.

That's why we need to review current unwritten DT binding based on code
requirements and look at it how to fix it (if needed) and then add PWM
support on the top of it.
If something needs to be deprecated, let's deprecate it and have
transition time for a year or so to adapt to it.

Rob knows much better than I how this should be handled.

Based on your list:
  * compatible
  * reg
  * clocks
  * clock-frequency
  * interrupts
  * xlnx,one-timer-only

all of these are required property in new DT binding.

xlnx,counter-width is optional if you want to use.
#pwm-cells is optional for enabling PWM support (I would expect that
when this property is present this timer don't need be used as
clocksource/clockevent by Microblaze)
etc

And for properties which are generated out of Xilinx tools I would allow
in DT binding to add others optional properties that DT won't error out
if they are seen.

Thanks,
Michal
