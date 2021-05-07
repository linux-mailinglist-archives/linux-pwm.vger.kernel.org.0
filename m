Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C76A376701
	for <lists+linux-pwm@lfdr.de>; Fri,  7 May 2021 16:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbhEGOZX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 May 2021 10:25:23 -0400
Received: from mail-db8eur05on2059.outbound.protection.outlook.com ([40.107.20.59]:55392
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235948AbhEGOZW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 7 May 2021 10:25:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dacbkEj7I7U4FvF/PPxh+FnLotu+WHDQQZYB7le7t1kqkCgWa5ZinmFwhnOscYPqVy0oHpsjnFJeMBDMqpfYA3agcWNoJIg2TwhCGHFfP5/LuGJqOAUnvj8+h4DrO3f4kaxGKRsKEOo2D+36C1ZDBSjbb0hyEePLFuaJp1q9Pi3Rx4ueDm0HZq7Jf+73d8VGpt1/znK9JiqfDbNQIzvHhwRJ+vPU62RQmlYUmltRZoMhdSQL8Eq5P8K9RWVJLRKiIzDvBmdIYYclnLFL88a27vmOLmvEo3QUqA11w7kxrPOeRS7edRMhzYuwWFC/lJFIYT7RrUscJlq9LWtvVwmVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLl3eTyIefKaLhbY5MnBhLlscsmIy37090nWeKSvhGA=;
 b=eVsTFJsfZ6BSvXU5pcMYSrpIHlu83ZVOlbRq96cp+V04wf7tVxa0ZIvbCoYxQZLa7t74NiXS5n3qJ5V5X/Q4rM3xtKa7yCCBRvE4eIgq3KnApAsY7JABHikliwcc5APtP19xPu6hfqs0eSkFJ3H3Rb1AVZGkQU7gdYqZBat3QqrTvgCRnFpT8qN1teHFSwh7OIIniVD5H31flR/BmG1+IDTS7BFOd4+DRtJ5kNHmw/fxWll33vYUaV02gWrVEnofnN86pw3WW+PiU6Q579FcuH165DeWN2MSfdwtA3kE27r5OoQuT2NsiU12tW7pdQjgpALU3wFcoI8v/VxQZBHUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLl3eTyIefKaLhbY5MnBhLlscsmIy37090nWeKSvhGA=;
 b=IW9jz6PR4ZnJBpqBLVs/jfd4lhYh90ZuHKcdkJjrSU1QK5WgVMiLGjdb4Ybfk+TPOixpCXTlp2RtdciXqZpzC5+rPZFfEr6mdaJw12mOPcrPrZp5pyzcRlgxpE9Z1nCjfQe9RejYy4yNrj8nJsf0FBS082UvveA5XdaoGnkU+TE=
Authentication-Results: hazent.com; dkim=none (message not signed)
 header.d=none;hazent.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB7129.eurprd03.prod.outlook.com (2603:10a6:10:206::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Fri, 7 May
 2021 14:24:20 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 14:24:20 +0000
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>
References: <20210504184925.3399934-1-sean.anderson@seco.com>
 <20210506210527.GA789155@robh.at.kernel.org>
 <b736d78f-4eaa-1057-71bf-02c3b44ec51e@seco.com>
 <eb3a9e61-c474-696f-4d81-e655ce058082@xilinx.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <11026a90-96e7-906d-a6d4-b3387fdd9b58@seco.com>
Date:   Fri, 7 May 2021 10:24:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <eb3a9e61-c474-696f-4d81-e655ce058082@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1PR13CA0379.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::24) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0379.namprd13.prod.outlook.com (2603:10b6:208:2c0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend Transport; Fri, 7 May 2021 14:24:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccf1140b-af33-4de1-606c-08d91163cda1
X-MS-TrafficTypeDiagnostic: DBBPR03MB7129:
X-Microsoft-Antispam-PRVS: <DBBPR03MB712923E8182C06C9E72D061296579@DBBPR03MB7129.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMNldnWHPC9oJbGwFBIEb7+6k4fFevROPXbss2gyaTQrN7Xf/iXXi/4JGUS2bWguJMaLcjtwucRh7gh/kYo2W6LGbUE4vN2JgQK9MwBtCHdQ4PRxeoIxJSrtylSt8bThOUs1S1w1BmiufSFFHeaDzV/euj8tXBg64d7JwkZMIMnJIWQ44ldXMFTG8XW3MfP4Vwo42XE9ZapxVWEC7BzmqalVr9SNTU/dVgrX0VDYTWKygx0aO9lwdMAm595TUhFm2HTR0kUBFGlcFc7UmKyKorkNf9CU6hrC0anDrR5AWGG3S6/FB8EoQ8BqlciLMYzkEjuxcwen61JBkCbGO/BVAhvMjQhG5+FwIykwO/Qqj102aQQse/0BwyUFdRs7eO4pjcIydctTOPE3+PoMNbCELDHacktTd9WzCmTTz+08a9I1oz6csUKrDa5j+a7C0gMwyLuPS8T4v25dAg3XeIRX3wrjO5aMzHCr6BrPpzdiT8fHgp/bi2ZmEpIQBJ7VWTvnSi0ydMBj2xV7QhBifSVSvCDPovZ9tt7LPdT+nGQjjIB3Sng41sawnyiGWHEttXESxyNqXMMReWE9DPrRpuNL17FMilC15JmQgVvxUy+zWVnPTW4FhzdqNGlc8JgzV1s5lwdtqYZX/5KBPWtiy3drQXPT8YHJGBCtkQ3PhnriOS1T6LKN3lJqIe4lX/4fRrS68vaCHmOGq2dcYaZmYjCOSyewfltALdEvcPlfsaNaR8tQv1oPAtB5ydes2S4T5RMksUxSc/1bbeomuLd/uLzn7IdyhJSinR6DpgXpuuva9XI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39850400004)(376002)(346002)(86362001)(16576012)(6486002)(5660300002)(36756003)(83380400001)(316002)(66946007)(52116002)(6666004)(2906002)(110136005)(16526019)(31696002)(38100700002)(186003)(956004)(8676002)(2616005)(38350700002)(66476007)(8936002)(66556008)(966005)(26005)(31686004)(4326008)(44832011)(53546011)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZWFONUllOWtCVHNlcURlNC9GUG50bnNpV1J6R1FLTmZYS2tQa1Nhc1pvbXhL?=
 =?utf-8?B?MEJrV2RqandwTjJmYUhROGZtbXROcFNmdnFnL3NGdWg3RW50K0NSWlV5c2E3?=
 =?utf-8?B?L0RNd0dnWUVxMmVCbGgvZEJsWURxTmVoN1JTeXJOTHA1K21ZcWNCUmJ4U3Bo?=
 =?utf-8?B?NWFsV21JbURTa2RGWE16YThpcFR4dGRxZFQyN09FQmZnV3R0cERVNWNrdVJH?=
 =?utf-8?B?cDhOMXl5UVRBZksrVVc5QTgvdFdxK25sL0prUEtWaTFRWTh2V2liNmNCVnlp?=
 =?utf-8?B?VTI2RGdjUExQeDlPWkJPdG1Wb01mVlZ0bEdNODdTaitTdmRLZWpobFo2Zzhx?=
 =?utf-8?B?ZElGMUxseWE2VWlDK2ZodnJ6MUNFL0ozbE1JWGFlZGZNZWpxdGxZYlBDbmlI?=
 =?utf-8?B?dVhBSEpQL0t2MDA0UGpPTUhCTk1JT0VLUjd2ajBXRnE5S2RXTGc1OVI4b0w1?=
 =?utf-8?B?S0hNTWV1dEo5VjZPbVkrWVJnS01UTElySVVGa2Exc2FaOGVybUgzRWV0ay95?=
 =?utf-8?B?ZWhkYU1zdlEvcmpWeXdhWmVjZ2VnRUE0YjFxN1dWbkx1ckFSVDFuSDc1NjRn?=
 =?utf-8?B?VnRuU29yUHlHdFY3MUZOS3lvYkt1RkNXVTgyYXc2Tno3MVZCcGJwR3hzUUlx?=
 =?utf-8?B?UVNVakQ3bVBUZHNqS0JoK1hiMzFmaldQN0JBZk4zOXF0VEcyMGRyNjQrdTdH?=
 =?utf-8?B?M3plMUFiUzhYQndJVnFuWE9MSVRFSDdUR1BFMU55OFVDZEtXMUY2YjY3MjJM?=
 =?utf-8?B?R1JHWGZIaU1aVE1iYUFHc0ovcXhsYXJzbDdnUTFTU1FTQlM3M1lMejdmZ01D?=
 =?utf-8?B?RElGdFQ3a2lyQU9SL3pXUFJ6ZGNMZE5vcE5lT2p1YkpRK3c5SnpqODg1MlFh?=
 =?utf-8?B?YnN4MlM0Vkh3WmU5S3ZyNytxRFVwMEljMzN3dXVOdXd4TzB5WFhVUWF4b1V1?=
 =?utf-8?B?QzJJWi96QzNCWURXTzVxRkdJS3FjUUNpbGdVNGFDS3U0Z2dhbXFtS0JDaGI0?=
 =?utf-8?B?Y2t1R2tMR2N0b3hjakhXOC9pc2pSZEw0OU4rZndHSHRvbnRGdkw0YllYRVkr?=
 =?utf-8?B?bzIrSmY1UlFCOVVieUpOSzlwUC9DZU94UlB5UGVVOFJiQ1Q4cDhkMVk4SUt2?=
 =?utf-8?B?Y1JaUHJzWEMwMmpvZ1VMR3grbVV1R1AydGpyd05UaFA1ZEx5cXRNaTNBQ1VI?=
 =?utf-8?B?UjNDZFBHcXdwVmlHRmIvaHo3bVZuSFcvcG5qS0FaU1MvaXlmSE1ncGFWbXp3?=
 =?utf-8?B?OEJoc3JQQ2tOS2orUXRBajZUbHNIUE5EYUx5NlBMQ01zWUtkTDFkZmZmeWNL?=
 =?utf-8?B?RFk5UFM3bFFxVWhiYmxUK2E0aEFubmswakF5UnFLSmU0Q0ZSM1lScWhrd1hV?=
 =?utf-8?B?QWFpVWhOb1MrWlRjY2FRWkdNbXdvRFNMWXBQdisyb1RYN3k2dnNUVHlSWDhI?=
 =?utf-8?B?Z2pNWkhkaHAzanJkZEVxcnBKZ3hiZEVlS2NjZ050eWFGNkphc1pGVngzZzIv?=
 =?utf-8?B?ZDZLVm56VGdGYk5Bamt4WlhGOTY0SE5aelMxUmpjbDBDUVVuRWhSZ3pkVDM5?=
 =?utf-8?B?b1dGbFlmSWY5bkdBT2JFYlowYnpjakxaQmNINnhxeUxyTW5KNDc0ZUNhQWRw?=
 =?utf-8?B?RXU2alovNVUvbTBieDRQc1RGb1BaQ0ZqZWt5dWFvTS9BUFc0bllBZU9xRS9W?=
 =?utf-8?B?R0xVVGdvRk80SUV1c21aVzhEd0Q5NHhtVHd4WS9MQk5nN2hSbW5WcHowekNG?=
 =?utf-8?Q?u/LyZaubKIWNBpoeqyRiQf6z7c22AIVK+CmrjRF?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf1140b-af33-4de1-606c-08d91163cda1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 14:24:20.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfr52LR81MYzBeQ3vz9+0jYFh6zLbTPqnMXJ1ZIVs402BtbjZQSLeNtE7H0vqtfZ1fx84huVfWoOpYXgqKr6uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7129
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/7/21 2:35 AM, Michal Simek wrote:
 >
 >
 > On 5/6/21 11:10 PM, Sean Anderson wrote:
 >>
 >>
 >> On 5/6/21 5:05 PM, Rob Herring wrote:
 >>> On Tue, May 04, 2021 at 02:49:24PM -0400, Sean Anderson wrote:
 >>>> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
 >>>> a "soft" block, so it has many parameters which would not be
 >>>> configurable in most hardware. This binding is usually automatically
 >>>> generated by Xilinx's tools, so the names and values of properties
 >>>> must be kept as they are.
 >>>>
 >>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >>>> ---
 >>>>
 >>>> Changes in v2:
 >>>> - Use 32-bit addresses for example binding
 >>>>
 >>>>     .../bindings/pwm/xlnx,axi-timer.yaml          | 91 +++++++++++++++++++
 >>>>     1 file changed, 91 insertions(+)
 >>>>     create mode 100644
 >> Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >>>>
 >>>> diff --git
 >> a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >> b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >>>> new file mode 100644
 >>>> index 000000000000..bd014134c322
 >>>> --- /dev/null
 >>>> +++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >>>> @@ -0,0 +1,91 @@
 >>>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 >>>> +%YAML 1.2
 >>>> +---
 >>>> +$id: http://devicetree.org/schemas/pwm/xlnx,axi-timer.yaml#
 >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
 >>>> +
 >>>> +title: Xilinx LogiCORE IP AXI Timer Device Tree Binding
 >>>> +
 >>>> +maintainers:
 >>>> +  - Sean Anderson <sean.anderson@seco.com>
 >>>> +
 >>>> +properties:
 >>>> +  compatible:
 >>>> +    items:
 >>>> +      - const: xlnx,axi-timer-2.0
 >>>> +      - const: xlnx,xps-timer-1.00.a
 >>>> +
 >>>> +  clocks:
 >>>> +    maxItems: 1
 >>>> +
 >>>> +  clock-names:
 >>>> +    const: s_axi_aclk
 >>>> +
 >>>> +  reg:
 >>>> +    maxItems: 1
 >>>> +
 >>>> +  xlnx,count-width:
 >>>> +    $ref: /schemas/types.yaml#/definitions/uint32
 >>>> +    minimum: 8
 >>>> +    maximum: 32
 >>>> +    description:
 >>>> +      The width of the counters, in bits.
 >>>> +
 >>>> +  xlnx,gen0-assert:
 >>>> +    $ref: /schemas/types.yaml#/definitions/uint32
 >>>> +    enum: [ 0, 1 ]
 >>>> +    description:
 >>>> +      The polarity of the generateout0 signal. 0 for active-low, 1
 >> for active-high.
 >>>> +
 >>>> +  xlnx,gen1-assert:
 >>>> +    $ref: /schemas/types.yaml#/definitions/uint32
 >>>> +    enum: [ 0, 1 ]
 >>>> +    description:
 >>>> +      The polarity of the generateout1 signal. 0 for active-low, 1
 >> for active-high.
 >>>> +
 >>>> +  xlnx,one-timer-only:
 >>>> +    $ref: /schemas/types.yaml#/definitions/uint32
 >>>> +    enum: [ 0, 1 ]
 >>>> +    description:
 >>>> +      Whether only one timer is present in this block.
 >>>> +
 >>>> +  xlnx,trig0-assert:
 >>>> +    $ref: /schemas/types.yaml#/definitions/uint32
 >>>> +    enum: [ 0, 1 ]
 >>>> +    description:
 >>>> +      The polarity of the capturetrig0 signal. 0 for active-low, 1
 >> for active-high.
 >>>> +
 >>>> +  xlnx,trig1-assert:
 >>>> +    $ref: /schemas/types.yaml#/definitions/uint32
 >>>> +    enum: [ 0, 1 ]
 >>>> +    description:
 >>>> +      The polarity of the capturetrig1 signal. 0 for active-low, 1
 >> for active-high.
 >>>
 >>> Can't all these be boolean?
 >>
 >> They could, but
 >>
 >>> This binding is usually automatically generated by Xilinx's tools, so
 >>> the names and values of properties must be kept as they are.
 >>
 >> Because this is a soft device, the binding may be (very conveniently)
 >> auto-generated. I am not opposed to adding additional properties which
 >> could be used by new code, but we should still accept this auto-generated
 >> output.
 >
 > I think in this case you should described what it is used by current
 > driver in Microblaze and these options are required. The rest are by
 > design optional.
 > If you want to change them to different value then current binding
 > should be deprecated and have any transition time with code alignment.

Well, every single one of these is in the microblaze devicetree since
2009. And fundamentally, all of these are required for a complete driver
implementation. They are generally not discoverable from hardware
(though I think it might be possible for one-timer-only or perhaps
counter-width by inspecting whether register writes stick). However, the
signal polarity properties are required to determine whether PWM mode is
possible, and to determine the polarity of PWM capture (if that is
implemented in the future).

I think allowing more conventional usage of devicetree is a good idea.
E.g. we could accept both something like 'xlnx,gen0-assert = <0>;' and
'xlnx,gen0-active-low;'. But I think we should still parse older
devicetree properties, given the (likely extensive) amount of existing
devicetrees with this binding. And this would also require Xilinx to
adopt whatever we decide on, and update their devicetree generators
accordingly.

--Sean
