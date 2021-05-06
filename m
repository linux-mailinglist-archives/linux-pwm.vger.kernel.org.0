Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D53375CA3
	for <lists+linux-pwm@lfdr.de>; Thu,  6 May 2021 23:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhEFVLu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 May 2021 17:11:50 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:29438
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229544AbhEFVLu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 6 May 2021 17:11:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLrHHjHXT+b+cZHUwfPm/4QjrMFsBIQst8dFlLe81r76gZLmAtHuNI5Asj5kx3LB3qbrigJwswlcFMMeSHuiAeaDDryhfauUD7aUcFvHCxoLSIQ9kioEPQypt45rQvaraRAVokAF8A8+gRDVip2ULnW+IfWq2mELIhLo9SUGQb5BenUYxjznaMmYKW6yf7Yhdzsjfygw13mbYyEshDr0Pm2OSuUem4JkJfsqYhfieWmxam9tsWueHkT2YOWgujfo34tIyveEr9diFynzcpiO5Ed+XnppX4DTqzeOFwUWfqgcNkPhBPQF9gai1lp6Y2RiPljoVhbOINcFkm6M6Cq7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5B2mqFNOuBNTXFHP9Ct803l641hZZfjNG1uhVNXojM=;
 b=XVHZlcKrYQt64iWqZRJKxr1vgl/meLYyvFDXbAsZwLnr1svzSmcN/FZoQLGicXeKqbM4sQMPtIDUsXXINBdGxnhmWZSiqve2wqKo0leTq65KInGp5WmrepHrEsKtctmktXROHScMkYiuhejFCQyhQfdtUw+U32PnBgplS7cLmSnlfcSL58cJ1je9LWlwYgmR3NkRlso5p8J7p2QaRQfT0V1RFiPoAkqZH87ZGni9AExoP1aeEfAcP2iBlKwMVUe47ywu6GuKKw4XEUZR371mcov1sCALFbq5wLt2hGWmAmpg0gekodRqM9CahTkLuAEjGEKnAHCA5skxnOAln5sl4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5B2mqFNOuBNTXFHP9Ct803l641hZZfjNG1uhVNXojM=;
 b=DnRd+sPAq1H9LTSm/rXu0uIxmLrWJnHn+TNtYasQvJJ2O4TY4LHdG9yx1pZz6c17ffmroVL9MdDa9EVqqK3zTGmirEgrceX6ZZAnqIXQXlu3/m5/zlBUCI2XWRKPTC15H/NQYA3claps6sbzHVc5JsRQRtgT0VdSC8FuzbUD3tU=
Authentication-Results: hazent.com; dkim=none (message not signed)
 header.d=none;hazent.com; dmarc=none action=none header.from=seco.com;
Received: from AM0PR03MB4514.eurprd03.prod.outlook.com (2603:10a6:208:d0::10)
 by AM0PR03MB5122.eurprd03.prod.outlook.com (2603:10a6:208:10b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Thu, 6 May
 2021 21:10:48 +0000
Received: from AM0PR03MB4514.eurprd03.prod.outlook.com
 ([fe80::4986:3655:d3b5:b3d2]) by AM0PR03MB4514.eurprd03.prod.outlook.com
 ([fe80::4986:3655:d3b5:b3d2%5]) with mapi id 15.20.4087.044; Thu, 6 May 2021
 21:10:47 +0000
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>
References: <20210504184925.3399934-1-sean.anderson@seco.com>
 <20210506210527.GA789155@robh.at.kernel.org>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <b736d78f-4eaa-1057-71bf-02c3b44ec51e@seco.com>
Date:   Thu, 6 May 2021 17:10:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210506210527.GA789155@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::25) To AM0PR03MB4514.eurprd03.prod.outlook.com
 (2603:10a6:208:d0::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0110.namprd13.prod.outlook.com (2603:10b6:208:2b9::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.28 via Frontend Transport; Thu, 6 May 2021 21:10:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a4890b6-4152-4f94-d098-08d910d36b7e
X-MS-TrafficTypeDiagnostic: AM0PR03MB5122:
X-Microsoft-Antispam-PRVS: <AM0PR03MB5122473A0771BB322B4675B296589@AM0PR03MB5122.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bCMTnDRIuGjR0YkqwvgDtY+goiSfUksmDiL1oD0neWoaGu8/ssnK5oqO9lSFUtxc+1JL9c5mJdS0gEg1OSKb7OMlnWv1ggIf8ZCu9aHNe8nDi5RzHfh+a1U4mUVNVGWA8noaphhGbsG/OoSvcIjyo9OODAHmceG5WdqCqIcgTd9LKIrVObIv+56Y3I5egJibw7Sm5BzAthM4SNFKKCPn3Kfs92Y6M1g9kU5x/RS3NpscfnQ0B6d1tvBrn8IA6M6VvwYvx6u+T5drfjATLccZqEUdNzEKltAcofC63rf5ePnZ1mxLRQy0gVKcaTmg7GVD6eqBq5wT+srXZBi3HgDWgiYmYRGilI5IfHziEH0JWdZN3wcnmWhZLqZz6H12dU57o5xQ/6y6R8s5t0gbE7FtUb2EvvRTKFs1+7e4D87j5ydUtPmVoN4xH5aHQxornyrimctRBS/wpb8ZLhLJDX3KWgiw/Q5Emo7SaKjlwJY/JDo2bTF389wKIzrTv+fIPnCUpOjvzSgrzsQbL5q6hMHXaedNVx2eK2mEOIakPrTX0v1QOcZdgAjuhm0NoxD9awv8sjr6Jh6wAcxtn7sO4+Gecpt3KUwvlgmdhqTmCWlmX91U9YZhmOVyNX2aiuM0YM3p7T2WqFL8e0ypTN6gL0RC02qNCZto55l6J8dME5flVJpPZONbxGfGqcObZM2IMw9VBjP2uJl//vXHcslMrAS3eTDDoiDBgbt5MJujddaI0X7KrQTTbAa3U48HkX1Kcv4mdPn8uEG5PYvEPOh+gZYtZm48lFvGXWYgf6WstK+FUKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR03MB4514.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(346002)(376002)(136003)(396003)(366004)(16526019)(186003)(2906002)(478600001)(966005)(8676002)(31696002)(38100700002)(5660300002)(6486002)(31686004)(956004)(38350700002)(44832011)(52116002)(26005)(66946007)(316002)(16576012)(6916009)(66476007)(6666004)(83380400001)(66556008)(53546011)(86362001)(36756003)(4326008)(2616005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OUZxTzRvTmIrOWN4NmFSbTF1SkgzUzZpUmIzb05LT2JQQ2xYaGk0SVEyU0tY?=
 =?utf-8?B?QVEvbVMvR0dxZ3NHbWZFRFpSR1JoanRzMzk5Q2ptOUFZQ09kZ1VpbjJDWFEz?=
 =?utf-8?B?VzBOSnBhZ2sxOTV4ejh2S3ZFOXRiQ1BMSmZTQTJNUHFSU3ZpSTlnTU5CQ0ZF?=
 =?utf-8?B?bThvemJTL21BcVh6WGUyeVlaT3dxdkt4VWpDcmgxVFBBeUdrZ1JWN1hIRUE5?=
 =?utf-8?B?TkhNeURJY2J6bGY4S2Y0eFhnd1MyMHZoRzJwK3V2TFduMlZLWk1aVUE2MEFO?=
 =?utf-8?B?L1ZCeHp6Rkp4Y29lVzNXU3hrZGpqTGo3SGpWSkFrcGkyYlZQT1FvZ3l0OVV5?=
 =?utf-8?B?eTZxbVd0Y0NSeVg2NnJ4K2VVb3E5cFhVQjYwN0YydWNxRGxmb1N4WEJacVZP?=
 =?utf-8?B?cGtlV0E0MDBvaGwzR21YM2tkNFhFUGtrSjdIcGJWVlh5L3E1dmFvUDlZd1Fr?=
 =?utf-8?B?Z0JnZVpFS0p3ekJLR1JNWWxPeDgrYS9JOURQNnR5TjBySE5hQjBZeHl1NElh?=
 =?utf-8?B?VFB2SStibDc0OXVCSUg4MUxHQ2ltQjNtdEZZM2lQT3NIc0dmRE5jemtvNzBQ?=
 =?utf-8?B?UFJISzNFQlUzWStXNy94VEtiODRQczZuUlY0SEVkN1dUWVI5Q1Qxc2FGUDZt?=
 =?utf-8?B?VGFQci80TytuL3BUdTdSS255ZUFrejFkZG5HY3I4cmJvazZBZzY4QUhRQ1RU?=
 =?utf-8?B?a3RmR0tKU2dBdGd3Yis5VWF6eHovM2NRclA1Z3JGdE0yamkxbkg2T1pmbU9S?=
 =?utf-8?B?dTFQczkvQVNlSVYyaFE3L0xRR1p5eTZVYXVWNmpPQ1MwT1RzMXV1RkVZcVR1?=
 =?utf-8?B?OE9keUNNdDZWQ2grNXhodXlUcThkaVY2RGRXNmNNdE5ocmVuc1VNQ2M0SEhG?=
 =?utf-8?B?ZmdORmp1ZGkzZzFGOEFwQmExU0YwU3ZrK2prWklRdEhRc05GRTVURHI5MHNV?=
 =?utf-8?B?YW9wSzhzOU90bmlvblpSa2RIb3BVWUdwMytnM1RDNG9Gc1MyeUhvTDRyQk1t?=
 =?utf-8?B?YlhjRGlLS3ViZW8zYnBOYlpuS0puNW5XV2FjUHdGSWRoT0IrVVBaN1AwVTBi?=
 =?utf-8?B?cDRucXM4VXJEUmpyVVphQUdBZUpIcEZPTUlPZUw5RWp3RzBCWFI3VHh1THJQ?=
 =?utf-8?B?RHpQWDROY1ZFOWc1MTl5bnRPU1hpZDc1UkZXenFkQTVZNENBc0lLeWVmWk1G?=
 =?utf-8?B?SGhzZThhcGFZM0ZBbWM1L0Rrci85QnMrb2dtcVhOU05xRXJPTGJERWRrNjZn?=
 =?utf-8?B?eUxBN0Q1NFAvaGZoWDlCRlJSditJa1Y0aFFXdm5NS2llRUxOQWp1Zk9Zb25s?=
 =?utf-8?B?YktpV3JGemVLTlZzRVM0S1k0cG1XTUFIejI2MU85MURuQTZBb3lFWVVKNU9S?=
 =?utf-8?B?elJmc0ZJbFhtR0d1WlBNUjVrWkNYaEFPQkRWdnZjMUs4WExWQ2pZRGNMS053?=
 =?utf-8?B?MkNkdjVkVS9oZDBUeFZienpOclJteXo5T0JrTUxEb0RtcmVhalp6Q2JVOFBw?=
 =?utf-8?B?aGVQSFRZKzhkZmFsT0R6azRkbGgxMTNIVVgxNlQ3aEhZUDBrNUdpUUI3Wnhx?=
 =?utf-8?B?VHpwMFB1Z25ZdFlyQ0N3ZFRsRm05T0lldXpQTmpGUHdEbmE4YWpiWGl4Mlgz?=
 =?utf-8?B?NTQydDd2Z3ZDOXpsMHVYQ2E5cXhURmZwUXI3dkdndklaY2V1MXNGbW9JcDNm?=
 =?utf-8?B?OHJzKzhUZGc2dHY3U3ZubUlUY0IxOTJ3QmpETlYwL1Z4SzBTSDN4ampkeC9q?=
 =?utf-8?Q?yslhE0WRDu4OLlBqxwrcIysd0AoambcFQR+ZZV4?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4890b6-4152-4f94-d098-08d910d36b7e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB4514.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 21:10:47.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OdXrRmnUXwOOp0ce1zH4S4OqKLS3Vsr9J4oxqw4sh3OngDzGyCEwr7JGVh3nY1VmiJh61IS/y5vl/VemTA//A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB5122
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/6/21 5:05 PM, Rob Herring wrote:
 > On Tue, May 04, 2021 at 02:49:24PM -0400, Sean Anderson wrote:
 >> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
 >> a "soft" block, so it has many parameters which would not be
 >> configurable in most hardware. This binding is usually automatically
 >> generated by Xilinx's tools, so the names and values of properties
 >> must be kept as they are.
 >>
 >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >> ---
 >>
 >> Changes in v2:
 >> - Use 32-bit addresses for example binding
 >>
 >>   .../bindings/pwm/xlnx,axi-timer.yaml          | 91 +++++++++++++++++++
 >>   1 file changed, 91 insertions(+)
 >>   create mode 100644 Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >>
 >> diff --git a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >> new file mode 100644
 >> index 000000000000..bd014134c322
 >> --- /dev/null
 >> +++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >> @@ -0,0 +1,91 @@
 >> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 >> +%YAML 1.2
 >> +---
 >> +$id: http://devicetree.org/schemas/pwm/xlnx,axi-timer.yaml#
 >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
 >> +
 >> +title: Xilinx LogiCORE IP AXI Timer Device Tree Binding
 >> +
 >> +maintainers:
 >> +  - Sean Anderson <sean.anderson@seco.com>
 >> +
 >> +properties:
 >> +  compatible:
 >> +    items:
 >> +      - const: xlnx,axi-timer-2.0
 >> +      - const: xlnx,xps-timer-1.00.a
 >> +
 >> +  clocks:
 >> +    maxItems: 1
 >> +
 >> +  clock-names:
 >> +    const: s_axi_aclk
 >> +
 >> +  reg:
 >> +    maxItems: 1
 >> +
 >> +  xlnx,count-width:
 >> +    $ref: /schemas/types.yaml#/definitions/uint32
 >> +    minimum: 8
 >> +    maximum: 32
 >> +    description:
 >> +      The width of the counters, in bits.
 >> +
 >> +  xlnx,gen0-assert:
 >> +    $ref: /schemas/types.yaml#/definitions/uint32
 >> +    enum: [ 0, 1 ]
 >> +    description:
 >> +      The polarity of the generateout0 signal. 0 for active-low, 1 for active-high.
 >> +
 >> +  xlnx,gen1-assert:
 >> +    $ref: /schemas/types.yaml#/definitions/uint32
 >> +    enum: [ 0, 1 ]
 >> +    description:
 >> +      The polarity of the generateout1 signal. 0 for active-low, 1 for active-high.
 >> +
 >> +  xlnx,one-timer-only:
 >> +    $ref: /schemas/types.yaml#/definitions/uint32
 >> +    enum: [ 0, 1 ]
 >> +    description:
 >> +      Whether only one timer is present in this block.
 >> +
 >> +  xlnx,trig0-assert:
 >> +    $ref: /schemas/types.yaml#/definitions/uint32
 >> +    enum: [ 0, 1 ]
 >> +    description:
 >> +      The polarity of the capturetrig0 signal. 0 for active-low, 1 for active-high.
 >> +
 >> +  xlnx,trig1-assert:
 >> +    $ref: /schemas/types.yaml#/definitions/uint32
 >> +    enum: [ 0, 1 ]
 >> +    description:
 >> +      The polarity of the capturetrig1 signal. 0 for active-low, 1 for active-high.
 >
 > Can't all these be boolean?

They could, but

 > This binding is usually automatically generated by Xilinx's tools, so
 > the names and values of properties must be kept as they are.

Because this is a soft device, the binding may be (very conveniently)
auto-generated. I am not opposed to adding additional properties which
could be used by new code, but we should still accept this auto-generated
output.

--Sean

 >
 >> +
 >> +required:
 >> +  - compatible
 >> +  - clocks
 >> +  - reg
 >> +  - xlnx,count-width
 >> +  - xlnx,gen0-assert
 >> +  - xlnx,gen1-assert
 >> +  - xlnx,one-timer-only
 >> +  - xlnx,trig0-assert
 >> +  - xlnx,trig1-assert
 >> +
 >> +additionalProperties: true
 >> +
 >> +examples:
 >> +  - |
 >> +    axi_timer_0: timer@800e0000 {
 >> +        clock-frequency = <99999001>;
 >> +        clock-names = "s_axi_aclk";
 >> +        clocks = <&zynqmp_clk 71>;
 >> +        compatible = "xlnx,axi-timer-2.0", "xlnx,xps-timer-1.00.a";
 >> +        reg = <0x800e0000 0x10000>;
 >> +        xlnx,count-width = <0x20>;
 >> +        xlnx,gen0-assert = <0x1>;
 >> +        xlnx,gen1-assert = <0x1>;
 >> +        xlnx,one-timer-only = <0x0>;
 >> +        xlnx,trig0-assert = <0x1>;
 >> +        xlnx,trig1-assert = <0x1>;
 >> +    };
 >> --
 >> 2.25.1
 >>
