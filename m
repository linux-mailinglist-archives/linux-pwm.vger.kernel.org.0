Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F2C3D2CA3
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jul 2021 21:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhGVShi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Jul 2021 14:37:38 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:21057
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229745AbhGVShi (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 22 Jul 2021 14:37:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fd+RM6FzCzkN7nK9kZvTK9pah9xjw9joIZCMTyHtPeA7Gp0kaU0lFq18vRZhSnrpxsf5MzchgO4Ve1v2LUMU45mglgxOALMBrppdscLsIlsak51y22oZfAXFC3BBrlVM09bu3uaiXxygV6Tu8obkSMvZLjDyZDLjC5gUSz0LW7yaVPD1CO3v1GTqo23YoE0zm6mNqtFKc3kZwNPRfNEdkAKjcVGYv/YwfY3CCupRShmMgM4C/6LPAcpr+upgEvGm6kv4fCcNuX0k7/eo3GJC3GpdyhPZM0GTsCbVWry88YADwnU5O8zcRl7f8ItLbmFK3SUWZGf2HZ76VvWUC5jZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vS2C+UgRD8Y17E7vvrqk4Zf/Fw0eGzXlr32xmLf+Dd4=;
 b=amujAFned5Gz6vQxWBQWxBoDJr8445CaJyq2fmLdOaGCHl2a/nsxVB8ODcNOONG3JYX/9YkqTDAI+kS/vXjKG9MQmgdE3k+EcZqvCvdn10d7nHdkGSRNT8EmHuqc1BZ9eJ14pcFBHZwN7JImkGDL050wu8FpUstXMXYTccKUGLHDcu+ZFCW7eOUJudYXGXbzlg9h4jUxZROuFe/JVrG3mtx4f20quu1NEAylxNkBGRfevPOTROMUK27Uzvi8Qo4YJ1mt9+oCQpJXWaHgUZ1EayJPuEUqo/1mCCcXs37CX+owKmFSUIGphtb1JcUJ/aJNhTxEznGXtWIFkxwdDjQXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vS2C+UgRD8Y17E7vvrqk4Zf/Fw0eGzXlr32xmLf+Dd4=;
 b=Impxjjo3Swwo1SKIVkhQ8PSf4FJAnWmEvThQDmgzdL6mvN0uZlcG8TNO2Vf/wyxK3TTmwJMQQACBkMi37Xqo97iNiCeIzpPbVEYQ1w+vQVnl2u/lbGQoUL70Pe3WrXHI3kn6oJVY7OQJ57yFPIrs4z2qHGErxgYsPmUIBiu9mBo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB5129.eurprd03.prod.outlook.com (2603:10a6:10:33::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Thu, 22 Jul
 2021 19:18:11 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 19:18:10 +0000
Subject: Re: [PATCH v5 3/3] pwm: Add support for Xilinx AXI Timer
To:     kernel test robot <lkp@intel.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     kbuild-all@lists.01.org, Alvaro Gamez <alvaro.gamez@hazent.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        michal.simek@xilinx.com, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210719221322.3723009-3-sean.anderson@seco.com>
 <202107212140.EAh7aLyD-lkp@intel.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <c895c09c-d1af-52bd-dff0-66dbc3d69a97@seco.com>
Date:   Thu, 22 Jul 2021 15:18:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <202107212140.EAh7aLyD-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:208:fc::47) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR02CA0034.namprd02.prod.outlook.com (2603:10b6:208:fc::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Thu, 22 Jul 2021 19:18:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23591ff5-2644-4265-d3cf-08d94d4571d5
X-MS-TrafficTypeDiagnostic: DB7PR03MB5129:
X-Microsoft-Antispam-PRVS: <DB7PR03MB512977886C7EB7234A8BEAF096E49@DB7PR03MB5129.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SGq0+CYP00HgBFM6R2N4VKXdJSbG3ml1J/ghP4WGUOoZq40GWSFcXl/bn1TlEyGX84EvicXqVU31URR2l9c16tzm1qlgpwl11gVYWCz6qeaD/2Y7qGzDQy6o06gawc76wTlLrpn7pK5MB9eYRA1CDmOJZVWpXSkK0tIyqK2ENe4hmjBAu137cFFKBye7dWc9419jzIUE5N7D5K1pG5pd2NgXqeLtQJmqtif2DtrqUmwve9Mfk0go8wGPI4Fj8E5Jz/WN6IY6nOHlUEuIhc4mwBRBe9N0EYIK1do7NaCBauiDMZkMjvKmkUmLf6xKVjP/zgSCNnjyt+CgbFyaW5O/9z63j/3PacKyIx9pA7bgjPLY8i5yPU1C4J90JHpyAdb3fKbBscYrZhXEIDCFTCea9lUCSBjqWoPeufCeKBY/yxpAPNgFPkeJhlw1Mck3EtL595QQaPbMQbu1Fai2Yjnjiq6tqFiVSs5y13iX96Q8HSWFT5rwCvPqVjawPtPRxLZqcb10tdPZz0WZ0UqZnDMDgcmqzrsQlWQhHKsJ1CXxl6kYCXmka/AJEfVieBRdqFDVRlj2mRLH7SwmWjbgv5RASboZZsiTgsmsDD4HoeGTXvbe3BBb8qLhCUUfQ38s6+/UoJSbN0WE1ox0WrL8VYvy+FeLLf8ZQlJM0n3yFSw0ZY3bRvMPxQW8af0VLFDq6W583goSD+Zmo4QdtPNe/UeGG5NqN7wlEmgtojWfVaPReGDiSIwe+yKQBOAdy6tBPiMmxkQ/G/jChuJfWg+Q86eNX7Ta3li5wu8sTDVnCtmDDo2xJP6zHdSiaJRd6ayDIXia6jkS+VGDnjyimn5xw3pu5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(346002)(366004)(376002)(136003)(38100700002)(86362001)(38350700002)(31686004)(478600001)(36756003)(26005)(31696002)(186003)(44832011)(2616005)(956004)(54906003)(8936002)(5660300002)(110136005)(2906002)(52116002)(966005)(7416002)(53546011)(16576012)(316002)(6486002)(4326008)(66476007)(8676002)(66556008)(66946007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?oB4yeUB2WnQ6mGOo/v9QZj2CyFX9EvI3PjBJFr2xKof4dbBd0yWFS5LT?=
 =?Windows-1252?Q?EcKgAht2VSuzHXoZQePvn8AqB1k3Wu4w8dUFGQG7MCtIYCLpH+y7B3r+?=
 =?Windows-1252?Q?+k45VPlqaY9bafwKNCIDlBjiHzuGqFo/DzwQtWdasFhyAmdHyCsfm14D?=
 =?Windows-1252?Q?VujvG4EstNw9zjdLVuRi9ch9EEGG2yIsH0uHhXu5kh6SbjPpGKHhgM9o?=
 =?Windows-1252?Q?mOcUCnbKkHgB4aR/9wZNaFPivO4DPBY+OvSkc/hfVfwBjxZZQdXgpbsR?=
 =?Windows-1252?Q?wgMYmOEOlD4l9aqo/asptBGR3Us9Dld8uWQFe8NCLS+iCBYBGmF87vKV?=
 =?Windows-1252?Q?05DLHCOhxMYTzk9+OcIlAo/s9uNdZL0BZOrwnXaViLSH7cKwkv7QEJNQ?=
 =?Windows-1252?Q?dCJrVk7vrN3ikxz1R3kFF9y1PLEbVWhxJC+6Em53ROIYFJzP/j2og/a7?=
 =?Windows-1252?Q?7JqsxLgeEep0f7RFnQ+EcaKZAoqBivOkO7UpKoxxOuM8YseQ2vQ9bfz7?=
 =?Windows-1252?Q?XUp+FSUJlaqIaE/5E4ox0Jzt0MUJkYRZXcSYaNtPDyKyuFrVxbsQdACO?=
 =?Windows-1252?Q?nfphOLS+XSd9cOYpZj+Le1KzLQca4Hzb4JRds/Bym/SdgVgQYvNuaSE3?=
 =?Windows-1252?Q?G/BFom/Ak8mpwIJbzFEMgnpOP7t7CQwiiGmGWjPHDwovb6660PEOkK5p?=
 =?Windows-1252?Q?e1fPLalX/ZbOP9X5YSHPvDtySMA6+It3VmNcCf4+BBOvqfou87bD9+b1?=
 =?Windows-1252?Q?Zi928GFqC418hetQAtMlivNjIFlLS3bk498g2IWDuZcg2zOKC+nQHU66?=
 =?Windows-1252?Q?qcAIc/2ayZDXW4LPW6WTUfXDvErv84DV4LBx7BWhniRbM15PD3EKEyQu?=
 =?Windows-1252?Q?C8hYf/wG/BkGDQrfHl5ClsPpXHNlqGSsU2xVZwyevzW6Te9iqGI/4FR5?=
 =?Windows-1252?Q?l/q0C0q3SQVW0O5KHNmWrrYUV9gvHGUuhlafmGcPxsMyylbUFABA9Vtk?=
 =?Windows-1252?Q?Njf4fPuuaXROMsglrlXWCiwL3huHGzRqGuq1vMIAEbtMiYp2eE/Guasl?=
 =?Windows-1252?Q?mAawhVulbdnx0Ao7C4V9EgmO62S4j1v6jnIrjKHsUJGa3ZGuCV4fYE9t?=
 =?Windows-1252?Q?ErEoUR0pEqNQne1CCVNno0+cK9G5N688fW2jMnF86jHYXUM0UbKx8sAv?=
 =?Windows-1252?Q?f8sJsF5dDMql2FwqBgdr9ZPmTEdL3DUTng1qHk6Sd/9DSNkv+dRLtBKh?=
 =?Windows-1252?Q?aXy2D06sb3wPL9xWm+Up5qSBnitRTdwF8yeYp9mY/Vdsm0xk2ecLkl8d?=
 =?Windows-1252?Q?fljtLADz3m0j08te0a8vb4Zt7LzZva6/vSYrBxRNwHdSSKW7OR4tsDQF?=
 =?Windows-1252?Q?M1g6tNcHyyBTQgWT1c/Oyi3H+MOpY2XbHo3Cpisn+5UN+BwNE04H4g2N?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23591ff5-2644-4265-d3cf-08d94d4571d5
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 19:18:10.8486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0faWQfWQ0EUCluHX25ok/WlL0oFoNZ7Fb+RkECu8zrKnT7Vjobee/Hjq9969LlUOdtxbLkv/uvFnOABftsTENQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB5129
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 7/21/21 9:26 AM, kernel test robot wrote:
> Hi Sean,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on tip/timers/core]
> [also build test ERROR on pwm/for-next linus/master v5.14-rc2 next-20210720]
> [cannot apply to xlnx/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Sean-Anderson/dt-bindings-pwm-Add-Xilinx-AXI-Timer/20210720-144903
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 2d0a9eb23ccfdf11308bec6db0bc007585d919d2
> config: m68k-allmodconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 10.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/338d061c42411ef012c4dce517355fd1d61c1cab
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Sean-Anderson/dt-bindings-pwm-Add-Xilinx-AXI-Timer/20210720-144903
>          git checkout 338d061c42411ef012c4dce517355fd1d61c1cab
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=m68k
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "xilinx_timer_tlr_cycles" [drivers/pwm/pwm-xilinx.ko] undefined!
>>> ERROR: modpost: "xilinx_timer_common_init" [drivers/pwm/pwm-xilinx.ko] undefined!
>>> ERROR: modpost: "xilinx_timer_get_period" [drivers/pwm/pwm-xilinx.ko] undefined!

Looks like I forgot my EXPORT_SYMBOLs. Will be fixed in v6.

--Sean

> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
