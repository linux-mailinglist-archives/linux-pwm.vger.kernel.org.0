Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267A13EF5EF
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 00:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhHQW5J (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Aug 2021 18:57:09 -0400
Received: from mail-db8eur05on2041.outbound.protection.outlook.com ([40.107.20.41]:54300
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229466AbhHQW5J (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Aug 2021 18:57:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJkNIK3PbQEFd3z+HY0cksosYG3Ogvpi0t4ytgPE1Y/6jdtUw4yGNRp9nLsGJxH/WbClNC2lQXkzaKYvFiRD5/Vvz5TGnUw+sja+CQdYiF63ikdzdVT88V/NW//itTtrt3tgIAO76BrY7JyyH80jUdBzQ4u4oiQ00J2KFpJe5THZ1v51EZdq6HLCl/YJzXvZFeCCaznZQpWVMKxzy0o8K6pFDJWWKE2TzvYRpQqQTA0kvQKFglnizUslfJUxiSIcrQYjwL7dAp1MVMgYF4xVP49yFVxvyGMkCkMnb0ozOJNuFNmODdQHOl+bGpgEjiU+cIruYn5wOvhLhDjl32n3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90ihAGcyUSgnLEHrQUY6AktQITiQj6QC4VFDWQbdwVA=;
 b=Xk7tHzWhA8LUKpsgU1bdTber3wmE/AJKUlllA7bpInxzaHcTXKxuC9clPhrr0hgxmoKDcPFpW2V3ejuT97LSodeddzCCcCgUmneFZbgNrVHFTueeUmC5edo6INfclariEQncEJzYKQbfx6LSOKDAJ1pISCn9WeEu1sjISb+Hm2yVxh/0xNvWMyf/ebj2JZ8jYbT+5Zc4pADVPyOCspOX9A1rv8gbFy0MIt0PRS+nhKB5ehZk+/agwjhETiQuzfOIIoaWDMuaugiV8H/iLdMcwFIxcj94jK7mfaLCIf+NLr9mBz2s26puAfMwHjNwd4Uv7iEF8GW4rb3+Z/wgcdUCrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90ihAGcyUSgnLEHrQUY6AktQITiQj6QC4VFDWQbdwVA=;
 b=Vt7h4SJAmu8cHF7iwEn4pR89MO7vuuF2PGYPhYJMbWQe742ouhAJ/8M40cSA3H/WDyUEOyY5UcuaQOgzPN0P891w+9g9UlFOn8JbLDnolLdxO5dKimwW1anB5w5fYnLEDkyYUEkLk4/w2moyTegO9A6el/GoXXPWVaj/dHhdbT4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4618.eurprd03.prod.outlook.com (2603:10a6:10:18::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Tue, 17 Aug
 2021 22:56:33 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:56:33 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v5 3/3] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        michal.simek@xilinx.com, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210719221322.3723009-1-sean.anderson@seco.com>
 <20210719221322.3723009-3-sean.anderson@seco.com>
 <20210814204710.retjwn5fycwtrypp@pengutronix.de>
 <e8d39f18-3aa9-e617-6439-2c0b071f62b3@seco.com>
 <20210817180407.ru4prwu344dxpynu@pengutronix.de>
Message-ID: <082d39cd-1ce5-344f-3229-3beb7cea0a15@seco.com>
Date:   Tue, 17 Aug 2021 18:56:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210817180407.ru4prwu344dxpynu@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0026.prod.exchangelabs.com
 (2603:10b6:207:18::39) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL0PR0102CA0026.prod.exchangelabs.com (2603:10b6:207:18::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 22:56:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ba3516e-aa42-4cfc-1385-08d961d24256
X-MS-TrafficTypeDiagnostic: DB7PR03MB4618:
X-Microsoft-Antispam-PRVS: <DB7PR03MB46185E8427E5C75A72178F4196FE9@DB7PR03MB4618.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRkkMMu+l2mzZOOW709Po6BAJ7649MTxGvr2mL/W0nOLU5dbpsqXAIsbkZ+pA4mcRn0VvxIVv2Nnz9VF6MfuJZgKbCCUvxniiqtlhO3KwhoA80heQ4DheEqEKQ13eYrjH9ybOsbXlkqUZ2VlKZsV2EYvhrbodnb7H+/9y/vWh8bgTaeQrL6YZjonDqEJW5Pf6GSRuk3bDSkM2k1cUv2KDkwSKqrvh8NDAOEuXxKNHUC4MeQ3ZwcPMNEbUQ44z1lyhQO7HY3EhpBe0I8WMSQMI3Wv/LD4gTK+9MUPCS4huGHOCE7ofXxss+8uFhL8uEh9jSKvC4PWxHnFO9gOMIwcVCJYCqbSUR6u9AX3rZFh/XrCeSrb8Knz7cBui1jAasdhvztMuVPnGkYeNiWhi8sj5G7o+GOmDqUtwMoiVWrHA3L5mnzMmwicnEly6ERpGqaVW2kwmvJUG2QzFMPGQVr0v43hsjn7jhlx9aX7M1i0AmgrVqYWajafjp3MqeyR0J0eGqBZH5KZIwnyrlc712Ww6JaVAAazInjMqvu6/CC43a+n4MLTKlvjoNdlTH2E5KtnLvcVnIA1ynOebsngHza3EppvYzwFoBf3oye270FV2jt2V7G4N8wHFEwIllla82YQSQ+paccvqfNLh8wEvfFS5zKTuqVv/W7udLFwdkZLKQ7IAtTNtMHpaLP2hSK5UTBHL8IF4GWx7Itvn9I6A2a0lL96xxR6xVZR0SPL/thOLjTaSr62xQFRnKWpEm0WeVDg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39840400004)(136003)(366004)(376002)(44832011)(8676002)(53546011)(5660300002)(316002)(16576012)(6916009)(478600001)(52116002)(8936002)(956004)(4326008)(54906003)(2616005)(6486002)(38100700002)(38350700002)(2906002)(31686004)(36756003)(31696002)(86362001)(186003)(66556008)(66476007)(66946007)(6666004)(26005)(66574015)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWgzdnNTMUtuK2F6RktKMG9iZEhhMFMxakwwMmVjS2dsN0VVWGhOYTh2cVk3?=
 =?utf-8?B?QXoyRXJXQ0xaUUsrcXBzaHRoeHA5Vk1rSjh2Q091VTFkSlowV3lIUVhrWEJi?=
 =?utf-8?B?Vmxyd2Q0cENxTVJYZmVTdyt2NkI3QUlYL3pzYmlnZGFLT2RrTnVvR0VabDhV?=
 =?utf-8?B?TUFPVG5ZbUExQkRiQU9GYlhOZkFEUTdDeGo5ZjA3S2M3YmdVRnVvbFQ4cG51?=
 =?utf-8?B?MkFsV0VMTFhvR2xvTm05RWJMelJaZDBJMXR3WCtCQnhrbXB0WmFrdmcvNVF1?=
 =?utf-8?B?TWNFV0llWFg5WXBsVndMMEpTY1NobUw2MXd6K0NhcUw0KzljMCtaZnd5UTRh?=
 =?utf-8?B?Y0U5SE4zM3hZTlNqUkxlV09PWXp2ZVdxYjZFODc5Z2RYVlFldUwwUC9WV2Fr?=
 =?utf-8?B?ckk2OGFOck5rRmN2cjJOcTZqZHcreS9VM1dZYy9Ga2NtMTMwcktnekthc213?=
 =?utf-8?B?bWhzVVd0SEtNd0doYWh2aEVUUkUwK09QZ2l0OGhGYkF1cE5Vb2EvNXNJVHBr?=
 =?utf-8?B?YmIvTGppMThlellxbjFqSXBlY2lCNkMybmk0MXh1VHR4bE1pemtObkxyT0hL?=
 =?utf-8?B?Y0JKTDJJaWFoWEJ5MWVUTktockJEcEQzbENEUWRxcHZLbDd6bHpRQ25XZnJG?=
 =?utf-8?B?TlVpWm9nMjBlVngwN1JFVzVqZXM3YUZYMWMrNlRVT3RGamd3WXRPdkZ2cGNm?=
 =?utf-8?B?YjVuME9vTDFwaWJZSU5kQlFvd056MlVGNGpWVWdyTUpwTTRoRFJOZURIRHhK?=
 =?utf-8?B?bVl5dEl5UUF2REppVzdncVN3Mm9yNzdkd1FidDFJNFpVdTJDU0sxcHZNL29t?=
 =?utf-8?B?MDVKb1JBZUF5UERpd2czNG5jL0hqL1oxbzhqRWE4ZW1YWVdmT2JqalV1S0Zj?=
 =?utf-8?B?cFBnWG5KTWZ3dURUWm56V1l1eEQ3WThkSE5SSkNCYzJ2YktJQ0Fmby90TE9J?=
 =?utf-8?B?bDFUcUlNd3FMaDlvdjRhdlBTTG11MGovTCtUa3gxdFlGZmNlTzM1MERiMHla?=
 =?utf-8?B?eGhRMFFNc0Vpems0bW1Od0p3UnhkT0NFc1NFU0huU011cHJtUXBiU1Q1Rklq?=
 =?utf-8?B?R0dNSkZyMklKNEZvZWUrRXB6K0N3VzRoamh3L1hPQjhMZ1ZJUitzeHJoWTJ4?=
 =?utf-8?B?NUdIeStlS01rUVJmREsvY0prZVFDd0c4TXNEeWlmK1pQSjZqYnk4bzk2MHpY?=
 =?utf-8?B?eDNQVllkOElWRnAxZDlTNzhsZkloZThkNjZ2SGlQckhJUFg3NVoxWENVcWg3?=
 =?utf-8?B?Szl1ZUVIZnB1RDFQMHd3RUIxT1FHMFlmVGc1MXJJTUM2MHB4R1JWQkRoQm1j?=
 =?utf-8?B?NzZtOURxdGRYRkpOZGFDZFp1NW04MW1Pa0xsYmV5dWd3QS9BbG1JbXhNc0VN?=
 =?utf-8?B?eU01TDFqSUZOSnFBalVDRU1lb1hpL0JrendHanQ4akx5c1F5dWFqdlJBMW9U?=
 =?utf-8?B?OVNSMncyRFVNSHhEWkEvZzUvWlpWeGtEa0hiSW52alJ0ditkQjdZak5WVEE4?=
 =?utf-8?B?ZkYvanAxMWFPV0IrekducWd5UlVZUDMwVGRuYkxtbkx0ZW5XcHlFTWVVSDRP?=
 =?utf-8?B?ZWUwWjNPWUFDT1VacTZYc3QwZmYxZzhiZUVKVVJoRkMydTVZLzE0M2IwYlpU?=
 =?utf-8?B?NERnS1Iwdm9BeW1pVm1TZEk0VzJjMlA0MHN3YlZDcStzM09SVVFpdlYyeGVu?=
 =?utf-8?B?Mnp3Vzc5QkFtdEx5Y01KMHY5aGFaWGg4R3AwYUJZdWRRYVFwS0xlMlNiS2lY?=
 =?utf-8?Q?UU3lf9FW12wBYZXOLNYhbNhKkO2Tfel3EC1R2x0?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba3516e-aa42-4cfc-1385-08d961d24256
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:56:33.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4l0GCP3Yyq+anl+6MP9R42IWSqt8/RJL07yNKJfznZ5Fi6G+CcwXEeSv9mFdafMAwLgLoBa2/LQJGDHSzY9ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4618
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 8/17/21 2:04 PM, Uwe Kleine-König wrote:
> On Mon, Aug 16, 2021 at 07:51:17PM -0400, Sean Anderson wrote:
>>
>>
>> On 8/14/21 4:47 PM, Uwe Kleine-König wrote:
>> > Hello Sean,
>> >
>> > sorry for having you let waiting so long. Now here some more feedback:
>> >
>> > On Mon, Jul 19, 2021 at 06:13:22PM -0400, Sean Anderson wrote:
>> > > +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
>> > > +			    const struct pwm_state *state)
>> > > +{
>> > > +	bool enabled;
>> > > +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
>> > > +	u32 tlr0, tlr1, tcsr0, tcsr1;
>> > > +	u64 period_cycles, duty_cycles;
>> > > +	unsigned long rate;
>> > > +
>> > > +	if (state->polarity != PWM_POLARITY_NORMAL)
>> > > +		return -EINVAL;
>> > > +
>> > > +	/*
>> > > +	 * To be representable by TLR, cycles must be between 2 and
>> > > +	 * priv->max + 2. To enforce this we can reduce the duty
>> > > +	 * cycle, but we may not increase it.
>> > > +	 */
>> > > +	rate = clk_get_rate(priv->clk);
>> > > +	period_cycles = mul_u64_u32_div(state->period, rate, NSEC_PER_SEC);
>> >
>> > cool, I didn't know mul_u64_u32_div.
>>
>> I didn't either. Alas, many useful functions like these have no
>> documentation...
>>
>> >
>> > Hmm, we still have a problem here if
>> >
>> > 	state->period * rate > 1000000000 * U64_MAX.
>>
>> Note that this can only occur with rate > 1GHz (and period = U64_MAX).
>> The highest fmax in the datasheet is 300 MHz (on a very expensive FPGA).
>>
>> Maybe it is more prudent to do
>>
>> 	period = min(state->period, ULONG_MAX * NSEC_PER_SEC)
>
> Together with a check for rate being <= 300 MHz to be safe that's fine.

That's what the ULONG_MAX is for; whatever we get back from
clk_get_rate, it has to fit in a ulong.

>
>> I think a period of 136 years is adequate :) This comparison also has
>> the advantage of being against const values.
>
> *nod*
>
>> > > +static void xilinx_pwm_get_state(struct pwm_chip *chip,
>> > > +				 struct pwm_device *unused,
>> > > +				 struct pwm_state *state)
>> > > +{
>> > > +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
>> > > +	u32 tlr0, tlr1, tcsr0, tcsr1;
>> > > +
>> > > +	regmap_read(priv->map, TLR0, &tlr0);
>> > > +	regmap_read(priv->map, TLR1, &tlr1);
>> > > +	regmap_read(priv->map, TCSR0, &tcsr0);
>> > > +	regmap_read(priv->map, TCSR1, &tcsr1);
>> > > +	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
>> >
>> > xilinx_timer_get_period rounds down, this is however wrong for
>> > .get_state().
>>
>> Why is this wrong? I thought get_state should return values which would
>> not be rounded if passed to apply_state.
>
> Consider a PWM that yields a period of π * $regval ns when a certain
> register is programmed with the value $regval.
>
> Consider the HW is programmed with regval = 317. The exact period is
> 995.8848711879644. If now .get_state() rounds down and returns 995 ns and
> you feed that value back into .apply the new regval (assuming round down
> in .apply(), too) this yields regval = 316. If however .get_state()
> rounds up and returns 996, putting this value back into .apply() you get
> the desired 317.

Will fix for v6, but please document this somewhere :)

--Sean
