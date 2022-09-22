Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25C95E60A5
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Sep 2022 13:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIVLN4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Sep 2022 07:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiIVLNs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Sep 2022 07:13:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44B8DE0C5;
        Thu, 22 Sep 2022 04:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyBQzzjZfAp1UWg63GuvLbVqO3fQq/UBSJUF5MaB04k9afYwmIFSWSkdGqXBBEyNlzvlbWf/q4B3zgVP3dhcyPRPrL6wRNm0jOJ4WEq46M0ROCXidyuxxDp/wI4Trpk4CEvSbtyDcjIqkT8kuIkYKUQiISnYFfWvhQC15wh8TMRnr/QGsn/3qV7F4prSCf3h7H1UP7HVAfFbC7/SiPZcKNjV1SS8MEmdG76euWLzeF4iBSafhBwZXaAlnMhB0DXYXQAdFDRGnmymtvAIOnOiNQ/P7x9xSFnmySoEwQQ0kxp8Ns1c/9bMGZTS0dXGcuDCram4ZbdNie1g+hkRbkOJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vObDZoAn1ZTQm+Gasj4W6qC6cndfUy8qsSDXvO2Wd94=;
 b=TIrVc92E5XC5cibFWW53tbAaIlzbTUaUNZJb14c29WbwJrr7eAh1DO8d0siNbZt3EVENmVaqMaiUEUx3MDcIL4yUo2a863SpQ7tK4+HiuAzI60/f5+xsFSqJhXNB0+1fl58SmXYXtRX39JCWBj0j6KxHDc4HpqTYuAse4FsSG9g1AHmlNEOJWX1wtJtwzQGd8qTQRLj4OZg38tQRwihIMjD14f8BQ+P+EKZpzxmLGyM7mC905wq4RYvtPPKRmzMVf1YIJB0k10MOIol3LGQtBXRKV2iUUmA49c5jNEeMmZXpmRrL24pGaSjiijwiHATQuoebyw8ymzEN4VQ4venqqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vObDZoAn1ZTQm+Gasj4W6qC6cndfUy8qsSDXvO2Wd94=;
 b=kkUMsW/u5VcuITaNWfoe62CL9Nuz7vBuFnnCOC7BYqCOazdu7+PRh5WaWvov1BV+vnc3e/QEIWb5TYvs5Bhrrvt0sJQlRmHcVpSUDLr/lbLJxnvnMQucxMsU+aCGl7SoShbb0DbTnpTnHDxJNzWj7Fx8HhDu9y+kIUsQl/pO1dltQRBZK5J2YaPtANS5JCoL8NlzKk6qj929FcKmXCB5DxMV3rPYXWASqYDycBxhVKD0FoTTAMNwPEMoFJM1kZPpMkmNy3YSvv2T630OIGHkvXsuYy0WiTRdhl335RLzKvjfCf3cfGsloQwl5n20c0VWgMy9BE3hTn6c840lQaEfMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 11:12:39 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d%5]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 11:12:39 +0000
Message-ID: <e109b19b-47a6-28b6-3eca-b45720637afe@nvidia.com>
Date:   Thu, 22 Sep 2022 12:12:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] pwm: tegra: Optimize period calculation
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Thomas Graichen <thomas.graichen@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-pwm@vger.kernel.org,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-tegra@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
References: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
 <524ca143-e9d4-2a79-3e9e-c8b9ffc9f513@gmail.com>
 <20220815070935.guqzzlny7f6kcprc@pengutronix.de>
 <20220818075401.wguqvcbhzj5ttnio@pengutronix.de>
 <8ba9431b-b2bf-9fb0-9ba7-afeb2c3bce94@collabora.com>
 <20220921081721.l2bpeokwxy5pwfdh@pengutronix.de>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220921081721.l2bpeokwxy5pwfdh@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0068.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::32) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 9632c7f9-0f81-4e1f-15b6-08da9c8b5c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjZSqhHTx6zGpn9tVaExdrSt3AplSWFEB2zzaiqZthi4FMimAFPBlr6ryM0vCl9bmP8d6ceQUUtV1dSl7y/Ls99BykR71ovEUjx1eqQTW7InscXe+59KzZ110SqvpELVH/XeAzCm4gYckPnPlT7CA3EfgfoFPBGaLSkIwxu9ZsFQnahNwHQKbEnnKmJF3ILqS8z6H4T85XlwNgLVPUtul41k6IyPVRipVQ3t3ikByzq0V1zLkhH83cA7rb11fMX4LdMKr3UNz+tPm8dpM1siWTX7lDfxBae88VqJf9ZWgn1Hj+u8+ZO6FHYhrfF4FOz9XVa1jnYlQS+p9X0tst+pv3If+cHhAC9+F+RTfS9ky8QNMLZpFIjJaRhUDTYWztfN+UE/63CxchHnwtNXSviozMYgYQ4KvF5HSabWWpk0YKzyGYf6qPTfDuoi1bd5IfmiRbU6JYE3C9PQGZAtE4GhXKhwDLy4AvE0/ZXFYARzsRBi6OSh/6+XT3c1AkHqiFE5IL5datyU6m9SooHV9bsTIL/GDP2gr7HmIgsHERoSM+NqG7NItVe2nP0+L61Yng2l78nlT83v7ju6JIA7NP2HjR1cGisEnsYX/0+XYPqS0LIidOzS3hyNf5xLvvCEB0BsoPenmZN5ztG6Kp23IQJC2jtqetYUa+DG4l1Rsb6nrF9x6TiGB3pm//HWDdsKzTHnLi4F1FnzjZXw/J5dg50n+wyLN0UPc9BvpWlTQJt6XDe7W69693nlYuwgwpiPihRkOxJsAgeAxPjG4m1W3DJOndifUUMAHFAyykLE4/tSFVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(31696002)(110136005)(86362001)(54906003)(2616005)(53546011)(36756003)(6506007)(186003)(6666004)(41300700001)(4326008)(66556008)(66946007)(66476007)(8676002)(2906002)(316002)(6512007)(8936002)(31686004)(7416002)(5660300002)(66574015)(38100700002)(6486002)(478600001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlpFUDZEMjRqa2JaV002RG1NVWVDSDZFWWs1aVN3RjF6R094UE5tSk1sTFhN?=
 =?utf-8?B?VzdSZnhxU3A0c1Q5TlFzTVgzY1JvNjhldlhXZWtKcFlsdnZ2Q1N2ZGFWUUpt?=
 =?utf-8?B?WUJVNDJ5QVVIRWUzNVB6UlVJN2tTcWdCZE5ianBFZHlxSUc0cFZGd2tudnJF?=
 =?utf-8?B?MDRsWnFCQTlIV1dTL0trU2JoK1o3dzNIODdJVEZKenB6MnNRRG5zSGpHZ05z?=
 =?utf-8?B?UVdZb25yc3BwRGtxSzdPWjVmeXArSWszMlU1dFM2K1BtMWxmTDFUVDBCRW1D?=
 =?utf-8?B?alVvQ2FCaW1FeURhZEFsK3MwTFg3aHF6ZHZ5cm5ZUFBOai91NWhIRUgyUkg3?=
 =?utf-8?B?bHB6ckVSTFhTcUgwRTVRMkJoN0x2YWJjQ29EMWdZWHR6ajZZNUQ0MCt0Z0dG?=
 =?utf-8?B?M3h1bkJGVkdhaFVBQVJING1NTHNubGNXZ0xRT1pJUjh2MGdNWHRqU0t0ais5?=
 =?utf-8?B?b2c3WVV5NUhtM1hYQVgxaTRuTUl1ajkybTBqUVNBWmN6UUN1VG43UjJXVG9S?=
 =?utf-8?B?aUxWbVpxQ1NZQ2ZDVUZzWkwwVW9aR2IrOHJsZUtWclVndUlNU0FyVi8rN3dr?=
 =?utf-8?B?NHd2UThnbEJHdWV3eDZyR0RzRUd3b2Iya0g2QWRGczR1MzVhSVl0dnZNN3o3?=
 =?utf-8?B?K3NzSTVId3ZXdnJzc2hLQ3NEMEZldXJ4RnppM1Z6eTJ0cGtGY3dJOGpLY1VD?=
 =?utf-8?B?MC9yVGhTby9Fci94c0lacGZqcHZXeXZESHVlZUJiMGtvWWs5bEpaNmZmTmF0?=
 =?utf-8?B?amJ3aU54aVRIcDMzdC9Na1Q5WFR1RzViYzJCTE4xM2VOcHJwVmo2alJUUVNr?=
 =?utf-8?B?WUdBcUtLRHVvcmw3bUhZTENlT0VSM21EVmZnMk9JUnBheGhJKzlYQ1gvQ2F1?=
 =?utf-8?B?eVdYTDBXRGl1NEFkS051V2tIODExM3hzNkt2cE1Od3NVVXlacFJKTzN1YkIy?=
 =?utf-8?B?OXR4cWwzbGgwd254QTJiZTZUY0FueUdXMG51S2VNSmxQZ1NNNUJidU53cnZK?=
 =?utf-8?B?RXNPanZxaUxyRERtOEdjb1ZidTEzQXpYK0JiWXEvaTg0VHN1cXdVVnpldE85?=
 =?utf-8?B?ZWMzWURLNWpiUDh4Q3FNZUM3RXR0czhjNkFOakh6czVrbE84TEtqZ2hLQTdh?=
 =?utf-8?B?YXZ5eGRzTEZ0bjBPM09NVWppeTdMaVdyV1k2ckpJK1E4ZWpLNlNRcDArRUhO?=
 =?utf-8?B?TE1JUmZacDRzVnJlb2VLUk9QeEpMMDMyekVhU1NvSy9pNUdOUUZFV0dmSDA4?=
 =?utf-8?B?Wk9mM3VxbjRXbjNnNEExcHgwb1V6M1ZoUEE0bTlzTjJQVUVJMy83TDZXekpz?=
 =?utf-8?B?eWJ2Tmp5N2RBdDUxL0NtVkViaFdEam5iZHd6aWNGdVFTZ0FpV2loODdNNDNV?=
 =?utf-8?B?YkFMZWE4WVZ2NUtBaDhqcTlIbWUyN0t0WDQ0RnIvYkFQM29RdWkwRThHZDdB?=
 =?utf-8?B?aEJsWkpYM2NTemliRS8ydlA1bEJDNjdoSzRJVHlqakNMd2phaFE1anpHbEUy?=
 =?utf-8?B?dUZxQVVGdTFlalpLaVFweEszOEZ2dXQ3eGQ2VUhCMGJJbEc3YUlBN2RMWHlj?=
 =?utf-8?B?SnZkUUp0ZjRzL3NUdWtReTFQVjNxbDRwLzQvWVFFRjc3aUxNSmx6eDhWUWpL?=
 =?utf-8?B?WGFmb1FDRFppekpoU0V2V1p3SjlEZXMwUWlnb3piWHVGdEttOFF3Q2RNaWVw?=
 =?utf-8?B?WXFjMUIwTkFJTmNzOWFxSVBVYXNHaFBwdVJFMVZLWlo1WkR3bkhjWVFlWUNV?=
 =?utf-8?B?MkhzMU9LZDFWWTlGU0cvNlVnQzl3aTJxa0wvMXhlWlE5TGhrbnlvaXF0L0Rv?=
 =?utf-8?B?QWRGbjZWeW1rUktSTGNTQ08rRExYTXU2T0lHV2M1Mm9Pc0VscGRTNndXZ2pj?=
 =?utf-8?B?MDFSZVRYZ1hhVTVTQzlqYjJvelduUUhVSXFqaGkwV1BwS3RFbU5CS2svVkN3?=
 =?utf-8?B?NXVwR1VaYi8wRkJpaTJpRUhYWG9sYzR2R200QTlmdXJ4dXVpRGVVK3l4c2dG?=
 =?utf-8?B?QVJwbExjMDFWNWlLZDNvRHNqcC96Ni9EMXBsdDliVEplSnQwUzhPZi9admQy?=
 =?utf-8?B?UGZuZzAycHl5UTlGN3N0NGUyZEs4VGRWUDRQWGQwaktIRjBzVndSTzZBbDlQ?=
 =?utf-8?B?WTVaUUNHVkYwcjFSUUJaajFzQ3RuTCt5RXFYZTl6djk2L09SZzNiQTJuRXlp?=
 =?utf-8?B?dFR1SW5CTXRzN3VYazFlRm9WOU9YY3lqY0s1Z0FJTlhoS1BXOHVFV3NzNTFw?=
 =?utf-8?B?R0w0eDFWTmFYYmhtcFROOFJyd0JnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9632c7f9-0f81-4e1f-15b6-08da9c8b5c48
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 11:12:39.1773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pf8cHjVnvabcddWNm+e3Rs7IXAQdEwjKYx7Q5yQvrPl/U5LNYwDYJhTJ51DwPAW0nyxQ7hB+KYv8AmTq1O2cug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 21/09/2022 09:17, Uwe Kleine-König wrote:

...

> As the clk-rate is only 32768 Hz we get (with period_ns = 1000000)
> 
> 	32768 * 1000000 / (1000000000 << 8) = 0.128
> 
> which is indeed rounded down to 0 and then runs into the error path
> returning -EINVAL. Before my change (that now broke the backlight
> configuration) configuration continued and then ended with actually
> configuring period = 7812500 ns which is off by nearly a factor of 8.

I am seeing the same issue on Tegra210 Jetson Nano (device-tree
tegra210-p3450-0000.dts). This also has a clock rate of 32768 Hz by
default which means the min period is 30517ns. However, in the probe
the min_period_ns comes from the pc->soc->max_frequency which is 48
MHz for Tegra210. The min_period_ns = 1/(48 MHz / (2^8)) which is
5334ns. Hence, the actual min period is less than what is actually
possible.

I wonder if we should be warning about this and fixing the min
period ...

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 2f3dcb9e9278..f72928c05c81 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -310,9 +310,13 @@ static int tegra_pwm_probe(struct platform_device *pdev)
          */
         pc->clk_rate = clk_get_rate(pc->clk);
  
+       if (pc->clk_rate < pc->soc->max_frequency)
+               dev_warn(&pdev->dev, "Max frequency limited to %lu Hz!",
+                        pc->clk_rate);
+
         /* Set minimum limit of PWM period for the IP */
         pc->min_period_ns =
-           (NSEC_PER_SEC / (pc->soc->max_frequency >> PWM_DUTY_WIDTH)) + 1;
+           (NSEC_PER_SEC / (pc->clk_rate >> PWM_DUTY_WIDTH)) + 1;
  
         pc->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");

The above does not fix this issue but ...
  
> I didn't find a device tree for an Asus Transformer tablet bases on a
> tegra124 in the kernel source, but the options are:
> 
>   - Revert commit 8c193f4714df ("pwm: tegra: Optimize period calculation").
>     I don't like this. IMHO this commit is an improvement and the problem
>     is that the consumer requests a too small period. For a backlight
>     this might be ok to result in a much bigger period, for other
>     usecases it isn't and so I like refusing period = 1000000.
> 
>   - We could just drop the "else / return -EINVAL".
>     This is inconsistent as then (again) some periods are rounded up
>     (with the given clk rate that would be 5334 <= period < 7812500)
>     while others (period < 5334) yield -EINVAL.
> 
>   - Increase the period that the backlight is using to at least 7812500.
>     This is done (I guess) by replacing 1000000 by 7812500 (or more) in
>     the backlight's PWM phandle.
> 
>   - Make the PWM clk faster.
>     Looking quickly through the tegra clk driver, the parent of the PWM
>     clk could be changed from clk_32k to pll_p or pll_c. This should be
>     doable in the dts using something like:
> 
>     	assigned-clocks = <&tegra_car TEGRA124_CLK_PWM>;
> 	assigned-clock-parents = <&tegra_car TEGRA124_CLK_PLL_P>;
> 
>     in the pwm node. (Note this includes much guesswork, I don't know the
>     PPL's clk-rate, so this might break in other ways. Another option is
>     using PLL_C.)
> 
> Probably the latter is the nicest option. Is it possible to find out the
> setting when the machine is running the original vendor OS?

The latter does seem correct to me. This fixes the issue for Tegra210 ...

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 4f0e51f1a343..842843e0a585 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -670,6 +670,10 @@
                 clock-names = "pwm";
                 resets = <&tegra_car 17>;
                 reset-names = "pwm";
+
+               assigned-clocks = <&tegra_car TEGRA210_CLK_PWM>;
+               assigned-clock-parents = <&tegra_car TEGRA210_CLK_PLL_P>;
+
                 status = "disabled";
         };

Cheers
Jon

-- 
nvpublic
