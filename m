Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC39372CAC
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhEDPEh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 11:04:37 -0400
Received: from mail-eopbgr10040.outbound.protection.outlook.com ([40.107.1.40]:64481
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230352AbhEDPEg (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 4 May 2021 11:04:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyj3FDIUcG8MFLvuL7Wq1iJTcbuZC5qwsh/PcjUwlwjHtK6/7q0sy4EgacM0iMp7bu25Y0jB1fAKGaXk1hugxhkM8XfTPXJT88scdxNWCcyaAAesF512iF3hm7qL8DFTztRbRGTZgoeA8snk+Wsxc7WXx1yuWmQ/R0x9MHCWTZ7Oc8ia+gWAWFvJLXJPp/T66yzhnbaUt8TGIVySDf7thMjflYCawZhGr6NiW8J/9nw6Gogx34kqvdTyLCP/C4FtB6D5CH89qtl6ESYSBgxw6MYaOKGsX67eT+UzhbaxC0bMPo5amTx+AhIV9Yf8JsKuQ9Sdeno249aVeDxyjPyAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoG+GpJ/o8vvRlO9FsRefqF8+YMvZnAbjYLO8BY6bq8=;
 b=GDZrPZfQ4TKOsXPtZrL0p6aq+1m0r3yuQYX1uypGML25B5qCO6ToFiEouaNVJUSRNhMtzUqhj/xeKqR7UV/KktBZ3k+BaIEntP/ifht/XDZ4/sVR5rdlo6xkUNod8Fccjt7mKJi6eDN4AJ6BoxT374DzKPc+Rsc8y4AP2tF08YZpHZBDIuk95WQF5nuvGtgafSDsx8r6B6mIv/txo/4bEbVYEZCvXf2K7Z58I/Sz5T3FfjxNCXnQ1xhIaZHETKVhVJGWFwuUJTpLyBtginJ6jRQQdpZvxsinvpz4zncytZtmatKrfr8aBiKGWPbOMSTagAtSvDaVpG0TdNVVLaLfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoG+GpJ/o8vvRlO9FsRefqF8+YMvZnAbjYLO8BY6bq8=;
 b=igtoe+DOzA4FQN0+og2r2H1xiM1s42zKAltlLnSCICZvTrHoo82DEJX/N3N8qUtu7OGNHeZRtKWW3MYckxlyfeL8aUurqG5SvVAiz+rywRawHswGDvJEog29csGmKQF6AMIjVnuMERyQEhucurDgZ8LzbPj6hIHtFDF7+db/fuY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB9PR03MB7418.eurprd03.prod.outlook.com (2603:10a6:10:22e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Tue, 4 May
 2021 15:03:38 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 15:03:38 +0000
Subject: Re: [PATCH 2/2] pwm: Add support for Xilinx AXI Timer
From:   Sean Anderson <sean.anderson@seco.com>
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michal.simek@xilinx.com, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20210503214413.3145015-1-sean.anderson@seco.com>
 <20210503214413.3145015-2-sean.anderson@seco.com>
 <20210504085112.edyy6loprfzejrjl@pengutronix.de>
 <2ef7de6f-4d17-e81a-11bc-27eb382577a7@seco.com>
Message-ID: <70fa97ba-ea32-e734-acd5-5f5de3c03348@seco.com>
Date:   Tue, 4 May 2021 11:03:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <2ef7de6f-4d17-e81a-11bc-27eb382577a7@seco.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:208:c0::47) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR05CA0034.namprd05.prod.outlook.com (2603:10b6:208:c0::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Tue, 4 May 2021 15:03:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45279a33-66d4-4cd9-d3c4-08d90f0dcc2d
X-MS-TrafficTypeDiagnostic: DB9PR03MB7418:
X-Microsoft-Antispam-PRVS: <DB9PR03MB74184A3C4B4DD51714155872965A9@DB9PR03MB7418.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3JZpjcv159YiWR3ujWQnavuyABc5SHBv+SRm9+JXteH2K0ukCHiikWxv7T7ORCxzMBm2fYqSaE7U8JTJl7eWfY1SS28VNkR5RJKkaYMIFgrbTL8viGqGJ6V8cc8HWZH3dWiJBy5laMjOE5615vhnj8ruQbF7Jn/bsR1ZJULc4GKuQCXgAYRG3GPdev3jzpun304eKx454t7ZNR8YAyP0KrjdOagW0QPDtMqahX9Dw5+8xGN8vRTKshYS3bfIYIR7Gmyhwnb/AfxNTBZQ82tm7yE7twko6Iqqe+/VegnGdTwntpNPYdIIVekW2KO1SE+s90j2i/kcHBhuQiNZKiuzPnjEXqz+TCA0/KKq0HX0jOLKfXOtahdHBobF3DZjW9xtHzGJw+cGxWCUFrGME4Lfvdj9n9CC+mlfiLmABgh2b/EImJnX7Pl4UQb8CJ62FVeNTYBX594oXT0kDH0GRe9HzCEn05Gs8pEGoJDbOiBls23Xczb70T6xfH+/vaMJvepSD2xiZh0sR8Oqxhw6Frazq45MQ8i60gODbjLQTqPhVpqwjtbxi0qi/cvW8Hsnx3o9q72+YfjDhVNC1rp9KQscVB6Ef5lAlhifnCvGxDw5603MExqSoQ729w6z7LKDUBMnHFqjbJdJQORsN+EsSIpBfnHGUQLsxD2Eu2Q+gBQN6fvX+tFIysVfCCW6OXE62La8985aybku0Jow89wfbec7QmzNjmJvc/oYNxV3z7Xur0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(376002)(346002)(136003)(366004)(396003)(66946007)(66556008)(8936002)(66476007)(186003)(8676002)(956004)(54906003)(16576012)(6486002)(86362001)(36756003)(38350700002)(16526019)(2616005)(6666004)(6916009)(5660300002)(316002)(31696002)(52116002)(26005)(38100700002)(53546011)(66574015)(478600001)(31686004)(4326008)(44832011)(4744005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?/KtioLL6dsIUjVREVsWq4q69H/ju0josa+i/lvq5PMusmxd9NNGh1peP?=
 =?Windows-1252?Q?VZ85YxkSlIb76eXMktzlIQT9CyBATMevzvGG42yxJczUfBlQr3A2EkSM?=
 =?Windows-1252?Q?B7NbcIqss4Yf7JSRkjb0fn6ckKaYVg9oQ6bnTNDVbuISWU53eNkG6/0i?=
 =?Windows-1252?Q?mcKO6CQvC1Y+fouHsovWvSEdzefnrgt2/g0BaB8lhDrc9OAdP4yUGj7G?=
 =?Windows-1252?Q?Iu3HJlnDOsG6kULvG6eg+8/7u2Q3MyTqsrfv1ruUMpBKAjPpCTUoAh+E?=
 =?Windows-1252?Q?HUzSYODOZi8C15xXWL7LQIoOU6Ty+S09XZhhn6mmedpVBMYZ4oPRPPbE?=
 =?Windows-1252?Q?eTA/rPgRWK9cqhoKDt/Np/8WzmxxKYYBoHDYv4RJptr5mvsvL7OHjgAh?=
 =?Windows-1252?Q?X3c46ywpCt2lQptfupNvOlgqJlXJgj/L81PhB5okg6pLpnmQEMm/nDDb?=
 =?Windows-1252?Q?DzMa1iwZE+QuurJDzpISnR9a0hVLOmSGDqU9yGXDogwP5gHtHA+I82TZ?=
 =?Windows-1252?Q?aJCJl57/gds/w21uaDM86B/yftM/FJJKKv5sJhIwU/Vxwn2Gw3BzuYT5?=
 =?Windows-1252?Q?3Wuvv6jpXF1sEmENHhkegiv6NDDGwyiJhiBO++KcNeiotbQTucZdDXFy?=
 =?Windows-1252?Q?V9LV+ex1tHslKEQDviBRmMEr2AeiICcCkV8+kQ+O2m2Nt5raESLB77Aq?=
 =?Windows-1252?Q?JiJRMpZU+veBufsCTkxJoXYZ9UrvmFW2QixUYL1MCIgagidfENnXU5p/?=
 =?Windows-1252?Q?TlAGwDs/s9EUcWhcPoocxc3S7ShMakLoOsZPnBp2fUNiiJd7JLOyZj7T?=
 =?Windows-1252?Q?s5hrcPPMZ0oUSRA2nboDNjmV38WJ5U4fH5NZGsOXTM1/9UlwegAKF44Z?=
 =?Windows-1252?Q?6rw1OWeqTfR12EL6/E8CQpkgzDaq7U9INcUTEGsti/BMT8UXqZp66U5T?=
 =?Windows-1252?Q?sy78saVJkrQ0S7uSwDQPR8fTgN3eLyRj798gDKNQ5Sd5gYVy1JjzY7BW?=
 =?Windows-1252?Q?Dh1j2aLpNrAbqpR+msaPIMEQJaeMAuiGINXVYTy62/ZdDcQgYFjfTffI?=
 =?Windows-1252?Q?fbYuqwfvq7L/FZWE6KprPfUGnAAoRFeFSsYuccLD57Jfmhp19tL/fRqc?=
 =?Windows-1252?Q?kdDWKqIHM+OrbwtIgSOWf/IYpN2HwMoFnOgPmAJsoRzUUqKqkONZ3v6A?=
 =?Windows-1252?Q?+WK9iHorlEX10M8SMTgTantv8GNQxLTQyKG8SsW9bwKm32Qu8XapavXM?=
 =?Windows-1252?Q?8u5zwSrwgHYd1AXB8W+xxZ1L2ICDNyzk0+2pV2J332IDYHgICUtZZbY9?=
 =?Windows-1252?Q?0mPcC2t4dNIWJ3rMiJb3j00ZNAvZmntntVdUTdK5ymxG9MwJEZIIpXOX?=
 =?Windows-1252?Q?udHBF5GQVTcQstrn1V6L/+YWWbe8F4Hn8Iq34+c9COGMu3UfPrBObdhw?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45279a33-66d4-4cd9-d3c4-08d90f0dcc2d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 15:03:38.5292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuMsO6PGmrMInpVJ4dkcLt2HU+Ubb14nrrffc0y4VWhelhd/GglqslZdapX3qN9whGpBfm8Ifh6Z2bgn1/HDDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7418
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 5/4/21 10:46 AM, Sean Anderson wrote:
 > On 5/4/21 4:51 AM, Uwe Kleine-König wrote:
 >  >> +static int xilinx_pwm_remove(struct platform_device *pdev)
 >  >> +{
 >  >> +    struct xilinx_pwm_device *pwm = platform_get_drvdata(pdev);
 >  >> +    bool enabled = xilinx_pwm_is_enabled(readl(pwm->regs + TCSR0),
 >  >> +                         readl(pwm->regs + TCSR1));
 >  >> +
 >  >> +    if (enabled)
 >  >> +        clk_rate_exclusive_put(pwm->clk);
 >  >
 >  > This looks wrong. You should rely on the consumer that they disable the
 >  > PWM.
 >
 > What about a PWM regulator with always-on?
 >
 > This is mostly to match the exclusive_get in probe, in case there are
 > misbehaving consumers.

Since we always get the rate exclusively, we must always put the rate
exclusively here. So if the PWM is probed, but no one ever does anything
with it (and therefore no one turns it off), we must release the
exclusive rate in remove.

--Sean
