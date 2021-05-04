Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E52372E97
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 19:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhEDRSD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 13:18:03 -0400
Received: from mail-db8eur05on2056.outbound.protection.outlook.com ([40.107.20.56]:64768
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231683AbhEDRSC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 4 May 2021 13:18:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEgq61q/bRBUkQgodRvJxZhOcD5LEIOu3YyF6mXkJfbVa+prixDDxPCR9hmYf8Qih4jl+5dcAaTEY66nmPvsmk7m+1/DtgwvcWTXYCb4IUuWxYMzp8CFigLDed1fEQJM++Skik4HLD+HBGSNgPlPrECc8WCLeAjzdc/ntaE4KpwlHR/TVkhH494gClk8qEFj6b6OYX17yAPUqWoF8fu3xOS16uD0KSm5ei1eP9LvOUxT+08NRpZF3k3PKK2aCl0UYoSWbFAgkEi3cGDXWwH/kBeL0QWP1ySCdINEXYxWjnqrsIGiTvIfDnZL7ZqnWstd35BLDMyb2hqJA0uVcD26fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/auWE8fwXYzWk4zqrFe4RBEKc5Of3hT7e0WGbULatQ=;
 b=N/i1IeyFvCrZx/At8UidGErfqCm7K8B0eqMnHj20qh+LRyb0bHrk2UXlG2oTkPf1r34xd8XhdxsvrJ7VAFerWIN8ngnsjBbYP3OFDWFc05qnfRPoFW2MYQda8RRCxxiZopE4bcYY75pvfPfldp2+DJEYpG+sFAHuMWk30346ZMXgOqFAifAn6WNiUBOGnFYwnu636b0mZpsvtBtgPtGR0Az5ly8YAWmegW+2SjGs6l35iSQnF1Vv6RpeGFVnyB0Q9ImrAahjlYxcCk0LVdtHypaBfC4ZvXVTGeQ+VxwbMwsDr3KjYjNYcdl7nWWN1mlvD5KfuuGKKzoTt4cLZCjZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/auWE8fwXYzWk4zqrFe4RBEKc5Of3hT7e0WGbULatQ=;
 b=SRqsPsqWlYFOKH753Q+XUYWEgJBC6YdDTczjOGhh+QDT6BsIdy06kRSoMiBXf9ChUbPBTxcm/QMXbTkdGckQV1w58BQJ/Xr3y+e4WQqPdtPHER9hegUeze2DDgYGexGs4wmI0U/KBVu6nL9BgnmxIJzAYc6M1iUKoNeLtzfFFS0=
Authentication-Results: libc.org; dkim=none (message not signed)
 header.d=none;libc.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4618.eurprd03.prod.outlook.com (2603:10a6:10:18::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Tue, 4 May
 2021 17:17:05 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 17:17:05 +0000
Subject: Re: [PATCH 2/2] pwm: Add support for Xilinx AXI Timer
To:     kernel test robot <lkp@intel.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, michal.simek@xilinx.com,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
References: <20210503214413.3145015-2-sean.anderson@seco.com>
 <202105041013.VkdTa8rG-lkp@intel.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <3082e917-be20-8269-5542-6c750cf97c04@seco.com>
Date:   Tue, 4 May 2021 13:16:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <202105041013.VkdTa8rG-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:208:23b::27) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR11CA0022.namprd11.prod.outlook.com (2603:10b6:208:23b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 4 May 2021 17:17:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49af430f-31d9-4a68-5dd9-08d90f207054
X-MS-TrafficTypeDiagnostic: DB7PR03MB4618:
X-Microsoft-Antispam-PRVS: <DB7PR03MB4618B6A805E8BE14318DF26B965A9@DB7PR03MB4618.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oe61PJNb1b/G3yD7UE+Tiek7BEfw/bDg07wZqlw3n8Z6tWidD9IEzdUjdZuMKZtkngQB6dtWEqQ7D1tgvLa5OtJOm5nFSuAvBzD21PhmSOa3ho0uYPNAu3lLCUOOvHhILCIS9bj8m8xyv21Je9K+Dt92zDXMU+W5wJhwSiIHpjIyopiEEftCdG+JCweSLeobBo2qwh0uLD7bcn6qQjbU/Bsnl1M511DqBAoyKzdBXhZ6zE+dNJJOiMbjJO7f9hdExxO3Rn4ZNNyqPnLo5SOXkxINMpIHvaWtpCBc3t8FlMfDPjPZiILTH6mFmnFwxphSspHh5POkll/PFNE77CKiInOu8Jkktll93j6GaVoj1dSXSDJgJv2r9zkkPQoaYFPGFzn/wSqbeuqZRILX7t9CjBUSbxIrFGGk8SRJ2KGRJ5LGK4Lm1uTRfh1pPTmL7zftjpuiiN5qPl1PN+xtpZCjAVJly+RxYMLjJ9C+7WZ8XM4/NBIdDWQL7GT7L0RMO5TfMzaVkJ59/HzjOG6qKs+ovv/4vi9NXln94SAfXolse2ARsGiCyuHITy9O4ksjtYk3SPx4C9Af2PWV70ygXaSdFuoHEgNXAo1BX6fZQeUy1B2jr1x1c/wCL6GRUyEAZFs786t/69mXGYio0Hv1v2WywCQqQzzXjS1qfQ3Yzpp5H/Nl7hElVsmxJjwHWy3zldLWKEx3Vgj08s/HWqCEGcXGZwMV0Qimy175wAieaOWSCxWOjVSI+fDd8XTn8+7ncymobNCh12IjSqSKk4+hNEYNYkH2hSUqkA0VjV06N4G4GCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(16526019)(31686004)(6486002)(186003)(53546011)(38100700002)(8676002)(4326008)(54906003)(83380400001)(2906002)(2616005)(8936002)(31696002)(44832011)(7416002)(956004)(66556008)(66476007)(6666004)(5660300002)(966005)(26005)(36756003)(498600001)(16576012)(52116002)(38350700002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?MRkHbGuTANv+dW6m/B2T4CjcWBPBolq9ad9dzVlofASCvs3aHflWJr0A?=
 =?Windows-1252?Q?LpXsuwZtkK19kLnb7y49iWdhadKskYE6yosaKZEeWlrGxYixWi8oNzjk?=
 =?Windows-1252?Q?V1Tf+3/6NAv3yrSJ07Sw8EoJrMSTKhSW1Aust7rxy/LGXMeI0BYaMr48?=
 =?Windows-1252?Q?DpHl86gYpQHL18wOWEuvE+nKJVViRK92t5i0dklbpTwFT9bmY/Y00R9A?=
 =?Windows-1252?Q?mTeeSVr21YexFMXdwmHiDqJI0D1YT+XQ044qjBlSXFwKUuPAE+AMzWgQ?=
 =?Windows-1252?Q?3hSzttF/udG/GrCJ50Ns30qlxS8I3WEzgH2r0IvzX9BkE+MGqAB4uADX?=
 =?Windows-1252?Q?BK2Tc4aZObjNmrHBItbiOtCfOxTQzujmZqQP9pfZ8vfpzt44Y11aPBpq?=
 =?Windows-1252?Q?PyIjkBDaS5JgLflOi1Ogv3YwywGIE0inJzUnvRz6pzZnXfXYAgta42/J?=
 =?Windows-1252?Q?XK+iwkRD41gxMRzm7iZ7LwVv0JgDtk5hI1PLlxqtW66NcZE6PghKFSWy?=
 =?Windows-1252?Q?DV/hq1Nhc+XbB5WZvm+KQAw/J19q6YuSpBxaaiA8F8MioaX8AMKJYrv8?=
 =?Windows-1252?Q?mN103JBdQH9fWOV8UlPLCTEfQf8Ugq7pOq0CIYejTpldv+dpF28IjQMd?=
 =?Windows-1252?Q?//Q9lsk3DOMPOYJMhMA+7t4HvL5rLjoUhJwFBHu9IXNdhsqf+ZzOPpWw?=
 =?Windows-1252?Q?ofcoBDlV/apwF6MIaUYdzG4Z/J34/8v+H8V5RgQCEnxLOnlKsNFfVSjw?=
 =?Windows-1252?Q?3ifF5VCgZpfnA1knmCjK4wbU9XG8nsyln0K/MMDAnj/AusdOxk5nbzno?=
 =?Windows-1252?Q?PKGBqonH3HLfkiEIeYqvMOrYYVYe9afQuVDCCxdx0WBf0IB/OxjVfAJR?=
 =?Windows-1252?Q?nmhkBRfDowXJZ8jy15Gf2RF+YiJJjArCJX+JQ9rqdVRqHf+ZxEn5/7yC?=
 =?Windows-1252?Q?5hDQ/rloBl0fjP7k2AYxYLNxGAYPDUNfnv8+/h6+8BYDN2urJ36zJG1+?=
 =?Windows-1252?Q?yz/q3wG3FFpe9rHU6jaQ+5yAeBagQk45pMpA8N9K2WIyKrLX2MPeFDy8?=
 =?Windows-1252?Q?WiYZlAnDzWDTTCx3tWCF4GlGC0qeKWuuBa8SeiG0dU5OT8PCd18TxkgZ?=
 =?Windows-1252?Q?jP4sbny+NrBnYMtlayYVA9ySEX7aiihafjIOagia38wcVTFb5ixCqhd+?=
 =?Windows-1252?Q?tr64hgA9jPW5/Bdgrm+RKZPRRm74eajXPeLt7a9U195lCDVBT61qncJD?=
 =?Windows-1252?Q?lIlr5vw7e0zXt/RO3D76GbIXABumU0jF2z7Z15oy39gR1+8a/lX4c+av?=
 =?Windows-1252?Q?ECEH55jAIv83EzjKAqXCurRdF1cc4uBsBJ8n67fvbZQIENxyRDdHHxkB?=
 =?Windows-1252?Q?97UY6jNUb50ufmN9m2xQKYznYfjleVzhevODiFmMfmTKpLdL8aZt5AFE?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49af430f-31d9-4a68-5dd9-08d90f207054
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 17:17:04.8892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNdgcH9kKfNYtkDs5jz8PJsKwVTHA8VqK8MB0VwM/A5d3JMhOhk6tPQBSmXH+oqT7JeTqMYyhf3oeCD6ySJfsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4618
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/3/21 10:24 PM, kernel test robot wrote:
 > Hi Sean,
 >
 > Thank you for the patch! Yet something to improve:
 >
 > [auto build test ERROR on arm64/for-next/core]
 > [also build test ERROR on linux/master linus/master v5.12 next-20210503]
 > [cannot apply to pwm/for-next xlnx/master]
 > [If your patch is applied to the wrong git tree, kindly drop us a note.
 > And when submitting patch, we suggest to use '--base' as documented in
 > https://git-scm.com/docs/git-format-patch]
 >
 > url:    https://github.com/0day-ci/linux/commits/Sean-Anderson/dt-bindings-pwm-Add-Xilinx-AXI-Timer/20210504-054451
 > base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
 > config: sh-allmodconfig (attached as .config)
 > compiler: sh4-linux-gcc (GCC) 9.3.0
 > reproduce (this is a W=1 build):
 >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
 >          chmod +x ~/bin/make.cross
 >          # https://github.com/0day-ci/linux/commit/164c8df701eef0c9509d544501a1de5c406e93cb
 >          git remote add linux-review https://github.com/0day-ci/linux
 >          git fetch --no-tags linux-review Sean-Anderson/dt-bindings-pwm-Add-Xilinx-AXI-Timer/20210504-054451
 >          git checkout 164c8df701eef0c9509d544501a1de5c406e93cb
 >          # save the attached .config to linux build tree
 >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=sh
 >
 > If you fix the issue, kindly add following tag as appropriate
 > Reported-by: kernel test robot <lkp@intel.com>
 >
 > All errors (new ones prefixed by >>, old ones prefixed by <<):
 >
 > ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
 >>> ERROR: modpost: "clk_rate_exclusive_get" [drivers/pwm/pwm-xilinx.ko] undefined!
 >>> ERROR: modpost: "clk_rate_exclusive_put" [drivers/pwm/pwm-xilinx.ko] undefined!

These should be defined in drivers/sh/clk/core.c, because
CONFIG_HAVE_CLK is selected (see the definition in include/linux/clk.h)
but they are not.

+CC SH maintainers

--Sean

 > ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
 > ERROR: modpost: "__umoddi3" [fs/btrfs/btrfs.ko] undefined!
 >
 > Kconfig warnings: (for reference only)
 >     WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
 >     Depends on SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && HAS_DMA
 >     Selected by
 >     - SND_ATMEL_SOC_SSC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC
 >     - SND_ATMEL_SOC_SSC_PDC && SOUND && !UML && SND && SND_SOC && SND_ATMEL_SOC && ATMEL_SSC
 >
 > ---
 > 0-DAY CI Kernel Test Service, Intel Corporation
 > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
 >
