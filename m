Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA6660EA1E
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Oct 2022 22:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiJZURS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Oct 2022 16:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiJZURR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Oct 2022 16:17:17 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2082.outbound.protection.outlook.com [40.107.212.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4912E4523B;
        Wed, 26 Oct 2022 13:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxIT3HsQMUkGs0yjjMgJzcCG4o1hSUFAEVlfsCf8xHtVaZuJFxoXY9ydpU9CbV+jAsuAYofinJdn6dB+uZniezSzFh5NtVWgYd+7KT7Vv+NtCkkj0NJ2UesKWhvyBfAO6/ynbbgeIITFlF59x6YZ5t8ZMfhzFXy11RmgSo+2uu9azAg6dVL998t0NcEDl7wMScx1Q2ceRe9tYIKeOGyHowLfPUqN93viE1inhBHp0fmJ/ZlETKAwQpe7vxD/gA0HFQMa15425SQlfW1vSgnuvCwt7jQUvRJYk9GrQ0or8gWF2PEZEPFyyjLFdUJltIXYsydpkMCrLimlSp+5msvHQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfEtQyjTR6U6R5rHSpJSe1XkoV63zUVNkBlHTQlRV2o=;
 b=ku+YdfkmdEYOeaV5woqvob94pxGHGBwF1p6Bmf5ZSd1cwTnP2XFOUGrt/2iF9/3WpC4FozmzTuv3X9+8vk/2ytRYuPRSNRuqYm9iYncZFMKrDXsSf5qKT3lV6Kr40OSI4KlMJNpLEEaE9h2nGMmPzJ8LUVQGhvnJwaGrtNfl2Ueuy3pctemacGonFVvrrV4en4gg3ctDGNmK0+JnJP+F9+wpRh7y7HtcPVQkPrVemAQxgnaqxWLKYFR9wPSJZeFPB8v0SVmIbia1NBubF6K1Il4DnDGGO4uCmbR3gPnVe0ADdbpc09KO87BiJICYCgj+GI8VVWJQFUN3AsJcBKGYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfEtQyjTR6U6R5rHSpJSe1XkoV63zUVNkBlHTQlRV2o=;
 b=USuLNTA8Bam5+W8+KcULnHOBWxCriBILa+VHNXXwdi6GRLOoLfI9VPvdb6R9SM8QFX6ft4qcVr7dNgj4cKLCEHW2rE4IwiyooOCH4p5erb45oovnovd6nl63Qc0an7wCHrE1ZllkQi8KFOsFTUmC4B5XoH4MTI5KE+tc0RCXi1LuK/E74yGdol2rheQccjgbSuIUJ4Pdo8xWdN5ktJm3gfG8Dyl/IDXCsZm+Gb+TfbQzI6amUotJCF29VtgdU5eObgpt2iLPtYh8CJsrNzlo/6AfI1um5ABOTP8MCttQHGQN1XDcgbwYdSEKyRbqS3WCFGN1FyJiSUnEZ+aGucNLVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 20:17:14 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%6]) with mapi id 15.20.5746.023; Wed, 26 Oct 2022
 20:17:14 +0000
Message-ID: <5bb9e817-9e4d-dd02-9c04-443efcf58226@nvidia.com>
Date:   Wed, 26 Oct 2022 21:17:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] pwm: tegra: Fix required rate when clock is lower
 than needed
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221026101305.30670-1-jonathanh@nvidia.com>
 <20221026101305.30670-2-jonathanh@nvidia.com>
 <20221026142301.3cgwqozpafpuu34k@pengutronix.de>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221026142301.3cgwqozpafpuu34k@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0219.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::8) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aba926c-4a2b-40ab-1f0c-08dab78f121d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqEJj4+266j84KpMucUHnx3I0KDsKkmN+w4kOu1EtgKxhHWCqumRcY9uiI4m4mdV5gJ5pjolk8e+JiwCHuYlFfh4yna70YzCHfJpXJagkbDRDQZmF+rsUcpH4iCyqM9JARqSLTagCQGqheJqeRFnyQgyWF3BMZaxuL3PotZsjDxiP2yUu+7FCeQQpPE5gIIbk+Uxkv8PNXvRptCnrT2tg+8TnU5m3mV8PbHgdD7jd3CUKmuBDtgIK5EgPpGJ688fQyxJWrnqPdONNIf6qS1Q1Z4mqUf1gv7rsMMKJBf2G+P321P0OAHWJhuA9fsHPdgQ1dq1TpbUMPDFtXT2ATv8zCtY0ffATX6VjYtrvIRuI8Vbu+36dgQG+rAgrhJ+LRQirJ6jNSF6h1lCJWBdTlAP8oSWpNA+bEJpBksr+frscCigpavQ/vNykjP/7yZ2VUWG21sGPldSKEv8As30eoykq9Rvx+nqwXtD3wMZGIfYfrw1UaJ6s9xKWePieZESkrnm7CoU0/hoNh+rgD2nzY/f0fhy6ujHU26KH5YvB2tlUGc0Sd5XuCG7RDSmCpSnmJO5G5ao0Tl+gfDxTfQKngliL/hzrSnU3zIYIQQ1BT8IaZHUDntT0geeOZZ7b+3aCWHZ6+6QB/k6jHgOwFnxzC6YySvtLyZl6Lm9RTYxQ5FD1l7Zt2tLRFk2xEjKS/ugN8JNApNuO0mY6eLu91WZTjpbKERIAcBllRxUJqj4QfDlGeYR5N5cOEFumVH/gP+qHUu1fBxqBZsDD1nqhaw4tSkE0qs7RH9uRoTubCJDXblYlyPemPGHK6Gs7XQshtn7FRm3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(6486002)(186003)(6506007)(53546011)(6512007)(478600001)(2906002)(6916009)(31686004)(6666004)(83380400001)(2616005)(66946007)(66476007)(4326008)(31696002)(41300700001)(66556008)(8676002)(86362001)(316002)(38100700002)(5660300002)(36756003)(8936002)(20673002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qnp3L3lKY1hjMzd4NmJBQ0FZMWNma3FBVTJpcWFkb0UxV083aUM3VHdsSEpE?=
 =?utf-8?B?OGlJWTVzUHV4anVsQS9zVTdFZ2xFZEtFMVhWR1NwT20yenBYcC9WODRwd1Jn?=
 =?utf-8?B?VHUzdmtVY3BUSEt4c1JUZE5XN2xGQ0FXOEtLeVVXeklBQUMyRFFQY2NhMGpH?=
 =?utf-8?B?QkluTDFGczcvOTJKdEYvOUl6NWNHTFEyQ2tmZ0dnOTJzR05laU9PUURGa2hn?=
 =?utf-8?B?ZmpIQ1ZkMzAzSEFhOWRIWnVtZFdRUXBSZHVXVmQrZEkxRWE1a09CdmFDckFj?=
 =?utf-8?B?VVkvNU5yWUtFQk5GRi80aE15UTVIeVpseFFFbG9FMnhkRXhGK0RqSitSbEVO?=
 =?utf-8?B?VzBCbmdwaitGOEROL2dEMi9kMkplMUszVW5qWkkycHM5dzhwN1NmV2s2cjB3?=
 =?utf-8?B?dmoyZ1J6NjFNcVp0czBKUThNNFJPcG5QWXJvRkYxWTJNZnVlSnNHSmlpMzdo?=
 =?utf-8?B?dFN1NGF5bDNGM1Q5dEhLOWZTYU1JSDk2RWRFRmIwTzBJZHFuTnc0V2FYSUw3?=
 =?utf-8?B?enlLdy8xenJXTnVybjNRdVlpREJ1THlRekNEMHVscHdxVFRvb1FuUlJrRk5r?=
 =?utf-8?B?T0NQUUZDS2VnR2xsYjdYY1FsbFdLakpnNWxFZlhJWVEzL0Q3Y0lsR2JDeTdx?=
 =?utf-8?B?clE5MFU4bG1hWnVEMXJWYU9xMUlQQXA3VkxUZWtxNEprUncyTGFZaUNzWmNu?=
 =?utf-8?B?TWpkQUFCKzgzRzBuNVBEc25xVjd4RFNJUUtsWWQ4ZFYySEtIN1JsUWJYYjJL?=
 =?utf-8?B?dHFsS1pVRnBnLzVRZCtLUkRDbEpPV3RGMi9kUlZ3UHJRSHBpcVFYNEhxWHI3?=
 =?utf-8?B?U1Q5U0s5QWlwZ01iVGo4VmlCMGpYeWE2cWlNQ0JZOVNZMk5QQU1Hd3VWUnEz?=
 =?utf-8?B?TEMvYWZUT3MwQlRMcFVZMU9EVzMzRFZGR213WFhRYVlqMVVMWWEzRUZZcXRp?=
 =?utf-8?B?dnJ2OGt3MFNOUWZ6M1ZpTUdpeHZRbS9uVHRHOXo2c3VVSGtQd3BweW5aWktH?=
 =?utf-8?B?cVgvRllVTUd5dUI3dlhmVmFDMW1Nb0xmUXhvdVJxZ3poV1VocWVLRGQ4M0Jl?=
 =?utf-8?B?aG5TTUlZVm5pQkJ6Z3laSklhSERtOXVWNWtRbnhMY0xVUW11a1pVOElFYXE5?=
 =?utf-8?B?M1AwZmQ2OXFJYllFd0J2endKengrZFdlQTdnWkU2SnREbDQyVG1jMTRsaGFk?=
 =?utf-8?B?amo5UllBM3F3WkV6dHAvUW1DcXB1SXBiWEpyVHhhRXcwU0J0SjZ4YWxHQ0d0?=
 =?utf-8?B?aE9SVS8vaG45bjRBYis3bnNXQkhXa0Q4eTFHUXlnZkhvZWQ5VzZJdVZwcTFZ?=
 =?utf-8?B?dFkzbE1tOHNNNm9WR0dKc1orZFpGY3EvQ1QxOWpFcytvVjg4TGpGblBGMXl5?=
 =?utf-8?B?cXVIaWR0T25IT0loaEZGNjkreGtGa0xOeVpWSmszL0JHbCs3OVhocnRRQTQ3?=
 =?utf-8?B?Z1Y3WEw2RkMya0NRWXpucDBlSnVMeFNQN2dxcHdUWm8vZEMwU2NFTGxITXVq?=
 =?utf-8?B?eW1McFltaEZCUFIxejI1VHNXTUhMMzI3ZGtBRW1XdVBtSlNhdXJnL0tCK3FF?=
 =?utf-8?B?RjhDNDV6NHFUNzJQL3RpQm9kZW02SGhFVEFYSmhsajlZa2hhN2hjVko4QmtI?=
 =?utf-8?B?Y0JCKzBDSkNtRE4zTVhhMm13a0pBckc1RXlyNDNobjZGYzhnRkQyN3JEZi9s?=
 =?utf-8?B?dmNVWW5lekhodUI5NzZCTGpuY09QaGM0cisyV3F5OHNjOGhmQU1GV0VHUTFW?=
 =?utf-8?B?T0hXSzRZc2hOTXJCTDNMRko4RVdlVTJ1UVY2V3NYQ0hYaGJCdk80WTI5dU1I?=
 =?utf-8?B?djkxNUlMOGhwNjdTRHdHWDY5bkppMkpxRGsvdk5ScGc5Vlh2bVBjUHJMTUpM?=
 =?utf-8?B?M1pIb0dQWmFwaHRqVFZ0MXFKYlo4MUtNdkI3eXlqUTY4SWUwcythRlc0ZXhD?=
 =?utf-8?B?aTgrUVlRVDRBTFFGSjFMODhHRThGSkQyMG1sZG40Z2NRVmxkaWRYcUd1cDNp?=
 =?utf-8?B?SWVsbXNWT2hJTWROQ1lUYkExbkM4TC9TbytWKzluOVovc0FTUkpUTzFDVVdF?=
 =?utf-8?B?dmk2MjFaMFlMbjBGbFRUeHhmcHdLNEhnWHEvU0lPc1VnTUEzMGV2bUlQeU9l?=
 =?utf-8?B?WXBVcEg2TzBUYTcrM0lWNGpOT2hzK3RkOGs1ZStpaCtnbHYzUW5zNWtnVUhO?=
 =?utf-8?Q?LKspS1zdDWKDImkZ1cX0sLFXgl9/ttNv1AtivQH+eQt2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aba926c-4a2b-40ab-1f0c-08dab78f121d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 20:17:14.0951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbRq0KL1WnlC2BfYZyCOs/FLnNLlR5OUwroEX7sNA0+vCwl72kYK8YjopjCeqBfyeIu+CvgLaoqSNoUnr9n/cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On 26/10/2022 15:23, Uwe Kleine-König wrote:
> On Wed, Oct 26, 2022 at 11:13:05AM +0100, Jon Hunter wrote:
>> If the 'required_clk_rate' is greater than the clock rate that can be
>> provided, then when mul_u64_u64_div_u64() is called to determine the
>> 'rate' for the PWM divider, 0 will be returned. If 'rate' is 0, then we
>> will return -EINVAL and fail to configure the PWM. Fix this by adding 1
>> to the PWM_DUTY_WIDTH when calculating the 'required_clk_rate' to ensure
>> that 'rate' is greater or equal to 1. This fixes an issue on Tegra234
>> where configuring the PWM fan fails.
>>
>> Fixes: 8c193f4714df ("pwm: tegra: Optimize period calculation")
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>   drivers/pwm/pwm-tegra.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
>> index 8a33c500f93b..973e2c1533ab 100644
>> --- a/drivers/pwm/pwm-tegra.c
>> +++ b/drivers/pwm/pwm-tegra.c
>> @@ -148,6 +148,19 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>   		required_clk_rate = DIV_ROUND_UP_ULL((NSEC_PER_SEC << PWM_DUTY_WIDTH),
>>   						     period_ns);
>>   
>> +		/*
>> +		 * If the 'required_clk_rate' is greater than the clock rate
>> +		 * that can be provided, then when mul_u64_u64_div_u64() is
>> +		 * called to determine the 'rate' for the PWM divider, 0 will
>> +		 * be returned. If 'rate' is 0, then we will return -EINVAL and
>> +		 * fail to configure the PWM. If this case, add 1 to the
>> +		 * PWM_DUTY_WIDTH when calculating the 'required_clk_rate' to
>> +		 * ensure that 'rate' is greater or equal to 1.
>> +		 */
>> +		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
>> +			required_clk_rate = DIV_ROUND_UP_ULL((NSEC_PER_SEC << (PWM_DUTY_WIDTH + 1)),
>> +							     period_ns);
>> +
> 
> It's implicit knowledge that (roughly) doubling the clk rate is the
> right value (i.e the minimal value to get a
> clk_rate >= (NSEC_PER_SEC << PWM_DUTY_WIDTH) / period_ns?

Are you suggesting I drop the comment? Sorry not sure what you are 
trying to say here and if you think something should be changed.

> 
>>   		err = dev_pm_opp_set_rate(pc->dev, required_clk_rate);
>>   		if (err < 0)
>>   			return -EINVAL;
> 
> Is it obvious that dev_pm_opp_set_rate(pc->dev, ...) and
> clk_round_rate() correlate enough that the latter tells anything about
> the former? Would it make sense to use clk_set_rate instead of
> dev_pm_opp_set_rate?

We call clk_get_rate() after calling dev_pm_opp_set_rate() and so 
hopefully when reviewing the complete code it is clearer. I don't think 
we can use clk_set_rate() and this was changed from calling 
clk_set_rate() by commit 3da9b0feaa16 ("pwm: tegra: Add runtime PM and 
OPP support").

Thanks
Jon

-- 
nvpublic
