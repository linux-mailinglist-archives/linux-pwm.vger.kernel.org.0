Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B5460FC29
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Oct 2022 17:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbiJ0PkQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Oct 2022 11:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiJ0PkP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Oct 2022 11:40:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5E77822B;
        Thu, 27 Oct 2022 08:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exmI2uWutjEEW5jHKHQ+zklHQAf3C09trSi50AEJtxts/FwzByUmRGmHMKA+sIeeB+ynxA4q6GLTepvsxdTGwciQwF3Zt/YvCeBtuv3F38iSGKdyq6JWpsdNDHwTJZ3CZ0PARxvxqyErTfc9Otm+hhVkLiPngSX8QRR9/yyK1X2mZnf91anuUUPp5CTjlr4OQH0GJigN5qHjQ37Zr7p57MxWZcnUoQwqtKyTgDvh/0SQ2Vf2dIZ8R76P6N8GGK7nLukY4NHNpMFUMOtRc3DbU0WG0TuJAUnj/8E6vhVS1APyoX4CEwW02dM/MXQOvdjCw4JETnl4hd5LK2wCDIJbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zA59AafPWd7k57S+gg/8tAyMZ8DY6Q/HS4szcPXWNTM=;
 b=OT6bQMHn7keJihaglVENnmsQT8q30tyO59H/IxZEtG1kypkyCDPSZS4RKxeHBdWUXlOmBHRbV8Ef68XDP0Saol6z8SGSP1G4okJA8RtaVDt8FMfz6sXrVbsXA9PodR1mo0pNbdTZcyDO8VOQ3fMe9A6UPL55kgqymLtt8MYyhihCbsipd8ePbwijWfaS1mfe+BOaIqUZ8koHyXXNcV/Wi4SjU/xb3K3Dd2/9mCrdcCxzPYgyqijGAH2r50QVpVw6qKpViQ93qEaqGwxCI10RcreCFJGiELoeM6I3GaAroJQBHwQ0hPj1eyktzeujrj7DcGVDFHGfpu+jJEk8aDIiEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zA59AafPWd7k57S+gg/8tAyMZ8DY6Q/HS4szcPXWNTM=;
 b=bweEC0p9ZZrgNaeODL/GwrWEvmG3LEx4qGBN0oEyrDbGpzMcqGkrSb8uFj0gfH62WhaMXNCi8ejkm5G9ODgeVsFjmI277y0yUZsAFLL0dKdGhu0vUQhaH8wrgLQbcJGzbnn9I9ALOrMB3/fOcI+1iOsPB0KlRGb+g8932lwE47l11Ftm0bNz3JsAWC+UcL6XwhC/7u3S8QxR44J6mHamimCd/YyVPqcxojuSF9jl2KLfwwXM683TJmABqYPPOEYm2Vd3w/v6y3xZWzhv8PUlXgfwUvQWjEfSuEcmQb+4kX+XxEhaf69mo+1E5Yzj46taV17w4zhizsrTWOw0p4A4Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 15:40:11 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 15:40:11 +0000
Message-ID: <04d2c7ea-cfb1-b8a3-c1ad-39449a6a1701@nvidia.com>
Date:   Thu, 27 Oct 2022 16:40:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] pwm: tegra: Fix required rate when clock is lower
 than needed
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221026101305.30670-1-jonathanh@nvidia.com>
 <20221026101305.30670-2-jonathanh@nvidia.com>
 <20221026142301.3cgwqozpafpuu34k@pengutronix.de>
 <5bb9e817-9e4d-dd02-9c04-443efcf58226@nvidia.com>
 <20221027064003.22hx7iftdpg7s5hi@pengutronix.de>
 <89260f9f-a54b-108c-6144-5bcb06d5dc83@nvidia.com>
In-Reply-To: <89260f9f-a54b-108c-6144-5bcb06d5dc83@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0038.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::26)
 To CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8e9036-7e7b-428e-9e7c-08dab8318864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p19VEQH46sr7epv0bMqrdbh1ZdJDbV0eQp9h5/Fj8wBx21azXMQ9RjH5cvNc6x2xtzXPO5IiLVYWQCcd9dWnAGiUTTS4ckW2fKONvkG6IPI2YMRVaxesCxqNcolSJvnCfBV1LWeTL+g/9xNAUqtnWAdijMiEVP4HkzPu2jG1/bb8KN7Ov3RJxQJuJt+rCoggCiHoVrQVQhOSjPngS8QfDs1PLBn5pD5mpF8WrtW1E+5KCUFzaQcQ+MeUwDONk9FPaD9fAOpx7+ZSqq6YYoaiGD1nodFfNr8NVLCKwojB7o4DmLYS3mFv4VGPncZdy6kRLXag20SqST5LRxtuviyVXtH6aONSWLLUyUsIzDc/wQCt/Nt6PZt7mG/EOVU4PK8hmp7lqpsJ08yZnjfVndxxuwAPYBA+uY0DCl1+Zp8ouRoZe0QkEEjPR9t4uiYOPoSFjIiZJAKHdwXrHcq0iM13kuQYvzTZ0ghoArDwMqcOzynKY908cW4gOw4xFLzDls3zD7u6X1TJDAQW/oKbT+tIcGQU1b0GbVoonq25SGdCQ93kig1K5gZDq0hwKfI4mBZhDFqVNwM23mk5tsWpVWu0vp6bkUYS77ER2LyXCNthh9LErkcckGzlYxx6IPD2i4KokLT6pZn75/PRNsmNn4GSUKsn0H7+fl8tXV9zDaM/zrd84BAWQO/4yv8CEZI1G51j/FOPpfXmRA6N1DEn4wtSTLKs2kEagvbDFaT8hhH+8xV0QiKc/KLBrJ1V34cdmJdgXSSv+q6w/edCzAjPnMmAyiYzZo9G7wDoaK1um/ZwyY/lI9FwoCUP1U9G8+I58czTWGibgoL/8MxUfTTvf5eCIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199015)(8676002)(66556008)(478600001)(2616005)(41300700001)(186003)(66476007)(66946007)(4326008)(2906002)(38100700002)(83380400001)(316002)(31696002)(86362001)(6486002)(55236004)(6916009)(6512007)(31686004)(53546011)(6506007)(8936002)(6666004)(26005)(36756003)(5660300002)(20673002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXAxeWhyQXdOZ1JoMitJcGthOWpyY0tCb3haWEswRkRvTjZ2ZVNHMUIzc2sz?=
 =?utf-8?B?M1lSRnFON3F0S2NqaFVoak44UGMzYU5SZ1VKSE1HNnV3QXdab3lqVGJIbUxG?=
 =?utf-8?B?MjZSZ0xZM1BvNEVacGxlaUNWQk1LdnRoZ2lsWEdlTnNSYzU1U2FoMjFOWHRl?=
 =?utf-8?B?OHZ1ZFprSFROQmhIWE91dWJ0WWxDZUJMQW4ra0NOdW1JOW01eEFhSE5iaEdk?=
 =?utf-8?B?WEszcGdpbjg5dlVIWUJ6WFpSai9PeEViMnd4Rzk5dHVtdFovMVErNitUUmFa?=
 =?utf-8?B?UUpoanNBd0hrc0t4ZUowcmVTODBnVElSNHZjbTNlZkhrYmJXdEQ2SGxTd1BV?=
 =?utf-8?B?amx4RmVJOHh1UWQvWDMyVi9TdnRZQ2ZBdnRGbjRLME9IMkZJMU9zYnE5czhQ?=
 =?utf-8?B?UjR3cngyeW9wTjdZN25Bd1IxMkp3ZWNJaXdoMU5aQy9ucXZRMERSTm0weDBx?=
 =?utf-8?B?K0E5dzBBcTdDaW1kNGc3ektxajkrQ3pXSnBqWndlUGdMaWM2Y3RnL0lPYXRs?=
 =?utf-8?B?bk1QczNnTFV2RUxMNWZQSmMyZ1hiMUp4aklGUUNFVSt3RERoUlBtelJsdXEx?=
 =?utf-8?B?NzBRcHkzdzhRWlB1SUl2QlpaZGZxK21XRURKMCtxV2ZZUWRoaUpTZGRJdFVs?=
 =?utf-8?B?SHVLbXJwVkFEQXFGTjhwYjNqWWpjTXZSdjRiVVdjSy9neGZFeVR1UDZvdlg5?=
 =?utf-8?B?NDh4NnhZZTFUVGNIbU9PR3d1SW1lbE8renB1WmJWTjVoZGdSNjBDSEF1aERQ?=
 =?utf-8?B?S0FuVTlDQkxodjhRMUJYODNtaUd0UFZ2VGNqYmhRaFVsMUJ6ODVyZXYrc3B1?=
 =?utf-8?B?VU9IQmpZOGZWSXBaT2t4UjVDRFBYV1I1UVJSem1KTlRqaFNsb0ZOQWJZUUlM?=
 =?utf-8?B?dEZYb1hJZS96em9xOXNxOGRqc1E1djBiZllTN2FZYisrMjdISjYxay9PRmtx?=
 =?utf-8?B?WVJMNkdTNFVNZFpCb2RYbktWdmhzRndWSWloam1aM2x2TUVQRXQweklUT2V5?=
 =?utf-8?B?RXpkMVVRTjl3cnllRW81VlpaSGN3RjNoTXhTdW55c1hxZHY3UW55ZUlGaENH?=
 =?utf-8?B?OGV6dWFPOHM5UFd0ZW0wMnJKdlNERWpOcERiRkwvWHVacVZNM290OXo0OE92?=
 =?utf-8?B?UGZNeXV4VHBHT1JkbkJ1ZTNDTlQwc0lCc2lxYnZBZDhVREh4blVFUEVsZy9G?=
 =?utf-8?B?VmlwZU0raE41a3hSUGpLdjhOby9lRXNIOVVsZU0xQTFOLzgzd1dRdkZvZW1D?=
 =?utf-8?B?ckJnaytHYm9NdDc4bUh6elc0aHhvUVRCT0Z0aWV1aksrU3l4eFZjaVIvcERW?=
 =?utf-8?B?OXd5KzQxU1hSamwyQWhZN0paM2FJUWZhSFg2NHRLQjEvMk10N01wODUxbFJs?=
 =?utf-8?B?N0ZOOTB3N1hCd1hiWWgydkJFQkJ0VXF3Ymc4ZUpHQVJ2MEhwQ2VmQjgraXBQ?=
 =?utf-8?B?WHNPL0VxQVdqYmRNR2R1bGptclk2ZmoyYUtBbE5JTEYxc3BhYktmZmEwdFMr?=
 =?utf-8?B?TUk1VFlHU1hNb3pRRWdYZmJreEVzcTl2SFBWMXdBajV0QTlHMlk5RWt4VjAv?=
 =?utf-8?B?VC95WUZMRFhlaE9JMWdnQ1dhNFBCQjlQMHYxaXdEY1hZNDAyaHhxbUFGSU1I?=
 =?utf-8?B?c1l3MkFSWlJnQlpRWE1qK1VVTTBscXNldWcwQ0kvU0ZyNG4vY3hEa0d2eWtX?=
 =?utf-8?B?Mll3bmJ0bVMwMGpVYW5qb3BVYmFUVFQ4TUMydysxTElRNHJ4TjFPdXhjaER3?=
 =?utf-8?B?NmdWN2FXU1NhT1o3T2xMMGROVkUyMm1na2xJaHNJZ3IxSFBoL3cyalNyMENu?=
 =?utf-8?B?MDFjTXVUeFVDczZpMHI0K0gxOVFMUW1lNVZVSlN1M3M1aHpZZ2tXcGhTdkRz?=
 =?utf-8?B?NWZYU3FCQjNOVEs2dUFyTVcraElxZFVZb25sMkFuTERmMm1wWmlkR1lXQjN1?=
 =?utf-8?B?VFN1L1czUitGU3d5cVRpVU1HbmNmU2RYb0c1TURGWWRLQ2pTeTVhOFJ5Mms0?=
 =?utf-8?B?OXZFT0ZKWmRCN3JtNGRoL2VXcUhmUTJLOGp5bGVrZThkdTJqNVFVVlcvZjhi?=
 =?utf-8?B?bmJtVUZlcUlUcktQbFBXZS9OOHhMdTMwd2NEclEwZFNWdDcyazgvQlBxeU0v?=
 =?utf-8?B?ZytjQXNrb2FGdFJDdnpzV0hsYnUxL1RTc3FCUWdnMXMyajY0VU5tVEpwbjB4?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8e9036-7e7b-428e-9e7c-08dab8318864
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 15:40:10.8955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sh6sD/Rv9V5SUBpRuxoDCRKpoBf3B3l+uAC3eS2Qhx2nznovQxJ69Y3lC/BWquX3YYgT3ioFMdojDj9CcDveMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On 27/10/2022 15:17, Jon Hunter wrote:

...

> However, I see that I have been focused on the current issue in
> front of me and this works. The alternative that I see would be to
> stick with the maximum rate permitted ...
> 
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 8a33c500f93b..2099ecca4237 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -148,12 +148,14 @@ static int tegra_pwm_config(struct pwm_chip *chip, 
> struct pwm_device *pwm,
>                  required_clk_rate = DIV_ROUND_UP_ULL((NSEC_PER_SEC << 
> PWM_DUTY_WIDTH),
>                                                       period_ns);
> 
> -               err = dev_pm_opp_set_rate(pc->dev, required_clk_rate);
> -               if (err < 0)
> -                       return -EINVAL;
> -
> -               /* Store the new rate for further references */
> -               pc->clk_rate = clk_get_rate(pc->clk);
> +               if (required_clk_rate <= clk_round_rate(pc->clk, 
> required_clk_rate)) {
> +                       err = dev_pm_opp_set_rate(pc->dev, 
> required_clk_rate);
> +                       if (err < 0)
> +                               return -EINVAL;
> +
> +                       /* Store the new rate for further references */
> +                       pc->clk_rate = clk_get_rate(pc->clk);
> +               }
>          }


Thinking about it some more, it is probably simpler and better to ...

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 8a33c500f93b..16855f7686db 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -148,6 +148,17 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
                 required_clk_rate = DIV_ROUND_UP_ULL((NSEC_PER_SEC << PWM_DUTY_WIDTH),
                                                      period_ns);
  
+               /*
+                * If the 'required_clk_rate' is greater than the clock rate
+                * that can be provided then we will fail to configure the PWM,
+                * because the 'rate' calculation below will return 0 and which
+                * will cause this function to return -EINVAL. To avoid this, if
+                * the 'required_clk_rate' is greater than the rate returned by
+                * clk_round_rate(), set the PWM clock to the max frequency.
+                */
+               if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
+                       required_clk_rate = ULONG_MAX;
+
                 err = dev_pm_opp_set_rate(pc->dev, required_clk_rate);
                 if (err < 0)
                         return -EINVAL;

Setting the 'required_clk_rate' to ULONG_MAX will cause the PWM to run
at the max clock. For Tegra234, this is 408MHz (assuming the PLLP is the
parent).

Jon

-- 
nvpublic
