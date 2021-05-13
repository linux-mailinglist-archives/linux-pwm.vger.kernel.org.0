Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB9937FAB2
	for <lists+linux-pwm@lfdr.de>; Thu, 13 May 2021 17:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhEMP3w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 May 2021 11:29:52 -0400
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:62599
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230406AbhEMP3v (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 13 May 2021 11:29:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnXZgrwZeV6O0kwb8jZvfX96SqF7fe3Ipy0pqaiz1+wtCG1lGg0k2vtVeivAyYOcVqnHF5lxvx1OJcmZ7lMKT9bxqpXLtAggtI+ry2FpuC40JyLgVAvRmrGjh2wj5cRXuZcrDFNB3SOBpUyLXJD7sMXCfS2hAXNlOo3qlwuJnMDKPiZnO5xHE5f7KLv3SHUtjRMWmCZjrG9y6udpF80sCtmgC3u7yxWXGEm/ZHKWUOE6XNlmTGM2sF+8uKpaxhTRWz0YPs2OXrSJMhmt8yFKAeXz6M/AekEJDK+n/Y3Ud7ObevMoq9hwRiJaE+VgTZNZODTnPLck92yuIgORTLWngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKLGCrZHbRkOgG2WAd088yygGKih/WdcefAL/1MTA0A=;
 b=gKHtXnAyiVlTkK1HJJKdlMLPDQnqMle9CITxr3UVgUDGVvyH3Jpa8w+ABL0Wkz5vU8SJysLGLRPMEiqZUjptPptUgxo050jq3uDgT/VDJlNHMBUOPwTb9Gmr6G9VyzBnMqdc/GAWcEn7bPWROOXzKYl2LEfeJ8w74RcZVGt+WteMchiI5NIdk+0cp9owAPniZacA9Ndh2fJ7wMdbdL7WfgEeZ8rqFGIOnluo7OAztpHAbwikmzy1M1C81WSWelLs99T2+2RtXxDdM2vg5TgJ5bM2R7M88OPUCh/ZJ0X6F8jt/POEQn9bD59xCbKCu95X+A+VnZeD4f5yOGC3HuiCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKLGCrZHbRkOgG2WAd088yygGKih/WdcefAL/1MTA0A=;
 b=erzt7dFli76clENdia7XSRbow1kRbsUy5RV8+ImWKgtoozBZfhJvuB4iVE4+TbrPp+cDMZAhVm8hAk3hrc3fbGK1nGmtOOx2E1r4K7dIm/BQoBamntyYYovbpFqYsR0Bi0Wr+7GiUT7jeh2C4YhoV8fibSWQrz9cFcn/h5iBaGI=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0301MB2438.eurprd03.prod.outlook.com (2603:10a6:4:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Thu, 13 May
 2021 15:28:39 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 15:28:39 +0000
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
From:   Sean Anderson <sean.anderson@seco.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210511191239.774570-1-sean.anderson@seco.com>
 <20210513021631.GA878860@robh.at.kernel.org>
 <f9165937-c578-d225-9f5e-d964367c4711@seco.com>
Message-ID: <70176596-2250-8ae1-912a-9f9c30694e7d@seco.com>
Date:   Thu, 13 May 2021 11:28:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <f9165937-c578-d225-9f5e-d964367c4711@seco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:23a::12) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:23a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 13 May 2021 15:28:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe69d59f-6132-41d8-df31-08d91623c8ab
X-MS-TrafficTypeDiagnostic: DB6PR0301MB2438:
X-Microsoft-Antispam-PRVS: <DB6PR0301MB243818F875F7CF076FF2BC3496519@DB6PR0301MB2438.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1npFq5AVL3Gn0otzgQhnj3mcUBLJVrTiq3PIAxQnCMCpnVYJeV8Ofb2NSXx2I8QoIJBZvhuVXYlyLQVyERjg70zW2L6q7soAGUR+2c35xdpz0IOwYj0BbH67EewqPvBR6JK3uDsxlx7xCxMgEMWjCUkpa2Bwig/sTXoaT1TZBMJXqIE7Wn1ypzkfEtsekPsaWmiVNizQdzZz9LbowqttR3Yu2UHx23TM71Kc2kso5GPvMI3dm4cyYkcacR02HDmKokoBFvkzGoeyZZb5G6dRl+KhzPkrRBDjy2RYdNu7bdGa3oIDLjPNMun/jYqbH5iH9HYFu4cyXil/sLiJTslKMEWLMx6GjTJD54dFFmEhi855cNEPsPVvMGtqJvAZ13kiPhSBtIXVnLlmHdodLCH+Xx/QyWwuQevBps31mkZOE2OPrT4WirRHCZixLXA2p3SzTxWXBVllZUwHx1tNIuoja1CfnQO5V3kQV41BNIeGDEAHWZJHIR4htu8krAwLffNlIydRyjP855CewoSwGzrdAAjsVUEJbGwtEM370gWzqruYWvVFJyKV6go7mBhPejbOykMM9kVNVq97hqFt0fz2v8VNCkeEgNStnEu5oAZ3OexZI8T7Mflz0zhI2C49CPa6c1SABZ5RdHxNlaPFeZZQkRfG1LnbZOG8FPbc41iXZGhROWXRtTDJhWJuTHfdtmySHMgtsdKJ4j6szaTmZv5VZ+V1Dp0FKL2bE6mnhTjxLrs1Ua6Y8OoRhCv+zmze1943fwff5Rc+FK8tA+6KU8GMdPtzEK5axBWGxkZlAXk1oBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(186003)(4326008)(52116002)(6486002)(66476007)(6916009)(16576012)(8676002)(2616005)(16526019)(2906002)(44832011)(66946007)(956004)(5660300002)(966005)(38100700002)(38350700002)(83380400001)(31696002)(86362001)(31686004)(26005)(66556008)(498600001)(36756003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SUdoQUNscDQ1WVl5TG1XRVYraXZMRk1jWW96L3MvS0JmOFhjVkhTa3VJVFpr?=
 =?utf-8?B?Znc3MDdCdTk4Zjl5SDJDWVhMNEFFZ2FOeU5RY0V5SGtBSmd2L013cEFEREM1?=
 =?utf-8?B?TVBNKytyMDNQcHBwVWc4Q3hORmdwNnNSYXNMMEVTRm01dlVaSnNUV21kNUFH?=
 =?utf-8?B?cGx4c0JjVEFOWGxTRU11b1NCNUFoQ29rSWdpV2dSTVdEL1RFMGNWRlRyVE80?=
 =?utf-8?B?Q0lnbU4zYmFLK0xOd3VKUTlFSXBSK2pEeFBpR1kramJCVHJDL2RnTk91eWtF?=
 =?utf-8?B?TWJNbFZSS3N0TDBlcWdHeGdNenhhMXkvcVI2TkkxUHBwV1BNbVl0MXhRNjZV?=
 =?utf-8?B?REFoRS83QzRhem5KRkJHL1pYczkxZ0xWQUNEcUV3K1pESjFqRXo3OGFzbXVv?=
 =?utf-8?B?RmNmY1dSRWZ5QkdEakd0OGwxMWxFL0JuVFFwZWZXSTBjWU9qd1JUTWxSMkRj?=
 =?utf-8?B?S2pkbDJ6STVHeXZabGhzV1NCMTdFWU1jVTlPa3pDRDI0c29hYmRJUkhDbmUy?=
 =?utf-8?B?YnIvMUd6ZXhYN0JvaUhhSFVzV0V3VnRiUURaYnJMRnhsSVBvbmFjcFJFSTMz?=
 =?utf-8?B?cFFuaXNtTGxMM1lUdjF5Q0lTa3dUOERyRXoxNit0K0hQaW1pUk0rYlpvV1B0?=
 =?utf-8?B?dnpDdHFVVzNjU0JjdW4rdEowQ2VKa2JTbFlNZEwrZXRTbWJNM3RBZkJOa2JI?=
 =?utf-8?B?WlJTSWpJSnFQaGJYbFU2VUZCU0Z2bXBwdkNqTjdSaHBITHlWMzRLUXRnRVZT?=
 =?utf-8?B?cy9CWWZQSlRLYTl2UEozY01zK0NQNU5keDJPNFN4S1V2V3RrUVh5TThwblRU?=
 =?utf-8?B?UUxnUk9vY1hPQVlUbUIvNGNtbjVqeVgyYmFZeU4wcjlSTzA2OUlCZXRtUjRt?=
 =?utf-8?B?YlB2L0VZd05DT2Q0YklZd01zZ0J1bFhBbmtIakcrYVJkS0hVUjkwMkVqTEJq?=
 =?utf-8?B?MElIMU0vZDdmWDcvbGt4V1plOG1SQnRxUDhoSHpTVEdPYmQvc0dQRFhhSVlt?=
 =?utf-8?B?a3dGWEEzcno5ODJMajZYdWlnd1NtVWFKTHBiN2Q4NDl3bnBvT3ltaGZRSFdr?=
 =?utf-8?B?QmcrSGQ3eGhiTHBzRXJZZFZOdHVQTHRZTVF5NTZTanhCUVpCVnBMbFdRTVdi?=
 =?utf-8?B?YzdOVlF4N1lKaTFJajBERnAxTmhWVElkeVJCcDlzdXVsN3ZBdk81MW00cFlT?=
 =?utf-8?B?SkhzenlPQUp2L2ZVWmgwQ2dDU1lGMWtZWGdXV0dWSWtUeGJLcTNVY1BQTzRB?=
 =?utf-8?B?SXR1MFVSM2hnbjZjbzIwN2ZvK0FCMDI5UXI3SjZjUnpjdmVqcktGTTJuWlc5?=
 =?utf-8?B?R3BaekVlNW9LOVp1b0ZrOSt4T1Jzd2Q3bDNZTHhqL3FMWkNFK20rWXZjRDVh?=
 =?utf-8?B?ZlVRdXdlQTU0d0ZsMTI1dWs5NXF6Qm1oNjlsNzZtOWQ1b3FZR09tT2VEMXk5?=
 =?utf-8?B?aTRhZEF6V2Z2c3lVU0plbDBMWlVJK0ZuY2QxZzhiNk9TV3R1Rlh6RlpyUitz?=
 =?utf-8?B?QWpRTjFrcVZuSFNKQmVzK1VkaktpSkFmUi9LZUxBRG9URHJNYXgvanlFS3d2?=
 =?utf-8?B?N0NFZHlrSW1VK1Foa1hYNWNRN0NvZFc1Zk9lcWV0dURIejBjRnR2NElQR2hk?=
 =?utf-8?B?cjVJemVKdEVGNVFjK2YvWTljVjJiUkJPcGVBejRCekNDR2p2YkR5RXBMVjVo?=
 =?utf-8?B?UEEwSmZJNm05OEFRY3UwUmtpYWNoc1IyNWFVL3JoUExjQlF0NFBCYzdGZUo4?=
 =?utf-8?Q?LeeF97OZHRblZpBMqZJBqw3RVPqyYb1HRV1Ip1+?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe69d59f-6132-41d8-df31-08d91623c8ab
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 15:28:39.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FKn6TQNX4OmsEdbBvWet80LtorQwCzosXZJTgAK66z4L+6VgDyPb4XBaVqf4VDmS9AA1DKvU2jpn4tKEiR2Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2438
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/13/21 10:33 AM, Sean Anderson wrote:
 >
 >
 > On 5/12/21 10:16 PM, Rob Herring wrote:
 >  > On Tue, May 11, 2021 at 03:12:37PM -0400, Sean Anderson wrote:
 >  >> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
 >  >> a "soft" block, so it has many parameters which would not be
 >  >> configurable in most hardware. This binding is usually automatically
 >  >> generated by Xilinx's tools, so the names and values of some properties
 >  >> must be kept as they are. Replacement properties have been provided for
 >  >> new device trees.
 >  >
 >  > Because you have some tool generating properties is not a reason we have
 >  > to accept them upstream.
 >
 > These properties are already in arch/microblaze/boot/dts/system.dts and
 > in the devicetree supplied to Linux by qemu. Removing these properties
 > will break existing setups, which I would like to avoid.
 >
 >  > 'deprecated' is for what *we* have deprecated.
 >
 > Ok. I will remove that then.
 >
 >  >
 >  > In this case, I don't really see the point in defining new properties
 >  > just to have bool.
 >
 > I don't either, but it was requested, by Michal...

Err, your comment on the original bindings was

 > Can't all these be boolean?

And Michal commented

 > I think in this case you should described what it is used by current
 > driver in Microblaze and these options are required. The rest are by
 > design optional.
 > If you want to change them to different value then current binding
 > should be deprecated and have any transition time with code alignment.

So that is what I tried to accomplish with this revision. I also tried
allowing something like

	xlnx,one-timer-only = <0>; /* two timers */
	xlnx,one-timer-only = <1>; /* one timer  */
	xlnx,one-timer-only; /* one timer */
	/* property absent means two timers */

but I was unable to figure out how to express this with json-schema. I
don't think it's the best design either...

--Sean

 >
 >  >
 >  >>
 >  >> Because we need to init timer devices so early in boot, the easiest way
 >  >> to configure things is to use a device tree property. For the moment
 >  >> this is 'xlnx,pwm', but this could be extended/renamed/etc. in the
 >  >> future if these is a need for a generic property.
 >  >
 >  > No...
 >  >
 >  >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >  >> ---
 >  >> How should the clocking situation be documented? For the moment I have
 >  >> just left clock as optional, but should clock-frequency be documented?
 >  >>
 >  >> Changes in v3:
 >  >> - Mark all boolean-as-int properties as deprecated
 >  >> - Add xlnx,pwm and xlnx,gen?-active-low properties.
 >  >> - Make newer replacement properties mutually-exclusive with what they
 >  >>    replace
 >  >> - Add an example with non-deprecated properties only.
 >  >>
 >  >> Changes in v2:
 >  >> - Use 32-bit addresses for example binding
 >  >>
 >  >>   .../bindings/pwm/xlnx,axi-timer.yaml          | 142 ++++++++++++++++++
 >  >>   1 file changed, 142 insertions(+)
 >  >>   create mode 100644 Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >  >>
 >  >> diff --git a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >  >> new file mode 100644
 >  >> index 000000000000..a5e90658e31a
 >  >> --- /dev/null
 >  >> +++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >  >> @@ -0,0 +1,142 @@
 >  >> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 >  >> +%YAML 1.2
 >  >> +---
 >  >> +$id: http://devicetree.org/schemas/pwm/xlnx,axi-timer.yaml#
 >  >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
 >  >> +
 >  >> +title: Xilinx LogiCORE IP AXI Timer Device Tree Binding
 >  >> +
 >  >> +maintainers:
 >  >> +  - Sean Anderson <sean.anderson@seco.com>
 >  >> +
 >  >> +properties:
 >  >> +  compatible:
 >  >> +    oneOf:
 >  >> +      - items:
 >  >> +        - const: xlnx,axi-timer-2.0
 >  >> +        - const: xlnx,xps-timer-1.00.a
 >  >> +      - const: xlnx,xps-timer-1.00.a
 >  >> +
 >  >> +  clocks:
 >  >> +    maxItems: 1
 >  >> +
 >  >> +  clock-names:
 >  >> +    const: s_axi_aclk
 >  >> +
 >  >> +  reg:
 >  >> +    maxItems: 1
 >  >> +
 >  >> +  xlnx,count-width:
 >  >> +    $ref: /schemas/types.yaml#/definitions/uint32
 >  >> +    minimum: 8
 >  >> +    maximum: 32
 >  >> +    description:
 >  >> +      The width of the counter(s), in bits.
 >  >> +
 >  >> +  xlnx,gen0-assert:
 >  >> +    $ref: /schemas/types.yaml#/definitions/uint32
 >  >> +    enum: [ 0, 1 ]
 >  >> +    default: 1
 >  >> +    deprecated: true
 >  >> +    description:
 >  >> +      The polarity of the generateout0 signal. 0 for active-low, 1 for active-high.
 >  >> +
 >  >> +  xlnx,gen0-active-low:
 >  >> +    $ref: /schemas/types.yaml#/definitions/flag
 >  >> +    description:
 >  >> +      The generate0 signal is active-low.
 >  >> +
 >  >> +  xlnx,gen1-assert:
 >  >> +    $ref: /schemas/types.yaml#/definitions/uint32
 >  >> +    enum: [ 0, 1 ]
 >  >> +    default: 1
 >  >> +    deprecated: true
 >  >> +    description:
 >  >> +      The polarity of the generateout1 signal. 0 for active-low, 1 for active-high.
 >  >> +
 >  >> +  xlnx,gen1-active-low:
 >  >> +    $ref: /schemas/types.yaml#/definitions/flag
 >  >> +    description:
 >  >> +      The generate1 signal is active-low.
 >  >> +
 >  >> +  xlnx,one-timer-only:
 >  >> +    $ref: /schemas/types.yaml#/definitions/uint32
 >  >> +    enum: [ 0, 1 ]
 >  >> +    deprecated: true
 >  >> +    description:
 >  >> +      Whether only one timer is present in this block.
 >  >> +
 >  >> +  xlnx,single-timer:
 >  >> +    $ref: /schemas/types.yaml#/definitions/flag
 >  >> +    description:
 >  >> +      Only one timer is present in this block.
 >  >> +
 >  >> +  xlnx,pwm:
 >  >> +    $ref: /schemas/types.yaml#/definitions/flag
 >  >> +    description:
 >  >> +      This timer should be configured as a PWM.
 >  >
 >  > If a PWM, perhaps you want a '#pwm-cells' property which can serve as
 >  > the hint to configure as a PWM.
 >
 > Ok, that's a good idea.
 >
 > --Sean
 >
 >  >
 >  >> +
 >  >> +required:
 >  >> +  - compatible
 >  >> +  - reg
 >  >> +  - xlnx,count-width
 >  >> +
 >  >> +allOf:
 >  >> +  - if:
 >  >> +      required:
 >  >> +        - clocks
 >  >> +    then:
 >  >> +      required:
 >  >> +        - clock-names
 >  >> +
 >  >> +  - if:
 >  >> +      required:
 >  >> +        - xlnx,gen0-active-low
 >  >> +    then:
 >  >> +      not:
 >  >> +        required:
 >  >> +          - xlnx,gen0-assert
 >  >> +
 >  >> +  - if:
 >  >> +      required:
 >  >> +        - xlnx,gen0-active-low
 >  >> +    then:
 >  >> +      not:
 >  >> +        required:
 >  >> +          - xlnx,gen0-assert
 >  >> +
 >  >> +  - if:
 >  >> +      required:
 >  >> +        - xlnx,one-timer-only
 >  >> +    then:
 >  >> +      not:
 >  >> +        required:
 >  >> +          - xlnx,single-timer
 >  >> +
 >  >> +additionalProperties: true
 >  >> +
 >  >> +examples:
 >  >> +  - |
 >  >> +    axi_timer_0: timer@800e0000 {
 >  >> +        clock-names = "s_axi_aclk";
 >  >> +        clocks = <&zynqmp_clk 71>;
 >  >> +        compatible = "xlnx,axi-timer-2.0", "xlnx,xps-timer-1.00.a";
 >  >> +        reg = <0x800e0000 0x10000>;
 >  >> +        xlnx,count-width = <0x20>;
 >  >> +        xlnx,gen0-assert = <0x1>;
 >  >> +        xlnx,gen1-assert = <0x1>;
 >  >> +        xlnx,one-timer-only = <0x0>;
 >  >> +        xlnx,trig0-assert = <0x1>;
 >  >> +        xlnx,trig1-assert = <0x1>;
 >  >> +    };
 >  >> +
 >  >> +  - |
 >  >> +    axi_timer_0: timer@800e0000 {
 >  >> +        clock-names = "s_axi_aclk";
 >  >> +        clocks = <&zynqmp_clk 71>;
 >  >> +        compatible = "xlnx,axi-timer-2.0", "xlnx,xps-timer-1.00.a";
 >  >> +        reg = <0x800e0000 0x10000>;
 >  >> +        xlnx,count-width = <0x20>;
 >  >> +        xlnx,gen0-active-low;
 >  >> +        xlnx,single-timer;
 >  >> +    };
 >  >> --
 >  >> 2.25.1
 >  >>
