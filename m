Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC7E60CEDD
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Oct 2022 16:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJYOWs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Oct 2022 10:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiJYOWe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Oct 2022 10:22:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD6361705;
        Tue, 25 Oct 2022 07:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMQnxBE0jcGq3w5jz2yUv6O/JZ2UjvN3970JcpFO6JtagzrsgnAjEd7EhumzX5JNEU4UiSsuKCH71z+vUOtV9bGvE7D0ybRwoXMCuK2heAtarVFU7MdSPEre6GysGYQaRBLhM02fnHBvYpalHnYxhudVY39zTjUGXxXVkEAlkUWk4bwxzrAYO2UnlwYMPh4RaY3G3vBOtetLdGIVJNsQx0o+3eczSZUp+UlpnfOMTiZcf5HCcOkOMSBROmRmyIc1+V/41g3sijHz+sQ7dw8+8pRMTHrsKHWcWm31KBJD+r03GqDyeHl1Pe1I4C/COB8tLPdRO6wAzfP2MXJtDtbwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTojzMrxPK7Y6rm2GwdITST4uSHWJsKckLRMo6teBAo=;
 b=C55Ncw0h+1E4czRmbKo7kupOp6XdfSLnSdTcz+6I9R96Su92VtJMzaSU9KDuFm+M3xmT0bY4bTEtQr5c1iQUCaqHeO/ujzkt6UUfFJC6tfqlbTyQFVv0mi3yZoQtPHl0+6Wx7epolk1yw9gS8/B6qlCCkXN3LSyO/CrHqKrobt6Em+jwBjUUelRqjXzvbk+mbRIQWWZTMckCblBBnBW9XfN/HRP37DWeKy2xB16P459peXNKDlKE29nhjgx5zRYMw8iSh2IV7+aiDrmen6cLL8blgJ5sFQjbWmEm7RElx2YnQGoMwWiq8jNld6LLQxNRe/leZls2WJCK5IQBjJgCPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTojzMrxPK7Y6rm2GwdITST4uSHWJsKckLRMo6teBAo=;
 b=Hh1osvMjrC8LbbbFgc+1Iv3sjGgRJS1wLCa/Df8PBd+v81fi2GqRW+lpKjkdNHTF6LqF8vYVLiEJdWfp5KDXnYWxSHpRR+6TZup2dY64xB8U8SE4Axs6nq9EpQzR8D5eH1vBD+9Ja3XvvnT6BSlTQQcjDcytLjdEBPZTN7e6J51g0ZXmpwDgFNhm5XwCOePhvPXQPZ3CdW9zAunT8LCqAI8R4LElUggu5yg93uDwDOtp6WjdS6QuV9/8X1fe5mNpN6kmDQdFVCIOtxGvnw1Ayi3rc/VsPiQ8NBMxuI9ReNKKZKsPXuMS3RUOf00JVOw3m3yzd5YxjhSFPLw72Ik/jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.21; Tue, 25 Oct 2022 14:22:24 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%6]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 14:22:24 +0000
Message-ID: <a0b92a81-71f7-ea14-e887-4486a398b709@nvidia.com>
Date:   Tue, 25 Oct 2022 15:22:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] pwm: tegra: Optimize period calculation
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-tegra@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
References: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::24) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: e0401cf5-b1cd-4ad2-b497-08dab69455f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5SzaiD6uFAcHlNFV/fVpv5DFtBsl0bFoYvncpGjm7pLVFZ/Cj350st+UHzeWajCEWRdtMzcAvx3IYq73lViPZAfH91sOpE3Z7T2OBK3ExBZiAHC1ual+oyXbQK2GfNjAnaYH20YSvkneTOueCAxT4a+Nxmu5VAJFi+LDfkn+LN+yqzSnfDKxwpLzlWf/9CGr9h6DuMyTP4NhQWi2fZy/obtoN5g0mUCrYYpQL67U36rqLQ7o6v0P0EN3KzoeICncN0rHprjF/zFYleXhYqAbrb8Cf5gCKX+sNooPwj2A6WNVRO3kGD6lFKcKzSrQfY/e8+cwYQEnSbNPkpnZmBq5GBBgZRE+QulWwJ/CBRgsMtjyrkiw2Jb7J3GlteXC44zB9IGaS1bmLS60FXme1gSuvRcWGehHyBOctYC92I8oXGezGU9vPwM4FuF2hyEwyMDLN14F2BCIQ/zEr9JMwtgq1EUavZdcJ2fj6CvLNQKRaQKWqiuO7yhpZ92PsQTXbJJBvTDlUMJtv9+vNk6UaFc98Ngco/0nj5WKs3jMfpqTgrkstwuWtqWxgN4XcEMZpj3AGoSCK+58zxWFSbmbp/lBcPxi65I8R/AL1NksgZsBK98bN0cIIzPxC7kexCXFeg1V7s7aLFscOGoMr+AAvU4lfmREKsChiCPiQnJfRrFPpjuccFRsugpQrbo6G9CqB+Pn2Bh1IHSO/QsRdWIOZi93t0HvzFIVP3C7zrQRUgQA3VpLYiepLWNpssL4P+jcu8Wfjm1J/NdO6O/n9vB1eV6BogfEG/C1kgI/u2oWxY9MPZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199015)(36756003)(31686004)(41300700001)(38100700002)(66556008)(478600001)(8676002)(6486002)(66574015)(86362001)(8936002)(31696002)(83380400001)(55236004)(186003)(53546011)(2906002)(6506007)(5660300002)(6666004)(2616005)(4326008)(6512007)(316002)(66946007)(26005)(66476007)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3Q0aXhiTXozdjUvNlV5aEg3YVFURHhjZ0FkVlB3NW1LWEtkZ2hxRVluQ2la?=
 =?utf-8?B?SGl4VE9wMTBaZlZkZzR5M2NqUTJEZXkrMCtIMFBWUFNuWmRLS1Z1NWFwZHhm?=
 =?utf-8?B?aVBENDBvMHI3ZnMvRCtDQWxXYm4wV2N2S1NzUVZSSlRxay9kRjROYjdweFJM?=
 =?utf-8?B?VnN1NDd6cVNUSUQvVVlmTWlZSWZsN3JsaUNpVWV2bmlYaWRtK3JPOFlnWU1z?=
 =?utf-8?B?SDRYQ2R4YVptdWd4cnVHTmM5eHVHWDlkYjVKWk9rdUZzY05ZdGRvMlpFSWtp?=
 =?utf-8?B?TGhwWmZVREgwUWNJY05GY01raUhQTmdsMkhSa0ZHeTV2azByRHM3enlOOGt5?=
 =?utf-8?B?bEdGazhEU2ZheVpLU05KdkJZbFpPNnpYdEVhRWRJTldPdjNRcnlmaExCV3pW?=
 =?utf-8?B?enV5NFY0ekhSZHJSMmt3eWF6OENvOVpFRkN3emZ4d1VSR2l0RUZQbFNCL0pw?=
 =?utf-8?B?ZVczS3NFZUl2Vm52UEVId0MwcHBBN0RqWTJlcUZveWl2KzBQKzhJSy92TUQ1?=
 =?utf-8?B?eHlOT1MyT2lzc3k4ZXRDaGV2TFMvSG10SGs5cEdtdFRZMjhqWU83VkxkNjdN?=
 =?utf-8?B?Q2xWdkhzTFdNbW82OEs0L040UGV4MzF6Vm1TWlNwOWRackhXcUVUV0ZFTEth?=
 =?utf-8?B?ZVRtQ2NRb1FPeXJFQ0ozWlhKOUc1aTJqc2ppQkk4Z2xYWURSVU9XRVB6WEZ4?=
 =?utf-8?B?bkFWZTQ3NXZyOXUvdjAzV3V0ZmxlSnI1dFhlMzhFc3MvUG81L2tFaUNacStq?=
 =?utf-8?B?bE9KcXIreDJNZlovZTJ1UitHa1BMRk1mYjV5T0pQQ252YS9QZkFGQnVHbGpW?=
 =?utf-8?B?c3dQYVZ2bE9RZWFvWkxsdHlOTFMyb3U5QXhKcHcrcy9RWFhQU2Jxc1g5Wldm?=
 =?utf-8?B?UlBnYTMrQWxOVmVNazZUQ1czbWNqczI4cGF5VTR6RHdwMUZRTDBXMGJPSCti?=
 =?utf-8?B?Nlc4clBkTE5DSEhRYVhseE5wam9BcGlGbER1c3I4ejlReEw4U3k5WFhLTEpp?=
 =?utf-8?B?Y2tkaGMwOFZsbnFHZjg0d2pUYWpNV2txOSt1dFRzdTVCVXRHRVZob1l0eGln?=
 =?utf-8?B?bUVHU1NwNlFNbENhTzNOaDFIM3ZaSTZFaENZVXhCUVZMME55VzJrcExxbXo1?=
 =?utf-8?B?Q01YeE5TRlZHTmZ3QUZON2hsZ3lFWEdyL044WGFRd3J4SWJyZlZDL3NFV09K?=
 =?utf-8?B?RmxKa3Ava2FrdkZPL0ZrY0YwODFPQjFPY1ZacEhwS091ZFdsV2pabGJaaTlD?=
 =?utf-8?B?S2FtWEFOdnUxWmJSSEIwQkhsZ1JpZzEyTkdib3F4elQvRDNpZHYzQVFYRWhU?=
 =?utf-8?B?TkdBTTR5ZXR1MWdleThqN0hVVjYvWHJuYUo4MFZYUGdlaGRWa3krN1ovY2dQ?=
 =?utf-8?B?ZDY5NXh5OWg4S3RoaW11RWFCbnFCQjhMOEpCM2o2eWV1cHBRRHlQMnpiNC90?=
 =?utf-8?B?MTJyMERaSkxPUHNzcWpDeWw4V1BCS3Nmbkp6Qm5SMUZ1SW9FSjlma2V1dlRL?=
 =?utf-8?B?dUFHeWFGTmpmQWZFWmpUR3YvTGRNdXB5N1c5aFJ2K2pRMExMdFpKLzYwU2ZR?=
 =?utf-8?B?aHNNWUQ1RnJHYUdENURzMnM4MERYOVZRMEJZcmZ6bXQ2ZEJjWVZGUTlwYWlZ?=
 =?utf-8?B?N0FiQWlFNVMveGJLTUwzVlNvWWpkeXFRS09GMGMvbVRPbGZPRjJ5bUF6cGNu?=
 =?utf-8?B?KzlKeWU1b3ZjSzVrWkJwNnhjdFRnZGdveE1uS1BMVHNvK3J5T05wcVBoZEFs?=
 =?utf-8?B?NXZvYkNDMTU3ckRxVWhHODI2UHM4dHQyMm8zdTZNYjNSMHE4WjE3Nmo3MmM2?=
 =?utf-8?B?QksycXpSclk2enRNWTJiN3VZeFNGYitIUlpwK2F5RVBJU3RWUFUzRjVSN1RE?=
 =?utf-8?B?d2RFcWhVRTZYUFlkbnc2N2pGTnNrZmQwd0NIK1FLU0xZYU44S21rYzdnOGFZ?=
 =?utf-8?B?dDBEejdpYnN6b1kvUW1DYzJHb2JrbHdwZWo5WXFKTENpczkrNStPZk9aYll3?=
 =?utf-8?B?TzY3UjhpMVovd3p4N0NRZVFIZW1CZTFwZVF2SVNLU1JIVWtsbTdzeENScFNm?=
 =?utf-8?B?bHB2TWdSMGZOc0lFVGI1dTJwQjQ4M1VsZVpaM2grd3J6NVc1U3hXVVErN3VN?=
 =?utf-8?Q?1V0mINNZHGmTJg2UNbuBvKtyJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0401cf5-b1cd-4ad2-b497-08dab69455f4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 14:22:24.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66JxctZRLstviOhJGLpTjgqIwq27u3t3X7/BbecB3sXye+cEq/sVbCd2LMnrSMwZytJoH2sJ4bQ4M4HeGDSPWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Uwe, Thierry,

On 25/04/2022 14:22, Uwe Kleine-König wrote:
> Dividing by the result of a division looses precision because the result is
> rounded twice. E.g. with clk_rate = 48000000 and period = 32760033 the
> following numbers result:
> 
> 	rate = pc->clk_rate >> PWM_DUTY_WIDTH = 187500
> 	hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns) = 3052
> 	rate = DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz) = 6144
> 
> The exact result would be 6142.5061875 and (apart from rounding) this is
> found by using a single division. As a side effect is also a tad
> cheaper to calculate.
> 
> Also using clk_rate >> PWM_DUTY_WIDTH looses precision. Consider for
> example clk_rate = 47999999 and period = 106667:
> 
> 	mul_u64_u64_div_u64(pc->clk_rate >> PWM_DUTY_WIDTH, period_ns,
> 			    NSEC_PER_SEC) = 19
> 
> 	mul_u64_u64_div_u64(pc->clk_rate, period_ns,
> 			    NSEC_PER_SEC << PWM_DUTY_WIDTH) = 20
> 
> (The exact result is 20.000062083332033.)
> 
> With this optimizations also switch from round-closest to round-down for
> the period calculation. Given that the calculations were non-optimal for
> quite some time now with variations in both directions which nobody
> reported as a problem, this is the opportunity to align the driver's
> behavior to the requirements of new drivers. This has several upsides:
> 
>   - Implementation is easier as there are no round-nearest variants of
>     mul_u64_u64_div_u64().
>   - Requests for too small periods are now consistently refused. This was
>     kind of arbitrary before, where period_ns < min_period_ns was
>     refused, but in some cases min_period_ns isn't actually implementable
>     and then values between min_period_ns and the actual minimum were
>     rounded up to the actual minimum.
> 
> Note that the duty_cycle calculation isn't using the usual round-down
> approach yet.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> changes since (implicit) v1: Updated changelog to explain why rate = 0
> is refused now.
> 
> Best regards
> Uwe
> 
>   drivers/pwm/pwm-tegra.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index e5a9ffef4a71..7fc03a9ec154 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -99,7 +99,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   			    int duty_ns, int period_ns)
>   {
>   	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
> -	unsigned long long c = duty_ns, hz;
> +	unsigned long long c = duty_ns;
>   	unsigned long rate, required_clk_rate;
>   	u32 val = 0;
>   	int err;
> @@ -156,11 +156,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   		pc->clk_rate = clk_get_rate(pc->clk);
>   	}
>   
> -	rate = pc->clk_rate >> PWM_DUTY_WIDTH;
> -
>   	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
> -	hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
> -	rate = DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
> +	rate = mul_u64_u64_div_u64(pc->clk_rate, period_ns,
> +				   (u64)NSEC_PER_SEC << PWM_DUTY_WIDTH);
>   
>   	/*
>   	 * Since the actual PWM divider is the register's frequency divider
> @@ -169,6 +167,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   	 */
>   	if (rate > 0)
>   		rate--;
> +	else
> +		return -EINVAL;


I am seeing more problems with this ...

1. In the case where we call dev_pm_opp_set_rate() to set the PWM clock
    rate, the requested rate is calculated as ...

   required_clk_rate = (NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;

    For Tegra234, I have a case where the period is 45334 and so the
    above yields a rate of 5646848Hz. In this case, mul_u64_u64_div_u64()
    returns 0 because ...

    (5646848 * 45334)/(NSEC_PER_SEC << PWM_DUTY_WIDTH) = 0.9999

    We can fix this by ...

   required_clk_rate = (NSEC_PER_SEC << PWM_DUTY_WIDTH) / period_ns;

    The above produces a rate of 5646975 vs 5646848Hz.

2. Even after fixing issue #1, above, I then ran into another issue
    where even if I request a clock rate of 5646975 I still get a lower
    clock. This also causes  mul_u64_u64_div_u64() to return 0 and then I
    see the -EINVAL returned. The simple solution here is to not return
    -EINVAL for 0. After all 0, could be valid if the rate if we are
    not dividing down the parent clock in the PWM. However, then there is
    always the case we are not operating at the expected rate. Seems like
    we should be rounding the result.

Thoughts?

Jon

-- 
nvpublic
