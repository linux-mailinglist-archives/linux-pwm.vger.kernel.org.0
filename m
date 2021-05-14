Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CBC380EAA
	for <lists+linux-pwm@lfdr.de>; Fri, 14 May 2021 19:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhENROy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 May 2021 13:14:54 -0400
Received: from mail-eopbgr40066.outbound.protection.outlook.com ([40.107.4.66]:48006
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230063AbhENROx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 14 May 2021 13:14:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJW6cTMEsKYIXLBn2UTSHmN6GW5jrMljt5zjPobDl68EJ1NGS+GBmBLmQM+U2ZbmTEFd9vSul6UL6BM5M+2TusNyJ23gutDDrQ9ucxRkdvZWHQQWaUZRyJRQZjUptsBLJc8LZg8pFzNpyNCDzJuJqi6ShUOzkV3mArvK9+rgHH602eEa2SAp5rnidWARjjWDjrSM5OFW2ZExhrUrlm9vt7H3ebJnISIwI0BKnQbtAf0T6gtXUiEJBmmGWp6s2zpekY2Px1ew5O2jSL5AJqune2uTefTr5PdpyFS7bPGcn7Mq8Uug2DMUpoiWR1RGttvLRB/F/7hGcjA0NMQWgH8J1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3IvTvH8H+OFelMjo4NVbx0ZNGknOPim1cFa+AsYsMI=;
 b=W8gDimsYfsa+cSmNMGcebJsgEgjG0BXM1ZBtIoesY/ARNAeSCjzdrCLJzmsx81yCoMdZpWzWtd338q2Fi1FDhchU86QAd2dCA/9ts6+q2scFkFO9kk9qXmr6MFHKx+eMVi18f6JjHXIiSHz8W9XYIluEfTrdJn1wJOhuCiBOGOLX0Yab7UnY5nYfN3kv6MUG1kN2mZkHVy73ZEAlT1tpm4WnYNzpvxS7h9MGJutlQLTPiSQzBDQah7mk9eyld3snwbgZ9111G4tHeJkoTuGkib8fn2kLOQ3NbI1psSZwtEnvxxj+W+X5u03iWo+xlYbJ6E1zSqcOOJW1l6iGBiw9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3IvTvH8H+OFelMjo4NVbx0ZNGknOPim1cFa+AsYsMI=;
 b=KOOv215vvF8oD762B4X77K+H1Xn3yQjF1gtcLplMPag1oUnETeBtAuJhCNS6Fd4v50f8I9i/vQOq+arYj3AgZ1wM/0nPQC1B2PaLOOrRfyK2fr8T643dzNkUVpmGTzEIVCpBwDzUHXMTeDhmVvv+013SwI9JDqovBMyHQ0V3FHI=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB7129.eurprd03.prod.outlook.com (2603:10a6:10:206::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 17:13:39 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 17:13:39 +0000
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
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <87b31b06-9b81-5743-e3a8-50c255c0a83c@seco.com>
Date:   Fri, 14 May 2021 13:13:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <9cf3a580-e4d3-07fc-956f-dc5c84802d93@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL0PR02CA0127.namprd02.prod.outlook.com
 (2603:10b6:208:35::32) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL0PR02CA0127.namprd02.prod.outlook.com (2603:10b6:208:35::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 14 May 2021 17:13:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d33ed74-d3a8-4b1b-369b-08d916fb9e04
X-MS-TrafficTypeDiagnostic: DBBPR03MB7129:
X-Microsoft-Antispam-PRVS: <DBBPR03MB7129F9B09C7A4C088850EE2396509@DBBPR03MB7129.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZEf+lyIPUEpvShU88JfdOBFFZMzERSCEdP/Dd/7zAGz2nXXOq3CbDMUc9rCIy0RSkZw7WkrLLO12qUETENXYLGGCfs+rPqxtIHOzoA62Tdy54udn51sWd+R61ptH+jiyxYKm/fpwtJEFWnvjYYrdwWL9xm4XNDcedKdO3eSkL8BY8mF4qp1mYWFXy39qwGBNS2WNOWZUo21g2wSt/hzm0erY1yEJgpc7i0rcEPgcYeLTqH8YnzkWe+1eRkEEGJdbXrFnJIFmYa1NDuEu0yECpZJDopHodf19V8kB7jp0rv0OwGJxyilNHL8ybPkEYgIjaYEMZu+x08f96+/+WwWHkd+6l9FB8BA/yEVbBsa9aBw0H1AZqLLae9o34hB5qSDXUl1KvF3aH5nJGG6iDqaVc7TpiI2XunBKh6yWP+ziC6negn/ngPmBXr5vzKbrVqtTBWrQiJzommAiIInqxAUG5DnKmZjNiqBJ6gS0UwnYQ1z83Vofp6WEKNK8YUPQYUbdhL22bsEPx2XVUp1ax6dEIhRz4hQYNPjnp4CGYmB/7h89u6GRqcpf601HmPuV8KJ9GQ534WFgTu1jjV+WgR/3qO/yKUHlZE5p4zHabTYMaU/QAsTDZ7wiu2UlaVRkb4h/q78KJHfZUISbb0+afjuK+q5oamBGChEafHHbPTGuhx3J1jdBpVYpwz2nxnaTLG0uHp+Tg09l9MSdlL6mWBTRim7XgykkznFk6H0rn3DPaNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(498600001)(2616005)(38100700002)(53546011)(110136005)(16526019)(31686004)(83380400001)(44832011)(6666004)(956004)(54906003)(8936002)(36756003)(16576012)(5660300002)(6486002)(4326008)(186003)(52116002)(8676002)(26005)(86362001)(66476007)(66946007)(66556008)(2906002)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YmZQWnQ3dU96OUcrMHp5bU5kdWZqNjhwVVh0c2JtTEdyekJleW10eFI4UFI4?=
 =?utf-8?B?aUV6MjA0TVJOcG5rQ3NQNHZ0LzRJL3NyWFcrZDBhblN2V0NoYUs3TU9EaHV3?=
 =?utf-8?B?aXhMb2VaNkdNdnU4VmoyYkVXVGsyWVlmRVBPRjQxMWxvQm5NYWFzSUhkNVdu?=
 =?utf-8?B?eFR1bldpNUd6TUxVRGczWkw0T0N2MERWSkZIVUxpMkg5eXB5QnZOcEt1a2g2?=
 =?utf-8?B?V09MZGpCSkh3aGZKYVNYRWxGZU9zdVA0c2FRMG9HK1BvQlRhbHhYeWxTZEg0?=
 =?utf-8?B?RTkvM1NhM1lZVGU0WWxOSkhNT25PZTdOVEFtbU9rWVE1MEZSY3Ird25mSzBW?=
 =?utf-8?B?MkVXZkZERWxkQUs2cEtYVzNCbXlKYUxmdnJNTUk0VEZVdGQ1OWZFTVFDNnUy?=
 =?utf-8?B?S3BnS2VRaG8rajhOL1MveFVvb28yQlQ2TW4vcHU2dXh4L2Vlc3BEbEsxQk82?=
 =?utf-8?B?Wk9OcStUWW5pb2ZFYkpDWjBIOTNERGEremJKSW9PdzRITDJ1VUF3N2g3ZlUz?=
 =?utf-8?B?OExrcEJBRUFWVGR5L21udkN3Mkszd0g3SDJNQUdaMkFYbHNlWkd0WnZxTXFR?=
 =?utf-8?B?M2tDTVZBUEVNcnBFZ0hKSll6SmwzS2dUYU5hemZOckxZTy83Ymhxb1dkZlVO?=
 =?utf-8?B?QnBtdXBoNUJTY1loeDQxSmJCbE9SN3oyaDVxRVFSWlJtTlJmWGZ5OXRDalov?=
 =?utf-8?B?Z1BUMFNkc3I1ZTN5MmtWZ0d5STAveGtMUDhhT0lsOWk2WUwrL1d2NjJvZ2ww?=
 =?utf-8?B?bTNOQ2swM0lURzR3bjZweTRIMXlxRyswOStycFAzOGxpM25BSmFVeUtkczFZ?=
 =?utf-8?B?WnBjMng4ZkU4L2FZVllNSk1GWFFzSGdabFFENkIzY2lvdFJQTVMzUWRsUzdu?=
 =?utf-8?B?TUhMZFdVNXVaNXpCc3c0akRBZmdnUENJTXdUZ01sSlFwSlVUc2RpMXJZZFJP?=
 =?utf-8?B?Zzd1Q1dsUkMwZmFtYjFNcTZobVVKSEFxdWtET01YdG03Ly85UTNlcnVoMk9r?=
 =?utf-8?B?Zm9ZNDUzVlVaSUMwUFFLVFp5dWNSSDRjNGkwQVlvby9lMVgvUm9uVWhzK3FU?=
 =?utf-8?B?Z1BBNW9CM2dod1I4bjFodVNQQ21xbko2dFA2cVZMdE1lT2t5amNvc2VJbTBS?=
 =?utf-8?B?aW9WN0gwbDJlN2ZlVFJoMlNFUFVIMkRwcEVWYWppVm0wSEZkYTM2a2dYRW9Q?=
 =?utf-8?B?UFBEMWVXOUhLWnd6SzN3azg5dGNUSzVnVFlEbW9DRTIvMUMxdGFRK3dnNldR?=
 =?utf-8?B?V2Z6SGV5VUttaTMwbDVLMGZiSzNreTdTdE1zdVEvYk1JbFFSenNjT3ErNUl3?=
 =?utf-8?B?RUh3V3FUaE9kbEZFUnR2TzB4MUhFeUk3aDBmMzZodmwwTUdvZVVndjl0Ujgv?=
 =?utf-8?B?dnVqdVpxbDZRcG9GRDJSSjk1TzlXMDNaUFZGL3JHd2w3dnN0azdGZnk0eDZz?=
 =?utf-8?B?Vi9TOXljcjUrTUNKV1FrMFVJMkZWbkYzY05CZ1NxbVJ1QTNQR2RuU2Z3SmZ5?=
 =?utf-8?B?WlB0VXpqSGQ0UmxoNnZzYzFvUUhNRC9jWW1tdU1HOWtXQ01NczF5Y010OEFv?=
 =?utf-8?B?SW1PNFRVbG5QdWlrTDRkZEdXdGhmSG5RNnlLUk85QmN1bTNlNXVSbVhIbEFq?=
 =?utf-8?B?ZzFsaVVaejBHTkdRWWQwUGpXa29oQmJKL2JqUEhTZzV1c3pKWFJ6S25XdjRB?=
 =?utf-8?B?bjFoNVBvOFJSRjVDdTdzaXM3OU9KNnAwLzcwK1hHeEw4eW1mZ0RSVGQxWllM?=
 =?utf-8?Q?n1tWyvFzdlESiC86Hb/QKcEOpdOs8TGDWpDEuTd?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d33ed74-d3a8-4b1b-369b-08d916fb9e04
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 17:13:39.4173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ep7TcwOY1sHjxnl3zVjsNpyBtNkKi32SVfxfX+6BUN+WrRhth8ufHQNm3N/rayuJjebXTn1yOF7T84qoeJ7rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7129
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/14/21 4:50 AM, Michal Simek wrote:
 >
 >
 > On 5/13/21 10:43 PM, Rob Herring wrote:
 >> On Thu, May 13, 2021 at 10:28 AM Sean Anderson <sean.anderson@seco.com> wrote:
 >>>
 >>>
 >>>
 >>> On 5/13/21 10:33 AM, Sean Anderson wrote:
 >>>   >
 >>>   >
 >>>   > On 5/12/21 10:16 PM, Rob Herring wrote:
 >>>   >  > On Tue, May 11, 2021 at 03:12:37PM -0400, Sean Anderson wrote:
 >>>   >  >> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
 >>>   >  >> a "soft" block, so it has many parameters which would not be
 >>>   >  >> configurable in most hardware. This binding is usually automatically
 >>>   >  >> generated by Xilinx's tools, so the names and values of some properties
 >>>   >  >> must be kept as they are. Replacement properties have been provided for
 >>>   >  >> new device trees.
 >>>   >  >
 >>>   >  > Because you have some tool generating properties is not a reason we have
 >>>   >  > to accept them upstream.
 >>>   >
 >>>   > These properties are already in arch/microblaze/boot/dts/system.dts and
 >>>   > in the devicetree supplied to Linux by qemu. Removing these properties
 >>>   > will break existing setups, which I would like to avoid.
 >>
 >> Already in use in upstream dts files is different than just
 >> 'automatically generated' by vendor tools.
 >>
 >>>   >
 >>>   >  > 'deprecated' is for what *we* have deprecated.
 >>>   >
 >>>   > Ok. I will remove that then.
 >>>   >
 >>>   >  >
 >>>   >  > In this case, I don't really see the point in defining new properties
 >>>   >  > just to have bool.
 >>>   >
 >>>   > I don't either, but it was requested, by Michal...
 >>>
 >>> Err, your comment on the original bindings was
 >>>
 >>>   > Can't all these be boolean?
 >>
 >> With no other context, yes that's what I would ask. Now you've given
 >> me some context, between using the existing ones and 2 sets of
 >> properties to maintain, I choose the former.
 >>
 >>> And Michal commented
 >>>
 >>>   > I think in this case you should described what it is used by current
 >>>   > driver in Microblaze and these options are required. The rest are by
 >>>   > design optional.
 >>>   > If you want to change them to different value then current binding
 >>>   > should be deprecated and have any transition time with code alignment.
 >>>
 >>> So that is what I tried to accomplish with this revision. I also tried
 >>> allowing something like
 >>>
 >>>          xlnx,one-timer-only = <0>; /* two timers */
 >>>          xlnx,one-timer-only = <1>; /* one timer  */
 >>>          xlnx,one-timer-only; /* one timer */
 >>>          /* property absent means two timers */
 >>>
 >>> but I was unable to figure out how to express this with json-schema. I
 >>> don't think it's the best design either...
 >>
 >> json-schema would certainly let you, but generally we don't want
 >> properties to have more than 1 type.
 >
 > One thing is what it is in system.dts file which was committed in 2009
 > and there are just small alignments there. But none is really using it.
 > Maybe I should just delete it.
 > And this version was generated by Xilinx ancient tools at that time. All
 > parameters there are fully describing HW and they are not changing. Only
 > new one can be added.
 >
 >  From the current microblaze code you can see which properties are really
 > used.
 >
 > reg
 > interrupts
 > xlnx,one-timer-only
 > clocks
 > clock-frequency

There is also an implicit dependency on xlnx,count-width. Several times
the existing driver assumes the counter width is 32, but this should
instead be discovered from the devicetree.

 > It means from my point of view these should be listed in the binding.
 > clock-frequency is optional by code when clock is defined.
 >
 > All other properties listed in system.dts are from my perspective
 > optional and that's how it should be.

Here is the situation as I understand it

* This device has existed for around 15 years (since 2006)
* Because it is a soft device, there are several configurable parameters
* Although all of these parameters must be known for a complete
   implementation of this device, some are unnecessary if onlu reduced
   functionality is needed.
* A de facto devicetree binding for this device has existed for at least
   12 years (since 2009), but likely for as long as the device itself has
   existed. This binding has not changed substantially during this time.
* This binding is present in devicetrees from the Linux kernel, from
   qemu, in other existing systems, and in devicetrees generated by
   Xilinx's toolset.
* Because the existing driver for this device does not implement all
   functionality for this device, not all properties in the devicetree
   binding are used. In fact, there is (as noted above) one property
   which should be in use but is not because the current driver
   (implicitly) does not support some hardware configurations.
* To support additional functionality, it is necessary to
   use hardware parameters which were not previously necessary.

Based on the above, we can classify the properties of this binding into
several categories.

* Those which are currently read by the driver.
   * compatible
   * reg
   * clocks
   * clock-frequency
   * interrupts
   * xlnx,one-timer-only

* Those which reflect hardware parameters which are currently explicitly
   or implicitly relied upon by the driver.
   * reg
   * clocks
   * clock-frequency
   * interrupts
   * xlnx,counter-width
   * xlnx,one-timer-only

* Those which are currently present in device trees.
   * compatible
   * reg
   * interrupts
   * clocks
   * clock-frequency
   * xlnx,count-width
   * xlnx,one-timer-only
   * xlnx,trig0-assert
   * xlnx,trig1-assert
   * xlnx,gen0-assert
   * xlnx,gen1-assert

When choosing what properties to use, we must consider what the impact
of our changes will be on not just the kernel but also on existing users
of this binding:

* To use properties currently present in device trees, we just need to
   modify the kernel driver.
* To add additional properties (such as e.g. '#pwm-cells'), we must
   modify the kernel driver. In addition, users who would like to use
   these new properties must add them to their device trees. This may be
   done in a mechanical way using e.g. overlays.
* To deprecate existing properties and introduce new properties to
   expose the same underlying hardware parameters, we must modify the
   kernel driver. However, this has a large impact on existing users.
   They must modify their tools to generate this information in a
   different format. When this information is generated by upstream tools
   this may require updating a core part of their build system. For many
   projects, this may happen very infrequently because of the risk that
   such an upgrade will break things. Even if you suggest that Xilinx can
   easily modify its tools to generate any sort of output, the time for
   this upgrade to be deployed/adopted may be significantly longer.

Note that while all three types of changes are similar from a kernel
point of view, the impact on existing users is much large in the latter
case. For this reason, I think that wherever possible we should use
properties which are already present in existing device trees.

 > I think DT binding patch should reflect this state as patch itself.
 > And then PWM should be added on the top as separate patch.

I have no preference here.

--Sean

 >
 > Note: In past we were using only parameters and name we got from tools
 > but over years we were fine to use for example bool properties and we
 > just aligned Xilinx device tree generator to match it. That's why not a
 > problem to deprecate any property and move to new one. Xilinx DTG is
 > already prepared for it and it is easy to remap it.
 >
 > Thanks,
 > Michal
