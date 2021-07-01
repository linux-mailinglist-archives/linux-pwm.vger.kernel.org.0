Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B853B93FE
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 17:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbhGAPfU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Jul 2021 11:35:20 -0400
Received: from mail-eopbgr140045.outbound.protection.outlook.com ([40.107.14.45]:5380
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233421AbhGAPfS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 1 Jul 2021 11:35:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkDckruHDLL+UPZZR9c0HcXn4gJsC04Mr+JqeWliLXyyUe/65WFqODFdK5hANeKHaIruyvaiqDpLkQErln1MYz+ZDJEEBOOP44ngXX/oM3+bZK5Jbv/6g0BTe5gOb7qF3KzjnQ98VoeV5+iKqp4tvz/IR7PuzXdXSzWmZJrZIgHvG+twdbbTaXMFlUPTKmtnnkqpZwdx7tLRMQxDrpcpl1xqNV+J/eEnKs+cOsRhODbS61dWkKWPpajtp0iED8NIpZ3+w0T6rCRGMuBcc58xsJADapTt17F4AhCEOmIqf1bQfs015x7lJTm3PzCk4BX0CFK5fXGVWW9NiAvG2lzm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBSScr67A762m/y2ibRXhgBVlxiKdecK+u+qy/yllpY=;
 b=gFUM/cDYTeA0HZ/c1OQKXuNbEsNe+cNhL4IyFahEGfrwhXszBVJbnUOuMuxFLozEdzfUQHQ55xtavN+if/HWUAvcN+w4xriBNgeFeMDEGRIJdnmJiq1v5M8fj9bi8UffCxv9gsYhjJWEESBSJ5rZ/uwEwrVysI6iG7EZdveWVEojADlhR50b5AfGKFFlbya1P/PLdfoxANKyIIOpx0PxXj8vb85Lf94qrBxMmS+g5K9L/nM2AXeJiMbvxTSwrwLpbnJROYRT1Ey5fyPJ37H9YZrBVHUNRfj2iLgmU7T9TsaxN9UHX99XsgE6QOdN1gmwDLkt1qX55ntafgBdi82fxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBSScr67A762m/y2ibRXhgBVlxiKdecK+u+qy/yllpY=;
 b=XYWgO9p9K3F5kRHqS4FG8lD4WIzEypKJBL2Ev95UsbJDTABMEBfBQaLHuFh5PqEOgwVAHmlFYPvQVTME4gZ5atgjJ4M521809Ha4JtWQZSfO6B0W8gBCIbr4lDlcvSVsqr8ly58FVDoFzBPM3XPjAluzrCCh1G97idSrBaRGHHY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4620.eurprd03.prod.outlook.com (2603:10a6:10:24::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Thu, 1 Jul
 2021 15:32:41 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4264.026; Thu, 1 Jul 2021
 15:32:41 +0000
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Michal Simek <monstr@monstr.eu>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <13c9345f-b3e5-cc97-437b-c342777fcf3c@monstr.eu>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <36b23b6b-e064-a9c6-2cd4-4fd53614724b@seco.com>
Date:   Thu, 1 Jul 2021 11:32:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <13c9345f-b3e5-cc97-437b-c342777fcf3c@monstr.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR12CA0011.namprd12.prod.outlook.com
 (2603:10b6:208:a8::24) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:208:a8::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend Transport; Thu, 1 Jul 2021 15:32:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20ba1547-ba61-40d6-cfae-08d93ca576db
X-MS-TrafficTypeDiagnostic: DB7PR03MB4620:
X-Microsoft-Antispam-PRVS: <DB7PR03MB4620D7541A489D02AE59D68396009@DB7PR03MB4620.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1gHrCEujfVNQMY9hBuUGEbnTVf+eqi9Q6GAWWn2k9MxHb4BnOsmbHYycsk500vilU0/ZYanPEf1Bj45tb4eqdypvTRR1WF5Ak99rKb1XeicAnBWqplTVtO5D1QjuwrMZIkt6YCS+nboprMzuDNWBao3KyxiuuvXk6XuMFZBN4091A3chIY7Z8TjgRmb1gFshUh+XMJ1iftGUo+eTwcUC8DgZdLx4TPoEtLe0Q/DtAf5Iv6O7/xuuJrPQoxIfWouhyMY1zKDKthc0VsLLoLXs59gJkbpHqvIVzISvO3Z2E3dqqGzD/NUTLsGGclHdO1M9y4dvXrRR8A1eB7Vo0urtZ0BkCdHkEZcvG0pOaJn9ljAfwROSyUqV9eLAqWDNwyCe0Sf8M9SlhaJZposp6oelo7Qf12EwR+qCapleJWpJKCLmoL/sPv0tlVGC8p+OAMnRIKQYfBWaGODs74FatlVnsh0GQ5J4rKk/Gy4bqbhkqFJ8xQWdoohQrgEpEBNga5GdTYURnTUYzupwwT49ZkcTcaa2C8QEutcqS2OlqfH1Ijx4xAvYV/dnw2nFWG1FtLwAqX0vdFPF+Mhl+H+K+o9aaql5OKpk+RlruYzVMWdpLAHiVddBFKva9WeH+SS7XBa9BC/7J8RGM5ZpNItWMN5xctawNYD88GdbZACES4+V4nD/Cz8QQyyl1eEYVQBqy+yeWdMACi2aAQbYAcB5wDZzBiUH6T1Tegr+1Z1otKA81F8Zx3cgs2tHZk9vNz7DvsCOQ+OdOkBcZHPJvKbMcM/RYm/qOBrSjhARmckHJ+/zM+rK5OdwaHqfm58WvfzlmAFhhs+zUHv1xpWUco4LWxVgrvscZ5Ly10QsJnGioO2f+1sfXKBTbzxOrMi8hcmUh7j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(366004)(346002)(136003)(396003)(52116002)(38100700002)(38350700002)(8676002)(8936002)(110136005)(6666004)(966005)(36756003)(31696002)(66946007)(54906003)(44832011)(53546011)(2616005)(2906002)(956004)(186003)(316002)(7416002)(478600001)(31686004)(26005)(86362001)(5660300002)(66556008)(16526019)(16576012)(6486002)(4326008)(83380400001)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzd4NmloYVB0UDVtL3BKdXRuaEVqb1pubjVscWMvb1ZXOW1KTUNYcmcwbkpp?=
 =?utf-8?B?eFlQN3pVWW0rczJObHBHY1AxS3p1S2N1SkszSFlWY0NHODhtd1VtR2c1ajdy?=
 =?utf-8?B?eEk4RC83eWZYaUpzVFZJak5Gc2svUVBSNWtOZHZ0dFVXbW9WNzlPUy9ndlZw?=
 =?utf-8?B?ZitWMk1NeVJvM3JJSFAwVGY3UmVzb2xaYWhZeCs1dWVCWkRDV3FEcTRtWEdE?=
 =?utf-8?B?dVUzRmhtRkZ3SGYzSFROOVAyZGNTaithamZRMEJyN1N4NkMzYldNY2Z3Mm9Y?=
 =?utf-8?B?UFZDeEw4R3J2NlJuZU5PUlpWbVR4d0JMTkc5SE1peWxjODA1bjJPUk93YVdu?=
 =?utf-8?B?R0J5VXZnWUhJUW5xVlRKNGRkQkRyQWJoUjBOaWJyZHhCaElEaTFYZWErWkRj?=
 =?utf-8?B?bDBLRDBaY2dySTM0cXlRMXB0M3pjMEdwVG5YdVgwNlFTako5SnNrOWQxY1JP?=
 =?utf-8?B?U3Y0eHd2T3F5YlhRR056M2hlZW1ybGJaWHZYN0E0VEd1ZUR0Nzc4OXE0Nk9R?=
 =?utf-8?B?a2hwZXJJTUxGZW5WWlpYNjZoMlA1TTZuRDl2Mmo4bVppT0Zoc1VkaVZTdDBP?=
 =?utf-8?B?T3hrMW5nZ0M2Zi9FV1BrNWIzMDd1RzRYMFlGUkNjNW1RU3NBRmd6N284OUNQ?=
 =?utf-8?B?S0VoaVp2V0QwWndzeFJDdURxdVB2QXFOVGFvNXAxMVQ3Vm5nMjJGWkFjZG9r?=
 =?utf-8?B?RlhYR2U1ZUE4cTJiYjJYZlBndWtEVE1OVzRoTlo4SHVuK0oycnUvYXpqWUU1?=
 =?utf-8?B?cVZyaitiNVk3UHBtbXJHZHdrYVpkQjlqRHF0bDNFZWFZdEtrTVcwNHdjQThY?=
 =?utf-8?B?WFBxTTVHYW1nNkZnRFpQV1dqb2lxOXlvZ0hMQVFnQ3VaT3hIeVlrMVhwdzA4?=
 =?utf-8?B?TjRjZTBGWUR1NlBqNDFQRlE0c09WbGNFSUFKV0ZramJLQytHZVFRZnROajBW?=
 =?utf-8?B?NEVMMy8vQlpwMmxHekdmb2c1bW55cXlPa2hwcnVjUWZMTjBsU1htYzBVODF2?=
 =?utf-8?B?YllOWitLSWhWZWVnQWtxcHcxVnBzWk9YQUpLckkrcFc3MkxTWlIyVnpaT2JF?=
 =?utf-8?B?UFhuZXU5REtZbWVnQlNLMTdGRmxKblFld1RaSEpWWGtOUlBPcVZ1RG9kSGJu?=
 =?utf-8?B?ekdkOWhLaDhhRldtaWE0Q2FCUS9RaEF0VmU0a2lUeXpUVTFHem1UNzVVZXVt?=
 =?utf-8?B?RDF4U0FyYWsvRGExN210VndZSDNMUU5rQ1R2ZFBFTWJHSU1qb1daWkc4aFpt?=
 =?utf-8?B?V2NZR2RUblptYjgyakd2c2ZJcWN5dFFrMDk0V3JZVEhibHRKYjFVUEs1UFJ0?=
 =?utf-8?B?RFA5aTdpZytpRzZ1a3ZnYmJWUGFud1NlNjJPQUZrU0w0MldUcHNod2VRTnBV?=
 =?utf-8?B?TURvK3grQnJNOG5lYnA2ZWQrZ3pNeFlRaVc2eTdOU1B1Qm9yaE82SlNlRk11?=
 =?utf-8?B?UVpIdGxmS1g1RFNGd011YUlFL2wwTzVxeHFycmt4NVUwRDRzSHJJVy9IdUpl?=
 =?utf-8?B?QjhHcGxIWFdnaUxiSUM0N1MwMWo5WjhCNzRJOEhzSSsydGVyMmY4Rk9nMTRX?=
 =?utf-8?B?NzJHYjdBbThwbTBlMVZrYWprc0tZVWxMNkJSbDY0L1Rhbk5WWDhGWjhvZ3hx?=
 =?utf-8?B?bngyNmc1S0JJNlQ0WHlpcG5MVzJQaWNIS212MitvWHd3a3lYdDg5ZjBCWFg3?=
 =?utf-8?B?ZUIwWTdaZHdlVmxOZ09xL0FJaEw5OHc3bnhrbXRWY3pyMTRjV01DbzZiOEJm?=
 =?utf-8?Q?1mZW14CIHKhxyx4/IFF9Fxeqdxlw6BD6YIKGvF9?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ba1547-ba61-40d6-cfae-08d93ca576db
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 15:32:41.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UY89HZohhS/g9iXZgXM6yAjGK3kxAHLdmtcT2Q5sGU6omcWPB5H9dYoMp6oP4lMCok6MBRbNcl1QAbRCXOS+jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4620
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/30/21 9:47 AM, Michal Simek wrote:
 >
 >
 > On 5/28/21 11:45 PM, Sean Anderson wrote:
 >> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
 >> a "soft" block, so it has many parameters which would not be
 >> configurable in most hardware. This binding is usually automatically
 >> generated by Xilinx's tools, so the names and values of some properties
 >> must be kept as they are. Replacement properties have been provided for
 >> new device trees.
 >>
 >> Because we need to init timer devices so early in boot, the easiest way
 >> to configure things is to use a device tree property. For the moment
 >> this is 'xlnx,pwm', but this could be extended/renamed/etc. in the
 >> future if these is a need for a generic property.
 >>
 >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >> ---
 >>
 >> Changes in v4:
 >> - Remove references to generate polarity so this can get merged
 >> - Predicate PWM driver on the presence of #pwm-cells
 >> - Make some properties optional for clocksource drivers
 >>
 >> Changes in v3:
 >> - Mark all boolean-as-int properties as deprecated
 >> - Add xlnx,pwm and xlnx,gen?-active-low properties.
 >> - Make newer replacement properties mutually-exclusive with what they
 >>   replace
 >> - Add an example with non-deprecated properties only.
 >>
 >> Changes in v2:
 >> - Use 32-bit addresses for example binding
 >>
 >>  .../bindings/pwm/xlnx,axi-timer.yaml          | 85 +++++++++++++++++++
 >>  1 file changed, 85 insertions(+)
 >>  create mode 100644 Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >>
 >> diff --git a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >> new file mode 100644
 >> index 000000000000..48a280f96e63
 >> --- /dev/null
 >> +++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >
 > I don't think this is the right location for this.
 >
 > I have done some grepping and I think this should be done in a different
 > way. I pretty much like solution around "ti,omap3430-timer" which is
 > calling dmtimer_systimer_select_best() and later dmtimer_is_preferred()
 > which in this case would allow us to get rid of cases which are not
 > suitable for clocksource and clockevent.
 >
 > And there is drivers/pwm/pwm-omap-dmtimer.c which has link to timer
 > which is providing functions for it's functionality.
 >
 > I have also looked at
 > Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml which is also
 > the same device.

Ok, I will move this under bindings/timer.

 >
 > And sort of curious if you look at
 > https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v2_0/pg079-axi-timer.pdf
 > ( Figure 1-1)
 > that PWM is taking input from generate out 0 and generate out 1 which is
 > maybe can be modeled is any output and pwm driver can register inputs
 > for pwm driver.

I don't think that is a good model, since several bits (GENERATE, PWM,
etc) need to be set in the TCSR, and we need to coordinate changes
between timers closely to keep our contract for apply_state(). Although
that is how the hardware is organized, the requirements of the
clocksource and pwm subsystems are very different.

 >> @@ -0,0 +1,85 @@
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
 >> +         - const: xlnx,axi-timer-2.0
 >> +         - const: xlnx,xps-timer-1.00.a
 >> +      - items:
 >> +         - const: xlnx,xps-timer-1.00.a
 >> +
 >> +  clocks:
 >> +    maxItems: 1
 >> +
 >> +  clock-names:
 >> +    const: s_axi_aclk
 >
 > Origin driver is not using this clock name and it is only one that's why
 > it shouldn't be listed.

The old driver does not use the clocks property. So this property is
only required for new bindings. Note that if the clocks property is not
present, we fall back to clock-frequency, and if that is not present we
fall back to /cpus/timebase-frequency. However, these methods are
deprecated, so they are not documented here.

 >
 >> +
 >> +  interrupts:
 >> +    maxItems: 1
 >> +
 >> +  reg:
 >> +    maxItems: 1
 >> +
 >> +  xlnx,count-width:
 >> +    $ref: /schemas/types.yaml#/definitions/uint32
 >> +    minimum: 8
 >> +    maximum: 32
 >> +    default: 32
 >
 > This is not accurate. It should be enum because only 8/16/32 are valid
 > values here.

According to the datasheet the allowable values are "8-32", so that is
what I put. Perhaps it should be updated?

 >
 >> +    description:
 >> +      The width of the counter(s), in bits.
 >> +
 >> +  xlnx,one-timer-only:
 >> +    $ref: /schemas/types.yaml#/definitions/uint32
 >> +    enum: [ 0, 1 ]
 >> +    description:
 >> +      Whether only one timer is present in this block.
 >> +
 >> +required:
 >> +  - compatible
 >> +  - reg
 >> +  - xlnx,one-timer-only
 >> +
 >> +allOf:
 >> +  - if:
 >> +      required:
 >> +        - '#pwm-cells'
 >
 > Let's discussed this usage based on design.

I don't understand what you mean by this.

 >
 >> +    then:
 >> +      allOf:
 >> +        - required:
 >> +            - clocks
 >> +        - properties:
 >> +            xlnx,one-timer-only:
 >> +              const: 0
 >> +    else:
 >> +      required:
 >> +        - interrupts
 >> +  - if:
 >> +      required:
 >> +        - clocks
 >> +    then:
 >> +      required:
 >> +        - clock-names
 >
 > And this checking should be removed too.

See above.

 >
 >> +
 >> +additionalProperties: true
 >> +
 >> +examples:
 >> +  - |
 >> +    axi_timer_0: timer@800e0000 {
 >
 > label is useless here and should be removed.

Ok.

 >
 >> +        #pwm-cells = <0>;
 >> +        clock-names = "s_axi_aclk";
 >> +        clocks = <&zynqmp_clk 71>;
 >> +        compatible = "xlnx,axi-timer-2.0", "xlnx,xps-timer-1.00.a";
 >> +        reg = <0x800e0000 0x10000>;
 >> +        xlnx,count-width = <0x20>;
 >> +        xlnx,one-timer-only = <0x0>;
 >> +    };
 >>
 >
 > I would list example without pwm-cells first as it is valid and reflect
 > current status.

Ok.

--Sean
