Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85463B9FDE
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Jul 2021 13:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhGBLi7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Jul 2021 07:38:59 -0400
Received: from mail-bn1nam07on2053.outbound.protection.outlook.com ([40.107.212.53]:54641
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231899AbhGBLi7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 2 Jul 2021 07:38:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYaCco5T3boLcHS8jl+LfnmpUQ8nQKU8ruboI46JMuKJNCFxXG/DCaGL1j1NSMV8fa4d3oQfxvoKASLZaIYnWtmgP+KPK3yMauRtm8q4pIUmxFLTn8avvKiscHUjvj77I57lAOJDyJefm4OtEFabk9E2+VPqbrzk1xRs/Sxz37hI4ER3fTEFVO5FcmF28Nf5QgXGTAbzQiYG6Bp2oejdeEfsvfQeqBmYnRcDtiZoljBHZK7OE18OHYOx4uDjKY4z8o4TvYs3KeJy6AhD+fFRQzinWV2V2bynP28IH8LBxrpQMX8xfYlD6HuqWd6scbl3F1lex6izrTsW03GSk1jsvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgVX1mk0os5jZDS7uCbjH+nR5PA+UbdKXO4d8S753tE=;
 b=H4jtBIY5T9VLcPVNAaJuOTP4d6mhmi8RqzqJUWcmAqHBxHxq4v2sDFdj/gmDC+yIUUSATd+OsE8xQLw6YLDHxcUZE1X2d6zYnVkQtHVaZuKyMmqS+fnLMfAwLg26Xu++ZydMmvuV0ApsM0A7v/u2NXg6u91Q0xEhLzc2zK/aQc7AWDAuNg0UwzI9kVFi4AVNY0bLEAVcJC1upowAaPIkwxplxz3Z022g8yQB4P2DyTG51FCfD/3nP46RhyUGcTA/7CZmB3rZuZEBy87ExUxtcE8qy2QD51NzIlxepBDoWhMp8SLCgLT+OsRfSbra5G91vWdR7XkZkQFcPFoMniGKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgVX1mk0os5jZDS7uCbjH+nR5PA+UbdKXO4d8S753tE=;
 b=XlG5zJfXiGp4Y4ZFWEr/9eyRwHHjKbTjYAfZ20C69YopqG6qorW4TCAll/KgjEU8vvqfwN/WPYDbX9FpzvRQhvaFziie+gkHzNfTD+YxZJQm0UGVTFGeq1cxrAY/Ai2xaNzHr025rKeIcmjGgMwu4Rix7dJ+qyoVNcda7hTnHL8=
Received: from BN6PR13CA0065.namprd13.prod.outlook.com (2603:10b6:404:11::27)
 by BY5PR02MB6977.namprd02.prod.outlook.com (2603:10b6:a03:231::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 2 Jul
 2021 11:36:24 +0000
Received: from BN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::69) by BN6PR13CA0065.outlook.office365.com
 (2603:10b6:404:11::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.7 via Frontend
 Transport; Fri, 2 Jul 2021 11:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT015.mail.protection.outlook.com (10.13.2.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Fri, 2 Jul 2021 11:36:24 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Jul 2021 04:36:23 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 2 Jul 2021 04:36:23 -0700
Envelope-to: robh@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 alvaro.gamez@hazent.com,
 linux-kernel@vger.kernel.org,
 s.hauer@pengutronix.de,
 u.kleine-koenig@pengutronix.de,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=42710)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lzHT4-0001ew-V1; Fri, 02 Jul 2021 04:36:23 -0700
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <13c9345f-b3e5-cc97-437b-c342777fcf3c@monstr.eu>
 <7a1e89bc-65fc-76b5-2383-19f0613d0a82@xilinx.com>
 <006fcbf8-d79b-3723-9a9c-03c6350f0a9c@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <4c0c35f6-f009-5dd0-bccb-4d74984f7d0e@xilinx.com>
Date:   Fri, 2 Jul 2021 13:36:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <006fcbf8-d79b-3723-9a9c-03c6350f0a9c@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d99bbc54-cd78-40e5-fdec-08d93d4d9f3a
X-MS-TrafficTypeDiagnostic: BY5PR02MB6977:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6977A8012DBDA9FC371996D8C61F9@BY5PR02MB6977.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKBlMZX5jzupvjw13Rs3QIulHlbn63x83Hjqu+owvK/+BgLxXNTHk/nHly5i8bIqrSgXifpwIrM/ZofcZ3chthugs1erCI6xVe6xrQWiEvEO4Z0Kl0zGyvKUU8fy3qVYlWvm45+JCb+1PQyuFlMLr28ofe8Kzbgfn5QR5eILJs51c/JLANnhAj0p/WoDRRjzWk34lDWJJw3S3EKRClmLZu26YaaqmF0o9Iyj8uhbj8YNKKhE87PJmaz9mJwMWgjLUfZ1UdzVMeEOJLMWqdKQnDMzoDFGLQcN10uGsyAtcmmROmgpFcQF4G3+HGnW8L55Xvd+ATZjL8xA0/ZfaPpm5AZyOTQiQzXu/ZhTrzP74gIj4yKj5NZyWBRwfF2OzPYEzbt3CfanVGrne18JYoXZJGfsK7sh867W1as8pM2ZoDMYSgjYrzFXpOyqTfY38LW6CvliYhhCHtWooFfFRve/bg6oGUKCxfuxjQ6tOPSN4TEpiEGe6vB9PZul4h0x5WJokQLWVcE0ZQfs2miFufzMhOViOi9dMEqOCq7Wc25ANUjz5AmHm6Tk79nBZNvnP27MMpGtS1ww0taQMZ0YyrWx/gWJ9n9zzJsBqwDStb3YYhHkeawFSAp/xcHmGJBrEIGkc8LnkULJ7cVpGATpbrveUnajLVRAwXuFwpqzdD8WBrYtj6M3bJoNMO1BUfcVLmBOJeqNhCmdeiEu3uyAnGbjncFj7YjbRtR0W06ZsurNVLdMgJk5RBTmV08IJiutiNp9pMlo3KzEHax3CBrQgGePRoVYnK12cHgIpvSM5TaZUacewXmhL5H3pab2Wx80/W588LQgbJXbUeWqkGQoM62kBm3BmAJVUX6fxAHV/h9yuH1onBN4OA6cXVHMVCJMYutDGFQ3/U13giZsyq87+2Y7tfAUBcN2eWWbiJbFpWJv4aQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(36840700001)(47076005)(7636003)(478600001)(26005)(9786002)(186003)(4326008)(82740400003)(356005)(966005)(44832011)(83380400001)(36756003)(36906005)(316002)(336012)(54906003)(53546011)(82310400003)(8676002)(5660300002)(31686004)(70206006)(8936002)(31696002)(110136005)(426003)(36860700001)(2906002)(2616005)(70586007)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 11:36:24.1316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d99bbc54-cd78-40e5-fdec-08d93d4d9f3a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6977
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 7/1/21 5:38 PM, Sean Anderson wrote:
> 
> 
> On 6/30/21 9:58 AM, Michal Simek wrote:
>>
>>
>> On 6/30/21 3:47 PM, Michal Simek wrote:
>>>
>>>
>>> On 5/28/21 11:45 PM, Sean Anderson wrote:
>>>> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This
> device is
>>>> a "soft" block, so it has many parameters which would not be
>>>> configurable in most hardware. This binding is usually automatically
>>>> generated by Xilinx's tools, so the names and values of some properties
>>>> must be kept as they are. Replacement properties have been provided for
>>>> new device trees.
>>>>
>>>> Because we need to init timer devices so early in boot, the easiest way
>>>> to configure things is to use a device tree property. For the moment
>>>> this is 'xlnx,pwm', but this could be extended/renamed/etc. in the
>>>> future if these is a need for a generic property.
>>>>
>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>> ---
>>>>
>>>> Changes in v4:
>>>> - Remove references to generate polarity so this can get merged
>>>> - Predicate PWM driver on the presence of #pwm-cells
>>>> - Make some properties optional for clocksource drivers
>>>>
>>>> Changes in v3:
>>>> - Mark all boolean-as-int properties as deprecated
>>>> - Add xlnx,pwm and xlnx,gen?-active-low properties.
>>>> - Make newer replacement properties mutually-exclusive with what they
>>>>   replace
>>>> - Add an example with non-deprecated properties only.
>>>>
>>>> Changes in v2:
>>>> - Use 32-bit addresses for example binding
>>>>
>>>>  .../bindings/pwm/xlnx,axi-timer.yaml          | 85 +++++++++++++++++++
>>>>  1 file changed, 85 insertions(+)
>>>>  create mode 100644
> Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
>>>>
>>>> diff --git
> a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
> b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
>>>> new file mode 100644
>>>> index 000000000000..48a280f96e63
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
>>>
>>> I don't think this is the right location for this.
>>>
>>> I have done some grepping and I think this should be done in a different
>>> way. I pretty much like solution around "ti,omap3430-timer" which is
>>> calling dmtimer_systimer_select_best() and later dmtimer_is_preferred()
>>> which in this case would allow us to get rid of cases which are not
>>> suitable for clocksource and clockevent.
>>>
>>> And there is drivers/pwm/pwm-omap-dmtimer.c which has link to timer
>>> which is providing functions for it's functionality.
>>>
>>> I have also looked at
>>> Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml which is also
>>> the same device.
>>>
>>> And sort of curious if you look at
>>>
> https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v2_0/pg079-axi-timer.pdf
> 
>>> ( Figure 1-1)
>>> that PWM is taking input from generate out 0 and generate out 1 which is
>>> maybe can be modeled is any output and pwm driver can register inputs
>>> for pwm driver.
>>>
>>>
>>>> @@ -0,0 +1,85 @@
>>>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/pwm/xlnx,axi-timer.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Xilinx LogiCORE IP AXI Timer Device Tree Binding
>>>> +
>>>> +maintainers:
>>>> +  - Sean Anderson <sean.anderson@seco.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    oneOf:
>>>> +      - items:
>>>> +         - const: xlnx,axi-timer-2.0
>>
>> I am not quite sure if make sense also to list 2.0 version.
>> There were likely also 1.0 version which is compatible with origin xps
>> version which IIRC was PLB based. And the same driver was using in past
>> with OPB bus.
> 
> It's required to list all compatible properties which may be used in a
> binding. And AFAIK it is good practice to add a new compatible string
> for new releases of an IP, in case incompatibilities are discovered.

I generally agree with this but is it practical right now if we don't
have these incompatibilities.

Right now we have 2.0 but there were 1.03.a/1.02.a/1.01a variants just
for axi. In past there were variants for PLB and OPB.

https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/pg079-axi-timer.pdf
https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_02_a/axi_timer_ds764.pdf
https://japan.xilinx.com/support/documentation/ip_documentation/axi_timer_ds764.pdf

That's not big problem but seem to me not practical to keep updating
bindings docs when new version will be coming just to be listed without
any code behind it. We have that versions which is definitely great that
if something happens we can add it. But listed all combinations? I am
not convinced about it.

Thanks,
Michal
