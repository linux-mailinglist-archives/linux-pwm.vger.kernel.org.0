Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8DC380587
	for <lists+linux-pwm@lfdr.de>; Fri, 14 May 2021 10:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhENIvz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 May 2021 04:51:55 -0400
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com ([40.107.237.74]:15846
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230185AbhENIvy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 14 May 2021 04:51:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZr+6xJPGswucVKes87/OC2b217oUHGVB0qjiM7JaqBkMy32BiEOuATFXPE0Kh0mqsF6ZOF915diRDK733DIG6LmKt8ySb6c4AiZQvBK1mCGJFE1zl9hGZpQVHTpDrp1VzffW62hcRxHSS0ZE5zxvgRFLyuCmgmIC9Z3WgUIYyG9xaP0a4HTK1GM/1wz8SlnnYaw+xLmHONjQV8dxSmaTqXNMtQ/8ZqsAq3/L6L/Oc4v40gzLiBGfS69FwbaOTdhfQhQI3ipbX3rRObZJgW/i1NRZ8DdIhFE/icNKHoNWCOm3cYQ2oOPrNugxxau6RXp8lM/Di7Uyt9dbI9GLIK9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r39krYKCqV9rgP8FRk9VFNcwUh3QYOl4Mo+kp8DPhs8=;
 b=TQRsRSSzizqLTh8upo/y+m9Y8aeq1A/LncUQll5/2bHOuwTeSGsNWyE5AseiVKfssp42NpTFid+cSu3G3QguzHDpW5ujmd4hzimWnN2H9ZS6Py9FnVYZ5ZYzIcTObstjkL573WrRpHng3n/0ePPEjY6OySs9HDa/X5fxoHswvLKhze9MfVY0yNRYivp6a06KXxzeuYe2oBT0HzNyXYaTqEkHvUcY5AjoCnFijgTWO9L5Bz6VcKSX9CwIU0mANkCvbAnlcSQ5OezsOmTUYn9bnlwE/IWjp61v5mt0OR9mbWJpsKZZckJsZVkw3I9Q3jJGBBB7utpZR7LEu+ls9kQclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r39krYKCqV9rgP8FRk9VFNcwUh3QYOl4Mo+kp8DPhs8=;
 b=njWU7tiqv4xlpdA9d02YWg5vgdrFBhrToiEmlJbUPyndBlfqFq/42VriTRdLdgeFTRYW58i91g5vhLTYR02IOKfy3ZP57R/2iURPGOKsM8EEC81kYPPShloTVrF1hnikBGxFXZQLOKYX2AAj2LcZahz0XlcpyTGnfYDjz+rwoiQ=
Received: from SN7PR04CA0117.namprd04.prod.outlook.com (2603:10b6:806:122::32)
 by BYAPR02MB5976.namprd02.prod.outlook.com (2603:10b6:a03:126::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 08:50:40 +0000
Received: from SN1NAM02FT0054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:122:cafe::d6) by SN7PR04CA0117.outlook.office365.com
 (2603:10b6:806:122::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 08:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0054.mail.protection.outlook.com (10.97.4.242) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Fri, 14 May 2021 08:50:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 01:50:39 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 14 May 2021 01:50:39 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 alvaro.gamez@hazent.com,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 sean.anderson@seco.com,
 robh@kernel.org
Received: from [172.30.17.109] (port=48736)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lhTWp-0003m1-BM; Fri, 14 May 2021 01:50:39 -0700
To:     Rob Herring <robh@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>
CC:     Linux PWM List <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20210511191239.774570-1-sean.anderson@seco.com>
 <20210513021631.GA878860@robh.at.kernel.org>
 <f9165937-c578-d225-9f5e-d964367c4711@seco.com>
 <70176596-2250-8ae1-912a-9f9c30694e7d@seco.com>
 <CAL_JsqJY1W=t-gYYt+iTPgF7e9yJqzYFYGSJNrA4BNhAY+va8Q@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
Message-ID: <9cf3a580-e4d3-07fc-956f-dc5c84802d93@xilinx.com>
Date:   Fri, 14 May 2021 10:50:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJY1W=t-gYYt+iTPgF7e9yJqzYFYGSJNrA4BNhAY+va8Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9bc8903-c8f8-4746-7434-08d916b559fa
X-MS-TrafficTypeDiagnostic: BYAPR02MB5976:
X-Microsoft-Antispam-PRVS: <BYAPR02MB59763C94622B919344A7B6D1C6509@BYAPR02MB5976.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C423qjS67oYh7RzhdAnZw/AmKY0bRMS38cEoHhAbA5u9N4wchnhyOwWAE9SKE+KicNMrRacjYlExnhSoNEs4U5CZARin98QBLIPesKNAI75Kskybm+4qJguWroGwTJme6F753G67HhvFDHF/fYE90AReODhhArLGsWqDHLXNYlS5UK/jDabSgkx3PsIP0hZ0HpqtuFNvtdtQgtpmYz8JKggK4vrEaGE5VJulBc7LXMHlByjZkWerPze0Dz3JAJQXazEMYUB/iNKuOLKiE3cGYRyTQvgC32yo9/ZqX1dzPeduq1ESB+3FU9veta+5qcNcL07/4+m+a0312v+DMhSw9xU8lYzqzIftP9KUr6+iLHAS5DBpAN+HIhecGwBOJztuKgokNjoBgzWLl5IXqRi++Gyw+EI26A8NUsrLovCmK+MJCIsWTYN88tYQni2/unXMRcjksMPtZZJCWNty7MLfusDXOBqQXHp70ClsVc3GcZxuwS4uQwq8v34AIfRP9fuPhMuxFX0HllIcBspGOwT1/IjBwaHUG2zUa6ovobsfJR++bykGcbR3oR3d6Z4JLkeVImDBEQ8DCY1jxH+cUSVxOQz1PPfddqGuePrOr2jnlwDowkpzXZw/Kh7+HC4Fmg8w3bVfVndd7y/Z/RDyOHcVqQ6bNmYeseaMDBsKeJw56ynUwLYiYq4lHbWc0yTIgLfNro1ynOCW8z+KRefPJm/DJw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(8936002)(53546011)(426003)(356005)(7636003)(31686004)(44832011)(70206006)(47076005)(5660300002)(4326008)(186003)(70586007)(2616005)(83380400001)(9786002)(8676002)(336012)(498600001)(82310400003)(31696002)(110136005)(2906002)(54906003)(36756003)(36906005)(26005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 08:50:40.3313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bc8903-c8f8-4746-7434-08d916b559fa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5976
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/13/21 10:43 PM, Rob Herring wrote:
> On Thu, May 13, 2021 at 10:28 AM Sean Anderson <sean.anderson@seco.com> wrote:
>>
>>
>>
>> On 5/13/21 10:33 AM, Sean Anderson wrote:
>>  >
>>  >
>>  > On 5/12/21 10:16 PM, Rob Herring wrote:
>>  >  > On Tue, May 11, 2021 at 03:12:37PM -0400, Sean Anderson wrote:
>>  >  >> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
>>  >  >> a "soft" block, so it has many parameters which would not be
>>  >  >> configurable in most hardware. This binding is usually automatically
>>  >  >> generated by Xilinx's tools, so the names and values of some properties
>>  >  >> must be kept as they are. Replacement properties have been provided for
>>  >  >> new device trees.
>>  >  >
>>  >  > Because you have some tool generating properties is not a reason we have
>>  >  > to accept them upstream.
>>  >
>>  > These properties are already in arch/microblaze/boot/dts/system.dts and
>>  > in the devicetree supplied to Linux by qemu. Removing these properties
>>  > will break existing setups, which I would like to avoid.
> 
> Already in use in upstream dts files is different than just
> 'automatically generated' by vendor tools.
> 
>>  >
>>  >  > 'deprecated' is for what *we* have deprecated.
>>  >
>>  > Ok. I will remove that then.
>>  >
>>  >  >
>>  >  > In this case, I don't really see the point in defining new properties
>>  >  > just to have bool.
>>  >
>>  > I don't either, but it was requested, by Michal...
>>
>> Err, your comment on the original bindings was
>>
>>  > Can't all these be boolean?
> 
> With no other context, yes that's what I would ask. Now you've given
> me some context, between using the existing ones and 2 sets of
> properties to maintain, I choose the former.
> 
>> And Michal commented
>>
>>  > I think in this case you should described what it is used by current
>>  > driver in Microblaze and these options are required. The rest are by
>>  > design optional.
>>  > If you want to change them to different value then current binding
>>  > should be deprecated and have any transition time with code alignment.
>>
>> So that is what I tried to accomplish with this revision. I also tried
>> allowing something like
>>
>>         xlnx,one-timer-only = <0>; /* two timers */
>>         xlnx,one-timer-only = <1>; /* one timer  */
>>         xlnx,one-timer-only; /* one timer */
>>         /* property absent means two timers */
>>
>> but I was unable to figure out how to express this with json-schema. I
>> don't think it's the best design either...
> 
> json-schema would certainly let you, but generally we don't want
> properties to have more than 1 type.

One thing is what it is in system.dts file which was committed in 2009
and there are just small alignments there. But none is really using it.
Maybe I should just delete it.
And this version was generated by Xilinx ancient tools at that time. All
parameters there are fully describing HW and they are not changing. Only
new one can be added.

From the current microblaze code you can see which properties are really
used.

reg
interrupts
xlnx,one-timer-only
clocks
clock-frequency

It means from my point of view these should be listed in the binding.
clock-frequency is optional by code when clock is defined.

All other properties listed in system.dts are from my perspective
optional and that's how it should be.

I think DT binding patch should reflect this state as patch itself.
And then PWM should be added on the top as separate patch.

Note: In past we were using only parameters and name we got from tools
but over years we were fine to use for example bool properties and we
just aligned Xilinx device tree generator to match it. That's why not a
problem to deprecate any property and move to new one. Xilinx DTG is
already prepared for it and it is easy to remap it.

Thanks,
Michal






