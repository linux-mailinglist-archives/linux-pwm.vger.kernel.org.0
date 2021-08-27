Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE0C3F9C6D
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Aug 2021 18:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhH0Qai (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 27 Aug 2021 12:30:38 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:16831
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231852AbhH0Qah (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 27 Aug 2021 12:30:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwhDRmiasd1WJfQYagA8U7qYUxFp6DlD+nImbp3JN9pEWFcCcxJz63MWwVDab68cht/6AQsxLQbaZ0VW24hDiGqHx5Cr+FfeGV4Vav5fSaWXcpi4ogCFfFIWMXNZwyueS0hCtAK6Z+vlxRVW4+yFmgVbybyxm/621jqGrxtK9XTwCulCIfbIm5EZ6B7pWIX2V7VCzFJUsXFVpYbD0GD6x3KmtEsb8VwnOfX4zgNRoUPYwmqmXerKDtDVCrdyQKMSZ1d2hKrQBF7tI01ZqXOlCnjUkFDN0kRXSZ8ie4EjtSKYR9TDahY6hNYRcvaHnVTJbhlmCqUuXJis9IfOBSeu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj4Fq7ObgvXjrsdkmEIz5ZJGmCzydmLNVog1Rb+MdMI=;
 b=Pd64V6YhnBB92ODDioV4o3kbr2ZDbhHuWScuS6/bPY3qR+hGJ7MLdZyF9hfRNjBSWPVQEoZuAPgBLcX3SBCBaowdLtoAZBjAC1funatnHfsG8k/wYNW+7sl0g54RzrMYuMB2Tlg99XiatLHaaRx+MC+Vn6oHV48Gm/sMLKrD24KMC+DOunoe48jrSn6U7v0kVcNKQmP2W7/MxAhopnVzFCCWkGrjPY+wpX2O6RMskpHTWu3VE4JVb7Wk7Vy8nYK3jDWelKqHkrazG2c6pu36W56FF7ywQ7ffxv9XVgKSR2ALeuqe9wg9cn+AH0zqzjUNHKmTcr0/cP0aeDBJnVdBWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj4Fq7ObgvXjrsdkmEIz5ZJGmCzydmLNVog1Rb+MdMI=;
 b=wicasUeI1k8fumokg8jESwUBHixTXQyQb5oUsvCK1gf1pM0vzmwZLrF18SNK9bx7CU8sxzjM38EtB3ZS5BflEXOVt6+47nc4Kvfqlyid5CogrAGXjaq9cHrVuwOuy4hfqn/i9mYTnS6TBN3+71qiB+C7NWJTNVErArL/5yCDA/c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4522.eurprd03.prod.outlook.com (2603:10a6:10:1a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 16:29:46 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4436.025; Fri, 27 Aug 2021
 16:29:45 +0000
Subject: Re: [PATCH v6 3/3] pwm: Add support for Xilinx AXI Timer
To:     kernel test robot <lkp@intel.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org
References: <20210826211830.3311140-3-sean.anderson@seco.com>
 <202108271550.btqnrtGU-lkp@intel.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <c57c4b16-dc8c-76c7-3ac4-63a5b62144d3@seco.com>
Date:   Fri, 27 Aug 2021 12:29:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <202108271550.btqnrtGU-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0004.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::17) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR15CA0004.namprd15.prod.outlook.com (2603:10b6:208:1b4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Fri, 27 Aug 2021 16:29:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bc87eb4-1d27-498d-1834-08d96977e163
X-MS-TrafficTypeDiagnostic: DB7PR03MB4522:
X-Microsoft-Antispam-PRVS: <DB7PR03MB45221ED7A7A61C19329ECEF196C89@DB7PR03MB4522.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYc4Hm+aOxWLfg1eiz5PyE2NNx27OVHqJXx5F31wMoW4xTrk77wbZ3dk+ffZqxwT+mwsl/NWm4qMN3fMXFJy5I1WZH03o1rAWXFQLmLLdyLJ+q6gyHd3zn59Pgc41yXNqPQQxH1svH3TXrY6cdABbni8m8t4fw7ASVhOtwNdRwZRieykROlYEwC3GfUB5v0CJwJ1PwNNxU5Ma6rRVlrLfUWp8+z4Kfntp7BuKydd5jHqOEXLuZHFmgc90zFvjOAcrOdjozuilEJnGxeXlBy7zwP1XX7n2sjP7IdLLRYQwonpHRkxHFsGOR2wxD8ARnHkzxB47ZXvOTAGP/APb5n2FRhKhgQlDp0bbV3Oz1FSSK+hBP6ApPBjyYM1f3IMrzNdXTUrIAD3kHU2NN9Z1I7mIprpC+RDBcc6P3NRrVQHDL7hORvAePeR/tNcQYiTNag3O0rUeJCEQXzLJB/DWmsQDoEMO6OoNFF0PFqzduLRvlB6BzyatZNBdCQ9wREHm/k6yw7DmWccWIMWZoS/W/JcPEYiKiEOcGWn0V6HiyaMNAqQt/TWN87Zi98mhJKNqP6feRBsTAWuNl63DSq8ybQRQ9omwk6n7WdSuz8is/IuDA0vojqvwWeErltpwdmPVrKEKUv4X3Aq66z8JqqxHH8G5BFk4pS1ec5JwNaI++PrFnFd8c5iuFeVlZCFWgOS5R/rhnl3hNDcgo+pmr5RvgFc/GmUOKWTqxmjabTSjN4G+n6XME2x0ZoG+0+bLbvgzXwes4tzhecO/xqoM1dkafQxOuJLg9FKYpQil4ruRq370NKAYLtahN8CWaBve4cUXajKw+f4khnM8Uz74qbUSLPzqGzMyaVn+7KoCcou6/qN3so=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(366004)(346002)(376002)(396003)(110136005)(2616005)(31696002)(31686004)(44832011)(4326008)(2906002)(26005)(16576012)(36756003)(6486002)(956004)(83380400001)(316002)(54906003)(6666004)(53546011)(38100700002)(52116002)(38350700002)(66556008)(478600001)(5660300002)(66476007)(8936002)(966005)(66946007)(186003)(86362001)(7416002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?XsyWJKfZeNIEw5seMR2IfhPZl7i1FItEC+5lJv2Fvfvuq42f4sKumH9d?=
 =?Windows-1252?Q?9R4VXe4+E39M/AapL01CtMGMMTpqfNdLkelfMX2DaTMglhQrERTs0gMQ?=
 =?Windows-1252?Q?Nc8cHE3mg6bIPRTbZw+3EU2wyB2dByO9OhGw8TrFFenKfYIKBKcaInlo?=
 =?Windows-1252?Q?Dwri50eBiLmeQVMXoFZlkFdEgzhjFbM/epBOg/WdMNUjY9F8O+wJqgXV?=
 =?Windows-1252?Q?IXU6QqknpDHC74Oo1HnG0zh2bPYVETWiM8ZFnVG3xjvuyb8mpPTKHvff?=
 =?Windows-1252?Q?dWMb8+uuyGAYUMFoMlut8ZHYiNP3NCpKoHsz1pIcN8RQznPJniQRRBTa?=
 =?Windows-1252?Q?fn9aRwW87sL4RsJ/e9W8HB+px5qccbTVDA+owGybme73TsWJweniwhoo?=
 =?Windows-1252?Q?Y4lRaBGYLsPT7FYlflId7jmygXGW5O6qaDmnzQmoeu9DIG1Q1hj4xEK9?=
 =?Windows-1252?Q?E17HUXu/vWmeKGU8HXdobmNMwQJwIlGBNY7+bfob+ijloA8ydLijs5MX?=
 =?Windows-1252?Q?2SYT8pZ7WF6raCbedJ+h3xYUXMJA7FI3zi/3PX3vpjOnCi+6kG90P5wB?=
 =?Windows-1252?Q?P3HFi+0Beuo9zKL0O7MJqm94JLMQCuFWAU/SZXW1fDGgtlIc5jQhJcut?=
 =?Windows-1252?Q?l2EVP5lfjfhyhMM3fdpk9KorAQ6HPtJZh6zqsQP4QCsZbQVzM8HDDo4o?=
 =?Windows-1252?Q?87mHTBQne1OlZAP6ZFqwpjbMgyNNHTbWC3vT2ASFAiUO8334gcEmaeAB?=
 =?Windows-1252?Q?MXBFXW0b0yWc5tNUbN1QwAeaV9CS3c2fIwdJ5A/8NEWNe+yNSMN9dvZz?=
 =?Windows-1252?Q?EGdgRBHeYrYFqObbRdDjs8oJ64Wv4lGc4M4IxY3hpQUCF8qORRU/2mh1?=
 =?Windows-1252?Q?yfvrOcTI58QUFRiEtxuRBEwVLCPuvgiUEYnyyr9+Vfd0hrB8q+3OOur4?=
 =?Windows-1252?Q?/zB/dCJ2+VrN6U6IQbogI98uQ9TMLAk2LN1jye4EY53+OjhRT+U1492Z?=
 =?Windows-1252?Q?ZQTwIUY0WKXoTNsdEOLBfzyMQDznrz6w+gu9uD8F86CkHR59UNj5+7+s?=
 =?Windows-1252?Q?demZgRwtYXZSrwKUJ4h+VKHrE5YNfIB36ApMr7BVwnpH1Na4EHlhgfJV?=
 =?Windows-1252?Q?9Fe3MyYS7uNGGGvQXDZbVs6SjZIjnqCKkRqBRCNHnbG9e3Zf+G1WnlZW?=
 =?Windows-1252?Q?IapQTLrKKpw/OuTAnst0d35PiY5epS45M41KkNn32BsxZLocAyAeRPD+?=
 =?Windows-1252?Q?QLLKiJkz2Tvas9jAxSUgQ0L4PYn0QIZ/qZWu7wO8hJWy826E1eQXcyj7?=
 =?Windows-1252?Q?OytvMj8vN9gOEW87TBHrWrnA4GDp+mDDUF65HE3UaWWmrQtRTsrBRqDR?=
 =?Windows-1252?Q?nxBxt7d1jOyLZB4dOiQHoNR8setIQ3WZtdRbXNgWxJaNvq3F4SDhWS2I?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc87eb4-1d27-498d-1834-08d96977e163
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 16:29:45.6006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e03iNKWVQ21SsVH56TecNEDuIUHVugnxoL72D8uKq4mdCvMo64yWXKrc70dwTt9cSLlRCnsnYmFkasIHbYRzDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4522
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 8/27/21 3:16 AM, kernel test robot wrote:
> Hi Sean,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on tip/timers/core]
> [also build test WARNING on pwm/for-next linus/master v5.14-rc7 next-20210826]
> [cannot apply to xlnx/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Sean-Anderson/dt-bindings-pwm-Add-Xilinx-AXI-Timer/20210827-052011
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 127c92feb74a6721f62587f1b89128808f049cf1
> config: mips-randconfig-r025-20210827 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 1076082a0d97bd5c16a25ee7cf3dbb6ee4b5a9fe)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install mips cross compiling tool for clang build
>          # apt-get install binutils-mips-linux-gnu
>          # https://github.com/0day-ci/linux/commit/eab56f0b0c5a62e40c04916eb1b4f21f478cec3a
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Sean-Anderson/dt-bindings-pwm-Add-Xilinx-AXI-Timer/20210827-052011
>          git checkout eab56f0b0c5a62e40c04916eb1b4f21f478cec3a
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=mips
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/pwm/pwm-xilinx.c:249:34: warning: unused variable 'xilinx_timer_of_match' [-Wunused-const-variable]
>     static const struct of_device_id xilinx_timer_of_match[] = {
>                                      ^
>     1 warning generated.
> 
> 
> vim +/xilinx_timer_of_match +249 drivers/pwm/pwm-xilinx.c
> 
>     248	
>   > 249	static const struct of_device_id xilinx_timer_of_match[] = {
>     250		{ .compatible = "xlnx,xps-timer-1.00.a", },
>     251		{},
>     252	};
>     253	MODULE_DEVICE_TABLE(of, xilinx_timer_of_match);
>     254	

For this and the error on the previous patch it looks like I am missing a dependency on OF_ADDR. Will add.

--Sean
