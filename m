Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4E540E8F0
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Sep 2021 20:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346011AbhIPSBG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Sep 2021 14:01:06 -0400
Received: from mail-vi1eur05on2083.outbound.protection.outlook.com ([40.107.21.83]:5760
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346604AbhIPR7u (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Sep 2021 13:59:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/KI2mB8jPx+BL8H1nM26gSM7WxatUEJE3qkkZOmtyGsx3j3xaItn/JvMZP3htE8bZB7HqV/DcxAhibUofSbW2iLOIoR52F0dvA1Y4RofoRYkq1W2mZ8jCobdOKrd7AW8m2cI6B/6SoRSdGoxcCcYo98yDc1IbbOS6JQwCeVg4Y+hxECNeJ9439wSuBvoBDDz6XVElq7gXOqjs9Xd/XSajHz4KN3fKSdhrswIz5BoU0rkpUgEZ4E4ctClgx12UScD7oUqyxvMuw+ENH6CyYtXlxVrCFSx81MyZ9D+Mql8tMcNHh33oiE+qYAFP3QZqQcS12/G1FXDnFaW990pdjc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=r7mOsISt8kqqnY4a0HhR33LGSpAbo2qczJbCtIRoEwY=;
 b=DcjvR4FRsD7fFzHDib3X/ZhzMOH9SafCgi+dkMUGujVEqzqEWJA9EkJwhUcXyjyOJ0oX8xR88Znz9xCCRQ5mAGCIDCAoRFywfljNlQY5KeKjpUPuAZj6x2I9bYaZqdl0OTHj56jlUXzg0MkOivuy7SiOYdqbJnPWaaZtkPL9eNZUsxLSk74Wpzbth+vpSnBjEq9NfVCOzcTYWy3xqMPaOLCPAH3zxR7RxRvXLS7u2mRswBemdi3J/nqdCVJD4e0x7eCb/p+3pUcQBeswmykj1o1kg9nLOPd2jOZaMvn7px26+usXIKjDSQ7NfB68dEF2u1p3euUl1n8PPc6vGXYFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7mOsISt8kqqnY4a0HhR33LGSpAbo2qczJbCtIRoEwY=;
 b=z02XDPceolrk6j13rr0qI8oaEVPN5sEb2199b02oqTbaiPSgMu8lCMb9WbmjsnT5RikoePUFSf55C79kWCDGpeEwzPKhmJ+MpCaWoyvUWDbz6OOUF5qdXvbWJUeeLQ9rMeUckMthluUy1QAOoHX1iL+hm197gNTaT+LT4m/4FGc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB6700.eurprd03.prod.outlook.com (2603:10a6:10:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 17:58:26 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 17:58:26 +0000
Subject: Re: [PATCH v6 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org
References: <20210826211830.3311140-1-sean.anderson@seco.com>
 <YS6M9jmTmy4EvB4k@robh.at.kernel.org>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <eedf3b19-18be-50ca-783e-c9537498db4a@seco.com>
Date:   Thu, 16 Sep 2021 13:58:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YS6M9jmTmy4EvB4k@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:208:2be::14) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0189.namprd13.prod.outlook.com (2603:10b6:208:2be::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Thu, 16 Sep 2021 17:58:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbae0156-ae85-4c65-f55d-08d9793b94e9
X-MS-TrafficTypeDiagnostic: DBBPR03MB6700:
X-Microsoft-Antispam-PRVS: <DBBPR03MB6700F8976C498D33E82897B296DC9@DBBPR03MB6700.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Jbw7A8Uww0V18iY0YvZnaqd78ggCLD8ET0YX1crpTC9EigMIvlKBrNSyv/d1kpcPENmnY0GIvMR3xIAR8jFSwcEnTexEARjHH07GMc7+PZnK++6OvZQw9kNDWisXkHTklmaa1tKA0qjZ+KzJaOimcqXl9pDEO8KNlnJf+bkBd/AxI9SGY8VF6wF+iDTnefag3N/TyShU8YE2CkM+hJI+gFkY3CO3N99kOw8q2diStaO0aDn6hmhgqj6JntvSiWmuUBqHWf6vQZB9WL+otuvmnWQWv1soAtbAuUp1pORGl2maNioJQ28g2FsQplhx45jQmmESlj6sOI8QgOTd+6Yo1W1bJhHaRMiybG6vQsnNsyXg+4Vb0GVmLxaJKupwfN064GkrAeltrYP+mjGExjY8XS/d2bTQ3Mtz9k77GWRN6Os4jk62P3M79BiQGZEB22kRr+S51b3sdSLv6EjXA9HTusAp7b/Eccy9VdHz8T/UgcWMXrWaB5hBM82gA3K7Du7Jv5b2TyflMOZzmwLheO5VEsJ4S2ZSkSdFmXAvpWsXRM2L78TSoLJfk3RWngngucC97n08e0pAbiwISiVfTx6Zt/4JqvmydbFcBwXTQWboO5v2qLYv5Wx8pWBk7+Mnr7i/OetHnLOyBKQirM39yffEX7IfRrKW4gsmxCz/8AQ6GR+xDagMTtb5NLdmQhDAo/Pvvunltiia6qmjoyE2mgAzZdG2Bcc48JMQGVDR76biFzNcIWSDoFCl1rzLkEUnR4MnEJXpfwKuKJYtzbj0ZHO33mTkHhaETryGLADVIVc/wKoW3FDUGkVA2KP4aIpRmvn/06ZyxBQ3UTQrm2vWi5jOXzmxETkNT66jfiYSD7/rlo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39850400004)(346002)(366004)(376002)(8676002)(316002)(53546011)(2906002)(31686004)(86362001)(8936002)(52116002)(478600001)(38100700002)(38350700002)(16576012)(54906003)(4326008)(44832011)(36756003)(66556008)(6486002)(66476007)(6666004)(66946007)(2616005)(956004)(5660300002)(31696002)(7416002)(26005)(6916009)(966005)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFNncG9hR0JDWkxLclprOG5DU3BOM00yZkZGdzVWeU9qWWlWSzdiaUxmUEJR?=
 =?utf-8?B?RGthK21JajZWOWhLbHh1TWcxWGZxcVhsbUFCcjFuczNBVFRZdlZwdGxKdFI2?=
 =?utf-8?B?TGFsQnFENk5tdE9ta3pyTjYwbTlWRjI4cHdwdFF4b0hJRmpkdUxpRDVEQTBV?=
 =?utf-8?B?TXQ0bWQwWklJT1dQVmNrbnEwZjhCdldZVXNNbDNCWk9saDlmcmZnTW4xYkdr?=
 =?utf-8?B?VmpZMmNGL092ZGdSYnU3YUt2OGxiQ0tRMFZCTStlNW5KMjlnd2tvS1Z2T2xU?=
 =?utf-8?B?MFZXVG4wdkd6eGpScGkva2xoNld6MFhVa3lIb05wTGZSQ1Nta3ZEaEhuZXhx?=
 =?utf-8?B?TlJnRUxsQk4xY2hkWTVIUlR1VzRKazZZVllYTlN2aGkxcm5aM0FjU2dubVdW?=
 =?utf-8?B?RkdhU21yVDFUNHYraUt4bzY2d0N2aUYyM2NNdFUzbHRaYVk0MzdxbkNtQmtY?=
 =?utf-8?B?SXdxbjVDdUZUU2ZOYndIbUNLZ2FsWHYrUTloTFlzM0IxQ3hrWmNSbEdsVTJZ?=
 =?utf-8?B?ZEh6WFFzWDNFTXZkOFlwdzlBRzJocTFtTHZSVXMvQm9FNlBlUS9wR0dHdUFv?=
 =?utf-8?B?Sld3RUk0VUgzb2xqODNsdk14WTJiSUtWc3JFS3FuOE9EWTlXdGlxMTlkOExS?=
 =?utf-8?B?MktSS0I1eTdFSlVYSzF1ZmVOSWVTaWh5UTkwWGlzclFsNVpmbU5meHhrWlVZ?=
 =?utf-8?B?WEUxNnkvdklzeklnb1NOWjYyTVBaazlnbExhdWlLZjRjSUdlTi8raThVdlJu?=
 =?utf-8?B?ZytuRW1ZVzJscGZFblQzbXVNRHVYd3RHQ21XZ0ZjRXdKT09IVzlDODdzdHJQ?=
 =?utf-8?B?RnVHQmVhelRjVERZdGhFTmRrODExYmg1M2dLbmVuZlpHcTZJaFpjeWFBVzdF?=
 =?utf-8?B?UU9KbjhGbzM5NnhzNXFiVXNJeTU2dlhvYURLa28wc1N3aWhTVVNFQit2SERl?=
 =?utf-8?B?enY3T1YvWVFZSjRxOXNEUjcrbXJjRWVzMVJYVHIxNVJ2N0NYS1FlbU82cFNS?=
 =?utf-8?B?ZUY4VE9JdTE2VldnQjE3MGhIcXgzZkNqZXZXWHFrdi9jR0F2aEpzZkwrZk1x?=
 =?utf-8?B?ZFZZTDZ6V2R5YWNnSW9qODd5S25oVEZ4YUYyOUpQR1Y3QlJscjVWVnRvaTFJ?=
 =?utf-8?B?TERaTHlYV2hOOFFtMEZYZGQwMDJUQ3czeFNPZG5Db05LNTlaZ0RlTjZId3ZP?=
 =?utf-8?B?eFVKczFVYTZjdStyZW52U3Z4cDB5MjB4SWJtcVBiQkJRU1hFSHZ0WFd5QjRK?=
 =?utf-8?B?L2FlNDRpbkxLQ3VJQjV3WFpWd3Qydk1MNndxSlZDaDRHWHdtK2Y3aG12V0N2?=
 =?utf-8?B?d2ROQmdkMDN2UmdYZldaV0tPNXhEWklJRmQ0V3lEKzJhd1BqMFg0ZGNxWXNs?=
 =?utf-8?B?VmdyeTVFbXlkMExZT2lkdlB0aVJlL1Vja2xIc0lRZGYvR0t4aEUxdHNIcWdF?=
 =?utf-8?B?dldpSnA0VVdqU0owRTkvVmRWa0tkQzBidDA2TTN5VVdlV3liLy9wamRUM05E?=
 =?utf-8?B?cnVlWm4yWGlZblYydlNOVkNxM2JuOFJsN05MaVFjb1N3RkoxclFaY2J2SUQv?=
 =?utf-8?B?QlY2S05ob21zcDRmK3pXd1RvT0Z6bVlNdnFqUnBsR1NrZE5HcXYrME5hUzlo?=
 =?utf-8?B?UTZZZ2VyOVVqd1NQekQ0N1h5UG5oczNFS1FWVGhmU1BNSlBVWUpGWFFrSkpn?=
 =?utf-8?B?NjR1UzZVdG45dGdUcUJJV2hNSzhNL044bjUxZ2hSR2dTclhySW5UemhzdU1z?=
 =?utf-8?Q?hOUK6qGfj9MOAYRii0ONlQBbpG8zaqSZyWXD2nr?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbae0156-ae85-4c65-f55d-08d9793b94e9
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 17:58:26.0076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZIwUOvlvXyxTTDT6E7G4RsoRJmCJ7YFYBuWPJS/AYWMP10EhsIqFj1ukI3tiw0LSpv2ZCUmkEYqIuFcOdDaug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6700
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 8/31/21 4:11 PM, Rob Herring wrote:
> On Thu, Aug 26, 2021 at 05:18:28PM -0400, Sean Anderson wrote:
>> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is a
>> "soft" block, so it has some parameters which would not be configurable in
>> most hardware. This binding is usually automatically generated by Xilinx's
>> tools, so the names and values of some properties should be kept as they
>> are, if possible. In addition, this binding is already in the kernel at
>> arch/microblaze/boot/dts/system.dts, and in user software such as QEMU.
>> 
>> The existing driver uses the clock-frequency property, or alternatively the
>> /cpus/timebase-frequency property as its frequency input. Because these
>> properties are deprecated, they have not been included with this schema.
>> All new bindings should use the clocks/clock-names properties to specify
>> the parent clock.
>> 
>> Because we need to init timer devices so early in boot, we determine if we
>> should use the PWM driver or the clocksource/clockevent driver by the
>> presence/absence, respectively, of #pwm-cells. Because both counters are
>> used by the PWM, there is no need for a separate property specifying which
>> counters are to be used for the PWM.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>> 
>> Changes in v6:
>> - Fix incorrect schema id
>> - Enumerate possible counter widths
>> 
>> Changes in v5:
>> - Update commit message to reflect revisions
>> - Fix indentation lint
>> - Add example for timer binding
>> - Remove xlnx,axi-timer-2.0 compatible string
>> - Move schema into the timer directory
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
>>  .../bindings/timer/xlnx,xps-timer.yaml        | 90 +++++++++++++++++++
>>  1 file changed, 90 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
>> new file mode 100644
>> index 000000000000..5be353a642aa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
>> @@ -0,0 +1,90 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/timer/xlnx,xps-timer.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx LogiCORE IP AXI Timer Device Tree Binding
>> +
>> +maintainers:
>> +  - Sean Anderson <sean.anderson@seco.com>
>> +
>> +properties:
>> +  compatible:
>> +    contains:
>> +      const: xlnx,xps-timer-1.00.a
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: s_axi_aclk
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  xlnx,count-width:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [8, 16, 32]
>> +    default: 32
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
>> +
>> +additionalProperties: true
> 
> This needs to be false. What else do you expect to be present?

I am going to leave this as true for the next revision to avoid the following error:

arch/microblaze/boot/dts/system.dt.yaml: timer@83c00000: 'xlnx,family', 'xlnx,gen0-assert', 'xlnx,gen1-assert', 'xlnx,trig0-assert', 'xlnx,trig1-assert' do not match any of the regexes: 'pinctrl-[0-9]+'

--Sean

> 
>> +
>> +examples:
>> +  - |
>> +    timer@800e0000 {
>> +        clock-names = "s_axi_aclk";
>> +        clocks = <&zynqmp_clk 71>;
>> +        compatible = "xlnx,xps-timer-1.00.a";
>> +        reg = <0x800e0000 0x10000>;
>> +        interrupts = <0 39 2>;
>> +        xlnx,count-width = <16>;
>> +        xlnx,one-timer-only = <0x0>;
>> +    };
>> +
>> +    timer@800f0000 {
>> +        #pwm-cells = <0>;
>> +        clock-names = "s_axi_aclk";
>> +        clocks = <&zynqmp_clk 71>;
>> +        compatible = "xlnx,xps-timer-1.00.a";
>> +        reg = <0x800e0000 0x10000>;
>> +        xlnx,count-width = <32>;
>> +        xlnx,one-timer-only = <0x0>;
>> +    };
>> -- 
>> 2.25.1
>> 
>> 
> 
