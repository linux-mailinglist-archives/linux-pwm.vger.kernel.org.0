Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E353375592
	for <lists+linux-pwm@lfdr.de>; Thu,  6 May 2021 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbhEFOZe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 May 2021 10:25:34 -0400
Received: from mail-vi1eur05on2044.outbound.protection.outlook.com ([40.107.21.44]:4704
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234397AbhEFOZd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 6 May 2021 10:25:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OosxvuUkT1OtWY1yAgE7YEQ8kp42XxoZeAU3lXTFOGZxrwYH0jqPSqqtISQox3iq28fAAE93038lhEkKC6/B9xyKV3aTwCO7QINr88BHanICRTRVDwQpXzhWKJ0zWX8QJ7I2hPYYwpmmQM3Amyw2X6ZmoZ7KX/OGK+4HRNrP8MgoJQGJlC8399qElTiiKiokyTmxGFHOqr2A36AIDy7HBKHmN1j2cSbwa4smD7qufEmtpPTKJLECSYmihrp23AdrAfFSitaFiDdruhD1VpVywwKhgorVFAG+EusBi8gn+qK2vvEY9MQ+kPge3L769kHsw9TMwgr4wH0Y3OBTRGrZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kssnTIfUSADtoLyBu7X8/Jbz0l3OCLIHcyrzxbnDTd4=;
 b=hhn/MFCJLcvQ4FeAqT8rAm3EIiBr/2BFgLvwOCFm6S6tY+t8lCpRGn8PLDJxERlqSenuGbNALcyJ2s/YVKZOS3OENwyku2fJzn/QQV7L8VzSbc3jt+rQbGdOjOjl6t5XjbFQub3QgXa2ee4RipXpVOeBcaF3YQjhu0RfPZxN84Ql5SqTfglRqjAEC8stGAD76WnJyOd2/f/jL9R6Kh9XgO7sBKJVp8NI9MJfnj4hlaaNZnLS1pF/4x2eoAXeps/OLeMoZTOMd/4kJqbma4ztDda+VO4QPGaHX2o97sdJS4woCEn+qCemEKn/rrIqGA+Iy0PqxeRNbwx2sXv+VnisUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kssnTIfUSADtoLyBu7X8/Jbz0l3OCLIHcyrzxbnDTd4=;
 b=yh09vUOIn4jha+xE/ngUhqEkymGM0ChJVHvXxqILhw6GM0lPBFYdnrKW/7IfcnEyBjR27BYVhnGJGbUSByJISfmGxBETHxwE3g8n5PlWVaTryXhFrnvNXPUq3JP+3UmV5SNF01eqPQVqD5AuPG7r8Z5nWxOzjymDbqr2EDcOJeU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB6330.eurprd03.prod.outlook.com (2603:10a6:10:136::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Thu, 6 May
 2021 14:24:32 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 14:24:32 +0000
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Michal Simek <michal.simek@xilinx.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Rob Herring <robh@kernel.org>
References: <20210504184925.3399934-1-sean.anderson@seco.com>
 <0326a217-e6cd-d2b3-65a2-4285e9342418@xilinx.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <b8a38fbc-dda9-688d-3985-8c3ca01168f3@seco.com>
Date:   Thu, 6 May 2021 10:24:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <0326a217-e6cd-d2b3-65a2-4285e9342418@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1PR13CA0311.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::16) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0311.namprd13.prod.outlook.com (2603:10b6:208:2c1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.11 via Frontend Transport; Thu, 6 May 2021 14:24:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 994152f0-2cdd-48fc-f643-08d9109aaa4d
X-MS-TrafficTypeDiagnostic: DB8PR03MB6330:
X-Microsoft-Antispam-PRVS: <DB8PR03MB633026EEF709908A67C0AD9A96589@DB8PR03MB6330.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2maaUJ6QaACmcM5Rl0CJDubrHc1hducubPV1BmJKJTY8xlApKEJJBCK1+fiZ22CLGI3MKvAHVGa1Uxjiekcl4FiBSdsOi50ZmM9RD2SA86P1Q465KKAme4lgYVIwQrHh7nLi5DIg5rEyOFJAjEt1sjYRT9Xqdl1jcHZ6LDNKimR80cEWT37Uj5sG/mwnd0eS2OQ3A5YYqPQOjsZoKALYYvv1I6HYn3ro8+B1XLmokuns980vD2VMVFSaNRs/CR1uNk65UyGB+bWJIMmRtzSKcUglP3jl0R3AnTb9qfjyCTvtiVAFvIYc0g0FhRpsq4lQEtX4JUd7jqhZJv7BMi5En+8oQlUh2kJkSJ8i0GotDRSM4uGSEWn4TE/WNam52Ba8lvOCthr/fq444Wdm+Puvj8xYUskMCuTzw2O57qSrD4S1mbzVi36BBQkb8kM475NbSc63aPpVXrPodSU2Xwbv12LZE/CPhZ+ismBLl/zxXPY3pc6TJ+vaAt1ezI9tXLuI2NOpPnHeo1uHUQjp0r+zq+ia2zyFo8aP+hwZOVLi4VfIzTxVlAdf10ivRI91pufv0bzb7LweuiyigDnLYTtpSAjN0P4zs/FG2e9vff5HuSg2Pt3Dhw43Sk2OxdU43vURfYiV6C9iqDBWpnHMweK//wEw2bqynJMNY9hmDxU7dJZx3gqsh9aZcDLIq6kXLNrWX4twogLZv0coCcQESQgkYsz/28g4twqmsPeQrKpzkVOz1Uic4Uxvh7ojjVDp+bXO7crf52rHNvWwF/CkDNnRLEOvr3stqd2FOOTsAQHCCmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39840400004)(396003)(346002)(6486002)(4326008)(2906002)(6666004)(316002)(44832011)(956004)(186003)(5660300002)(26005)(16576012)(478600001)(31696002)(8936002)(53546011)(83380400001)(66476007)(54906003)(2616005)(16526019)(966005)(38350700002)(38100700002)(36756003)(86362001)(66946007)(52116002)(31686004)(66556008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UFBYRzd2V0pYM3JuR2MzSkNieEZhQjZFbmsvcVkvV2ZsbjkvaDJsN2F5MGpw?=
 =?utf-8?B?cmdVSXF3anVCTThnSjAreWJ1YSttMFNvY2Z5RVg5akdaUm1ZRDdTWnE2ZXlv?=
 =?utf-8?B?MzloWjFObmQrdi9NbVg2UzhPdjJXMW5XUmcxMWpkWHErZGZJOUVBRjNwTjFE?=
 =?utf-8?B?ZHZlK0FrbmZDUGsvOGFob253eFIwVUowd1ZpK1QrZ3JtZ0NoeXpjRlUrNGZ3?=
 =?utf-8?B?VEVCRUFDb0hJbzVDYi8rVU9way8waFRPbUZtbXBmK1hseXZ2VldlbmJNTVlD?=
 =?utf-8?B?NUJHdkFHMU0wbkhSdHhrRmJQekczMUlSVTZEYy9TNC9FMlJzdnlsejNMbkJq?=
 =?utf-8?B?TERiMlpwUFNCcjVMYXBKNUhDK2lmYjhIWGJKU2V6QXNEbW5icW9VQlZRWkNu?=
 =?utf-8?B?emtkazU2eWFrV3RoRGV5cURxVng3Rm1mWUllenZsNVN5NGNnYm5zakdLTzlk?=
 =?utf-8?B?b2ZtaTRNcHRBRm5ldUd0ZkRTYklROUhORFBaMGNraFlsTThWZkZjNzBDVWJs?=
 =?utf-8?B?Z2ROMUxXNDJyZWZNdnNlakV0SVBkbmptRGZFSHlYdFNmZkxNOVZIelZ4Ui9t?=
 =?utf-8?B?TlpTejl0WC9GZm5XWVVPU0RNNjBScDJ6SVFKcWsrTFRzK2pXYXNZamxmc0JQ?=
 =?utf-8?B?OFIxZVBweC85OERYNDV2ZlFhWUdrbEVmcjN3cGdacWxmWTJjaFNaNi8rK0dk?=
 =?utf-8?B?VEo2dk5vcHZPam14L0pVRCt0eTUvS0tYOGJMMFlRL0l3V2x0T2NiRUZZNUFo?=
 =?utf-8?B?RzdSVzVTcW1oY3ZacTZHdlR6R2pnd2JWTHlDT0tWNUc1VitqaVNVbUptaTBF?=
 =?utf-8?B?QWZoWEpoZkRnbm91SDltUENyVmFFTndXTXJMczlJYzZRTzBiZkMvWnpLS3FI?=
 =?utf-8?B?eXc1OTJ2bHkxYlJwM1NzamxXcGVEZUhqTDdmUkx5Z00rY3BCYkxLaDNwZXdr?=
 =?utf-8?B?NkNVOWxtUlpUTmlRMEl0R0wzSVFIRVpkNzNkODFMcXE5ZDM5TVBXVUl5M0Zl?=
 =?utf-8?B?bFpldFJTY2tpQVZDTERKU2FXMlBvdE9GVkwvczhzTHlkaWdVcy9NU0MxV2VS?=
 =?utf-8?B?bmtZQWx5WWcxTzh1WjlWcEg1dHZ2M0tQUXNwc0JEcndSczJOcE9DaGRJaHpa?=
 =?utf-8?B?YUFkUVRvSHpid0lnek4vdjFVbFJ1QjgzSG1IcjhFL2xVSjZmTGQ3M2hmMHp2?=
 =?utf-8?B?YVZWZWIyY3hoVTkzVWFUYW0wQlFmL3ZSZnBwTGxmUjJXWURaVG9CMExicFlw?=
 =?utf-8?B?cmV2R1dRelg5aUhlRVZJeSs2OCtWbnJuTGpCQ1k1UEpmUWlRNDZwUkNXQlNS?=
 =?utf-8?B?dENXWGplZXNQc25PMS92aVpkNGJ4ajZLOFdCMzlWV2lLV3pXTnRtMC9zdmRW?=
 =?utf-8?B?R25pbFFhSExwcXlYc0ZLRUVrTmJBYklncGZkdlJwVW1LWkU0OWxCanBQZkVU?=
 =?utf-8?B?WHhhVXFwdHRVYlRSc1hRMVJJY2dUb0hlQzNGTi80MUdoYTdlYXBRVFMxcHVi?=
 =?utf-8?B?UzVEZzRRY1dOb2ZqTlMyVlJidW5qUVdnTUVMV0EvTVh5RU1hZWNLUDJRSHRl?=
 =?utf-8?B?N1J4bDYrSTlSSTBETE1EYThPNFIrRFZ3dWhnSTRma2JLaTd6MU1jcVVXL2Q3?=
 =?utf-8?B?dEFBelNYTlBYTDZQajlIRXFERFMwM0IrQ1BvNTZrazJ6Z1hzQkJpamZ0KzFN?=
 =?utf-8?B?akxpT1hzeENtNGk2TmhBcWhOV0VZMGVmSi9BMWhGWEhGOVVkS3N4Nk42aEli?=
 =?utf-8?Q?K6YG06KPxFd6RDFtE5cF3S9POO3LTTYQkykUCEB?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994152f0-2cdd-48fc-f643-08d9109aaa4d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 14:24:31.9209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cR2Mrd4C19b5y5Y3Q8lZ3d4TgbLbWhf34t2d3aKjmHKFsIIvaIdyCyprjfKRUjtXL4+z18hCFrkTZPya8VeVnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6330
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/5/21 2:46 AM, Michal Simek wrote:
 >
 >
 > On 5/4/21 8:49 PM, Sean Anderson wrote:
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
 >> +
 >
 > Based on xilinx design tool selection there is also mode_64bit option
 > which I expect will be translate to xlnx,mode-64bit [0, 1].
 > But any coverage of this as bool property should be fine.

I believe that just selects count-width=32 and one-timer-only=0. From
the data sheet, there doesn't appear to be a separate mode-64bit
parameter.

 >
 >> +required:
 >> +  - compatible
 >> +  - clocks
 >> +  - reg
 >> +  - xlnx,count-width
 >> +  - xlnx,gen0-assert
 >> +  - xlnx,gen1-assert
 >
 > these 3 shouldn't be required.

Count width is certainly required so that we can determine the correct
value to program into TLR. For the PWM driver, gen?-assert are required
to determine whether PWM mode is enabled.

 >
 >> +  - xlnx,one-timer-only
 >> +  - xlnx,trig0-assert
 >> +  - xlnx,trig1-assert
 >
 > these 2 are also not required.

These are not currently required by the driver, but might be in the
future if capture mode support is enabled. In general, since these
properties cannot be determined from the hardware, I think they should
be present in the devicetree.

 >
 >
 >> +
 >> +additionalProperties: true
 >> +
 >> +examples:
 >> +  - |
 >> +    axi_timer_0: timer@800e0000 {
 >> +        clock-frequency = <99999001>;
 >
 > I can't see this listed above. It is allowed to have additional
 > properties but I don't think it is good to list it here.

This is just the direct output of Xilinx's generated device tree (but
with address width reduced to 32-bit).

--Sean

 >
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
 >>
 >
 > Thanks,
 > Michal
 >
