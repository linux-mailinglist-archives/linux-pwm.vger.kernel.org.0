Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5137D60FA44
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Oct 2022 16:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbiJ0ORg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Oct 2022 10:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiJ0ORg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Oct 2022 10:17:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4B3186780;
        Thu, 27 Oct 2022 07:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHD1yvrI+8yqkZDGT4NoUt4OJmMcL4k+14bDg+Z00kEs7fJ2J+NBtNaWQfwZgdoKOkxq1+AAcHRIa6uWkpVCCwdcC40gJdFOfkJelo7+eZ+pGfwvULnPLFA4oHBxMCGw9fJ/H7PS+a9w/gWkBlkrxo8nhR5rgH22tTV1Yf4+y1tuBaBGsPcA3At6BAZWSJPOeaGpP2X1BZXO//kBBP8hMpgyyUFbCVDG4QrdIoZv+uzNOTg3mz9mzjWEEdmAqHqvNA/TWMfxDnq6tpMtL8LQkqNWnQmBlXYNrN1ptulwYf3orYaD9aSsfwG4yHCSaFXpfO0AnD/OkFDAPoc5lUtsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68kjr2+7f9k44ruJC5/DSrNKz17Sjj0bevNKmJZNUPo=;
 b=ZtUn5qGjIj1+sHF5rwLJWsGtF+RNg5Wpbd4PW5w/Wsj1gYRVicH6voFb9t2XUWCXu1gC77nGTYyxk/amya1A1ts0UP554sF0QlJ2T7x1KGxP2M21zywANcLk1CsoE2QYxYkLVOV88JEG7Ei7Lr+Cuh1s7L8Hqh/l0VLfkK8UWREf3Ho4Wa0jGugVvdXn5dbzn6LHxnoMIC+DG1v5CrzPL7hLyDbkvXJzkqbC0vwgvg4/h0sVSdnpg+2kl8296uKtzjZNgg2J5KmTJVZQvPXF7d7UwWr474sWAdrmFj6fKtfq/c6vvYqB3NRVeW7EaYpyXIjGqR5GnP1wHBH3mOL7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68kjr2+7f9k44ruJC5/DSrNKz17Sjj0bevNKmJZNUPo=;
 b=NvpHj8vBU/XtwDnFSRucnCjlcra1H71k/voM3Zu95Z32ndfgiD1yeS++68HBdulUpM2syZmaT9ReAldmekfRi0miInCMBmPzWWhIvMZN/ymRjE7zU3JFnQsB7E3Pti/2gZy75mPHNR4pMVfUBp24T81j0OyZ63tnRn+F7icoDe0Gl5i6WHcHgxCLUibJn4BgPeWeSjjmJsJtR23ieNlvuO1CAYRRjL8Z0hF3a038t2ohVTL36+zYv+o+jHNM3KRNuZxD9sPZyMOevaQjPfZRD6x7FWGE34nallRPE+fIqLPKqvmni8aODiOHSdrK20xY5yxBhiliqUh0etKwLTVT5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.28; Thu, 27 Oct 2022 14:17:32 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 14:17:32 +0000
Message-ID: <89260f9f-a54b-108c-6144-5bcb06d5dc83@nvidia.com>
Date:   Thu, 27 Oct 2022 15:17:26 +0100
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
 <5bb9e817-9e4d-dd02-9c04-443efcf58226@nvidia.com>
 <20221027064003.22hx7iftdpg7s5hi@pengutronix.de>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221027064003.22hx7iftdpg7s5hi@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0250.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::21) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BL1PR12MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3eba9e-8acf-4837-9890-08dab825fc9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81i8dr7MudYQq0oOvFSgwkRqWuAqDwbxL57iypaWGqvCKDd78li8ys6xILz7qsIXGcKTazTePkK4GuXzfHF4AFb8gT9xtUBExB1nv4i4zvnlD98+5WU/SFK0GELpn0fInA9BBe0MufL0F/XVUIh3ynE/45cld9LwAPFozc3WdhGcE8ZsWWjT2s8vWNWfLU91jYoAV6s1wB2hleQpbym2tr2UoBkv7JtAOaKqGQ63A+QCQ5M3m+z7iwKOclN6WPn4nDazmwzv71iCW2f8ekHnJM+FYjTGPjQZ+ghgHpjBeIckTuAsOj5c15eV8Pq/WSd4n4X/CnBZH2oOM8uoE5P0qKUkDIRb2+qb61nrpVy+jsld2jsB1UYf+F6OjbVHovniAIkGd4GPbDTLdlOMz6uBEHzUZViRqEt6+DBQ+sx8zAU+aYHqYXLJw7L3la1QuHme/l3w14HATrI4VhisvKd+oB03K/M45RC6eWd61Nygmvjg2WjJNuhlHqCiQcmt9fp26Bbhk6YNHFwm4IdrWU1gEX7m6+HOgvaBfDHb7t5JJ747u/4jzvM3vtMFz96xGtSGFIYZCFh3przEJHkHT94p0YYXkfq21avEOQyJNWZUPy99ouJ+HzZ7PHDYfNdvSluJDwQSuiOae3ZnRTzOblNJSPZdgULsBU1hlAsrd+9s2+HPpzlHkTJamuaFhzjWnU/+VDhg8WYvi848eXeTlM4pNKciEvEkMAmIOlSHi/MGTukQJ56UQUPFHEoGdYLQanHLc2E/DKE6CqMdEG7VR/Z1myUe2E38TAL5o1juH/CxkdJ9njDtXnLp9vAuVt9IiG7INEzwrd7DpVRzjEMsPUUyzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(2616005)(31686004)(6916009)(6486002)(316002)(38100700002)(36756003)(8936002)(86362001)(31696002)(186003)(53546011)(66574015)(6666004)(83380400001)(55236004)(6512007)(26005)(6506007)(4326008)(478600001)(66476007)(41300700001)(5660300002)(66946007)(66556008)(2906002)(8676002)(20673002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXZtelpUMGZ5QldvWG5jald2YlJ5cnRTRnNaaGFzMHJZekJUNGpvK0xBVXp3?=
 =?utf-8?B?c2Y2UWxQU2FidFBuWDhOWDRySFoyazVGdUQzdjFETlAzZzJ1dDc4aWt5ZkNl?=
 =?utf-8?B?QVgzRlIyeFU5K0gzdGRlNVZDelVjN1Uva2JNSjJqRHBOcGJweklqMldkc0JZ?=
 =?utf-8?B?OGVzVVYrK09GTVcrZG5XZ280ZlNBNDBROTBPb2FSMnNEYmlha3J1R2RPRU10?=
 =?utf-8?B?Y1N2ZGxSZUhiUFR5UThYdTVFSTlFRUh2REIvemJqQmN0UitLMTBtVmkwMGZC?=
 =?utf-8?B?Q2JRZStlWFVnWWlyNm8rdjA1UTRjSUtIQjUrTUhWbmNCbDBDajFFQXI5QVVD?=
 =?utf-8?B?WnZrelNWUFkrRmpBbkNlcXJUaUNNRTVpejZaclp6WGU3NjhOQWdtL3VBdzBL?=
 =?utf-8?B?VnQ2NW5rOXdudGsxZHZUQUtOOGhoT081ZDR4Tkx6SGMrSWh3V25sc1VtQXht?=
 =?utf-8?B?S2dYM2RGQ3lnZmQ5ZmJkTnIvZDduWVdIYzMwWURGdWp6bjhpSlkrL1hKeHNJ?=
 =?utf-8?B?anVKYzU3VE5iZFppSzdzSWxGSUFPMnlXMTdkRUdacjJLdFY2dTRaSHh1N1pO?=
 =?utf-8?B?TmxvZ0ZTVDVvK2tBTlBOWHloYld6SzBPOW1UMFB3YnovNEd2VDd0dFlKRUNo?=
 =?utf-8?B?RmdGVllEdWlEQVdjdG9SYkZqMjNQWTN5cGZIaUV4M3VQWnRpWldsSyttRENl?=
 =?utf-8?B?ZU5HM0JIYlljbjA4T0d6NEFudHZPZkJNMjVyeEFhWVRWRENaZElYYW53dVUr?=
 =?utf-8?B?S0pFSzBlaHZkajk0MWMzbDBHTGIwMnlxS1ZhdnlmWk42MkNXUW51REMvMGFQ?=
 =?utf-8?B?b3QveVdZTWRxVnU2dkhReTFiaEdDOWFCN2Y2NnZhOE1MTWtMcUhlK1ZGYVdn?=
 =?utf-8?B?QitMaDhIdGF2WFNRdlA5dlh3R0NrRGpkRmVnVUQ2Rkp2YUN4VUtUVnU2aHB1?=
 =?utf-8?B?eHA0czNHOVdGQkVkdkRnUlFBem9kNEN0RDdoWmZIWFFHSmZlbzgweHdWNkFU?=
 =?utf-8?B?YmJoUHFJK0N4U29WQU1BT2lEemUyeS9zV2FiWGs4bVA2QmZCU2VhcDVGeVFr?=
 =?utf-8?B?enF0TWdEK3dCQXVjUDd4b3I5ZzRxb2hPcm12RlFLZkhBNTZEaGE4akcveERo?=
 =?utf-8?B?N3E4VEg0Tk1iTDU1dWVDekJReWpHSndtZTBIRWdqUzRiRVpnU0pWOEluWlRH?=
 =?utf-8?B?WjY3UGY2MWJWUWk5bGRmQVFQSDUwb0pzaFkvd1RqV3MybWFVa2R0NU0xN2NG?=
 =?utf-8?B?dXJGSUVWaFlCV3crVnFXOEI4bzhrYm9FenNoZlRySjlVcXBDZ2ZXWmxXQXBS?=
 =?utf-8?B?aDVsS2l0YXZ5eTFWRFFSNFluUzFUZGdnbmhkdHZrdkVtWXpaY2NjWml1akZz?=
 =?utf-8?B?RERFQlM4NEZibjA3UmY4YzArN1ZtdGhZZmpWRW1nb0dMaFhwR2Vqa1U0R3Z1?=
 =?utf-8?B?WkR1WDFZWldaaTcyQUN6U0ttMTFpTzdNSm5BblBDbzRFMlJaTm40dnZJMUhX?=
 =?utf-8?B?ODlzMktHSzJaa2dQSGdVWHpQTDJQSHZOcURud2gzeHBWZk9xd2lUYkxSUUF5?=
 =?utf-8?B?K1hMZ2hzYWVyUTRZbVZ1aFQ2TlF3d3hOeXBBcVMxZW1XWkpQeWZWVkxHUE5U?=
 =?utf-8?B?Ym9RcW53RWNwd0RQUUF3Zm1GTkF6aXNPRW9yK2krUy9jZU10cnMzQlBRSko4?=
 =?utf-8?B?NWRtc0ZKTjRMaHpLNm9wbjljaVh3QlVSS25SL3RiQy9sdEtVc29qZFloQzly?=
 =?utf-8?B?SU84d1I3V09rQTZydDJmdFhwM2pGamV4eDB0UkN5TVZNZEhUeGhKMWlnSTdo?=
 =?utf-8?B?enZtZVJMYzRFdmlrczRKQjFYZmhYNW45UnpmL2tVbzkrUmRSbGRud3VoQ2pX?=
 =?utf-8?B?Yi8vTnVaZWhMK3BXQUxSclBYd3R5NmM2dzRVYTJNUmdjUEZqYTBISkNLL3dL?=
 =?utf-8?B?OXJNMzdqMENNRmdJS1NHeStQMGU1eS8yZDRIbXBhcVpRNHpjS2JpR1R6ZWV6?=
 =?utf-8?B?akhqTnJ5UmNNdVhPUHplRnhJbFFPbmEzN2NnL0lGWTJCMzVIOFlLdDdYYk0y?=
 =?utf-8?B?Qlk2TERZYU1GUzN2eXdVS2xvMHpFMzRCVldLOFFXT0hKSy9Ud3VET1o3eUxL?=
 =?utf-8?B?SUR2QjJvMVJmWW50bzZRbXpLSGFtTHI5cDZ5elIydDFhZGIxUndFVytvZy9H?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3eba9e-8acf-4837-9890-08dab825fc9a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 14:17:32.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aze7owLK/+RPZAmbZS9I6BWKvo7m2bbUlUq+veJa0EwKCevLXLIstJk1JMS4BuOtqMfZRkRcRXSzQHkLhyHtkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On 27/10/2022 07:40, Uwe Kleine-König wrote:
> Hello Jon,
> 
> On Wed, Oct 26, 2022 at 09:17:08PM +0100, Jon Hunter wrote:
>> On 26/10/2022 15:23, Uwe Kleine-König wrote:
>>> On Wed, Oct 26, 2022 at 11:13:05AM +0100, Jon Hunter wrote:
>>>> If the 'required_clk_rate' is greater than the clock rate that can be
>>>> provided, then when mul_u64_u64_div_u64() is called to determine the
>>>> 'rate' for the PWM divider, 0 will be returned. If 'rate' is 0, then we
>>>> will return -EINVAL and fail to configure the PWM. Fix this by adding 1
>>>> to the PWM_DUTY_WIDTH when calculating the 'required_clk_rate' to ensure
>>>> that 'rate' is greater or equal to 1. This fixes an issue on Tegra234
>>>> where configuring the PWM fan fails.
>>>>
>>>> Fixes: 8c193f4714df ("pwm: tegra: Optimize period calculation")
>>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>>> ---
>>>>    drivers/pwm/pwm-tegra.c | 13 +++++++++++++
>>>>    1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
>>>> index 8a33c500f93b..973e2c1533ab 100644
>>>> --- a/drivers/pwm/pwm-tegra.c
>>>> +++ b/drivers/pwm/pwm-tegra.c
>>>> @@ -148,6 +148,19 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>>>   		required_clk_rate = DIV_ROUND_UP_ULL((NSEC_PER_SEC << PWM_DUTY_WIDTH),
>>>>   						     period_ns);
>>>> +		/*
>>>> +		 * If the 'required_clk_rate' is greater than the clock rate
>>>> +		 * that can be provided, then when mul_u64_u64_div_u64() is
>>>> +		 * called to determine the 'rate' for the PWM divider, 0 will
>>>> +		 * be returned. If 'rate' is 0, then we will return -EINVAL and
>>>> +		 * fail to configure the PWM. If this case, add 1 to the
>>>> +		 * PWM_DUTY_WIDTH when calculating the 'required_clk_rate' to
>>>> +		 * ensure that 'rate' is greater or equal to 1.
>>>> +		 */
>>>> +		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
>>>> +			required_clk_rate = DIV_ROUND_UP_ULL((NSEC_PER_SEC << (PWM_DUTY_WIDTH + 1)),
>>>> +							     period_ns);
>>>> +
>>>
>>> It's implicit knowledge that (roughly) doubling the clk rate is the
>>> right value (i.e the minimal value to get a
>>> clk_rate >= (NSEC_PER_SEC << PWM_DUTY_WIDTH) / period_ns?
>>
>> Are you suggesting I drop the comment? Sorry not sure what you are trying to
>> say here and if you think something should be changed.
> 
> No, I just wondered about that +1 being the right thing to do. Consider
> period_ns was 400003. Then you get required_clk_rate = 639996.
> Now we want to prevent that calling dev_pm_opp_set_rate(..., 639996)
> yields a rate less than 639996.
> 
> You're implicitly claiming that 1279991 will do. But without further
> knowledge also that value might yield a rate less than 639996; or 959993
> might yield a rate that better fits our needs (i.e.
> 
> 	639996 <= clk_round_rate(..., 959993) < clk_round_rate(..., 1279991)
> 
> ). So my question was about "why 1279991?" and if there is implicit
> knowledge that makes 1279991 the right choice. Assuming there is such a
> reasoning, I'd prefer a comment like:
> 
> 	/*
> 	 * To achieve a period not bigger than the requested period we
> 	 * must ensure that the input clock runs with at least
> 	 * $required_clk_rate Hz. As consecutive possible rates differ
> 	 * by a factor of two we double our request if
> 	 * $required_clk_rate yields a too slow rate.
> 	 */
> 
> I'm not entirely sure this would be a sound assumption but I think you
> get the point?! (It might be necessary to double exactly the requested
> value and then you still have to make some (reasonable) assumption about
> clk_round_rate().)


So actually, I am not claiming that doubling the clock rate will do.
All I am claiming is that we know that based upon the rate returned
by clk_round_rate(), we can determine if the original
required_clk_rate we calculated will work or not. If we determine
that this does not work because it is less than we need, then the
next logical step would be to try a higher rate.

We already know that the period is greater than the minimum period
that is allowed, because we check this earlier on. So if the period
is greater than the min period, it would seem that doubling the
clock rate might be sufficient. Worse case it is not and we still
return -EINVAL and we are no better off.

However, I see that I have been focused on the current issue in
front of me and this works. The alternative that I see would be to
stick with the maximum rate permitted ...

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 8a33c500f93b..2099ecca4237 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -148,12 +148,14 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
                 required_clk_rate = DIV_ROUND_UP_ULL((NSEC_PER_SEC << PWM_DUTY_WIDTH),
                                                      period_ns);
  
-               err = dev_pm_opp_set_rate(pc->dev, required_clk_rate);
-               if (err < 0)
-                       return -EINVAL;
-
-               /* Store the new rate for further references */
-               pc->clk_rate = clk_get_rate(pc->clk);
+               if (required_clk_rate <= clk_round_rate(pc->clk, required_clk_rate)) {
+                       err = dev_pm_opp_set_rate(pc->dev, required_clk_rate);
+                       if (err < 0)
+                               return -EINVAL;
+
+                       /* Store the new rate for further references */
+                       pc->clk_rate = clk_get_rate(pc->clk);
+               }
         }

Jon

-- 
nvpublic
