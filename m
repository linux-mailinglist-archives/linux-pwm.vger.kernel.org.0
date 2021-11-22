Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2A6459400
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Nov 2021 18:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbhKVRfi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Nov 2021 12:35:38 -0500
Received: from mail-db8eur05on2046.outbound.protection.outlook.com ([40.107.20.46]:34784
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240239AbhKVRff (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 22 Nov 2021 12:35:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCtdMDzz/uAmVzex94AikjGyYhZkV/UnHSHV4/7fa3KQKf46znMdy4RFo0QrZNg0LXUJOPaJfb86ln+TrXykTxRQhO5xeO5e9REVavOeqA1Cv0fWdyEDd/fO4prdjeLY1fQk+Ww1IQ5Ih/wAtXVtTHC+UCHU+ZDrTZzab/KN1ND045whw6aqWe94aOwDZkTAJdd/TTvIgjU4QNyNktdgvpe0r+lP6kX1Q9ygNRRAwWYGbav5V7JNhu98SQa1jckTr6qJVgop8r0fgTrZ12LNsSARNhVE457SDe+fysOOIqSVRlHVUZx4nx5ngvx7Bj6dTpEUHDDMWdQHfCmDyY7UWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga1IijzoymGiazjaf5TR6DYKT3cSwWczKnXwcYoy6Kc=;
 b=OWhCWqjpTgUHLK+gjeW9Ca2WsbwEGIQ2aEWemdTRwWK1J7UHtmjfNT3LX08fPFs1yo84vOGZoosaJRr5pLL6EgUbn3HuAvO/53rjTLTKuatBA90NZzUVIxrWMQYI9fd7cI+7T7p/1p+dMedmxNrig0DctfXsHsq8u9g6J4qtmMrCwooDVBLxj5nQF3Cl2j6eEazzAlzgu5tGRVsdqHNhpzsSWRSGor/N73q3DbKpIpo9CUgQY+I75reL3LrWueFhqsyWq+HVDWu+cJI8K+19RvaFdG/bD8HKXmywlf9jCd2w+t9OkeGMWqxTgnhnCvrONLIgqqpu+dTN9Qd3U1c/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga1IijzoymGiazjaf5TR6DYKT3cSwWczKnXwcYoy6Kc=;
 b=l2tWEsiBvQfmtRrxMGvzlkUpl9DYebtEMdJ1Zbjshrzm6UDScOVjxuWPUf5OSXB0rBPUvFvxugxs7Z6iyuVzG+82nryvOJZRdktFiBGgl40rQGLVzNdSyxQdXlpMfYYOqVmnRj2twqJiMjqdxibGiOKs4cRutITPijUETsXFq9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (20.176.234.91) by
 DB6PR0302MB2822.eurprd03.prod.outlook.com (10.171.74.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.24; Mon, 22 Nov 2021 17:32:26 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9093:a60b:46b7:32ee]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9093:a60b:46b7:32ee%4]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 17:32:25 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v10 3/3] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com
References: <20211112185504.1921780-1-sean.anderson@seco.com>
 <20211112185504.1921780-3-sean.anderson@seco.com>
 <20211118092813.xhulsyy5l36ukngw@pengutronix.de>
 <e826e68c-d725-79ef-2140-365383eaf0e0@seco.com>
 <20211119084351.hhk4omumje45hpge@pengutronix.de>
Message-ID: <94175b6c-bda0-08ce-85be-0164eabcb477@seco.com>
Date:   Mon, 22 Nov 2021 12:32:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20211119084351.hhk4omumje45hpge@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0104.namprd02.prod.outlook.com
 (2603:10b6:208:51::45) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from [172.27.1.65] (50.195.82.171) by BL0PR02CA0104.namprd02.prod.outlook.com (2603:10b6:208:51::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend Transport; Mon, 22 Nov 2021 17:32:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bbc8034-bb6d-4c73-7aaa-08d9adde0cac
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2822:
X-Microsoft-Antispam-PRVS: <DB6PR0302MB28222B79806F59AA6A309CE3969F9@DB6PR0302MB2822.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPBUY8bPinzw0KR0/YZS10bjOcPOnzIJ95If6aUr9m/30jNDVxhqaIejBGSCjil7BAneevoJTd+JlFsmhLtvXNqWPdyWCcv8tGQ3BadlGUQ89vtliElnxleW92unhifzLZDQEPunymrjW+t9m+/e7PzN0UWUxmPub1U8MlNiGC/JoeSOirJFJhtjX6p8/7Gjz3UCHJviJkg3q8O0UpQqh3zGUaulexQaqyi+Yk4g4H2a77w9WgrdcHiK2R1GsAtlesSZ9RgowEzJkh4atOjyeSXRJIW96FZtqTVOwkeG07ZOtlnR7RjGhc7zCF4bUBKi78fWks63RbE3WN/mJpnmu8cjXgsu/o8CYMlOODf17p7Jtouz8cAPBr4XjEd/PMmDjJ/SG5bmLSJ5915ex1f9LP8//0uYdzxQO8E14TlYpwRBNuS8TQcZRQ/KNAWdGz48V+ZK1JP06+4hl/iVBhQQ5sarIMVDdsDMI2GzDDyBqAj116nMvUfluOB5vFc2ZTLcfsslyyZYgRoaRqDBDYPVsBHm5xLU5l/soYlOvcigGmGURRuzRt3bTm/znLF3UISh5RX/l1gyYHNR+ahDUDI6buVpwD0A/g4mxS67AcDGbDmhpFIiQmIZqqy1C60Gev5SNIeDEGd2vFz4XzR6d8oHCW2EIGTgaEJ4XZNSPH0EmlRYPV8C8g7dRMrHKXC1f6me8kDUsBBEtTf/5fU+v6Z40QCzMxCKmhqQqCRaISfcagR4lvPWCXsS6Nnc81+rnlnteZy3DLJxvT1ApwQxnQ0poRVn/+yeqIqfszyXpH2rL4egHEur/prtQ8IaRSloNqYKHZ/xUxeFjACz1l88DYbBi0KU36mOoZmOsc18J6uQk/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(86362001)(66556008)(16576012)(956004)(53546011)(2616005)(36756003)(508600001)(66476007)(6486002)(66946007)(38350700002)(38100700002)(2906002)(26005)(31696002)(52116002)(83380400001)(966005)(6666004)(44832011)(316002)(8676002)(5660300002)(186003)(6916009)(66574015)(54906003)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzE1L1M2M2x6N3RKM2ZTbTRxc00wN2lFQStYQjVrVGlRMVFiYkg3Z0ppUFBH?=
 =?utf-8?B?ZUJnYTQ4MXJGTW1RWDdqQkRKTlkxSUx2MC90Y25GZHVWdEpESGtEZy91NlNq?=
 =?utf-8?B?SU9SM2ZtUmN6aEE3TlQzTlBCOVlSbGRaWjNJZldzbEdJNDJNMFJiNzhNcXZv?=
 =?utf-8?B?MG1OVDZBZ2J4Q1VlcGtibkJ2b1lCenBYSm94QWwzQ3Q5WVZZenRvVjAybTJH?=
 =?utf-8?B?YmJPZUppZXovcmlmVjYvSW11VEU2Y0JFMmxvTHBnMWpOZmVLYjFOd2N3MGIz?=
 =?utf-8?B?Nm9PR3dMemFnbS9iNnNsczNkamVBV2dTZjRTSmdBcmF1bUhWNFoxd1hDeThm?=
 =?utf-8?B?UndYUVNtMURHTkU2eitvY3dSVnpwUVFLazFQN1RLRmRmajNOUkdJYmYwbmtz?=
 =?utf-8?B?a1dvT1podTVLU3VyUTBISGt0RkNKQmlGSUVwMWlzKytENFFGNUxBSnYwNDJx?=
 =?utf-8?B?aGQ0TWE3YklBSW9weEhQbFVNUi9CMVBrbTVVTUhCSSs3cVlabm93bXhzRmRs?=
 =?utf-8?B?N0pKREpEV0p2TERpZGE2OG51ZkhaYy9icSt1VFZRZW4vSnBOUnZZemdCeWFw?=
 =?utf-8?B?amx6SWl0bGh2REVxVjdjK3VlOXBlV0tDTXhPRFdGZ3p1ZzJ4RENXcGtqSVlt?=
 =?utf-8?B?NDdJb0dSRFhLYUhINm80Smt3Q3dBK0paUnloSEpaMnllT0lJZ2pKM2ZPeTBZ?=
 =?utf-8?B?VVZreURMcDNJWVVsR0FCck1uRHZLNFNzMDdocmErUWg2eDhtaURXRktJYXhm?=
 =?utf-8?B?UXdnLzhhWjVnMlBHMmQ5RHlkeTh1Z3A1WU41d1k4eGJHNWxQMUh6a1NjdkZv?=
 =?utf-8?B?UEszNDZsTkh2aExjbngvZ2ZyTGRjSklXQnVxczgybkpqdnkzSEdvVFNpcHgx?=
 =?utf-8?B?UnE3THcyek5mVnJ6UEhWRFlnU1BGNTF2Y1FNR0JWS3VpNnZsUEIvRGVPcDRR?=
 =?utf-8?B?NWVieUVGWkhhY3NxRjlHZGFUTzRuWnVLNWtIdzJYYWtBREVNQmNyZ0gvcG40?=
 =?utf-8?B?N2pGOXUyVGR4T2lMMDlMb2x1SE9tQ2ovbVZDa3J6ZExUMHFYYVMvbUo0TGVY?=
 =?utf-8?B?bkhzSmJWUHN5d3h3UDBkMElxMDRDM1QwVDZ4aGlwUm1waVRkMUk3Mm5YYUg1?=
 =?utf-8?B?bVZ5aFRmSi95TURPbktkTzc5cmNYWkhXdXBRcFNaTDdqUGlqc1VkcHlaWGFO?=
 =?utf-8?B?V2tvWWlKUTRwT1Q5ZDdDczVHRXhLYTJCTHdYWVZtNms4RngvMU95Smd2WldZ?=
 =?utf-8?B?am1qb2dMRGkrMzdUMVg2ZmIrR3ZtMEkra3hhbkYraDVvYWxycjI4V1BkS3RL?=
 =?utf-8?B?aEQydENmWW41QlhqT0xzNGpRdHMyM2l4dmNpbllES1RTeUhEbVA5NHNnK1hZ?=
 =?utf-8?B?MXdMQUU2Z1RFSWVqRnNWcXkxNlRyT3QrdFlkZXhXMW1MSTVNUjdFc3BkTXFL?=
 =?utf-8?B?Q0pXaE94YkZoY01qdHZIcGFka2dseTMyK09FL1VCbXl5Q1NBWFdTdktSRUFt?=
 =?utf-8?B?M3FRdzdHYUpqNlRldS9yNGpUSUptOUJ2Q2xtVWQyOEdLa3NzL3BIclVLZ2tj?=
 =?utf-8?B?TzJFUXgyMVFYTTlET0xuV0xGVUpvMjI0aWxrb1FCTERoNlMza0VWU3ZnbWpD?=
 =?utf-8?B?TVVvWEtTbTRNdkpjK0ppNmVTeTdoNzZlOFQrZVBIQ3daOTA4TlRCa3RWelVB?=
 =?utf-8?B?NEhtVkk1ZGh6S2lITkxwbWlrTHZVdkI1NHEyVnVqbEM5Vjg2UFV1eTZWYWVB?=
 =?utf-8?B?TWtEbzJVR2xPK3VvZC9oUFM0TXNaNTFFUVJzWVhPL3k0U0tEQkF3bFVNajUz?=
 =?utf-8?B?dUtPQUc3VjM2NXJmRjBTNFlIMTF3aTIveUY2ZWRTaThvRVZkenRkV0V4c0lx?=
 =?utf-8?B?aUxUbXFxSzRmaFdXdWJwcmorZ1d3bDAwejdzK2tRelYrZEtnMVBKUGhuVUFq?=
 =?utf-8?B?RVZjbVl1RUVRT1hXcDFnUTg0RDMrdm44bkNjbDA5VytCTlZoMVlQenVydGpI?=
 =?utf-8?B?VmJqUnpoY1Q0QkVhZHRhL0NSeWJ3eDNSclNzY0YzL1ZFc25BT29yOW8ycHlk?=
 =?utf-8?B?Rld1RU80UmlUVkdrc1RLTzV3WHRVK3daR1ZJVEdKT3VqaHJhaGFwUjZuZG5X?=
 =?utf-8?B?R0xVeWFNaWlpZ0VhOFEvY2xEbzVhakc3N3EwRWpnNHBnV1pKNG9ESEhnVVZR?=
 =?utf-8?Q?WpOE5RyG+scc+adqkPpYWfM=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbc8034-bb6d-4c73-7aaa-08d9adde0cac
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 17:32:25.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2VwwMgCR4ljRxQxgFQB4InsofImHkimdq5XuUXRGlKz9WRrWuZAfPfkLjVq4nPB20FYlcZm6mTzHI7K9w42Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2822
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 11/19/21 3:43 AM, Uwe Kleine-König wrote:
> Hello Sean,
>
> On Thu, Nov 18, 2021 at 04:08:45PM -0500, Sean Anderson wrote:
>> On 11/18/21 4:28 AM, Uwe Kleine-König wrote:
>> > On Fri, Nov 12, 2021 at 01:55:04PM -0500, Sean Anderson wrote:
>> > > [...]
>> > > +	/* cycles has a max of 2^32 + 2 */
>> > > +	return DIV64_U64_ROUND_CLOSEST(cycles * NSEC_PER_SEC,
>> > > +				       clk_get_rate(priv->clk));
>> >
>> > Please round up here.
>>
>> Please document the correct rounding mode you expect. The last time we
>> discussed this (3 months ago), you only said that rounding down was
>> incorrect...
>
> I think you refer to
> https://lore.kernel.org/linux-pwm/20210817180407.ru4prwu344dxpynu@pengutronix.de
> here, right? I agree that I could have been a bit more explicit here.
>
> .apply should first round down .period to the next achievable setting
> and then .duty_cycle should be round down to the next achievable setting
> (in combination with the chosen period).
>
> To get .apply ∘ .get_state idempotent (i.e. if I apply the result from
> get_state there are no changes), .get_state has to round up.
>
> After our longer discussion about v4 I would have expected that this was
> already obvious. There you wrote[1]:
>
>> * The apply_state function shall only round the requested period down, and
>>    may do so by no more than one unit cycle. If the requested period is
>>    unrepresentable by the PWM, the apply_state function shall return
>>    -ERANGE.
>> * The apply_state function shall only round the requested duty cycle
>>    down. The apply_state function shall not return an error unless there
>>    is no duty cycle less than the requested duty cycle which is
>>    representable by the PWM.
>> * After applying a state returned by round_state with apply_state,
>>    get_state must return that state.
>
> The requirement to round up is a direct consequence of these three
> points, which I confirmed (apart from some wording issues).
>
> [1] https://lore.kernel.org/linux-pwm/ddd2ad0c-1dff-c437-17a6-4c7be72c2fce@seco.com

Ok, will fix. But again, a little something in
Documentation/driver-api/pwm.rst would help a lot.

>> > > +	period_cycles = min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
>> > > +	period_cycles = mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
>> > > +	if (period_cycles < 2 || period_cycles - 2 > priv->max)
>> > > +		return -ERANGE;
>> >
>> > if period_cycles - 2 > priv->max the right reaction is to do
>> >
>> > 	period_cycles = priv->max + 2
>>
>> It has been 5 months since we last talked about this, and yet you have
>> not submitted any patches for a "pwm_round_rate" function. Forgive me if
>> I am reticent to implement forward compatibility for an API which shows
>> no signs of appearing.
>
> This requirement is not only for round_state. It's also to get some
> common behaviour for at least new drivers. The primary goal here is to
> make the result for pwm_apply more predictable.

The behavior you specify is *not* common. No drivers currently round in
the manner you specify here. In fact, returning -ERANGE or -EINVAL is
far more common than attempting to handle this case. If you would like
new drivers to use a new algorithm, I suggest first converting existing
drivers. I think it is unreasonable to hold new drivers to a standard
which no existing driver is held to.

>> > > +static int xilinx_timer_probe(struct platform_device *pdev)
>> > > +{
>> > > +	int ret;
>> > > +	struct device *dev = &pdev->dev;
>> > > +	struct device_node *np = dev->of_node;
>> > > +	struct xilinx_timer_priv *priv;
>> > > +	struct xilinx_pwm_device *pwm;
>> >
>> > The name "pwm" is usually reserved for struct pwm_device pointers. A
>> > typical name for this would be xlnxpwm or ddata.
>>
>> I suppose. However, no variables of struct pwm_device are used in
>> this driver.
>
> Still it provokes wrong expectations when reading
>
> 	platform_set_drvdata(pdev, pwm);
>
> in a pwm driver.

The second most common use of this function in drivers/pwm is the above usage.

$ git grep -h platform_set_drvdata v5.15 drivers/pwm/ | sort | uniq -c | sort -n
       1 	platform_set_drvdata(pdev, atmel_pwm);
       1 	platform_set_drvdata(pdev, bpc);
       1 	platform_set_drvdata(pdev, ddata);
       1 	platform_set_drvdata(pdev, ec_pwm);
       1 	platform_set_drvdata(pdev, fpc);
       1 	platform_set_drvdata(pdev, ip);
       1 	platform_set_drvdata(pdev, lpc18xx_pwm);
       1 	platform_set_drvdata(pdev, lpwm);
       1 	platform_set_drvdata(pdev, mdp);
       1 	platform_set_drvdata(pdev, omap);
       1 	platform_set_drvdata(pdev, p);
       1 	platform_set_drvdata(pdev, pwm_chip);
       1 	platform_set_drvdata(pdev, rcar_pwm);
       1 	platform_set_drvdata(pdev, spc);
       1 	platform_set_drvdata(pdev, tcbpwm);
       1 	platform_set_drvdata(pdev, tpm);
       1 	platform_set_drvdata(pdev, tpu);
       3 	platform_set_drvdata(pdev, chip);
       3 	platform_set_drvdata(pdev, priv);
       4 	platform_set_drvdata(pdev, pwm);
       6 	platform_set_drvdata(pdev, pc);

With other contenders being "pc", "chip", "pwm_chip", and "p". This used
to be more common, but several examples have been converted to
devm_pwmchip_add. To say that such a variable (used once!) "provokes the
wrong expectations" would be to have expectations misaligned with the
corpus of existing drivers.

>> > > +	u32 pwm_cells, one_timer, width;
>> > > +	void __iomem *regs;
>> > > +
>> > > +	ret = of_property_read_u32(np, "#pwm-cells", &pwm_cells);
>> > > +	if (ret == -EINVAL)
>> > > +		return -ENODEV;
>> >
>> > A comment about why this is done would be great.
>>
>> OK. How about:
>>
>> /* If there are no #pwm-cells, this binding is for a timer and not a PWM */
>
> Fine. Does that mean the timer driver won't bind in the presence of the
> #pwm-cells property, and the timer driver uses the same compatible?
> Sounds a bit strange to me.

Correct. See below.

>> > > +	/*
>> > > +	 * The polarity of the generate outputs must be active high for PWM
>> >
>> > s/generate/generated/
>>
>> The signals I am referring to are called "GenerateOut0" and
>> "GenerateOut1".
>
> Then maybe:
>
> 	The polarity of the outputs "GenerateOut0" and "GenerateOut1"
> 	...
>
> ?

The exact wording of the configuration option is

> Active state of Generate Out signal

with a drop-down to select between "Active High" and "Active Low". So
the most exact way to specify this would be

	The polarity of the Generate Out signals must be...

>> > > +static struct platform_driver xilinx_timer_driver = {
>> > > +	.probe = xilinx_timer_probe,
>> > > +	.remove = xilinx_timer_remove,
>> > > +	.driver = {
>> > > +		.name = "xilinx-timer",
>> >
>> > Doesn't this give a wrong impression as this is a PWM driver, not a
>> > timer driver?
>
> This directly relates to the fact that the timer driver and the pwm
> driver (seem to) bind on the same compatible as already mentioned above.
> The dt people didn't agree to this yet, did they?

Rob Herring has acked the binding. And switching based on the presence
of #pwm-cells was his idea in the first place:

> If a PWM, perhaps you want a '#pwm-cells' property which can serve as
> the hint to configure as a PWM.

As I understand it, the compatible should be the same if the hardware is
the same. Ideally, this sort of thing would be configurable by userspace
at runtime, but timers get probed so early that we have to use something
in the devicetree.

[1] https://lore.kernel.org/linux-pwm/20210513021631.GA878860@robh.at.kernel.org/

>> Perhaps. Though this is the PWM driver for the Xilinx AXI timer, not the
>> Xilinx AXI PWM.
>
> I would be happier with "xilinx-timer-pwm" then.

I've changed it to "xilinx_pwm".

--Sean
