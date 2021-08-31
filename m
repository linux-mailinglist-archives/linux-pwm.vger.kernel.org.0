Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D763FCE36
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Aug 2021 22:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhHaUOe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 31 Aug 2021 16:14:34 -0400
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:48199
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230286AbhHaUOd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 31 Aug 2021 16:14:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5wseSzHa/thRK1tMKLUcebVWT+tIl0YXllpCBA9T8B0CZOuEx06wtwlK5iEoTAHZEizSgUsmGyVGSKXIHbH7plESm8G+/1CRiYRl4QUTuOVG/VrkcmLXGaugXJV66tqGAB4KZiA89Qg7jELUhiBLbSKkyedez4ifZ4YazN+h5CvoekLXmOtMCgmjykDEWKrOy/xwk49nQnc3vhBeuAP8N2QB0F4HQOWmLgPO6KyQLyaXRx6bPDBfWOFBkfFIvsJyC4NZ/eiI6I2nFPCR2aWfbliia+mLcpm8yEunyNpyLhn0Xb4VgD+rd+rU1F6bNMFTppbVHs812Cv6BzuDJLODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywxYz2rgttcAuAW8bBmXsGaLNBdXcTmTwC7bV5QuClE=;
 b=KJ6ijk+65uRQTkPyuTD3WW7QP/YXBFQ0BpkPgIWofR+RDrzb77/s4mFFI9p0pF2GHVu9rtvnQ7rBb2WZrtnPzj0gjtAjyFSdrIbWDyrHvmTvEzp7+qIMI5Ymn21hFUHoUp44ataJvIMIzx28/HyjEcCjMnW2FU2Mcrp2C30BQdMpnUtls/JU/qTsCBZ9uYx7wS1cJTFwd8R125CcP8nh7laXVdOa0qaKLLvf/EYqN6D/2v5KnBnZjzHQm9cZ/Kho7mQu/1tAV/WTVIlHwmTFzsb9XJOTjbtgjU+pbmOQC28c6zNLX2vueyKMj4c53CfWltsz1vNyK6Olfk61NNmb3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywxYz2rgttcAuAW8bBmXsGaLNBdXcTmTwC7bV5QuClE=;
 b=LZh3UGew3r4/Vw0kY/7sIUIXW4VV35awNFTbvATJOnuYFkQklpcLg7gpyPqA7pMiW2WiBPPE8xfd0p9mgm4BgPS8GUdeLRzRa7w8EhCEk8iPIGUOt2TRMjDb9fZOti0ZOn1Ie/Kd3veHlqo2rMq9gaqoEFbICxyBx4jWvjKkdQs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB5676.eurprd03.prod.outlook.com (2603:10a6:10:10b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Tue, 31 Aug
 2021 20:13:35 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 20:13:35 +0000
From:   Sean Anderson <sean.anderson@seco.com>
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
Message-ID: <264f3ab9-fbf7-8f5d-af57-26b8602a6fbd@seco.com>
Date:   Tue, 31 Aug 2021 16:13:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YS6M9jmTmy4EvB4k@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0049.namprd19.prod.outlook.com
 (2603:10b6:208:19b::26) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR19CA0049.namprd19.prod.outlook.com (2603:10b6:208:19b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend Transport; Tue, 31 Aug 2021 20:13:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 007d1717-ffc3-451f-8aca-08d96cbbcfde
X-MS-TrafficTypeDiagnostic: DB8PR03MB5676:
X-Microsoft-Antispam-PRVS: <DB8PR03MB56761C1208DCF8C3483515B996CC9@DB8PR03MB5676.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M29liULkdVP6gm9nWKGhic+evTy7VQ8Il05hWDm53kNbiCpR2e+nN5r2mGb0QtZ2DHhJ5RqUTLNK6LlZlMl59i0LSF+GydIpnGdZIhvqw8cM/yC4RloFXNJsXH6Z/Y3VYVIFvgqZ3+9rrXLN5qCoCxW0asom223Zl0/Jhaud0+S3v6TBSPshp3f1DQpW9cI75YnjLUksmBFPqp6AKG/59DJSZRuKcdo1GvtMYkEW47q9L5L7uvQLIkDZx1QCDoczKNo8xShf9Z5ARwLJLZEi1JNhtmpPMh0mU7BP0hwOndCIgoN4gSPttb/6+K3mOogQX4zIeCqFO73nLZzoa0o2Is2W9lM2eOB5/T3LKyEe5G6dfMD7ztcQa/ohsWSRYLr287jlsAHbIc61NvhB0EnPPovY2cNi+mPnJmop1h1f3LaQF7KE0PwaEalfoL/rigojK0b7JtweId9OtJXXo3YsYJtpbIQ01/sLGgRgzM/BjFTKMRf7eL0wbaQXu9oTft4HS+KtQBn/uo2OVLgfjBUaX6h6VhSuN9uZ6wW0LoW9kEu/Fh0OVm5fa7dQ+q0J1OrgKoVKVxrh/rUNX6i3UNw7m2bn6F67vJBY4ahzI0vErWUcpb0yUWmF+QakBrCMY6igVhxGuHI70ew9l8ZjAFFSERCdvS8+tKgiuJjm+3yIt3MiA2B6ZjGFPL3yddySJ5JkzBbeWelMD0raStXg0YXTcYL57PcKoozihRJH6xaAJMP/oyFDfGUtzuDI03JYpI0FNC2zz0AXWlyJayN3CbD3YD1xgB3LJFpiY0ZVfOGxFRW5ciHvIopTJhnMeqWUuHho704IXli2/7nj8eSYLw7TKS3jEUgOS9tsLOeFsfI6qiE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(376002)(39850400004)(2906002)(16576012)(956004)(31696002)(86362001)(8936002)(26005)(966005)(2616005)(316002)(478600001)(52116002)(6486002)(8676002)(54906003)(6916009)(53546011)(38100700002)(66946007)(44832011)(66556008)(186003)(36756003)(6666004)(31686004)(4326008)(83380400001)(38350700002)(5660300002)(7416002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2pEbG9qQzQ0S3hNK1FTSk92dVJPbVQ5TDA3UWtyYkU5NjZ2bEV6YTRrcTRW?=
 =?utf-8?B?b0RaQy95VVNJTkpYeXpuV3dRZmdOTXd0cnZrMytEaXRBTElXTFJlK09NMGQ3?=
 =?utf-8?B?ZC90SnVma0lTSlJxWGpPNDYwbHhYbDdubW4zcUhkWW5IQVVaM2ltd1BrZDM3?=
 =?utf-8?B?OGU3ZnVhSzJmMVA4bEhTRVhCbVcwbkJMYThZaVlPOWQwbVRBQU02cS9mNkxh?=
 =?utf-8?B?YnE0U1pxQ2hDN0QzUHl5YVVsOTg3MHA0ZVRXMGcySCs1RW02bDc0NlVNUVA4?=
 =?utf-8?B?aVFOS25EWUp3S01UaDh6NjVNZG42M3dyMjZ5aDdQekZlTzlnR1dqUnJiNExQ?=
 =?utf-8?B?dXVTN0U5ZVU4dXU5T1p0RmdubFV5bWV6eTMrRXVtbndjaG1vdU1KYWpFVTIv?=
 =?utf-8?B?N2gvN1lXNmdZS21tcEtvQUo5d1k1dlpZMDNsam5NTjVzWXlWd0NIVFEwb01a?=
 =?utf-8?B?ckhTMXlZemtSNTJ1alNBYytoME9jNFNsdWtCc2hleEJtMG40bkZ1STU0Lzkv?=
 =?utf-8?B?a2RWaEtQcWJNd21sZkJmekZOck5NNjNVeFdyS3BYQUdEZW5Jd1BhUXp0cFc5?=
 =?utf-8?B?QzVDQWp3dW5WUnVFb25TeWFiUFRRZUE5OUNiekJrMG5iSGVwOXNvYTEzbWVs?=
 =?utf-8?B?a1ZZNlJwWDN0VU9zQjNTaEJ4SmthNjBRekZuT050VjJ4SXUxQjNFUXNNbHFo?=
 =?utf-8?B?dldVYkpFSWY2ZFBlNHZCbHJPUU01NDJkVkUxOUlmOGZrWkkzRCtXbFFMZE9h?=
 =?utf-8?B?RDVjNHJKTm9sNTl2a3ZYeEIyUURkVkY1d3k2YVVPOEZNb21HNUNsVnpsdkpx?=
 =?utf-8?B?MXFCa0w5N21qVnptS3lwaStCMUtSaDU1dnRya2grTXdlOEdMTkIvdzlockdH?=
 =?utf-8?B?ckdlWkNFa29hQm5VVHBEcUE2bk8zTzcweDZnaEhqQ1RKR0lyR0JTb0tOQW4r?=
 =?utf-8?B?UG1XZWRZTDFoaUR2aUU1TzRkNDF0L3BnMmdyNzJOZEg1UGdBR0ppWVZVK2Rp?=
 =?utf-8?B?cEdLa1JaSWFRbXpCZk03SlR4eHh5d2o0a1dtQ1pYcStXSERldXhZanVoYXJR?=
 =?utf-8?B?S3g0d29WOTVmbGRZRnJUN0djY2NmdTl6UUwyVEdiOWczNkFBdVkrN2ZWYVNj?=
 =?utf-8?B?VGZmdGtxV09sVzNUbnUzbGp6Wm9ObHNaU0RRREt3YkdKSUhHZFBzV2xvZVFh?=
 =?utf-8?B?MzloQVE0UTVVSmgvYStCOEJHVDFET1ZabE8zS1dFS1ozcEw2Z3dpdW1sMjM2?=
 =?utf-8?B?REhVMjBuZENlb0ZvRkw0L3BKdXEwTGdjeVRhRWxYelVOb1BtMHgvN3ZVdWx4?=
 =?utf-8?B?VE5Pa053UDhma3BpTUo5TjdXNFhEczNSVTZEaUp6VU10VnVtQk5LdHU5eHpx?=
 =?utf-8?B?MnBRaUFubkhnTWxMRXYvL1dSYU84dFc4aHlkS000K1djWTB5dmFVQXpvVzlC?=
 =?utf-8?B?UUFBa2J2TGt3N0NWZitjNE53S3YzSDN1K2ZXZFNTZmw1RUhhMlJGMWlwQWpD?=
 =?utf-8?B?U21tWENmZ2Z0OWlHZU56UVYzZVRKTDQ5bTBscDhPZWF2MlFsa2pObThWWFJY?=
 =?utf-8?B?bFhyYVpwejBZbGJoRzlablhqU0lzb3NnOU9nZmpza1BYaHlUY1YzaWxxQkhY?=
 =?utf-8?B?RlB0V1dwdnppS0c5Z0tDZTRROFJhVzBpWGlDeDFFb1RyZW5Sc09qYUVabGNx?=
 =?utf-8?B?WERNK0xEUy9wVDZYT2VmeUZudXRCU1ZINWJzdmV2TXgxalNWQ3FDVEhyVFEz?=
 =?utf-8?Q?5YHV099nzSOEgmwh6CGehUFGXs1M+1S4/JW/DFl?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007d1717-ffc3-451f-8aca-08d96cbbcfde
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 20:13:35.3107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhpeMIObOPT+XY9AT+Ea8OlHjLn1+kCRxPJfUnJy/nHlieHQks+j9fXYWBnaPj4lAh5POb7erSaNAkP45GqGmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5676
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

There are additional properties present in the existing in-tree bindings
for this device. Should I instead set "unevaluatedProperties: false"?

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
