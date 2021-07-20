Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4313D0405
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jul 2021 23:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhGTVEF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Jul 2021 17:04:05 -0400
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:28899
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230527AbhGTVEC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 20 Jul 2021 17:04:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XG89eaLkZUruZO+t+gIKrOK4HIeDlaymIzzemx6c0NcfDOhSmLEtGpruoILSZhZ66eQU31z7vG+Flv75ZIHafzIyOKIwmZsSm7XMc8fOfhGIx8A57nNhJqNF6rv6IqCGN6rx14K20KPa2ivVjjhcOg5ZEKb35v7BtJA0gNOh4oi/IwJ7T2bSCGVA9zSc8Sx9OfdtzV9lqtteZOdBUYQcreIscfer8qugd9mhwIGmYYDNSDeIwXwB7Iz5mTgVate8JMs7LqVpBAnJw3FWqvrQsIf0eyc99wFPVvKYU8MwOPGM/zAFFAla+6judhqTrgm3A7doyk0L3Ty6p28ROCadtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTINjxJYDPp9lXGnEyISztI3liovaoOWXNlQG+H9F/s=;
 b=Pf2P6/0v2cWSzcIR2v1kBkn+PNeX71nCeTn3PZPGO9oU/iRNoKuZQR4RpSzV39cFnJliN6FSuHfJkUOwSYGpARggrYfUAOhW7gNQttmuxb28640fPgCAxTxo9fY4/WCo2XpbaPxkWCAID8N9g3+rPYA6R6qpzvffjbrWgYTtiYuLXeZDbewbCXYouITwMeKPDUCZ8ybcUut1z1l/ppBI2o3HykSYyfZs/8+yAG9TSjMjLPpesCi54i547Wlj5PfFBzgugks8bF0f4qyMF4NWUrPJN6wVWeYSZGQRdf407J0EOUVDoFiGJ6Oal7nv8QsY819jiesXYueMZ+dDkRUifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTINjxJYDPp9lXGnEyISztI3liovaoOWXNlQG+H9F/s=;
 b=NM6hUkZXjVTXfNKKdWmXkz0exOnCmsoC+cKa751k1SJKONBwDd8Xj28zz04vxmY8WmOA4JSjFDw4NAR/0l2HmSuQ19ixbNvtecL+tMVJAw+7xaOUkmE+aBFf7u3yWTVgEymaDClbtWbmP1NlFPmtNCMoa+QC3nhomJ3QYzTXuCo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0302MB2822.eurprd03.prod.outlook.com (2603:10a6:4:ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.34; Tue, 20 Jul
 2021 21:44:36 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 21:44:36 +0000
Subject: Re: [PATCH v5 2/3] clocksource: Rewrite Xilinx AXI timer driver
To:     kernel test robot <lkp@intel.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     kbuild-all@lists.01.org, Alvaro Gamez <alvaro.gamez@hazent.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        michal.simek@xilinx.com, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210719221322.3723009-2-sean.anderson@seco.com>
 <202107210546.xSpBmBBe-lkp@intel.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <c24ce7ad-02da-00f5-e1d0-1630854a42df@seco.com>
Date:   Tue, 20 Jul 2021 17:44:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <202107210546.xSpBmBBe-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::24) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 21:44:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5d013fb-7c52-4e17-a3e1-08d94bc79165
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2822:
X-Microsoft-Antispam-PRVS: <DB6PR0302MB28227BC2F8719E8D9688CDC696E29@DB6PR0302MB2822.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUUFwxvPDjb4xUqKNDOTIJeYB586uhdilvfWYpzDo6xH3jWWJS5mpBVOskQDPYymQrtcuq6jj85v9aRd3KWbe5wF5kJbbBgO17JDnjXl53R2+SsT1lks0d5zZuyb3OBhWK8ehnWRfOkhGK1BIsamNeKA0e+POcAE6qTMGMtYhHNSfzNv2hryqr1QeyqL1H9o+lx7pXdHebrUb3PYtzUETe59XG4JLe5YOzEzfVpVzw8mWOITzhzopq6tbm/9bEI88rrMv/kCqF5QjgOzTLkhpfvmLP0r0/q4fKDtVD47N44s8Z16XH6zgcivBbIBDEw5ve+PTDCA43JTtdYsLIy0Z40q3hdAsWEAjSvilSiahbR/IGUtZosEsxcTRGL00Em04aOUiOi6GveGZzL9IsPvXysfR/szd4KrUXw1/WYYYdaI3Ogi+4E6WRR9yJseEA0i477q9je+mteTTrX9Dcqc2w9goT5eebxyHmxFx5cMXG0ZpXVv3sqxF7VKUj51pmSdnl7D+DrakP+bWkaIqKsFY7shFmTPLzi3Rt7DUZrmddAsj0NA+rDJQ8/ezsMJg9nSY9vMbsKpp/xV6Nos2tMCdiQN3rCCaNR7vHRYcQSaHsY1thpPrJ12cuyFHJjTuJyzVSUbvR7BaqNLjgUDkk1mloEYzH/qM/RGBYFQJktEzR+QDo+3HW8gl2XHK811F5SjPurF6BS9k7D3L8uIWPk/b+8UZaAdFIaVw38DmfqlnJ1Um9phWvNGxfX7ICQ1aY2UIszhAcwxVKhGyNTQambQtlwpvb9RZQJLVOknmiU74DBlZG4aq/TYOeGHvVxVD0txev5sm2yHiRfvNEFLtJkARkfbCLcxayJaYntIyM7V1BU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39830400003)(136003)(38350700002)(38100700002)(86362001)(8936002)(31696002)(54906003)(316002)(4326008)(5660300002)(6486002)(31686004)(8676002)(110136005)(36756003)(7416002)(16576012)(478600001)(44832011)(6666004)(83380400001)(26005)(966005)(52116002)(53546011)(66946007)(66556008)(66476007)(2616005)(2906002)(186003)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?y2EtwO9JA9kuSr3/kqTcSN53ctil2CZampFOV9AI0hD/qfGNJ8Kom4tT?=
 =?Windows-1252?Q?sc4qY7bNANKT34Dx0IQm4mRROsX5pmhwXPjPY5ruzdVZV3qM0Z3/3VPc?=
 =?Windows-1252?Q?xuFEay4dX24d4fxgdtE80mtx0PiswEVhvtlSZN8YERvTNpYHFJa/zFXE?=
 =?Windows-1252?Q?A15OcS1ef83P1RsfkbouszlT9WF8hix/BG3hPhN7u/shnPBdFiYq7QHo?=
 =?Windows-1252?Q?sU2Oq6fFgg6oILVVLkTkwlUq/7+2IYDryLXZHM9WRe83z82fQiEaVHXx?=
 =?Windows-1252?Q?Aw/pEN5FcJ5iTU881O2XRcQl/Tb/vgDUj/22+p5VpLaRyob+oYg5TObQ?=
 =?Windows-1252?Q?1weLE57jHpvSK9x8ww7g82cCxSMR2riXiJ50Aa284Tu0xULNu0q2HRKs?=
 =?Windows-1252?Q?WpvqznWLvNtaIuUkZ5ss0KzhgKdYLlCuzl44JppANjjQxQNrqD8M7te3?=
 =?Windows-1252?Q?Glp2FpMoqC5tthvE7EV0axqMJ0St3peoQHoeOVtMqd9LOkyxgciixsTz?=
 =?Windows-1252?Q?+LLmZphNlMYNjbMvGOtsmgdG/XqDdvMOOl31NoCtsRSRJSr8sfXWtTkG?=
 =?Windows-1252?Q?wD9FvE72aNKtW1Byaq/QwkG6BiKto5PwqGyUAaNEF8hYSTpx4Ljz03wL?=
 =?Windows-1252?Q?JltZOg427jr/4OLHVJF2GUj0sCQO5zgKszTd0GR0hgti/THHkBK17Y6M?=
 =?Windows-1252?Q?CGMa7aiDZfySTkQqjMZdKjzUj0/TweD1MIb5p7XLkWW6tQbj6T6Xf9do?=
 =?Windows-1252?Q?YxguL/VkQAku92eqR/SBYxvvLeAPK4gPfZuwMEPKYFQWU2zppiKHVVxW?=
 =?Windows-1252?Q?2NSZxG8ApTIK/frMY3k9VSTheHhJ7tihTG+qQzYzBk7v+8JbdLmpiW5I?=
 =?Windows-1252?Q?u21BFWO3up1qmS+EyD9bP1I3knN35znB0kFSS438pcX2BH05dUKWJdmg?=
 =?Windows-1252?Q?O4PzV+WdpdHIH4EW3owZt8E4AN3R96Aeu0PtUVfB8AEzVRE2XMO2aKKj?=
 =?Windows-1252?Q?CR6UZtyGqSnIDvgE+vHXkgOIVzoZK1YAq0znqdW4+LZN+cjt4GdFUtwe?=
 =?Windows-1252?Q?bfci7cj03gg3qa+n5C6oCJqWfY/pacpmbuLF+TVvMuev4mpqVMn9mrhx?=
 =?Windows-1252?Q?ucD4aQkCL8KYQRaRZM5kLsN4V6+E7PFCc82C+oq0CPsmf//aFMGKI3n+?=
 =?Windows-1252?Q?vBo/QTqbBcg+iulg+ZSp/deMIZAlbPZR9lJxEnhS7r80IK33/YtUZMfy?=
 =?Windows-1252?Q?b//PK1WaPI1gE7Rot8z9AxBFOSrKh3Ku5c1+KlWJYvnDt8WJ+RfeEbPk?=
 =?Windows-1252?Q?aUqayircW6fZHCPvZJXiIAs91smr0s13JA37JGfeUCu0/VFbmzyvXkWq?=
 =?Windows-1252?Q?RbZa9rgzgY1NXX0gNX2OkciCnvHvb/TgpnenoBiHPDyDKK8CGJN3EgjP?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d013fb-7c52-4e17-a3e1-08d94bc79165
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 21:44:36.0277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5sHdAUAfXQlhD6AW7XR9yCk/bNgbE9bc0bi9N3maS96NKmPd2dGcq1BtRlPES5y3QrpXnO8uSjy5rtH6QxmfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2822
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 7/20/21 5:41 PM, kernel test robot wrote:
> Hi Sean,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on tip/timers/core]
> [also build test WARNING on pwm/for-next linus/master v5.14-rc2 next-20210720]
> [cannot apply to xlnx/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Sean-Anderson/dt-bindings-pwm-Add-Xilinx-AXI-Timer/20210720-144903
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 2d0a9eb23ccfdf11308bec6db0bc007585d919d2
> config: microblaze-randconfig-r003-20210720 (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/94fdaff6f9a931388dfbeecb76ea7b50eaa06711
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Sean-Anderson/dt-bindings-pwm-Add-Xilinx-AXI-Timer/20210720-144903
>          git checkout 94fdaff6f9a931388dfbeecb76ea7b50eaa06711
>          # save the attached .config to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> WARNING: modpost: vmlinux.o(.text.unlikely+0x530e8): Section mismatch in reference from the function xilinx_clocksource_init() to the function .init.text:sched_clock_register()
> The function xilinx_clocksource_init() references
> the function __init sched_clock_register().
> This is often because xilinx_clocksource_init lacks a __init
> annotation or the annotation of sched_clock_register is wrong.

Will fix in v6.

> 
> The below error/warnings are from parent commit:
> << WARNING: modpost: vmlinux.o(.text+0xc650): Section mismatch in reference from the function pcibios_allocate_bus_resources() to the function .init.text:reparent_resources()
> << WARNING: modpost: vmlinux.o(.text.unlikely+0x1698): Section mismatch in reference from the function mm_cmdline_setup() to the variable .meminit.data:memblock
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
