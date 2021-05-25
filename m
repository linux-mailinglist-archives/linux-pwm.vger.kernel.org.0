Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAEF3903ED
	for <lists+linux-pwm@lfdr.de>; Tue, 25 May 2021 16:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhEYOcn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 May 2021 10:32:43 -0400
Received: from mail-vi1eur05on2085.outbound.protection.outlook.com ([40.107.21.85]:53184
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233406AbhEYOce (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 May 2021 10:32:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EW5Idby43HNs/gBWrm+N+wtxn7Sv6zhD+JY6sBmLh/Vx9O6lcYXH2l59odKwaOhYMUi4MFfvez6YD9sMvn1bYatwenVEED60n8b9KTcQMbeC9mogWA2N1/llRCz7lvLdHKufXQ4Sq/r54rroK2lthiIB5x+pwsnlz5Dhm0Mni4spoFqVQFGXpnDIBFL//z6eGhmM7U3F7PyiJ07NOFt39dvE7FjVhpJuA/rWgYRBVSj0e58xhdI+5W3q4f42xCiGud44FNmnEgpFAuIcn0/7NtGkaCJoaAs1N2X9xzK0b8cdIoPeN39mvGIykgHKO1PEH23mPkThJHc15yrHfgPjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR9afKVwTbK8naoFIDs6z22aPwYEseJ2N3THqUQIopA=;
 b=R0MrDsju4qwPigZO0GGPOujh5VyNRTeW5ychYHa5yhz6gr39arn69gipWIUUJ69vNdHyDNcEgMzEk/iyhxzxs8QosB5XPT72Bj4HYWZAPi0wxukvXxdceww4txxylgl/zh22km5iHon/8zvxaEQVI18pcSdAwLcGo+55hbBo8EsFcNavsco12FJAWmpxXmyRunU2ruVSR67W7CwmTmt3LzI/0XEKrO4gkOFyZc5dag3DciwuRoYHvBRSi8vmVvPOx4iLFi4W5Egt4MwDfqlLW/tL4rKNU0Ayi9+1GdK4T8i9MRRB2wuwAUfmv9HCwbouvsueX8zU+jfcUUR4G7o3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR9afKVwTbK8naoFIDs6z22aPwYEseJ2N3THqUQIopA=;
 b=kKliBdr0+9TEicVmHuc9LpYPdfCXaA6SZErAoZFEimmTm3NI7+wmenGL3XaR8qs24DYFrImmdaPr1Mb3kdI9e1YPjXJqo824bToJuQlFjFEz2XtSz/Hmhtu2dkzbSF760WDPvur63l7gEZKpp0cKhj7gzLDHMpqnTz6ZxLHWy9k=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB7146.eurprd03.prod.outlook.com (2603:10a6:10:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Tue, 25 May
 2021 14:31:00 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 14:31:00 +0000
Subject: Re: [PATCH v3 2/2] clocksource: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@pengutronix.de
References: <20210511191239.774570-1-sean.anderson@seco.com>
 <20210511191239.774570-2-sean.anderson@seco.com>
 <d4bb7b5d-9f38-cf60-fb0b-18f8e0ca2b1e@xilinx.com>
 <5f960034-174d-0ed8-9f52-3d5fde90e16a@seco.com>
 <9f227f96-a310-0fbd-fd34-91eb386306b9@xilinx.com>
 <7a06cf46-0f85-1edb-ca08-abd7b2543ad9@seco.com>
 <41542760-3967-4f9a-0f0c-1206e03ff494@xilinx.com>
 <d206a399-454e-d9c5-e2d3-337d098ed7aa@seco.com>
 <2296d4e5-717a-0470-d487-e0924cf6c076@xilinx.com>
 <20210525061131.omrbcdewf4z75ib7@pengutronix.de>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <beb342c7-6c82-10b2-08da-18ca2c5d32ea@seco.com>
Date:   Tue, 25 May 2021 10:30:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210525061131.omrbcdewf4z75ib7@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR16CA0062.namprd16.prod.outlook.com
 (2603:10b6:208:234::31) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR16CA0062.namprd16.prod.outlook.com (2603:10b6:208:234::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 25 May 2021 14:30:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bde0516e-3c78-4049-c520-08d91f89b7d1
X-MS-TrafficTypeDiagnostic: DBBPR03MB7146:
X-Microsoft-Antispam-PRVS: <DBBPR03MB7146D65B2DA7BD858BB8B6CB96259@DBBPR03MB7146.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upy1CH/v403WQp+wSzaPmql0Moy4AzVRf4VuCt5w5LkqCkrnnkEcJHb//Zvnwk0VJTN/irJQo7eSBCgcTlh7/DyDHjsdPKYGlbGi3TBfbfT0RhzXNA3p2Qq+jlq/i/h5FHbra4Zq7oBFVFYCS6t9puvgXqGO9lTv2auTvDBVYKRzLb6UAD2FYm50RBqLlopxe+/sCRk4Ha9V5pkVPZiyJsCMc8aaFCqqMoLYnbX3plw9Vq/jNs3UYSxJaK6VWERA0pTnDIxhUMDpLxo2xBSVSmYnI9P+d0PgiBb3m1zS7UJ4MpjiedMgX3nivz9VjanC2q90A6CPMnuiSWnzi0oTWHs9FbYR6MzbaoTF2shyfd02/ATn5O4boP8Ro4lBTWkfgPs0ravBnAlRtlKA9atpl8V+kjIYeytl0sC8DYG3maOeA6+U4iEP21SRPtqIZYb99pWA5vax4qPeCJ8KRLGoyewtYNNCRMLPnn6LIx/tz0XVbeSieN8QWEqgVyVmcWs7yoXZeOzcA3ePY6eTzNvsPJelVIrTJCbblYxuMGdv4hOl7iTao9apirDKhCBpDDq5JdhgMxiULcbLNm1SLOjeEiAIcxA34Mmq39vLgw10WHsNzCJEyt1RQfga7Vy71dA7sq+Dj712TeeLYCgKbb7PTWlKlK9rNp6WY+M95nfBEQXbPDW9fXmhT/rSHEfHodCDbfqll4Mz9q45iH0RaSgSsxh99Wip7qzRF6nwTXVGFhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(366004)(39840400004)(83380400001)(2906002)(110136005)(38350700002)(38100700002)(52116002)(16526019)(8676002)(186003)(6486002)(316002)(54906003)(36756003)(66574015)(6666004)(16576012)(86362001)(5660300002)(66476007)(53546011)(31696002)(2616005)(66946007)(478600001)(26005)(31686004)(8936002)(956004)(7416002)(4326008)(44832011)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?8JwVfejOQBDpxKsiX6WtbIh2A3wpMP8ov6RI0CbTEVfhL/953mtyP91V?=
 =?Windows-1252?Q?XTx0Sp0X65PpHv04tcYfOwUCPLdRMt5iouZ4ey70dYGVR87lqHkc2+5n?=
 =?Windows-1252?Q?ie+3l+wh3VkPIKDLx0+PBmLa5ZU0/huyGYtDWzc8bcJoWeLU07EgkGNV?=
 =?Windows-1252?Q?Ze0LNyAgngA4E7pYWoFr8JxfKn8FgRsEZOJeWOUPB1tx+J8/XZ8Q+HPj?=
 =?Windows-1252?Q?E1GHe811kYMyJYt+ZKtAP17RSbDfLk7SB8iLv+SluYkYTYPQenAPDDmO?=
 =?Windows-1252?Q?F/Cs1kIe/wv8nQQLaK+eIecH62XAaau2jiXL0I53kjm7ip3r2Gp4Cwz4?=
 =?Windows-1252?Q?Buc6MTSlQs/F2+IT28dFMNuEVZv0KFKLc4zfEVzx6aV8kNYD8bdGge2S?=
 =?Windows-1252?Q?m1YOrF6vRhHLl767zQgqlTZkXT4Nyz5dt7tZRDBuNkP5Uiw3AibpJ9m4?=
 =?Windows-1252?Q?8xmbbFWCwOizEcU1shL4Y70lmf1dVtSprwfZ7zK+V0aCOAAmhgUDUSFf?=
 =?Windows-1252?Q?RoDYT0Lc8ULt3yyTk5E7qQt5FPqAEnPhHP4xW2UMeCsmrM0ORKX5pFJ3?=
 =?Windows-1252?Q?tS2jYpUUuUDFG1oZ81TK+s9Zuq9NfkyRE3IAoi5JXPHfXjTHJJLQlbvU?=
 =?Windows-1252?Q?aA0sP1tCiEIUkJLwvaN3XHy82O53KNcvo6mTIGKaE4g0MlDQDb0i2QZQ?=
 =?Windows-1252?Q?sbeye7fmUXtC5UleJEBtov8fRnfCwiXKx4+S9+n4gdxEBhGHkDgPt06w?=
 =?Windows-1252?Q?yB7JBUZrMATHCSD609TMuu83uywaKKVuHSAEHvxeGAbCpyr/oVd2djyh?=
 =?Windows-1252?Q?3kLIhqVckNjBAuLYdcf3SVjnjHgNZDybir9KA6aeSGmP37HG14ajsOjJ?=
 =?Windows-1252?Q?oMpp7zJ4MvX4vQW9HBMFPKKmyErOtHYwjUNqTfloUFUXMnDbYa0D5z4R?=
 =?Windows-1252?Q?QLsBtw71RsqT0aUOu6BLv2CnEjxs+klLvdtk5pIistFJ6ukTTVEAbMo8?=
 =?Windows-1252?Q?NqDT8W/yAbAAsPJ1y4AWSkUiPjgzOSIKwH6SjpWQUfreaBl5CvOtMfr/?=
 =?Windows-1252?Q?6LBmjJ8gUjJNcRbIbBNIbOfJJlvTQLLkrYUnmZaiwK4jdRve6BNB8l75?=
 =?Windows-1252?Q?rsGf16GkRdBEVM0URRwCWPOubDC7Ij9zz8nYd+xyX2XYeLBFSDgqoDOv?=
 =?Windows-1252?Q?iS6nsOEPOnOarJlThzSKi+wAcvD07qijscIxTEJC1bObThI9lncXxko+?=
 =?Windows-1252?Q?R+qXCmPZXPd796ggtZMHFacBxcUP/Jde+9Uz190/wjpcVu+HCdRjcx0D?=
 =?Windows-1252?Q?MamUhqZSs1mOKc3CcL4G/mGgdK6jz9qg36lb1K36PZqqETMphhAfXLav?=
 =?Windows-1252?Q?0i1kOnc/py2IFgi2KELgs7NfSRETf6eb63p3Mm5EFaR+puINZ5aScKzW?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde0516e-3c78-4049-c520-08d91f89b7d1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 14:31:00.5443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApJSrHOOn9aWT38fSBRNlWlzJYjZUP4VQLpQQgw8bo4kxgq9rG1/mvtCOayeEWsHjuItMpeWB5YOXfvnhiY1Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7146
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/25/21 2:11 AM, Uwe Kleine-König wrote:
 > Hello Sean, hello Michal,
 >
 > On Mon, May 24, 2021 at 09:00:51AM +0200, Michal Simek wrote:
 >> On 5/20/21 10:13 PM, Sean Anderson wrote:
 >>> On 5/19/21 3:24 AM, Michal Simek wrote:
 >>>> On 5/18/21 12:15 AM, Sean Anderson wrote:
 >>>>> This could be deprecated, but cannot be removed since existing device
 >>>>> trees (e.g. qemu) have neither clocks nor clock-frequency properties.
 >>>>
 >>>> Rob: Do we have any obligation to keep properties for other projects?
 >
 > If a binding is in the wild and used to be documented, it has to stay.
 >
 >>>>>> 4. Make driver as module
 >>>>>> 5. Do whatever changes you want before adding pwm support
 >>>>>> 6. Extend DT binding doc for PWM support
 >>>>>> 7. Add PWM support
 >>>>>
 >>>>> Frankly, I am inclined to just leave the microblaze timer as-is. The PWM
 >>>>> driver is completely independent. I have already put too much effort into
 >>>>> this driver, and I don't have the energy to continue working on the
 >>>>> microblaze timer.
 >>>>
 >>>> I understand. I am actually using axi timer as pwm driver in one of my
 >>>> project but never had time to upstream it because of couple of steps above.
 >>>> We need to do it right based on steps listed above. If this is too much
 >>>> work it will have to wait. I will NACK all attempts to add separate
 >>>> driver for IP which we already support in the tree.
 >>>
 >>> 1. Many timers have separate clocksource and PWM drivers. E.g. samsung,
 >>>     renesas TPU, etc. It is completely reasonable to keep separate
 >>>     drivers for these purposes. There is no Linux requirement that each
 >>>     device have only one driver, especially if it has multiple functions
 >>>     or ways to be configured.
 >>
 >> It doesn't mean that it was done properly and correctly. Code
 >> duplication is bad all the time.
 >
 > IMHO it's not so much about code duplication. Yes, code duplication is
 > bad and should be prevented if possible. But it's more important to not
 > introduce surprises. So I think it should be obvious from reading the
 > device tree source which timer is used to provide the PWM. I don't care
 > much if this is from an extra property (like xilinx,provide-pwm),
 > overriding the compatible or some other explicit mechanism. IIUC in this
 > suggested patch the selection is implicit and so this isn't so nice.

In this patch, the selection is by the presence of the xlnx,pwm
property. In the next revision, this will be changed to be the presence
of #pwm-cells (by the request of Rob).

 >>> 2. If you want to do work on a driver, I'm all for it. However, if you
 >>>     have not yet submitted that work to the list, you should not gate
 >>>     other work behind it. Saying that X feature must be gated behind Y
 >>>     *even if X works completely independently of Y* is just stifling
 >>>     development.
 >>
 >> I gave you guidance how I think this should be done. I am not gating you
 >> from this work. Your patch is not working on Microblaze arch which is
 >> what I maintain. And I don't want to go the route that we will have two
 >> drivers for the same IP without integration. We were there in past and
 >> it is just pain.
 >> I am expecting that PWM guys will guide how this should be done
 >> properly. I haven't heard any guidance on this yet.
 >> Thierry/Uwe: Any comment?
 >
 > Not sure I can and want to provide guidance here. This is not Perl, but
 > still TIMTOWTDI. If it was me who cared here, I'd look into the
 > auxiliary bus (Documentation/driver-api/auxiliary_bus.rst) to check if
 > it can help to solve this problem.

I don't think this is the correct solution here.

 > A key requirement for utilizing the auxiliary bus is that there is no
 > dependency on a physical bus, device, register accesses or regmap
 > support.

Since both PWM and timer drivers need register access, we cannot use the
auxiliary bus here. Further, timers must be initialized very early
during boot, before we even have devices, and cannot be unregistered.
Because of this, it only makes sense to bind one driver to the device.

 >
 >>> 3. There is a clear desire for a PWM driver for this device. You, I, and
 >>>     Alvaro have all written separate drivers for this device because we
 >>>     want to use it as a PWM. By preventing merging this driver, you are
 >>>     encouraging duplicate effort by the next person who wants to use this
 >>>     device as a PWM, and sees that there is no driver in the tree.
 >>
 >> We should do it cleanly that it will be easy to maintain which is not by
 >> creating two separate drivers or by switching to completely new driver.
 >
 > +1

Ok, then you would like me to continue my current approach where both
drivers live in the same file?

--Sean

 >
 > Best regards
 > Uwe
 >
