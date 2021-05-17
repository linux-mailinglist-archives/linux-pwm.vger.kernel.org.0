Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422F8383201
	for <lists+linux-pwm@lfdr.de>; Mon, 17 May 2021 16:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbhEQOnx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 May 2021 10:43:53 -0400
Received: from mail-eopbgr00064.outbound.protection.outlook.com ([40.107.0.64]:40011
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240890AbhEQOlq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 17 May 2021 10:41:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MavVxC8VXVWPX85YRbJ4mFZhaihZOkvRTtBPPEAWsdKl56/U042edF3ab1gNFlOg9kzQiPc7NW8q3US515ToIZX694E71X7mhyvIDKVRD1oQmiymLO4Xl9LiRQAsvXDr5RSTwfrot4Z6+x41Jcd5V6onAtDQX/dLWlvMxlHSYXZZTaenQpBtkroGoZwCprl/FfHZpEzvkdPB5CSKZUnt0HJuMYqI/FIWCL9VI+mzZ+R52Azq0LpksonOOnOGkrNGffgbgWC8p4JI0boOoGyYFYPVDefKaXfWEcE3zKt7u+V/IsJkZDVSa6oqXbrXjj/Y3Kxg6J8nVBj4Tr4lu4OH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Gi593o8A4n+/r7+nks6yQSAhrWXJMi/Au0k0niNcTA=;
 b=cta39uRSPQXfHKIOiyCNRzXTxwYLDm8lBgDDpmXvdjjTl9KaOi7xPX4g/9lVHREqZ+YwZaPg4fPO/obM6LPiapGmEXAMzxPuQnYKLTcXnP4uzamuH4+EPNvubRTq1S3tXSoZuhcdDu6d/AfVMWHsKqNm1d5o4FXTWTR75AveZwKDZc3lZ0wJf2bCL09W69FayfCIkU22FLFB3tV8K59H0xQzKSXu9QPI0DFwI5p6gbTtO04MOMwU8/WZ1da+d7RgDXq6fhNg+jSXfCh3x3tvl0VlU6V+WsopX8rSVmjTXsOKlL9SbJ5DuZPMLPss7h3PI8IZqzkle6XdJLMKqnz1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Gi593o8A4n+/r7+nks6yQSAhrWXJMi/Au0k0niNcTA=;
 b=FA0R8WHH9aCXVYiAb066Yrq0MC/SBD/RG7aQmDLfZXI8t4HMFNyToMYqpYXnC3HvbCp6Zu4CcjE3VjF23IJsKTJHBiieDBaRW+fr8Wuh+LLruY6MczdOZlJ6G+JuRM0TQmGj7RaOIsFxNee5l1+CpzsGTSwdPsqR91R/Xl0WOJw=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBAPR03MB6549.eurprd03.prod.outlook.com (2603:10a6:10:19b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 14:40:26 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 14:40:26 +0000
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>
Cc:     Linux PWM List <linux-pwm@vger.kernel.org>,
        devicetree@vger.kernel.org, Alvaro Gamez <alvaro.gamez@hazent.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20210511191239.774570-1-sean.anderson@seco.com>
 <20210513021631.GA878860@robh.at.kernel.org>
 <f9165937-c578-d225-9f5e-d964367c4711@seco.com>
 <70176596-2250-8ae1-912a-9f9c30694e7d@seco.com>
 <CAL_JsqJY1W=t-gYYt+iTPgF7e9yJqzYFYGSJNrA4BNhAY+va8Q@mail.gmail.com>
 <9cf3a580-e4d3-07fc-956f-dc5c84802d93@xilinx.com>
 <87b31b06-9b81-5743-e3a8-50c255c0a83c@seco.com>
 <141399b7-db9c-45e1-f743-9e3bc5e6f9fd@xilinx.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <5b038a5a-9aed-7810-66d0-128e586283e4@seco.com>
Date:   Mon, 17 May 2021 10:40:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <141399b7-db9c-45e1-f743-9e3bc5e6f9fd@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 14:40:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d0a489d-4268-4c7a-e6bb-08d91941b5b3
X-MS-TrafficTypeDiagnostic: DBAPR03MB6549:
X-Microsoft-Antispam-PRVS: <DBAPR03MB654935FFDE442F418E91A923962D9@DBAPR03MB6549.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wh74Y4d6M6VIIH/VdPKOSL9HIMxfOCAdBdyqGVG+Cm4pZVypYMKcop4+lC6tI0rShIR6uyJn7VguRv9LJw2Oolf66nx7tj2FWO/0BWd29Fq5om4E78FMSZCgKo7HadmvRlymJld2xz9rF5NlEhV43IYIGOayw5gdkX8zRbwHcdb+LA8WRGg0sKUnoRqZ5mYZsoGqlWTmPpb0RRlS87qlk4Bow4QLSSkViOPGLnOydQqVDktYqj9AYvEpAHUlCvW2hiQ3LyRUZala+aaPpaUF7xE9sbtD2ql/GFNUCqMdd36h1LidtACucu3zWqUOfnUrHQbvQaZ0nRslm3ySaNBQ8eKwo+L6V4hr01GoFfBXi00yJRsIX2UI9GIyD4C2IOW8a6HIOiTI+ehq8u4nHfrzLqVgfAWEjaoVz7kCBWm9LlTkCP5Oin5BZi0bGh6h8OxuLbN6dzdKM6X+hHGryjbbpsGxvej6m6npWPDfMgMa/MVIAJ8lfg7qkDFjBO7MRwKvnMiQ41CC1OhZ6q4UAU+UI9lg1tVfoX3tlQqaMhZE6sJvNb+f39Q6BRAAhVoHykQ7yHXHDRxPwQHbiz8qKuE2Z2aFfZ+Qf72uABF7k8ZnyI1Yw7tq5YUu3/+H103PH3k8d3Ip0FooGlWaxixklIZrgRnyZqQ3Jj3y8FR2mjo35eIuMQFTa/TfVUnR/YVD5ClO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(30864003)(2616005)(4326008)(38100700002)(498600001)(31696002)(38350700002)(53546011)(2906002)(31686004)(52116002)(86362001)(44832011)(83380400001)(6486002)(186003)(66556008)(16526019)(8936002)(6666004)(54906003)(66476007)(66946007)(110136005)(16576012)(36756003)(8676002)(5660300002)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TEVXakRIOXFISkVIUFdDdzBONWVLUElMYkhVZk04YmkwTGRYVCtHdEtGUW5q?=
 =?utf-8?B?L0lMclpuU05rbnNPakRBeUNCTGtMK0ZCeHdwTGp1NzhwZ3RLWndVMFRxTlYv?=
 =?utf-8?B?alhId05KTFAzbGhnWTRwVVZ2K2dQdUhMMVgzcHQ1SnczeVpVSjAvMkVxZC8v?=
 =?utf-8?B?dEF0eG4yUlhFOHBZbE1ZM1B0QUJzZEhDSGd6YytMZ2JqS01OcGdDSnc4WnBP?=
 =?utf-8?B?YmtWWVluZ00wREltYW9lUHBqSlBwSzhLQ3BJdE5MaS9kT0QwQ04zS2Y0QkpH?=
 =?utf-8?B?Z0VBN1h5RHRqb1ZENlhjQUhKN2F4YkJqQ0NCRTJMZ3phSmE4V0lGcCtBdE0r?=
 =?utf-8?B?WDlCQUl3eXRVdmhjTUg3WE9ybGsxNW9kYXlIRmZTeU1SNGZVa2J0cFQ0dmQy?=
 =?utf-8?B?T3VXbWNTU1VkTUU4Q24wQXdzd3V4MkExaHZ0cUVZNm15WS8xUThLNmdiZllD?=
 =?utf-8?B?VFJQRHNpb0RheG55SWdIc0M1Q0t1NkRJY2lYK2lVN0pKdzRZUVBmbTF3bkJr?=
 =?utf-8?B?M29LSVU4bkRWWEtGVzZtSXhOc01ibDRydTJTNlh3SUFReXkwbVNHdUR1d3ZQ?=
 =?utf-8?B?aFgwZnVpWVZlZXR3a0JML0puWVdvc2tnYnV1QTBRQjIvSG5KM0FPMzVMdFBk?=
 =?utf-8?B?bFVaaWZxTkpyUVA3dUVKeUFKeGVNV1pEVHVkamRid2xWRW5hMTNPNWh0Ungr?=
 =?utf-8?B?WmZteUcxZTB2OEVHd3FwMy9NLzdiYkpCdlpnYUdSVjNoQVMvZ05PeHFLWHdx?=
 =?utf-8?B?cGg0TTlwbk9qTUFNWWF6RU5FSVFIeHJRRDViTjA0WVdTaUZRN2xVY01MOUVq?=
 =?utf-8?B?ZVpndHdydmRuZ3dZVVJVN2toMEdaYm53dEhjQVNjQnFNQ0pPYWtDdFBFNzg4?=
 =?utf-8?B?V1JRVzVPWmJXUktTaEJOVml0N1ROVmNZWDNvbktrblI4MzJnWmJJM2ppM2x0?=
 =?utf-8?B?Z1crV0dDcXZTUjg1WjB6cDV3a3FHK1FpeXlBVktaakFTK1U0c2hrcENidHJI?=
 =?utf-8?B?NUdtbjVUWkdmRm9WeDJYMENUNW15Mm11WWlWaG5PTUEwS1B1bWFlbVhrL1po?=
 =?utf-8?B?NEJwUjZPMHk4VzBYSHhmVHZ4RjcxWmtpUFB5UnhleDVmZFR2YnhYendzazk1?=
 =?utf-8?B?NE1aQk9tMnRRODU4YzBmUnZUaFl0c0dyZ3RuZkU2Z0tVcEgzMU9Od0lKWVY4?=
 =?utf-8?B?cjFTVXVydDhSV09zU295c1hERmJVVGRnTnd0NFIxUERKQlZSMmN1dlAwaUo2?=
 =?utf-8?B?dWNZT0NpdDIrZjB1MWIxNmV0RVlEV3gzamNVaW81eEZEK2pLaUprUVJBQTNL?=
 =?utf-8?B?WDRUWkwxWFpYaUxvek1zV2JnV2I3YWNDQWhEeEJ3TzB6RStKQ2xtNVVUZGZY?=
 =?utf-8?B?MVRaWDZ0WUdWa3kxTE9pcFdoVEtudkRJN2ZIQitjMFpXcFByUkNXTWoydzlJ?=
 =?utf-8?B?RGlGeXhLeUprek9PQ3B6N2U3Y2Z4VXFBYjQvYjNKLzlLa3NoWm9GYjJtTTdB?=
 =?utf-8?B?WWs0eFpCajh2aTVNcFhVTnU3ZGpOcDVpbjdTZmhQY2FXZVQzZGRSTFlpOWxa?=
 =?utf-8?B?NHBWS1c1a3BjckJxeTBjRnczazBHNnJ4MkJwRll6b2F1c3BqUkxLeU54MkFH?=
 =?utf-8?B?dFFkU1hBZjhzejBEdVZRWlJKcTJlZ1IzdC80MWE0UE51Um1MdUNiejgwUGJa?=
 =?utf-8?B?bW0veUgzcUFCa29kSmdQWGVndm5MOGEvK2lTU1B4NFZpUWp2NUk5a0MzMi9h?=
 =?utf-8?Q?SdVTA0slqSZ8lNQWrbdFKDBdk6W1NxC04ptm6gp?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0a489d-4268-4c7a-e6bb-08d91941b5b3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:40:26.3069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oMdoco1DI6X0SjfNKHA3a2Xd+L0G3bV7uRwiik1R9aUSE3PKiO4wpx95SKbNtFAxClvyxYojML69uzE7k6dAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6549
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/17/21 4:28 AM, Michal Simek wrote:
 >
 >
 > On 5/14/21 7:13 PM, Sean Anderson wrote:
 >>
 >>
 >> On 5/14/21 4:50 AM, Michal Simek wrote:
 >>>
 >>>
 >>> On 5/13/21 10:43 PM, Rob Herring wrote:
 >>>> On Thu, May 13, 2021 at 10:28 AM Sean Anderson
 >> <sean.anderson@seco.com> wrote:
 >>>>>
 >>>>>
 >>>>>
 >>>>> On 5/13/21 10:33 AM, Sean Anderson wrote:
 >>>>>     >
 >>>>>     >
 >>>>>     > On 5/12/21 10:16 PM, Rob Herring wrote:
 >>>>>     >  > On Tue, May 11, 2021 at 03:12:37PM -0400, Sean Anderson wrote:
 >>>>>     >  >> This adds a binding for the Xilinx LogiCORE IP AXI Timer.
 >> This device is
 >>>>>     >  >> a "soft" block, so it has many parameters which would not be
 >>>>>     >  >> configurable in most hardware. This binding is usually
 >> automatically
 >>>>>     >  >> generated by Xilinx's tools, so the names and values of some
 >> properties
 >>>>>     >  >> must be kept as they are. Replacement properties have been
 >> provided for
 >>>>>     >  >> new device trees.
 >>>>>     >  >
 >>>>>     >  > Because you have some tool generating properties is not a
 >> reason we have
 >>>>>     >  > to accept them upstream.
 >>>>>     >
 >>>>>     > These properties are already in
 >> arch/microblaze/boot/dts/system.dts and
 >>>>>     > in the devicetree supplied to Linux by qemu. Removing these
 >> properties
 >>>>>     > will break existing setups, which I would like to avoid.
 >>>>
 >>>> Already in use in upstream dts files is different than just
 >>>> 'automatically generated' by vendor tools.
 >>>>
 >>>>>     >
 >>>>>     >  > 'deprecated' is for what *we* have deprecated.
 >>>>>     >
 >>>>>     > Ok. I will remove that then.
 >>>>>     >
 >>>>>     >  >
 >>>>>     >  > In this case, I don't really see the point in defining new
 >> properties
 >>>>>     >  > just to have bool.
 >>>>>     >
 >>>>>     > I don't either, but it was requested, by Michal...
 >>>>>
 >>>>> Err, your comment on the original bindings was
 >>>>>
 >>>>>     > Can't all these be boolean?
 >>>>
 >>>> With no other context, yes that's what I would ask. Now you've given
 >>>> me some context, between using the existing ones and 2 sets of
 >>>> properties to maintain, I choose the former.
 >>>>
 >>>>> And Michal commented
 >>>>>
 >>>>>     > I think in this case you should described what it is used by
 >> current
 >>>>>     > driver in Microblaze and these options are required. The rest
 >> are by
 >>>>>     > design optional.
 >>>>>     > If you want to change them to different value then current binding
 >>>>>     > should be deprecated and have any transition time with code
 >> alignment.
 >>>>>
 >>>>> So that is what I tried to accomplish with this revision. I also tried
 >>>>> allowing something like
 >>>>>
 >>>>>            xlnx,one-timer-only = <0>; /* two timers */
 >>>>>            xlnx,one-timer-only = <1>; /* one timer  */
 >>>>>            xlnx,one-timer-only; /* one timer */
 >>>>>            /* property absent means two timers */
 >>>>>
 >>>>> but I was unable to figure out how to express this with json-schema. I
 >>>>> don't think it's the best design either...
 >>>>
 >>>> json-schema would certainly let you, but generally we don't want
 >>>> properties to have more than 1 type.
 >>>
 >>> One thing is what it is in system.dts file which was committed in 2009
 >>> and there are just small alignments there. But none is really using it.
 >>> Maybe I should just delete it.
 >>> And this version was generated by Xilinx ancient tools at that time. All
 >>> parameters there are fully describing HW and they are not changing. Only
 >>> new one can be added.
 >>>
 >>>    From the current microblaze code you can see which properties are really
 >>> used.
 >>>
 >>> reg
 >>> interrupts
 >>> xlnx,one-timer-only
 >>> clocks
 >>> clock-frequency
 >>
 >> There is also an implicit dependency on xlnx,count-width. Several times
 >> the existing driver assumes the counter width is 32, but this should
 >> instead be discovered from the devicetree.
 >
 > For me it is important what it is used now. Which is not
 > xlnx,count-width. That's why if you want to add it you can as optional
 > property.

At the very least we should sanity check it. E.g. check that it is 32
and return -EINVAL if it is not.

 >
 >>
 >>> It means from my point of view these should be listed in the binding.
 >>> clock-frequency is optional by code when clock is defined.
 >>>
 >>> All other properties listed in system.dts are from my perspective
 >>> optional and that's how it should be.
 >>
 >> Here is the situation as I understand it
 >>
 >> * This device has existed for around 15 years (since 2006)
 >> * Because it is a soft device, there are several configurable parameters
 >> * Although all of these parameters must be known for a complete
 >>    implementation of this device, some are unnecessary if onlu reduced
 >>    functionality is needed.
 >> * A de facto devicetree binding for this device has existed for at least
 >>    12 years (since 2009), but likely for as long as the device itself has
 >>    existed. This binding has not changed substantially during this time.
 >
 > note: IP itself is even much older.
 >
 >> * This binding is present in devicetrees from the Linux kernel, from
 >>    qemu, in other existing systems, and in devicetrees generated by
 >>    Xilinx's toolset.
 >
 > Only from Linux. Qemu is trying to reuse the same properties but it can
 > also add own one. They are trying to be aligned as much as possible but
 > there are a lot of cases where Qemu requires much more information. (I
 > am not saying in this timer case but in general).
 >
 >
 >> * Because the existing driver for this device does not implement all
 >>    functionality for this device, not all properties in the devicetree
 >>    binding are used. In fact, there is (as noted above) one property
 >>    which should be in use but is not because the current driver
 >>    (implicitly) does not support some hardware configurations.
 >> * To support additional functionality, it is necessary to
 >>    use hardware parameters which were not previously necessary.
 >>
 >> Based on the above, we can classify the properties of this binding into
 >> several categories.
 >>
 >> * Those which are currently read by the driver.
 >>    * compatible
 >>    * reg
 >>    * clocks
 >>    * clock-frequency
 >>    * interrupts
 >>    * xlnx,one-timer-only
 >>
 >> * Those which reflect hardware parameters which are currently explicitly
 >>    or implicitly relied upon by the driver.
 >>    * reg
 >>    * clocks
 >>    * clock-frequency
 >>    * interrupts
 >>    * xlnx,counter-width
 >>    * xlnx,one-timer-only
 >>
 >> * Those which are currently present in device trees.
 >>    * compatible
 >>    * reg
 >>    * interrupts
 >>    * clocks
 >>    * clock-frequency
 >>    * xlnx,count-width
 >>    * xlnx,one-timer-only
 >>    * xlnx,trig0-assert
 >>    * xlnx,trig1-assert
 >>    * xlnx,gen0-assert
 >>    * xlnx,gen1-assert
 >>
 >> When choosing what properties to use, we must consider what the impact
 >> of our changes will be on not just the kernel but also on existing users
 >> of this binding:
 >
 > I don't think that this is valid. Rob is asking for adding #pwm-cells
 > which is purely Linux binding. We also don't know what properties are
 > used by others projects not just Linux or Qemu. Also required properties
 > in Linux doesn't need to be required in U-Boot for example even we are
 > trying to aligned all of them. Another case are others RTOSes, etc.

Here I do not see a way around this. Any way we do it we will need to
have some new binding. However, as noted below, adding a new binding for
configuration is easier than exposing properties in new ways.

 >> * To use properties currently present in device trees, we just need to
 >>    modify the kernel driver.
 >> * To add additional properties (such as e.g. '#pwm-cells'), we must
 >>    modify the kernel driver. In addition, users who would like to use
 >>    these new properties must add them to their device trees. This may be
 >>    done in a mechanical way using e.g. overlays.
 >> * To deprecate existing properties and introduce new properties to
 >>    expose the same underlying hardware parameters, we must modify the
 >>    kernel driver. However, this has a large impact on existing users.
 >>    They must modify their tools to generate this information in a
 >>    different format. When this information is generated by upstream tools
 >>    this may require updating a core part of their build system. For many
 >>    projects, this may happen very infrequently because of the risk that
 >>    such an upgrade will break things. Even if you suggest that Xilinx can
 >>    easily modify its tools to generate any sort of output, the time for
 >>    this upgrade to be deployed/adopted may be significantly longer.
 >
 >  From Xilinx perspective it would be ideal to use only properties which
 > fully describe HW in the form how they are generated today. They are
 > stable for a lot of years and as I said only new one are added.
 > But this alignment wasn't accepted long time ago and we have been asked
 > to start to align these properties with similar HW done by others.
 > And truth is that in a lot of cases there is clear 1:1 mapping and
 > generic properties can be simply use. This mapping ends in Xilinx device
 > tree generator.
 > Back to your point. Required properties are required by Linux driver
 > only. This driver is around for quite a long time where certain policies
 > haven't been setup/used/enforced (Microblaze is 2nd architecture which
 > started to use device tree).
 > We should create DT binding doc at that time but in 2009 it wasn't
 > standard practice. In 2007 Grant was adding support for Xilinx PPC
 > platform also without any DT binding document too.
 >
 > That's why we need to review current unwritten DT binding based on code
 > requirements and look at it how to fix it (if needed) and then add PWM
 > support on the top of it.
 > If something needs to be deprecated, let's deprecate it and have
 > transition time for a year or so to adapt to it.
 >
 > Rob knows much better than I how this should be handled.
 >
 > Based on your list:
 >    * compatible
 >    * reg
 >    * clocks
 >    * clock-frequency
 >    * interrupts
 >    * xlnx,one-timer-only
 >
 > all of these are required property in new DT binding.
 >
 > xlnx,counter-width is optional if you want to use.

Again, for the existing driver this should at least be sanity-checked so
we fail noisily instead of buggily.

This is the situation for the generate polarity as well. The driver will
work fine, but you will not have PWM output and there will be no
indication why. This is why I think we should start with supporting the
existing output. This is used to ensure the device will work as
configured. We can also add support for different properties exposing
the same information, but to support only new properties is not very
useful.

--Sean

 > #pwm-cells is optional for enabling PWM support (I would expect that
 > when this property is present this timer don't need be used as
 > clocksource/clockevent by Microblaze)
 > etc
 >
 > And for properties which are generated out of Xilinx tools I would allow
 > in DT binding to add others optional properties that DT won't error out
 > if they are seen.
 >
 > Thanks,
 > Michal
 >
