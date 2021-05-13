Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D3137FF8D
	for <lists+linux-pwm@lfdr.de>; Thu, 13 May 2021 23:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhEMVCV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 May 2021 17:02:21 -0400
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:17953
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233226AbhEMVCV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 13 May 2021 17:02:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFZ36ajkV7FX2GAT/rc0ZvTJkPHq7q+mPcSBeVIs6c7Al1RBTOXG5CKO+P33xwi/HCcnJV/r152gRWho2Fl3fhZWZzxHIYqThXbPZbbMnsM3VfRB4d07ds6mS0ClPSH9DImiYpP72vci2YB5BrB5mtuvjF+NIpJkcU3qYv2W6tBxwDg2v1HGfptgtehmHf6O44Q3EFDA8cSqy6ZPRTFO06bDAGI6o14pzfjf71wF7Y1oiP+wAEDJ7UWMb/oM25HMhGzH3shl/klvlZNApP58Cx43fpwAUjFQ6g0ZUo430KKiaHw8xIrto/n4Ed+k2dLc7zF6LCyOvgq07CK8Ho9hkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H562WErgoKZbZJcIH+MqgkDW800DLKMrlFwFIl5UMbI=;
 b=FzquLwKHOahH3dw3+xrvZJWln7xsz3zbPidSuNEBnfSZDSOY+leTGuEY9dcXtDMWg1MjfxdjCEpdIwfgDBX5VYbUuWWpw44szrbjHv0NyiltDJ6p/PcXXJPHmgpy/L7RwvQzJFdBkUI10b/lOMP8IeBMLHBJhrO4xTY1g+nqS7xYJr+s6+WpV1g3/x8o6xmxaangygtnQlsDelpYQMy9p6uowRZ0qhcOgBgDvD23NJvsCUAhH/eU+syDvtYnLuOKRiMdwy5LZcB9soQbZ5zHwr4pXi28evC3OdVsiIiSOepioRW8IFCna+asNYtynCaenifHscODa+oxuWFETd04eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H562WErgoKZbZJcIH+MqgkDW800DLKMrlFwFIl5UMbI=;
 b=wl0333KHeLxOKK06rEunexi1GzYwBlomIVIfieNDEsiZtXSlwvTOz2lFZ7s9F7LwVgq2uLQT2JWOpQ2PV0KlmOwBHhuKyyi6N0/VDCY5jIr4vh2AiQfCFfBxZEQ0fK/IFHAhCwh0IvnpRNSKonlGGp2HdQobyXLOZozUzzAdFCc=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB6700.eurprd03.prod.outlook.com (2603:10a6:10:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Thu, 13 May
 2021 21:01:08 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 21:01:08 +0000
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Rob Herring <robh@kernel.org>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        devicetree@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20210511191239.774570-1-sean.anderson@seco.com>
 <20210513021631.GA878860@robh.at.kernel.org>
 <f9165937-c578-d225-9f5e-d964367c4711@seco.com>
 <70176596-2250-8ae1-912a-9f9c30694e7d@seco.com>
 <CAL_JsqJY1W=t-gYYt+iTPgF7e9yJqzYFYGSJNrA4BNhAY+va8Q@mail.gmail.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <b460d11d-4244-71d5-3b84-51c3f7e7f661@seco.com>
Date:   Thu, 13 May 2021 17:01:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAL_JsqJY1W=t-gYYt+iTPgF7e9yJqzYFYGSJNrA4BNhAY+va8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::20) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0135.namprd13.prod.outlook.com (2603:10b6:208:2bb::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Thu, 13 May 2021 21:01:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1ee49d1-995d-487c-f24e-08d916523ad2
X-MS-TrafficTypeDiagnostic: DBBPR03MB6700:
X-Microsoft-Antispam-PRVS: <DBBPR03MB6700A2640C9402F755C310BC96519@DBBPR03MB6700.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sh0EjLVyrXf+AnY1EROD4yTeiHS5WsUFE/xC9M2JpNj/mH0szg+oLkBw6UBjlDcXZ2DwFQDn2C5R9pAVyL1qOiLDcuBfWPhBH1FJlwj0ZYuM7Vn47S2a0w/keEaJPxpgaMTvwuBKKDUz1VUqhieJIUXkmOEgWSMEWdTlfx9ckCLu9TZWIXuMjZzNQbEd3sYwfhdW2y4VDYzPj/4hhrG9TeC4KKLzc1QjCfU98v0AjW06Wd5u3d+7p3mb/EQ591HZVvjTNQT6HvmpL7VQ2ad91LvZCk212LXfAJ+Oc71+++IlDiJyiBRiLv4+W7ezs1qSWYnhbvwGt7mqJBWmq2CR3yG1Afzcg3AcIrdiiLJeRzcsorWDIbLwykVRA8bDzH99lah0haU/dA4GQGmYqqpZaOeX5vXOr44rqwIzonnCv/xI0ZcQHNtWbuToPtXH+ChkKtqauZJ58eEO2bYrZVW/z1Iudk1qUsD7kzyd4P4PGyG7GtJcCA0nJFbQoi+S20zXV2mBTYm8x58i1l/o0zXVKwFBls6bEE0DwKO28eiMqZ8l4XhtGf35Bik31cWdXr1GcvnXIV3IBwLbF7RPt+2c/QrZu15+x1dPK6cu2/UDFvM097XEz9GA8jpAcMYWerLD4jJkv5CQ8YcW/dbuEnZyjBkpAY7MZin34CWvED+wgEOt5+ZbJORITRXI4kk74AAnrRHZCYnpr1Iyds9nMVhXuphnQpJEyH6q729kvYyVsaljJxaT05gjoHkv70VtpVgt2HNe6yWnCM6b2OJCFQqo3/JH2W37U0wf4RAyF05diaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(36756003)(38100700002)(86362001)(16526019)(6486002)(83380400001)(54906003)(38350700002)(44832011)(26005)(966005)(52116002)(53546011)(6666004)(956004)(2616005)(66476007)(66556008)(498600001)(2906002)(4326008)(66946007)(16576012)(31686004)(8936002)(5660300002)(8676002)(186003)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZElNN3RiRTduVHdNa3FhR1JVbGlsdURYMFRSMWF3dTdybFpGUGJqREVaMlVT?=
 =?utf-8?B?S0V6RTdQdTQ2NnpMYU5VZnlaWjMvRWVtMSt4b0Jkd2FBNURlTjV4Mk5GUjVB?=
 =?utf-8?B?ZzZuNVZPUkFLZmZVVlJjNnhwcXdrOUs3cnZtOG9oQ3dnb1hkdHZiaDdERU5m?=
 =?utf-8?B?bHdsQzBkUUpiUHh5RVBrZGQxTXBiL0ZIbFFnRlRjT0JMTnBWS0ZCUkR5MldO?=
 =?utf-8?B?UHIwZDNSSkZTNm16Wmg2QWJtQXJuUGprejdSZlplZ0V4VVNBRzRRUjNqd0U4?=
 =?utf-8?B?dWdOU2VOc05pSTV6ZWpYNnJOem1wSUhDYlZhTThhdmxhVDdWVVZEcEhWRHhN?=
 =?utf-8?B?RjhKQnBHNHpwdjF5WXN0OEVBbXh1M2tsSmRzYzJvcEVxZjRlVDB3TTM0NTRR?=
 =?utf-8?B?ajR0aDArRncxWFdyZlNIK2RKK0VCbGszdmVXYUJnNTliSkpacktIR1pyMUlZ?=
 =?utf-8?B?VGdiZUMwb0plZWlZc0M2NlVwYmZEUFRwd3E0V1ptSjl2ekdhWHBNODdhV2kv?=
 =?utf-8?B?MjZOcVFRNlNEYWIzYTh4blN3VGhaWFpBU0h5MVRMSFZQSFliMmVqUUR2NTd3?=
 =?utf-8?B?eTN2Z0NjeVR1ZEFLNzM4RndVRldiVm1kSFdkWkFUNUtlOVJrTkNUMlpvejlJ?=
 =?utf-8?B?OFhzNlBVeUIxSld1MEJTRzd1akFPQ1ZvMHVJOGtjK2YzVjZ5eHdzZDNkR2Vx?=
 =?utf-8?B?NVhReWZqT09Dakt4ZzRVK0h3c3grdzFFRWNIWUs3Z20wQlFXUVZueWIwQ2tr?=
 =?utf-8?B?UlJvdjF0TGJsZnd1elJyRUZQck5pN04wU1p1d1pvcW5YSG80RS9mUzZwRDN4?=
 =?utf-8?B?b1UzOXZBVzl3TTZyTXN6OUVIVnFCUXF1WVNleHVmNTFoUW9zVUszdk1LZXJh?=
 =?utf-8?B?Tk8zZjJYTXNZcHNvSGQ3b09yYUJpVGxxVktkdjRUNFh0bWsvd3ZXMUppY3JI?=
 =?utf-8?B?TkpWRngrM2cvdUwrcGtSNUhHSDFvTVlLRlV5OVhPQnZ6NC9Za0hXSDBEM0xW?=
 =?utf-8?B?M1A2dHE5aWVHTVRwbjJrYllQK1BnaGhSSmx2bVNoWUpWRDBaY0NGVTNTTmtm?=
 =?utf-8?B?QkhFWGc5QytvV1BmVlJWdkRKdXlVdDJBSVg1U2FVQ3hYSzhsUnFUT3E3M2Rm?=
 =?utf-8?B?bktPQlZVQUFsdjhhbWZPTDAxRzJLMmkzenk0TlRTanB4MTgzZ1RJM2FDNlVx?=
 =?utf-8?B?SitSUG5aM2h1Vk1XazJRMXRmMVllZ1UveWkweFdpanJWN0ljR1lRRVJIbE8y?=
 =?utf-8?B?U2QwRERJTmJzbnFhd3ZMVDU0RXZvWkhpWUFmRHplK2dNY2l1Z25UbUs0SG1P?=
 =?utf-8?B?bzQvWDRLejJ4aG12SElleDZ4aXpIekkwaU81NkhEbzhpTEE5aEw4V1U5dy9h?=
 =?utf-8?B?UGhGYzUrNklmaDEzS2UycVFndUFnaEU5WnZLeUV0YlhSZjZPTUlMTDBzd1NO?=
 =?utf-8?B?K2F1TGZPelhzU0tFdFc1eThBM2xWK1dtM0xBb2ljajlINThoNFN4U0dJUEVS?=
 =?utf-8?B?ZGtxczFiM2lsTzJtTGo2UlJHSzBVRmtKT2dwVnZxbUlqVTBGUC9PRWZ3WU9N?=
 =?utf-8?B?Y0QxWFVIdzM1cHpTdnUyM0dJQkI1L2xmSHpkOWhlSm5YV0p1U3MrQkhpMkdj?=
 =?utf-8?B?bUFsaVpTRkJpdTFVaGNzbGdEcmRFQ3Q3SFlia0FncVlIeVFuRUpzenhwdVd1?=
 =?utf-8?B?OWdCeEg0QjBWMVVHR2hSeDRmb1JGb2lmbjZNV2lYR0ROL2xESGZ0U1JUYlVT?=
 =?utf-8?Q?r8reDZ4yFnqiPw3fAYorRsuk8KCFjVf5cqGRU9K?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ee49d1-995d-487c-f24e-08d916523ad2
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 21:01:08.1317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBY3vCKmph9ZEgvgJ6u/v9zwHDWyqa8MJBjpYzmfB02T/Cvx9TSYtaty3Vrg6IX7BPHgwGX2ARKo6StEn7BUTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6700
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/13/21 4:43 PM, Rob Herring wrote:
 > On Thu, May 13, 2021 at 10:28 AM Sean Anderson <sean.anderson@seco.com> wrote:
 >>
 >>
 >>
 >> On 5/13/21 10:33 AM, Sean Anderson wrote:
 >>   >
 >>   >
 >>   > On 5/12/21 10:16 PM, Rob Herring wrote:
 >>   >  > On Tue, May 11, 2021 at 03:12:37PM -0400, Sean Anderson wrote:
 >>   >  >> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
 >>   >  >> a "soft" block, so it has many parameters which would not be
 >>   >  >> configurable in most hardware. This binding is usually automatically
 >>   >  >> generated by Xilinx's tools, so the names and values of some properties
 >>   >  >> must be kept as they are. Replacement properties have been provided for
 >>   >  >> new device trees.
 >>   >  >
 >>   >  > Because you have some tool generating properties is not a reason we have
 >>   >  > to accept them upstream.
 >>   >
 >>   > These properties are already in arch/microblaze/boot/dts/system.dts and
 >>   > in the devicetree supplied to Linux by qemu. Removing these properties
 >>   > will break existing setups, which I would like to avoid.
 >
 > Already in use in upstream dts files is different than just
 > 'automatically generated' by vendor tools.
 >
 >>   >
 >>   >  > 'deprecated' is for what *we* have deprecated.
 >>   >
 >>   > Ok. I will remove that then.
 >>   >
 >>   >  >
 >>   >  > In this case, I don't really see the point in defining new properties
 >>   >  > just to have bool.
 >>   >
 >>   > I don't either, but it was requested, by Michal...
 >>
 >> Err, your comment on the original bindings was
 >>
 >>   > Can't all these be boolean?
 >
 > With no other context, yes that's what I would ask. Now you've given
 > me some context, between using the existing ones and 2 sets of
 > properties to maintain, I choose the former.

Ok, then I will go with that for v4.

I noticed some another patch regarding a similar situation [1].  Would
you prefer separate files like what is done there, or is a unified file
like this ok?

[1] https://lore.kernel.org/lkml/d36e3690ce8c5a1e53d054552e4fd8b90d6a5478.1620648868.git.geert+renesas@glider.be/T/

--Sean

 >
 >> And Michal commented
 >>
 >>   > I think in this case you should described what it is used by current
 >>   > driver in Microblaze and these options are required. The rest are by
 >>   > design optional.
 >>   > If you want to change them to different value then current binding
 >>   > should be deprecated and have any transition time with code alignment.
 >>
 >> So that is what I tried to accomplish with this revision. I also tried
 >> allowing something like
 >>
 >>          xlnx,one-timer-only = <0>; /* two timers */
 >>          xlnx,one-timer-only = <1>; /* one timer  */
 >>          xlnx,one-timer-only; /* one timer */
 >>          /* property absent means two timers */
 >>
 >> but I was unable to figure out how to express this with json-schema. I
 >> don't think it's the best design either...
 >
 > json-schema would certainly let you, but generally we don't want
 > properties to have more than 1 type.
 >
 > Rob
 >
