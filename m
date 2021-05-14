Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F66B3805BA
	for <lists+linux-pwm@lfdr.de>; Fri, 14 May 2021 10:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhENJAw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 May 2021 05:00:52 -0400
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com ([40.107.93.83]:41792
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229544AbhENJAw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 14 May 2021 05:00:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JY23yLCVIiFwaBamYxRhm0KFKEVUNsdmQONSkdXvBIjFWb8izBP5mZwEPRUWMjZJ5mBMW9xIdoJdQshlp8gCN4opC9M/eTOEny/vHiGw1rd+O2rrhHAdUkE1IYie6el/W1r7fPGngn9J/JFSzdKpnoWsmEZ9eGISClb5P+W5orGVtjN0G0G7qbYFdpky6dEC7VcaJjqOf2TOGSRhGiIdTFEkeEnVdrX34aIOmuvabg46/SCf7p9/PBKgBkdaMc8DVxR4NIWqpyrtQHwNWkKU04j/ls+vsBPC4QE8UfbnyGx3aZs1reaVNCpk/KUizvCm187UJ/0fZuCBroZt9xoMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttddy0Ob5Rq3W6WOcVoUUHz8iVVy7RUdLF8G7IDtlQE=;
 b=DZqsNRz8K+QQehQQdaq0phnk2Gavz89/mr8uDobrpzABqFbTcVIl9isgIH9JK6mfIyA5carMxB27IjNlQivaU0JMc8wUqHGmfjAJqHxPw0PJ7hcNjhE+rq1v1FIQKpDzvZEiIs9sXx8pstfhOjoGc9cWJgo/6hKxoZDdHvR5xM3e7zIDTioYoBet6BsnNrs8w7+w/H4zgIGFNb/MsObD2+EMC8Gfj1bHBsYZr6Qg0YyrbaFlVvlLXkJm9aDmmxG06WW4dOAmfl+ZaVvb9gVrKcneb/vlUwF9kCfhkt1vu+gcxtE42kau5Todz8cxcHzANyyoCi0Hvo/7vp37qEJuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttddy0Ob5Rq3W6WOcVoUUHz8iVVy7RUdLF8G7IDtlQE=;
 b=LUt6dj27JWPlwWwLkOXg7BMNJ5VrIjm807+8JBAinYcrVjqzlX8KQ35mWRZJkQ+ZgmlmK4UR0CGGcX0HXHIYW4x6AT4QH1kCw4u1fekxQdrl8MW5C048cFwGFTKYn95PQoz6ZGKooQKtpcR+K3RBGOuboqDqDpf1M61TSj1/E/c=
Received: from SN4PR0401CA0025.namprd04.prod.outlook.com
 (2603:10b6:803:2a::11) by SN6PR02MB5006.namprd02.prod.outlook.com
 (2603:10b6:805:6a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 14 May
 2021 08:59:38 +0000
Received: from SN1NAM02FT0044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2a:cafe::57) by SN4PR0401CA0025.outlook.office365.com
 (2603:10b6:803:2a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 08:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0044.mail.protection.outlook.com (10.97.5.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Fri, 14 May 2021 08:59:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 14 May 2021 01:59:37 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 14 May 2021 01:59:37 -0700
Envelope-to: u.kleine-koenig@pengutronix.de,
 tglx@linutronix.de,
 thierry.reding@gmail.com,
 lee.jones@linaro.org,
 daniel.lezcano@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 alvaro.gamez@hazent.com,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=49478)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lhTfV-0002EF-0x; Fri, 14 May 2021 01:59:37 -0700
To:     Sean Anderson <sean.anderson@seco.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, Alvaro Gamez <alvaro.gamez@hazent.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20210511191239.774570-1-sean.anderson@seco.com>
 <20210511191239.774570-2-sean.anderson@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v3 2/2] clocksource: Add support for Xilinx AXI Timer
Message-ID: <d4bb7b5d-9f38-cf60-fb0b-18f8e0ca2b1e@xilinx.com>
Date:   Fri, 14 May 2021 10:59:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511191239.774570-2-sean.anderson@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eedbec9c-409b-4f6e-3bca-08d916b69a8e
X-MS-TrafficTypeDiagnostic: SN6PR02MB5006:
X-Microsoft-Antispam-PRVS: <SN6PR02MB50065F0DF3D86237453D9A30C6509@SN6PR02MB5006.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MqEhM6PECLOWkR3nUFwPOCuCrtqKySLrB7Z0GkK1wksaYgIrxKuWyEmHwkkn1PTRk14vz16gp9ZY5q4LNqlVf5Wc3aOS7Krlreq6UeNlsmIOpmaFWmF6ocWdJr6qgYdfyjwjRoPClbuLXuuTpcWudFNFG4e94ilw0hjhe2wuIk5+GPXfIckM0wgb2S56uWcApW+qrtEilkTWpbQJ/EN1ibjVdsA+7lERG2Hwh9roeLyIPEJLuA7mOa12TEDKE4xuifbsKOOPWL9VRj3E9+XQLBZdfaUB2GEokOaNomlH3UC2YEBhQuvDS2x8sVKX28RDvSP2ihUNp7PttmTT2qQoE49DxVsJo/RX5xUwxL82mZd9X1hD7z5hzIgRk/vk0DZUpyi67UX+krNyjOFs5hkPjKDUTSs0f5O4/50VqU3gr5U7xIndEq4TG3FRLg2+FHvYA8OEdJa5XUjm2CcmNf3UTHbUaNXUSMdQa1AdSrZS/+1DJ8nTeMMwOv/XZTd2fZ45d/3aD9ljGLZSUbmQELjqiTaXQ2b8pidDAVK30RvnsTiOaUiDzobAf2fbqiky+UKOsqhD92svsMeEtp9dPvImEULyWJYETVOscF+86AxpKUZAsj+kL2W030u6wjet5DDDF9MTPNMKZ6XsGcT7QCuub9wNsP1rID8HKUCEY6q480uCTiQHN0myi2szDoWqUR2TKzu1jDVTNGZNbpcEM09eEq4zwhq52RyBnNpathyr1kOXLjX6asGZDMkbrxpo44z25agAcM4hU5r9Y7vt28QHqs1KrI4bZtOdBue/8i5IW9k=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(36840700001)(336012)(426003)(36906005)(7636003)(186003)(31686004)(7416002)(2616005)(110136005)(8936002)(82740400003)(54906003)(478600001)(70206006)(70586007)(4326008)(83380400001)(82310400003)(8676002)(31696002)(966005)(356005)(53546011)(5660300002)(26005)(47076005)(9786002)(36860700001)(44832011)(36756003)(2906002)(6666004)(316002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 08:59:38.1707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eedbec9c-409b-4f6e-3bca-08d916b69a8e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5006
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/11/21 9:12 PM, Sean Anderson wrote:
> This adds generic clocksource and clockevent support for Xilinx LogiCORE IP
> AXI soft timers commonly found on Xilinx FPGAs. This timer is also the
> primary timer for Microblaze processors. This commit also adds support for
> configuring this timer as a PWM (though this could be split off if
> necessary). This whole driver lives in clocksource because it is primarily
> clocksource stuff now (even though it started out as a PWM driver). I think
> teasing apart the driver would not be worth it since they share so many
> functions.
> 
> This driver configures timer 0 (which is always present) as a clocksource,
> and timer 1 (which might be missing) as a clockevent. I don't know if this
> is the correct priority for these timers, or whether we should be using a
> more dynamic allocation scheme.
> 
> At the moment clock control is very basic: we just enable the clock during
> probe and pin the frequency. In the future, someone could add support for
> disabling the clock when not in use. Cascade mode is also unsupported.
> 
> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
> 
> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> Please let me know if I should organize this differently or if it should
> be broken up.
> 
> Changes in v3:
> - Add clockevent and clocksource support
> - Rewrite probe to only use a device_node, since timers may need to be
>   initialized before we have proper devices. This does bloat the code a bit
>   since we can no longer rely on helpers such as dev_err_probe. We also
>   cannot rely on device resources being free'd on failure, so we must free
>   them manually.
> - We now access registers through xilinx_timer_(read|write). This allows us
>   to deal with endianness issues, as originally seen in the microblaze
>   driver. CAVEAT EMPTOR: I have not tested this on big-endian!
> - Remove old microblaze driver
> 
> Changes in v2:
> - Don't compile this module by default for arm64
> - Add dependencies on COMMON_CLK and HAS_IOMEM
> - Add comment explaining why we depend on !MICROBLAZE
> - Add comment describing device
> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
> - Use NSEC_TO_SEC instead of defining our own
> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
> - Cast dividends to u64 to avoid overflow
> - Check for over- and underflow when calculating TLR
> - Set xilinx_pwm_ops.owner
> - Don't set pwmchip.base to -1
> - Check range of xlnx,count-width
> - Ensure the clock is always running when the pwm is registered
> - Remove debugfs file :l
> - Report errors with dev_error_probe
> 
>  arch/microblaze/kernel/Makefile    |   2 +-
>  arch/microblaze/kernel/timer.c     | 326 ---------------
>  drivers/clocksource/Kconfig        |  15 +
>  drivers/clocksource/Makefile       |   1 +
>  drivers/clocksource/timer-xilinx.c | 650 +++++++++++++++++++++++++++++
>  5 files changed, 667 insertions(+), 327 deletions(-)
>  delete mode 100644 arch/microblaze/kernel/timer.c
>  create mode 100644 drivers/clocksource/timer-xilinx.c

I don't think this is the right way to go.
The first patch should be move current timer driver from microblaze to
generic location and then apply patches on the top based on what you are
adding/fixing to be able to review every change separately.
When any issue happens it can be bisected and exact patch is identified.
With this way we will end up in this patch and it will take a lot of
time to find where that problem is.

Another part of this is that you have c&p some parts from origin driver
and do not keep origin authors there which can be consider as license
violation.

Thanks,
Michal
