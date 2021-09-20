Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A64D4119B3
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Sep 2021 18:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhITQY4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Sep 2021 12:24:56 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:60771
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229530AbhITQYz (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 20 Sep 2021 12:24:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1n1Q88CKc0znDAU+SW87JP8DPtlJaq7JfVnMrf6iCbugtXb/8PgTr/KCVUu6iuyN7/jHIdtTG+sZ4v/yQY0E5zQp3/pvQoCiAvQ32STy1Bg6LJLeuJaNXD+S5ve/LGmoouvaj7w1j42IraDB27ZPnRnE9OL47Bf06bxvjDoiDNF1Cg108xqf9Wk0in++KUoCCeHeg1IZz57xVpsZQhpzNRVoj2X2H5+2w8DGaJrgwtibYca6wSHnOHhccCIFNlhHparqbMzPQl+avG5ESPb4iS35zt7/CYpWUtrI7dLgy6uG3sTPYC8ap262360StvJg8oOAjxJ2/3OnEjLxmxXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wn9gnvdqr5sq/9GCl/yxZeyLJM+hUjA+OP3QW5nCxos=;
 b=TNawkrvK6MuJuHCy9hXvGGG+1Jo5Pu/di/zqTPCvbfbmksKacrQ1zqvRVi7kOzEj9vooaoe2WcpYNAkxOyxI0xpN2ac7SY9gF/gxg5HUQDRL179yBtZdnr4ca48pqQ8p+X5NNsfxnPOJMYJb5BZRkr+5P6W7YBbzAgY+vX1tXIWmqhwIMaGHb87UFEnFIsd0AscY/3sdIUzyjif3QKT3Kg9e+KfGdClnDAxZ/QsQZL/Ozn7FMFqRVju1q/pdREuwdv1lgGVV9bZWucFto8Sbi7Z3pba7Sp0wb2gMAY2WBJlq6+uy8gZlqsuCJm7+iVJuh6rV7mwQBP7dyzPa1aKafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wn9gnvdqr5sq/9GCl/yxZeyLJM+hUjA+OP3QW5nCxos=;
 b=eQSG1x4vW6nq20RCDTi67nLUp6PFab3+ZFijdSuVXUoSpgyOt6mGD8UcC34I+Jy+SiCAtdiR2jkcUd36YVLPyzbYtfmTV2BYI8E2yOO0kPpz2cmm9yRPLWfVyMvg7/BTgMRyKtT21oY4vUL0dbrq/p6OxECrlyFewZ7TXCcg6l8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBAPR03MB6549.eurprd03.prod.outlook.com (2603:10a6:10:19b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Mon, 20 Sep
 2021 16:23:25 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 16:23:25 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Rob Herring <robh@kernel.org>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210826211830.3311140-1-sean.anderson@seco.com>
 <YS6M9jmTmy4EvB4k@robh.at.kernel.org>
 <eedf3b19-18be-50ca-783e-c9537498db4a@seco.com>
 <CAL_JsqK+vfnGUpuQT=Bb3Zf0q7_M8aOUZao+e4icx+vtx5zssA@mail.gmail.com>
Message-ID: <0a88491b-7ccf-affe-32b7-ff7eea9726d5@seco.com>
Date:   Mon, 20 Sep 2021 12:23:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAL_JsqK+vfnGUpuQT=Bb3Zf0q7_M8aOUZao+e4icx+vtx5zssA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:208:d4::33) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR04CA0020.namprd04.prod.outlook.com (2603:10b6:208:d4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 16:23:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 085d8093-164e-4ca7-9914-08d97c52f8ce
X-MS-TrafficTypeDiagnostic: DBAPR03MB6549:
X-Microsoft-Antispam-PRVS: <DBAPR03MB65497F88E1857941D6987C9E96A09@DBAPR03MB6549.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcnKSiO6Qk0lQyooBcNkkOkCSuxedKt5wOtX+XpA7mjxTfpG9YTPux2Shg0yziiBu1wF1yCEPTbecOetgJPIOOj4v9GKme1IpIcSfqApSiclY8yUZHonkWBA84hQyVdZi7weL8fd0QmZUbybdf5PcS3blevTs3QJH42KxpjdYZyaQzrrpAntLeLwnn2hPg1my40wJeALAdXO4sSazFZrvFjeQRHB7sBZdXl8UoiOhbE81sz+7M6UJDPtRR+WY9RxxKuwtyke+fcgM03q1q/koT2259Nc7woMi8kJ4pXBzgLfqYO199QPTamfrvpCURZHgAhdsf40c5CTgTY5EKyJa2t1juA/f2ZC7PHT/bBE5iFElp+tGshCQiRmxQDuiVoQe9J4oVO674MWWSfJ1q/pZbSNWyD0yRi2ZehZNljVI/AkF8lSpTfys8/o+mhmNNTJwYrm7t5UkH2U2CIerehiZMPWefzVuud+y+tCZTIHEqijz+/oGjRCbQkae3nDO3irlTwmSkQYZN7+WzhW4yaQnxmds1vuaGjhYdk4XxSbJhRg27uZn8XFip6ISqLXCQp0KP7Hj/5OXKu29oVZIyVitPN5j/ZQy1JDNW07ZTI3NBSgy4vEG09HbkUeURGct7SPEQctGqJbp8qTKgdAHhZrbmISjEgjx6w5tpWYEs/XkQM/jjaKDfxiE1xelyQLE6e2sRsTCfLWNIYpHKtyOPttZKrQbZJYxYe3TKT9usNB1nhlUpb8+EEI6ZFmlZ/4Xyio1jfR2ZxS9XCFvU2MMnUsLCi+w8lTVzcasIyIaDtgUp/xL3DF1rAPBV77BWDViYLqb2UCLB1+sbu+hl+L8S9DNiMNw6z8Xxn2uJQHiqoS29A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(316002)(7416002)(956004)(6486002)(2906002)(36756003)(31686004)(31696002)(4326008)(38350700002)(5660300002)(83380400001)(16576012)(8936002)(8676002)(966005)(52116002)(2616005)(86362001)(508600001)(53546011)(44832011)(66556008)(66476007)(66946007)(26005)(186003)(38100700002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WExPVi9xNjRuMW5hYjdSTlZPN3BlNDk5VkRqcmg1ZDZmV1QyeGNDVzV0aTRI?=
 =?utf-8?B?MGFYc1BFSkNDYmcyUDB5RzRFbW9YcC9xNnRwcC9mcWtoMG82aXNkTkJWbDFY?=
 =?utf-8?B?dS90dEExOTdhY1dSRzdHWWZVZFJNM3V5dWxySDZmQmdwSTZvbkVhOWN2YXVi?=
 =?utf-8?B?RStyVFBtRkZRUjA4YkVLR0kwaDF3TzZPNWhYTzFMVGtHelRBemg3Q2tJSjZY?=
 =?utf-8?B?S1hiSzVEUzBtT2N5L3lJekVUaEhublVmc2pKQlQ1L0dlS0Q4SlAySVFDSmxS?=
 =?utf-8?B?UEtyUDNyMWFKT0FMeVozS05Gb3o1OXdXRkMvTSt4VGE0VUliYnJ3UnQzUHZN?=
 =?utf-8?B?RjNTcGx6dFBpd2Z6dVBhKzQ2clBDdG84Rkh5QytQZ0xMak4rNmRKajZ6TWRS?=
 =?utf-8?B?TVA5VFRyZGdTcXZNR2xWVmRoeTBKbUZqTE9ESW1Vd2plNGppTkdxaWljYTA5?=
 =?utf-8?B?eTJqd2ZYa1d3S1F5VEp4MFhDVFRmUyt3QVFOaXBQV3NocTZhZUVQNCtPcFpp?=
 =?utf-8?B?enFabU5TM0FwanVqVHJiMlpaUzJ4SEdYdFNBK01sN2x0Nk05U3FSOEhyUDl0?=
 =?utf-8?B?bDVldWVZcFl6Rjh5ditxdHE0Z0F2UThndnJDZzNnRjZxYkRXVERGSGoramcz?=
 =?utf-8?B?RS9lTXZ5NlZDQ04zTHBQbGtnVDdweXFtZEJPMU93VU1zbGdzUm1KaWN4RWx1?=
 =?utf-8?B?OTBocGhCQUhRV2VjekhyQUF2WC9pV0Q1dVlZdU1jcFB5dmRMMDlHOXZWUmVP?=
 =?utf-8?B?NXdVRU0yREJFNmlheWxZbnVKNUp3MzE4NjlrTWxEbmRVZDhoS3FEc2Iyd2px?=
 =?utf-8?B?akJsZjBKaWxkSVdHUzQ3SHUrb1VacGJEQ201T3N6YkovR1RjM3NzQ2JYVVJy?=
 =?utf-8?B?NXV1NTRwdUxKZ3pLd3hraFNXcmlVVlpUaUdhOG9OY0JZdm5QZ05tVkE1ckpH?=
 =?utf-8?B?cXlqT1BkcXJEZVhnSkphOU5PYXZXUm1vWlplMGdWaVJIbnRab2tMakxsUWpp?=
 =?utf-8?B?TGljRFdleG9JbHhlVHVPRTlkeXEyRDFQdlFqa29BaEQ5elhxMFFmNnNoZ2gw?=
 =?utf-8?B?eUNtSzRGbW04c3VISndUc3VEZG8vZ3FDTW00TVVPdlUwZnEzbWNrclFyMUJU?=
 =?utf-8?B?eXozdTc3VlJkcHBhS1NUMWk0Uk9ITFBaQ2p6OHBhVzVUczFjTmZLV2o1aEhl?=
 =?utf-8?B?MFBFcW42TVJVbHFIaDdwY3lIY3RZTHBlMldmYm1xYjZHd3VUMktRazRYMzBS?=
 =?utf-8?B?N2pOYWx3YkEzNUF1NVNsY05oVFBxU2s4V0xoQk5ydjBYK2plVmVCVTNsUG1Q?=
 =?utf-8?B?UVBBTkk1T0JvYnMramJmcm5PV3NSSnZsZFZ3ZW9hQUR2T0VSYVBIZzdDMkg5?=
 =?utf-8?B?NGdXdWMyM3JOMHVkeHFwdEIzVS9SZnlSaUtXT0YwaUdTTUN3VS9VQ3NVZ2Ns?=
 =?utf-8?B?cVZKV1BOYWhYYzQ3K0dDNnZCeGdGV2ZpS0VDVHJKNXFadXN2RDQyaVFEWDFV?=
 =?utf-8?B?VU5BeGl1eXpscU9NMW9QM3FFQ0E4bnZlWnJlWGIrNG53cTkvY1hGMHZxRXhj?=
 =?utf-8?B?T3dReHY3Ri9HL1FMYjZaRjIvcGFIZXJSb3o4U2dxdGN6dHNhb05kVTZxUTFV?=
 =?utf-8?B?NGt3VkVKaURCWE5DdjNuTFJINmJXZkFEYjQxSGhNbGJmVDJIWXdiYng3UmxW?=
 =?utf-8?B?akJPZHlCbklHdkw0c08xbTFJcjI0em1VZTJpZSt6RE56QnV3LytwWFE4b2Ny?=
 =?utf-8?Q?lmRY/z4OxKGRsNqphyVPJjsszIFyE9zmzuW12j6?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085d8093-164e-4ca7-9914-08d97c52f8ce
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 16:23:25.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ln352PTmK+TDC7iD0ODxFfyvwQCoZWYA06TIolZIHdzNlrjJmEWuUNpgW+KGKAkXIrN31O4N8eQxzlN4Ur5UKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6549
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org




On 9/20/21 8:35 AM, Rob Herring wrote:
> On Thu, Sep 16, 2021 at 12:58 PM Sean Anderson <sean.anderson@seco.com> wrote:
>>
>>
>>
>> On 8/31/21 4:11 PM, Rob Herring wrote:
>> > On Thu, Aug 26, 2021 at 05:18:28PM -0400, Sean Anderson wrote:
>> >> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is a
>> >> "soft" block, so it has some parameters which would not be configurable in
>> >> most hardware. This binding is usually automatically generated by Xilinx's
>> >> tools, so the names and values of some properties should be kept as they
>> >> are, if possible. In addition, this binding is already in the kernel at
>> >> arch/microblaze/boot/dts/system.dts, and in user software such as QEMU.
>> >>
>> >> The existing driver uses the clock-frequency property, or alternatively the
>> >> /cpus/timebase-frequency property as its frequency input. Because these
>> >> properties are deprecated, they have not been included with this schema.
>> >> All new bindings should use the clocks/clock-names properties to specify
>> >> the parent clock.
>> >>
>> >> Because we need to init timer devices so early in boot, we determine if we
>> >> should use the PWM driver or the clocksource/clockevent driver by the
>> >> presence/absence, respectively, of #pwm-cells. Because both counters are
>> >> used by the PWM, there is no need for a separate property specifying which
>> >> counters are to be used for the PWM.
>> >>
>> >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> >> ---
>> >>
>> >> Changes in v6:
>> >> - Fix incorrect schema id
>> >> - Enumerate possible counter widths
>> >>
>> >> Changes in v5:
>> >> - Update commit message to reflect revisions
>> >> - Fix indentation lint
>> >> - Add example for timer binding
>> >> - Remove xlnx,axi-timer-2.0 compatible string
>> >> - Move schema into the timer directory
>> >>
>> >> Changes in v4:
>> >> - Remove references to generate polarity so this can get merged
>> >> - Predicate PWM driver on the presence of #pwm-cells
>> >> - Make some properties optional for clocksource drivers
>> >>
>> >> Changes in v3:
>> >> - Mark all boolean-as-int properties as deprecated
>> >> - Add xlnx,pwm and xlnx,gen?-active-low properties.
>> >> - Make newer replacement properties mutually-exclusive with what they
>> >>   replace
>> >> - Add an example with non-deprecated properties only.
>> >>
>> >> Changes in v2:
>> >> - Use 32-bit addresses for example binding
>> >>
>> >>  .../bindings/timer/xlnx,xps-timer.yaml        | 90 +++++++++++++++++++
>> >>  1 file changed, 90 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
>> >> new file mode 100644
>> >> index 000000000000..5be353a642aa
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
>> >> @@ -0,0 +1,90 @@
>> >> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> >> +%YAML 1.2
>> >> +---
>> >> +$id: http://devicetree.org/schemas/timer/xlnx,xps-timer.yaml#
>> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> >> +
>> >> +title: Xilinx LogiCORE IP AXI Timer Device Tree Binding
>> >> +
>> >> +maintainers:
>> >> +  - Sean Anderson <sean.anderson@seco.com>
>> >> +
>> >> +properties:
>> >> +  compatible:
>> >> +    contains:
>> >> +      const: xlnx,xps-timer-1.00.a
>> >> +
>> >> +  clocks:
>> >> +    maxItems: 1
>> >> +
>> >> +  clock-names:
>> >> +    const: s_axi_aclk
>> >> +
>> >> +  interrupts:
>> >> +    maxItems: 1
>> >> +
>> >> +  reg:
>> >> +    maxItems: 1
>> >> +
>> >> +  xlnx,count-width:
>> >> +    $ref: /schemas/types.yaml#/definitions/uint32
>> >> +    enum: [8, 16, 32]
>> >> +    default: 32
>> >> +    description:
>> >> +      The width of the counter(s), in bits.
>> >> +
>> >> +  xlnx,one-timer-only:
>> >> +    $ref: /schemas/types.yaml#/definitions/uint32
>> >> +    enum: [ 0, 1 ]
>> >> +    description:
>> >> +      Whether only one timer is present in this block.
>> >> +
>> >> +required:
>> >> +  - compatible
>> >> +  - reg
>> >> +  - xlnx,one-timer-only
>> >> +
>> >> +allOf:
>> >> +  - if:
>> >> +      required:
>> >> +        - '#pwm-cells'
>> >> +    then:
>> >> +      allOf:
>> >> +        - required:
>> >> +            - clocks
>> >> +        - properties:
>> >> +            xlnx,one-timer-only:
>> >> +              const: 0
>> >> +    else:
>> >> +      required:
>> >> +        - interrupts
>> >> +  - if:
>> >> +      required:
>> >> +        - clocks
>> >> +    then:
>> >> +      required:
>> >> +        - clock-names
>> >> +
>> >> +additionalProperties: true
>> >
>> > This needs to be false. What else do you expect to be present?
>>
>> I am going to leave this as true for the next revision to avoid the following error:
>>
>> arch/microblaze/boot/dts/system.dt.yaml: timer@83c00000: 'xlnx,family', 'xlnx,gen0-assert', 'xlnx,gen1-assert', 'xlnx,trig0-assert', 'xlnx,trig1-assert' do not match any of the regexes: 'pinctrl-[0-9]+'
>
> If I wasn't clear: NAK
>
> All properties must be documented or removed from .dts files if not needed.

I am more than fine to document xlnx,trig?-assert, as they are necessary
for implementing capture support in the future. The xlnx,gen?-assert
should really be documented as well, as it provides a good sanity check
for PWM support. However, Micheal has in the past voiced his opinion
that these properties should not be included (despite specifying
information which cannot be determined by probing the hardware...).

xlnx,family can probably be removed, as I don't believe this device has
any differences across FPGA families.

--Sean
