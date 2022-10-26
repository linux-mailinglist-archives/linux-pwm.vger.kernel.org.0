Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8216260DEB7
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Oct 2022 12:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiJZKOv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Oct 2022 06:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiJZKOt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Oct 2022 06:14:49 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24A113F82;
        Wed, 26 Oct 2022 03:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLE6xf07p64ef600IutEA1/8v/B2ysNd4GZeVPmYmIKYXOredzQstCVYON1yYbrbj6ZViKeHqI/R9rTGTbRdDG41LXd6Z65jadVAWcD/4pla0mYw6WIDdGUDeFd3YzyzSLDGWi1Z2XD+91GnFP0uwSg/vDuNcVIf0kCiIR6jEMFL9irYaiydt7JOEG6tPl31CojmYc/iAlMw5QHnLaW8C7pv6J58nqvsDNQjszGDPMpBX8rnckoFbxp3A+1sSr049zGo/Zg1+2ZzbWOLvd94MUSVqD0XfMYWNn0hukIbDwAqA1yfrS7NXz+ECJbzkg6bdPAVnEWjP94k7FwA8Lby2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7yglESBBIgFmgFfkP/CsRVU7D9Q2PGs89exNSGb+DE=;
 b=O0gNLQ/NOe6VKIS6QEBeYWSXk8NTEArYsOgRWiatn/VWKkAakDM+rOIzW7eHK0gcmWyNF/CEZOX0hiaC2X/JqD7bBQTG0efFsUjru2erDKji+2VUKNVNokwuxA+Sz/6LZe4rMUpkc07vB17cMN0LXok8HXsppj4mbbnCnmojKJJVeo6Eezkfl+m6wpoedOCu5bKhEERSSZfJDdVeeze/wN8aGTjYxw1hJ24W4/CPLdlbKLHFlmwq1RJb57Te9LKHaX6vwlISPOEC7rBduJs1fHpxDkmoGUu5zQlUjfLMxNp4+J0uhfOWRpy45iAompJZMV5FaTeZonmDSYXDQ2v7GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7yglESBBIgFmgFfkP/CsRVU7D9Q2PGs89exNSGb+DE=;
 b=EvmYL/wu8RsURd2weqhoSULLT6w4uMegnhy/Ox+MXrmaRU1wPHJQqOr+HBcaqk43fnUo3mSNhGDJBXp/XBlstjIszHJN37jsyMLnvuoMjmO55V4nk8OPs0gnqo0hUfy+YiblzMHDe3oT14w1bIryAOPb7V7qq3p8L9l7OvBRm5fVZ4V34wWODlX0qVMVnC2gAp/3bPRbXzLPZ1Xq1M9xZNNqk3+OBD3oxjlLLlyJ+OkEZejxigizhwtUdVq9LgGAJ5QEmUSwU9UiPmHMNEdj2BjR00zTkuycyl7R+I/VQ9vK+W3fx5S3psTW4fsG7/XJE4cphdMd4ya5pEcxCY94UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 10:14:45 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%6]) with mapi id 15.20.5746.023; Wed, 26 Oct 2022
 10:14:45 +0000
Message-ID: <3afb5c9d-f37d-2c52-043f-54e8c278b30e@nvidia.com>
Date:   Wed, 26 Oct 2022 11:14:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] pwm: tegra: Optimize period calculation
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-tegra@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
References: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
 <a0b92a81-71f7-ea14-e887-4486a398b709@nvidia.com>
 <20221026001016.4cm4kbhfzdsmb4rq@pengutronix.de>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221026001016.4cm4kbhfzdsmb4rq@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0179.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::22) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: a380da60-c463-45fb-b553-08dab73ae7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Ig040ztSJmNeFTswl5alDDSMv+NGaOICSvoPpNAWW63QWnSUB0EGqF1wlt443OW9H01TnwzOYR+3oImeHN0masxSYTjNNbWr+k8JrVgc1twoBVBJOk89nyoLAGNDNRpLXXNnvylGR4eFLjcF9tVncXzuqaUeDnOs9mNO7zbIPlUGU3Xd72FJZg9ibitPdnSbPz5nQMPdq18BHF0wRhEe4YOMtnhdJhz5j9ZvW+WhoDPcE8F4ZWrhJS69V6XjabXJdSSC0XMeaX2ItFj5P2zkMwGKj5W6qG7rF/xn/36A9aHp7ai81DRHRLPBDCMYup/7Qne4d4cwPJ+q+l6JbCBAaHo0iZf2RstCiEtuGvDgU1Rp9J882JmB8Y6sVVMk6AFJivCOcvOZT8y7HHg8smhTZqZaDz/kJ55q9uEohzl6eOjPJIga40R6VaVhDehHk2u1MhhS7KhtvxPguHW5k/cbKcSQbAK1Rxv97J8JFPqDDEgGH1NO6jel57zkHGiGDPxBVn5VYSvml3fuGUHbmIrYKVeBBxQLQl0GGdJxakTFg2A3D9dFotMQDP0tl77JAdASc9vIZAEVBGMH5ynKZ35NU514xuurNJFORnNYY2h8+C84IPmGjgHM+G0Q8/v6HOGmESfWAgLbYDEXioljw6H/rLcpWekYiIyhslr2LZN95DrhLkPQ1ZwGobHLD6pfgrw3kpw1R6P+YwkKFzFx0ZA82CiYOp9h3/wqOmWibDCazCsrDebtMVbTzfKVGg2n+d7vHwYeQjvbNbjxBSkzPyfXiQe0JwT6k73819s5b2E2uM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199015)(186003)(2906002)(83380400001)(31686004)(41300700001)(86362001)(6506007)(53546011)(4326008)(8676002)(31696002)(36756003)(66574015)(6512007)(54906003)(66946007)(66476007)(5660300002)(6916009)(316002)(6666004)(2616005)(8936002)(6486002)(38100700002)(478600001)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmwzdkRJek5IYkY3QWFoNzBDeXNCbm9mOE8yTytzMk9qd1NDTHlhZ2QwMFc4?=
 =?utf-8?B?bHh5Q3E5VUM5dUtXajlpS0dZb2R6SHdpZnh3WmdGdTRJdzFJNnJFZlpNellr?=
 =?utf-8?B?SjNrNFlaejdXOEFBdmpUU2xQZ0t5MS9XR1l5VlpNTmRJdWx1TjU5QWtlN3dP?=
 =?utf-8?B?Tm1uYVBBMXpGdjgwb21GSFhaTURYWVdBMVNBSkpnK2ZxNTB6aCtmblNmK2xK?=
 =?utf-8?B?dEd0Y1FlcFhZeWtLTzRmSkltVEZCZDVBSTJzOVJjUlJaNkhuZFdvZmEzUFBz?=
 =?utf-8?B?alZ5VlgyQzdTbWNBclBsSUY5Mmk0TGVuMzYya2Vic3l4UENwU1pRcTE2YUdq?=
 =?utf-8?B?YURtRUNXck9tY291YW8wVkhBbS9jRFcyL1VsNDVtSmdtMVBhQ3ZnTDQ2bjV2?=
 =?utf-8?B?cDJxQUVTY3FFWGcrNDU1T3NUWmpJVFFBNjAya29LbVdJYU1uaW9MZk9Qdi9K?=
 =?utf-8?B?Y2krcDF4NlpQdUdMWFFYcS9KMSs4UWE0QjdVSTc1eUJ4cHY1Y3BPWUZVQVZN?=
 =?utf-8?B?YkFDOWlaTGR0Z0thVDBPRUpqREQ5cFFhaUVFOXBvS3dFQlg4VGw1d1pieUVF?=
 =?utf-8?B?RUZjZDlSeCsxVTY5aUcyZWc0cTRhbkZiUEE4WFpNdnZyQWRLT2crQnNqYjNh?=
 =?utf-8?B?L2F3OElFUlUwMGhJallJNDNKSVJyUzhTUjBqUUhDdS95aDRyUi9DdzhXWEJv?=
 =?utf-8?B?KytyblFSYlIvamZNMzRaWkY1MHlaMlhTMVF4VWlVNk82N1Bqekw4ZS8xU3NJ?=
 =?utf-8?B?MXk1ejVjTXhUYUFoZGxXMHRqTFVTNFZxUEwzWllEdHU4d29KU09pM1h3c0Uw?=
 =?utf-8?B?NVpUc2JlOHQvZVozSmp0ZXBKRjB6dC80Y3JIdG8yYmhBakc2Mk9xbkxRYU84?=
 =?utf-8?B?V2RVSlhWSnAzc1dUaEpCZGl3NXFjTlk5aHBrb2JBbW9uSU1hYUQ5bi92SDlG?=
 =?utf-8?B?aUpkdlZvK0pVSFpvaGFtUGR4NFhsL080SWo2U1Q1ek0ydnh4NE9VVDBUVGti?=
 =?utf-8?B?YUY3SGxaaEJpT2wwTzVkOGhjVy9aRzZZU3FZU3dhYitEUHl3UDlVNlNJckF4?=
 =?utf-8?B?bU5FSW1wamFSK1cyK1JSeWtxZm9JQ096ZjhPblB0Y0hMZzdLYTQ1Z0t0OUFX?=
 =?utf-8?B?WURqbkdZaUpOZVNaQ3dTOHc1ZCsxOEhvTXVzZVFacWt1R0dWQkdLeTkzOEtB?=
 =?utf-8?B?eFl0NEVaTEdIZDBuOHk1bDRranpPWGppa2p6VUlxamMzSGFyTDhFUFlQQ0tM?=
 =?utf-8?B?WG9HRXpyUU92bXFVdG5tbEEyRHFNMjAreTl4RlFQVUN4NE81dE1sbG1oQW16?=
 =?utf-8?B?S3FzTFNMbzYvSm9DY0NHU1plK2ZKc2dvYU9YUGxDMkN0QXFtRm9uc1ZLR3VG?=
 =?utf-8?B?cDRqWjNGT3o0TlV1alYzcks4RXdhQndNTEp1T1hZKzNXNXB3cUJEQ25PNTlu?=
 =?utf-8?B?aklUYnBOcGR2Sk5LM0JiSFFqeHBFcTk0c1I4M05QSTZzOGl2dDF6bEhzc2pT?=
 =?utf-8?B?VE5jK1d5eXo2bTBySnE3V2ZQUXhRNTgzd3BIWFpER3hIUFhRTjgxa0JkQWY1?=
 =?utf-8?B?TkZ4OGJSbVZCamZWLzRqK2x0anRHWHlkMHRtUm9DTU1xVjMzMHJzdDZUMzlL?=
 =?utf-8?B?SkRyS2FCejFONHArYkd2VUVtUStnaGtDUTFOQm00SmhJcXlzd0FvbS9qVndn?=
 =?utf-8?B?S3ZwRFBzN1dkemlycHZqdnlXYlBaZnZEQmxROGxPWTB2NVNWV3B2MHdPc2VN?=
 =?utf-8?B?OXJQenlyTTBrVHppWGRiRjA3b2pMUWF0WVdsc1NyamZWcEpPQ2crNkpmQVBy?=
 =?utf-8?B?YUJqeGp6bGdrcFdtZmtMcVM2NmZISDd4aEdUc01zQWNCWGkzcHlwOVlyMllB?=
 =?utf-8?B?TzBHa2kwcm02TkoxV2x0am1GU1JkV25pYmVqTnFIK3NCeVBtdHZYenpITEhW?=
 =?utf-8?B?czNYT2lnd3czbklQUHpoZ0o0U05mK1NISGd2UmJtdzg3amJnYTNBYUNWQTlL?=
 =?utf-8?B?ZHJ2c1VvQXJqS3BDQ2hjeUtGak5yTTBRVWFrc0JCaHU0NFdId3JGaWprRE9P?=
 =?utf-8?B?SmRMakI3RXVybzZmVHRFcnh0Z0FjRUxBZERQaDc0bDhOMlFOZk0rcWF6MExt?=
 =?utf-8?B?Z1N3eklwRG43Mk5JbHA0QzhaOHcwQ1FEYmJ2UFRFSUxPVXkvNzNRQ1Rib2F1?=
 =?utf-8?B?MHZWS29uWHUvUm1BSTEwWUZOZnBUZjZDdE8wejEvcHZKWGwrdW91SkVpNjE1?=
 =?utf-8?B?d2hDcXlFZUIzSk9XdHM5Z1JoOEF3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a380da60-c463-45fb-b553-08dab73ae7fe
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 10:14:45.7218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lct3qzu+JRE9wWyA+Lc5Hl3QPhhnGr9aAJv1ed73SlSSWDlZ+MOUlUJOqKEzb83fe9PkstguzN5d5UFYc+zhOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On 26/10/2022 01:10, Uwe Kleine-König wrote:

...

>> 2. Even after fixing issue #1, above, I then ran into another issue
>>     where even if I request a clock rate of 5646975 I still get a lower
>>     clock. This also causes  mul_u64_u64_div_u64() to return 0 and then I
>>     see the -EINVAL returned. The simple solution here is to not return
>>     -EINVAL for 0. After all 0, could be valid if the rate if we are
>>     not dividing down the parent clock in the PWM. However, then there is
> 
> As you have to subtract 1 from the result of the division, you need to
> write a -1 in the register which doesn't work. Writing a 0 results in a
> bigger period than requested which is the thing I intended to fix with
> the blamed commit.
> 
> If clk_rate was 5646976 (don't know if that matches as nicely as it
> should? If dev_pm_opp_set_rate might set a lower rate you're out of luck
> again) we get:
> 
> 	rate = mul_u64_u64_div_u64(5646976, 45334, 1000000000 << 8)
> 
> which is 1 and everything is fine.
> 
> Note that the math before my commit already had that problem. Before the
> driver was just more lax and didn't subtract 1 from rate and so
> configured a bigger period than requested/expected
> 
> There are probably similar cases where the driver still configures a too
> big period (i.e. when the effect you described yields a rate that is too
> small but bigger than 0).
> 
> So the optimal way to fix this is to adapt the calculation of
> required_clk_rate as you suggested + rounding up and to make sure that
> dev_pm_opp_set_rate doesn't configure a rate lower than requested. The
> latter might be complicated as the API (AFAIK) isn't specific about
> rounding directions and there isn't a dev_pm_opp_round_rate function.
> 
> As a short term work-around dropping the -EINVAL is probably best, I'd
> like to have it documented clearly however that continuing in that case
> is wrong and yields unexpected settings.

I have done a bit more testing today and sent out a couple fixes. I have 
added you to the review. Let me know what you think.

Jon

-- 
nvpublic
