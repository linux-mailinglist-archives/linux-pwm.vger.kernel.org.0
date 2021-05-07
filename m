Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DF7376072
	for <lists+linux-pwm@lfdr.de>; Fri,  7 May 2021 08:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhEGGgx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 May 2021 02:36:53 -0400
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:13024
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231263AbhEGGgw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 7 May 2021 02:36:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYydbPvJoKyftEPBPotX80tzs6JJ7MkYLfMReDdybzmRasjnTFt+yICMCIIrtiRMx8uRCpSCilao4Xef/EvPjjErr14R52hnD8DGSg1FziwlP5fEZb6wde4X+2ymdnmeRQ4HwY54ozUqNb68V+lC3f4Ks/oJDXCb0zx/VNToG5OiwkVbsBKpbbToyCSBdL/jPXk0EctOnX1Iia4y+ORT8xly8TNhy8Fx0WxVol31l2vIQnpQ6Bmnd2pPb603tufQnHiUdikbF5v3APTlexYDjsKGUPqumjMGVnC8c8Za4Dg8P/3Rk3eiIUXnBZkHAk4MRjycGf2bK5s8i1O0vMIIng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMMlV6sW7W6SS3KLLyX0pD6pTu9NbLGjxhalxaN4gk8=;
 b=JEx6MExQF+jH0CgmHemllGNSyUjk2ulGTnFTGKxhQZAMCJ18J6JcVNbH2zwNVVz/e5+IU98VVxnuTw7yESwH2K/qqEfaK4alrTI4LfnOJMjROGIrdZcVBVbFfdZDjAM6GJOKM/fyYNt5eREpeyeuQp95Y+wf5gbwmnsEk7BXzEuzvvKp6E1jwq+eQwcU6mdl+xWFrZc6Y7xlPrB8rGsJ2JJHczDHJ0gH2Koqb7uuWA7N1pWSx9ekdRdoAitDa4ORCWrLAoncOhTMdcNt80Il07eOP5QYNcBGW+LwqF0TVLRZsN2FPP1IAe5u9MfSs9kZKyGrEvlOjp6QVHkLNo7AbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=hazent.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMMlV6sW7W6SS3KLLyX0pD6pTu9NbLGjxhalxaN4gk8=;
 b=JFmHmgS9sRBfJeplZjg98m3RpDyuhhWWnus7vissDz236JWDgL5sn2eHaVWDPX7+UDD+KOuM2zizcY+dUZ/2H08vjojs6PrnKlFRfiUP5J+A/d//eg8uNSrdtPNAlz9ol/7M0KMUnLyPG1dcP9TnEKd//ydI11vuCyFodgHxZw0=
Received: from DS7PR03CA0178.namprd03.prod.outlook.com (2603:10b6:5:3b2::33)
 by BL0PR02MB4467.namprd02.prod.outlook.com (2603:10b6:208:48::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 06:35:51 +0000
Received: from DM3NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::a5) by DS7PR03CA0178.outlook.office365.com
 (2603:10b6:5:3b2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Fri, 7 May 2021 06:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; hazent.com; dkim=none (message not signed)
 header.d=none;hazent.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT026.mail.protection.outlook.com (10.13.5.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 7 May 2021 06:35:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 6 May 2021 23:35:50 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 6 May 2021 23:35:50 -0700
Envelope-to: alvaro.gamez@hazent.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 robh@kernel.org,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=38944)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1leu5V-0001KM-UL; Thu, 06 May 2021 23:35:50 -0700
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        Alvaro Gamez <alvaro.gamez@hazent.com>
References: <20210504184925.3399934-1-sean.anderson@seco.com>
 <20210506210527.GA789155@robh.at.kernel.org>
 <b736d78f-4eaa-1057-71bf-02c3b44ec51e@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <eb3a9e61-c474-696f-4d81-e655ce058082@xilinx.com>
Date:   Fri, 7 May 2021 08:35:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b736d78f-4eaa-1057-71bf-02c3b44ec51e@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6aab2917-864c-45bb-1613-08d911225b60
X-MS-TrafficTypeDiagnostic: BL0PR02MB4467:
X-Microsoft-Antispam-PRVS: <BL0PR02MB44677CD55AE3EC82E5B71616C6579@BL0PR02MB4467.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecOIzo1x995njpKYbhYKNRhTJkspFuyhayaZOa8MT6bkIAzaCy3kSk0k/9U5DbQxF9fEEDm0uPa6YeAwviOVmpguUUw+1cRoqwsfjxHCEPFMRH06TMXuN0NEoDzLVR8bLdmtFSiWxwesk8j0WT+ZUhaMisTP7BrOPG/gY/55UJUdbIavl+e7/uVyVePX340vdTKABV3yECIHF295ytLBFF2gTFDYsEv4G8kot8YSbTxWckuCA+nWN4omLL8QpmipEJbOUPZlcmNgG6Yf6LYpZRN9Bb4C4SPKf+enzmJ46zXgTEw78wKs59YC46fYb6Sv3Jj8yerqHQCl2KNwySnslbTaGif0Kcf6EiKpeSZ2lW3MSNHNnWXdt4gik7MYAXVwnBiw0sg+S3CyGQntdAdY4/+1Zlz4ijLKWuvRFFfB0TD1th0LDYa4TtTZkubr9zj/JFVVB2RW8/oI1KkpVuB6RnAZtL72vpw17gVKynr4N9qpD5RVZXnzz/1C1ZSracmxcs3SS9LAKnyLcdnKqF5dHmk45BiZ7COuUPS5HVbA3rc1L7BTpTDDNI0JC5sEOFQZWueVEF6g7EVcadeZ2akeDH4UL4j+fdwFClr2JcZzH2oVC0wsCyGKlENbcPqnjIM2RmDF+Pz7wUOCXbb+7NH4Hdcl7yFUqCLFmx5RYKVSKG93Ch1icV4VTyrALGtgHbGxPqgpnpI0pIbZ/8YfkcNsd7fhqyKizcdxv1olf02xMf6uAvdQsUzSuNBH0NTDTNgCtkiCaxt6cwXnY4/KrAI6h6WcdpcwM6d6quQra0hW/A8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966006)(36840700001)(478600001)(4326008)(6666004)(2906002)(2616005)(31686004)(70206006)(44832011)(47076005)(70586007)(336012)(82310400003)(36860700001)(83380400001)(53546011)(26005)(186003)(36906005)(110136005)(9786002)(36756003)(54906003)(966005)(5660300002)(8676002)(356005)(7636003)(82740400003)(316002)(31696002)(426003)(8936002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 06:35:50.8310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aab2917-864c-45bb-1613-08d911225b60
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4467
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/6/21 11:10 PM, Sean Anderson wrote:
> 
> 
> On 5/6/21 5:05 PM, Rob Herring wrote:
>> On Tue, May 04, 2021 at 02:49:24PM -0400, Sean Anderson wrote:
>>> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
>>> a "soft" block, so it has many parameters which would not be
>>> configurable in most hardware. This binding is usually automatically
>>> generated by Xilinx's tools, so the names and values of properties
>>> must be kept as they are.
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>> ---
>>>
>>> Changes in v2:
>>> - Use 32-bit addresses for example binding
>>>
>>>   .../bindings/pwm/xlnx,axi-timer.yaml          | 91 +++++++++++++++++++
>>>   1 file changed, 91 insertions(+)
>>>   create mode 100644
> Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
>>>
>>> diff --git
> a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
> b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
>>> new file mode 100644
>>> index 000000000000..bd014134c322
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
>>> @@ -0,0 +1,91 @@
>>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pwm/xlnx,axi-timer.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Xilinx LogiCORE IP AXI Timer Device Tree Binding
>>> +
>>> +maintainers:
>>> +  - Sean Anderson <sean.anderson@seco.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - const: xlnx,axi-timer-2.0
>>> +      - const: xlnx,xps-timer-1.00.a
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    const: s_axi_aclk
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  xlnx,count-width:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    minimum: 8
>>> +    maximum: 32
>>> +    description:
>>> +      The width of the counters, in bits.
>>> +
>>> +  xlnx,gen0-assert:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [ 0, 1 ]
>>> +    description:
>>> +      The polarity of the generateout0 signal. 0 for active-low, 1
> for active-high.
>>> +
>>> +  xlnx,gen1-assert:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [ 0, 1 ]
>>> +    description:
>>> +      The polarity of the generateout1 signal. 0 for active-low, 1
> for active-high.
>>> +
>>> +  xlnx,one-timer-only:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [ 0, 1 ]
>>> +    description:
>>> +      Whether only one timer is present in this block.
>>> +
>>> +  xlnx,trig0-assert:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [ 0, 1 ]
>>> +    description:
>>> +      The polarity of the capturetrig0 signal. 0 for active-low, 1
> for active-high.
>>> +
>>> +  xlnx,trig1-assert:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [ 0, 1 ]
>>> +    description:
>>> +      The polarity of the capturetrig1 signal. 0 for active-low, 1
> for active-high.
>>
>> Can't all these be boolean?
> 
> They could, but
> 
>> This binding is usually automatically generated by Xilinx's tools, so
>> the names and values of properties must be kept as they are.
> 
> Because this is a soft device, the binding may be (very conveniently)
> auto-generated. I am not opposed to adding additional properties which
> could be used by new code, but we should still accept this auto-generated
> output.

I think in this case you should described what it is used by current
driver in Microblaze and these options are required. The rest are by
design optional.
If you want to change them to different value then current binding
should be deprecated and have any transition time with code alignment.

Thanks,
Michal

