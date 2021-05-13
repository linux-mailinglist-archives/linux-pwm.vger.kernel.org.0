Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFA537F9B3
	for <lists+linux-pwm@lfdr.de>; Thu, 13 May 2021 16:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhEMOfE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 May 2021 10:35:04 -0400
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:58852
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234480AbhEMOfD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 13 May 2021 10:35:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP5gPeeo2rBG85780de3nencDURLGndx4wfjT9u+bsYffV9px4zuqxLunOX734LZ7TQEahmWg+ZvWWOo5ALvFxOWVRXK3tE/IgN9CHs7hbTz9PTMVs6DO3WJXwENXPUhjX07melflTcVDxQq4RUPrk4acZ5aHxXlhlnsFqGHQZ+WY2QgVRj+BFXDbl/QJr+hWLGxv3TX7ECYMQbfTnkSlwjT+bLNWpoXcmy7gP/M238fUpOluqkb52nCU3Od4K65Sw693HDBbOy2iaGNCn80d12JXUpmNiBhhfzdNfzxq3X6APgr+yTFFyQdtutl/CXAtFDuPXxeWC9ylo3KOlHcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRPriKkoBmzo9f7Uf7gaXvgbVuWlxvmUUAy8KBNwUaI=;
 b=Sb3Fp9KEsh3AkENXqVdeR/3jX2bT4C80TI/24BmtESr38O7hd/voQM73RD1Dzo9/Df+kLeu20+OzSBgiSgr2U3hTRb8wv41hhCx6Jx6+abccH5L3bZL3/E73PF5t/qg5kO8I01Ad/dwCkQvWXt3uIOn4lFk0OkfGcmizEurmoFfCNcgGnoR1+vQLt/iIHhYn9APhvfw5jWk8R9m4ryUOshTBCXIxD/5KVTUb08vT40b0m0iJPlavj6sAhVWG4ShL2Hr+ieopegfe0S6I+S0H1d4KVqJrFMecdZ3qqLYNz8csUEpBza+4RcMvHcYvurVVAfnlsvrwkZLLttlE8wBJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRPriKkoBmzo9f7Uf7gaXvgbVuWlxvmUUAy8KBNwUaI=;
 b=ZpVXbZPHoUudazc3PysgXl9kaBzXjTBZRSh1W9kNyljeMUIs2n7NXtIPqspGc6YG0y5UWvQY5GF6qxDPHgII57GZfC1DH5/UITbYYRJEgBG7p6E7C3AyE2ZXFQWyyyEpb/khODfLCg5nibTntD2fK7Anpa6ZGl8+zL0Vdf5DWkA=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4155.eurprd03.prod.outlook.com (2603:10a6:10:13::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 13 May
 2021 14:33:51 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 14:33:51 +0000
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210511191239.774570-1-sean.anderson@seco.com>
 <20210513021631.GA878860@robh.at.kernel.org>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <f9165937-c578-d225-9f5e-d964367c4711@seco.com>
Date:   Thu, 13 May 2021 10:33:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210513021631.GA878860@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1PR13CA0407.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::22) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0407.namprd13.prod.outlook.com (2603:10b6:208:2c2::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Thu, 13 May 2021 14:33:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ea478b6-e207-4905-3322-08d9161c2065
X-MS-TrafficTypeDiagnostic: DB7PR03MB4155:
X-Microsoft-Antispam-PRVS: <DB7PR03MB41553A203F994239A017628396519@DB7PR03MB4155.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZe2Jr4cl4FWWjzzWIw03qbbhToEwxRIRBjUJePaT3SGIXVfv+YHfLd5h1ngwszt0vEvU3xrCdx4r6fj3vvylT40gGFyBSU7CzH1ihqZmw5mcdGDlszDwl+IHobeATVyS3v2qOU4WYrOkCoO6SsBIh0fhD8aXlRjVadcuaEyALs9FdMh++/S+HHHZyBKPJaTOMoRo+SCjjNgvyopxrOGGf9ARM7bwPGANDF0ZL5I+XJ/nXAbSWD0r9lC9FMCpF3XswaxJMAbmPdHNQd3xBYZ1PDINlibRbhFQFCamkZHlF9cr+KOb7GBhnUmmhxTWmFgGK2PfZzidk2Gp/ibjgdBPQNrwDpryNnkBb14xtlOtXSlqdm2fQf5YD4j7zvuNf+I8W8WLvloBq13LypDXY0Sx7bAD9HdecxvvSJB7LC3B1S8iWnTK2YBtANIm5sQ9N37RQyFNpjv8psiNL7dFmSlNVNncUX7HDtXzp67+lyI0hfE9QjX3VI684PAKJWg2aWV9s0ZiAGACDGh9ajZWSFhVqP/Cqm97PwmH+TUg57E9bOa/Nel3vTRa5h0UkKgDqcJISCgKQaifpm6tNWVKpr90KiYEnpntCHEndZbIjn5a8Vc6gi1okIAQWc4dg2XtTKPqHNZ2bXBCeGdgdaupmsnYob3+BMe2wjZIQaSkwNGYrk5Wtx08WsOXuRg9IYjgOQC6pVr6eEXrX4+tFt88niD62y5viEiZ9XoHRrNF1Q6Vdc6epA230w1moD/dNztOL8jXE+IYx83Gd3EV1A6QcW0Y6LyGm3w2ShEvWATSr1paGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(186003)(4326008)(66946007)(66476007)(66556008)(16526019)(31696002)(966005)(86362001)(31686004)(8676002)(2906002)(83380400001)(498600001)(6666004)(53546011)(8936002)(956004)(2616005)(38100700002)(44832011)(38350700002)(26005)(5660300002)(6486002)(16576012)(52116002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZlNTcEVlY1Zia1c1VlhGNHB4bGY3Mml6b1NHckNDSGs0NU02TEZnbHRvSENl?=
 =?utf-8?B?blVKUUhSZUx2eHMxTEI0U2wwaDVMMEZHQUNtaHBUWFFNOFNCNjBTMWY1OWFJ?=
 =?utf-8?B?UGlydXFoWEVQT2hyVWQzcXd1dytQbVExd3V3bzRaLzlSMThvT3JLYUNLa3RC?=
 =?utf-8?B?SHBrT0I3OUxzS0ZmUnVGQVdyKzQ5bGJ5K1dqS0t3V0NGUlhDME00VXc4aDNi?=
 =?utf-8?B?OURhQ3BJdTRBOE1TdEFSdUoxUVZSY1BYK29XV3U3VVNVT1pmdjE5ZUhzMzZS?=
 =?utf-8?B?VjZ5aVNqcExKMEU4MUY5YjI1QkRKam9qSUhQWG9ZMGRWMUIweUNZOUhDS1FK?=
 =?utf-8?B?UzM0SUpVVW81T1I4OVhGOGt6enVEQ0RsSFBtL2Ntd3E5UFZuRkp5WDNJTEox?=
 =?utf-8?B?VEJjWHdlUm1SU1NSdGRQQ1lzaERYWVNESW9VTkY0SGhreThURkM5WlFQVGtH?=
 =?utf-8?B?TEE4L1lUc2R3L1Y5Vjc4bXN2aE9RMiszcDFyYThOd2Y2Z2YwWlZXUTczck5m?=
 =?utf-8?B?MEdaU3RIQ1FJZGxyMFV3WlZRNjlzSVN4cnp5dDNzSkp1MjZ4VlVYQk50SmNu?=
 =?utf-8?B?aU9OQXNLd210dC9NWHppSXc3UC80UlZGaVQ4UGZnWE1RdEtlWkZ4K3lRakJu?=
 =?utf-8?B?SGp5dE1IeDRKUkIwUUpYNjQvQ3pDbHhkcUk1bmJjVCthUmxtNm5pVDI0OFZa?=
 =?utf-8?B?c2s0a3ZtQ2xQQkVXK05DbUJlWHVQMzNMT3NueFgrTHJqeklwdkphcVNsZmY5?=
 =?utf-8?B?REJQdVczOGRNazlvRGozeW92eXcrTW81SExmN3Mya0QxelNJOTFNZkt3Ynkw?=
 =?utf-8?B?eWM2b0pDdHAzdkZiRWtrL042NFJXM3RKU2VPNUlsR2tFQkxkd3dzenpnSzBE?=
 =?utf-8?B?QXZBQW9sVGJXcTh6eThEZjFrYVBtSUhJcEJHTjFsNzNWc2NwWXh3allYSFhR?=
 =?utf-8?B?blM4N0FrZ2ZaM2VSL0hwUUhQSFIxaG9QMk53b2d4WTZrTnl6bGZIMGtFUVc2?=
 =?utf-8?B?QUlVWnA2MXQwSzgzdUM5RkVlZmVXVDNRY0VSZXVmWW9tZlVlTU5XUEkyVUZN?=
 =?utf-8?B?WENwZGxqS29Kd2JlOHJWRk1TYnJUM1VYY3kzSzJtWUlIKzJJem56dlk4VTBB?=
 =?utf-8?B?d2Z0bjNLSUV3L0dwZEVFTUlESE9KTi9yOFIvSGt0bk5RZHBLa0F0akJoYy95?=
 =?utf-8?B?M2xHRW4xRHF2QWNnQ0I2aTRZY2hJQ0MzeWFnM21vbStPZSsvQXlUbUhTMXJU?=
 =?utf-8?B?aDA3ZG1LeWxsK3gwNUZ6cUxQY2JESEdEK0JqSXhBdmxESHFJZ1VGK1RLRWhM?=
 =?utf-8?B?ejg4SVF3NlE2eENqWTdEbU5WdjQ5eE8yVHVoMXlRM0dvM0oxZGZLRzJTeE5q?=
 =?utf-8?B?ckN1RWZzaWxyd0EzSFV5N2kvM3c4dXJrTUJJbEcxZk9iZ1FNZWZuVVhzdmRO?=
 =?utf-8?B?ZGNobEtzK0djYk9mNzFaSmQ3NHBXMDhJOWlVeHZSSkpZa3VaZzd2RTZlZ0lt?=
 =?utf-8?B?RUxJZlVLL3BydG8rSWtVRm1nVUJJaUF1TUZrTlBGbXJuUHd4UVhsd1VJN0F4?=
 =?utf-8?B?TXUwZ2dkMGF5ZVNWVmZHY1ZJSzU3NmNhSXJ1c3dnWFlvdG1UMjFXd2p3UDda?=
 =?utf-8?B?Z0d2bEFKTXVmZ215bzNEdlRaT2dtVitiZm5YcVpFcWY4RnVZc2dyL0ZrbFF3?=
 =?utf-8?B?R0o5M0l4a1VEc2xmdGg2TkVDNUhITHNqcVJlVFFOaDFIRllQc0FNbys3Nzk4?=
 =?utf-8?Q?//19GKEdOWr3jU7m+UZU566xLJvhuUXIL6i/TqQ?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea478b6-e207-4905-3322-08d9161c2065
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 14:33:51.0502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhVFZzbN8BpfO2kAuT0TMxCAgXLW2ucG2FEdVhLHJbej0uvDq5b5kUtmvz2OhhrcOMKBcpgZ0E3Un1qL+fCV5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4155
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/12/21 10:16 PM, Rob Herring wrote:
 > On Tue, May 11, 2021 at 03:12:37PM -0400, Sean Anderson wrote:
 >> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
 >> a "soft" block, so it has many parameters which would not be
 >> configurable in most hardware. This binding is usually automatically
 >> generated by Xilinx's tools, so the names and values of some properties
 >> must be kept as they are. Replacement properties have been provided for
 >> new device trees.
 >
 > Because you have some tool generating properties is not a reason we have
 > to accept them upstream.

These properties are already in arch/microblaze/boot/dts/system.dts and
in the devicetree supplied to Linux by qemu. Removing these properties
will break existing setups, which I would like to avoid.

 > 'deprecated' is for what *we* have deprecated.

Ok. I will remove that then.

 >
 > In this case, I don't really see the point in defining new properties
 > just to have bool.

I don't either, but it was requested, by Michal...

 >
 >>
 >> Because we need to init timer devices so early in boot, the easiest way
 >> to configure things is to use a device tree property. For the moment
 >> this is 'xlnx,pwm', but this could be extended/renamed/etc. in the
 >> future if these is a need for a generic property.
 >
 > No...
 >
 >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >> ---
 >> How should the clocking situation be documented? For the moment I have
 >> just left clock as optional, but should clock-frequency be documented?
 >>
 >> Changes in v3:
 >> - Mark all boolean-as-int properties as deprecated
 >> - Add xlnx,pwm and xlnx,gen?-active-low properties.
 >> - Make newer replacement properties mutually-exclusive with what they
 >>    replace
 >> - Add an example with non-deprecated properties only.
 >>
 >> Changes in v2:
 >> - Use 32-bit addresses for example binding
 >>
 >>   .../bindings/pwm/xlnx,axi-timer.yaml          | 142 ++++++++++++++++++
 >>   1 file changed, 142 insertions(+)
 >>   create mode 100644 Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >>
 >> diff --git a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >> new file mode 100644
 >> index 000000000000..a5e90658e31a
 >> --- /dev/null
 >> +++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >> @@ -0,0 +1,142 @@
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
 >> +    oneOf:
 >> +      - items:
 >> +        - const: xlnx,axi-timer-2.0
 >> +        - const: xlnx,xps-timer-1.00.a
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
 >> +      The width of the counter(s), in bits.
 >> +
 >> +  xlnx,gen0-assert:
 >> +    $ref: /schemas/types.yaml#/definitions/uint32
 >> +    enum: [ 0, 1 ]
 >> +    default: 1
 >> +    deprecated: true
 >> +    description:
 >> +      The polarity of the generateout0 signal. 0 for active-low, 1 for active-high.
 >> +
 >> +  xlnx,gen0-active-low:
 >> +    $ref: /schemas/types.yaml#/definitions/flag
 >> +    description:
 >> +      The generate0 signal is active-low.
 >> +
 >> +  xlnx,gen1-assert:
 >> +    $ref: /schemas/types.yaml#/definitions/uint32
 >> +    enum: [ 0, 1 ]
 >> +    default: 1
 >> +    deprecated: true
 >> +    description:
 >> +      The polarity of the generateout1 signal. 0 for active-low, 1 for active-high.
 >> +
 >> +  xlnx,gen1-active-low:
 >> +    $ref: /schemas/types.yaml#/definitions/flag
 >> +    description:
 >> +      The generate1 signal is active-low.
 >> +
 >> +  xlnx,one-timer-only:
 >> +    $ref: /schemas/types.yaml#/definitions/uint32
 >> +    enum: [ 0, 1 ]
 >> +    deprecated: true
 >> +    description:
 >> +      Whether only one timer is present in this block.
 >> +
 >> +  xlnx,single-timer:
 >> +    $ref: /schemas/types.yaml#/definitions/flag
 >> +    description:
 >> +      Only one timer is present in this block.
 >> +
 >> +  xlnx,pwm:
 >> +    $ref: /schemas/types.yaml#/definitions/flag
 >> +    description:
 >> +      This timer should be configured as a PWM.
 >
 > If a PWM, perhaps you want a '#pwm-cells' property which can serve as
 > the hint to configure as a PWM.

Ok, that's a good idea.

--Sean

 >
 >> +
 >> +required:
 >> +  - compatible
 >> +  - reg
 >> +  - xlnx,count-width
 >> +
 >> +allOf:
 >> +  - if:
 >> +      required:
 >> +        - clocks
 >> +    then:
 >> +      required:
 >> +        - clock-names
 >> +
 >> +  - if:
 >> +      required:
 >> +        - xlnx,gen0-active-low
 >> +    then:
 >> +      not:
 >> +        required:
 >> +          - xlnx,gen0-assert
 >> +
 >> +  - if:
 >> +      required:
 >> +        - xlnx,gen0-active-low
 >> +    then:
 >> +      not:
 >> +        required:
 >> +          - xlnx,gen0-assert
 >> +
 >> +  - if:
 >> +      required:
 >> +        - xlnx,one-timer-only
 >> +    then:
 >> +      not:
 >> +        required:
 >> +          - xlnx,single-timer
 >> +
 >> +additionalProperties: true
 >> +
 >> +examples:
 >> +  - |
 >> +    axi_timer_0: timer@800e0000 {
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
 >> +
 >> +  - |
 >> +    axi_timer_0: timer@800e0000 {
 >> +        clock-names = "s_axi_aclk";
 >> +        clocks = <&zynqmp_clk 71>;
 >> +        compatible = "xlnx,axi-timer-2.0", "xlnx,xps-timer-1.00.a";
 >> +        reg = <0x800e0000 0x10000>;
 >> +        xlnx,count-width = <0x20>;
 >> +        xlnx,gen0-active-low;
 >> +        xlnx,single-timer;
 >> +    };
 >> --
 >> 2.25.1
 >>
