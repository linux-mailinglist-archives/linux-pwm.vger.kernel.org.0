Return-Path: <linux-pwm+bounces-3608-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A1C99B01C
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 04:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B636D1C20F9F
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 02:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E856213FEE;
	Sat, 12 Oct 2024 02:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AzGVVc94"
X-Original-To: linux-pwm@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2048.outbound.protection.outlook.com [40.92.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8003D531;
	Sat, 12 Oct 2024 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728700651; cv=fail; b=dbFkq0jBAu/W8ZPhkmtH65DdS9+EPv0Mhhkb97naz+9W2kRTFcbQhUf3yJTKPJo5zjj7qiaM8dTGcehCVKtKy6ZE7VktXb7n8GLZmnI01wvXy9AGCGsYG7a1QV5d9u6ou0AUVuJGBUxU9iCusKiRWNMBTlrI30X5htWFPLO8Zkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728700651; c=relaxed/simple;
	bh=3nTBRo6amDt7IPOYrZ/sQl0J131jod1YOZAM8B295+o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gj7mlsPW22NHnK323MpjcPwl1i9zdLRsg3fGG1qhAV+vJrP5JygKSqXcbsg5cLSzyMnVwsInESv/rKSIitMdUk4HHnvLjh4A8qh/mwqWN83inhc427Mtf8GbfY6YJWnS18DZek5lTh00uofJdOd6vSGM6T9o+JwPn5+150n+3B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AzGVVc94; arc=fail smtp.client-ip=40.92.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/dKsOzRRRRVidNR6UtNiSW6F3a7L1eZ8FJ6AnWfWhzF3bod6UYaR/42/QsE481+B0pcqzJLruqyiaRz1mNOO4TuJ3LTmrCM8lf4krElbXobrSCV+YVNiVxS7J2qAZt24x/iUFsWnqPJZ3gLnhNEHBU0hjPvWsc8uiX7bIEIx7FQnVlmD6GGPnlOuZQWGRnUHA7Hio31Cja60S20WbR8ahchVA2LedxVY8vD54qg5JSbYE+FqfWEbC4sHXXtARjL+zNPWmRZvODhPEg7C4F+43iTTNog8UOpQZtpdk2zWDK2m7TMQ9ylmeEmel5SV69+YPsvykRtUBVT8+SAlnJP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rv2/We7U4AXwNWfsjUjDDNuSIZu1LTS7FalcHJ3vXdc=;
 b=PpT5OfeRUZqZPuu/tHFxj+Y06CiuyRTpRgkO8e0FTys+hqKxtjr8+FAGcRe71x3U0qfw7jXiyjP0aPYbE4L5gIRRbFgcfMey2DblxIZUOE4Fx3fp4rdunHBaGNIJikOrkhkPYGkHP+pNI3Ge8GjeZkzXnhiO3KE49Hqm3UmmpEMl5mdK/YSdkdjhpVp84tu6fpdAA2pz7SyXn9YAFzq3hjVJMC+Yrn3T2ottNB8tahLl2fM7/5XJfF5MATkv0V87mtz4AKoUJWgZHlPHFnA6WGiXsXCigeGVU6nVfHISAW/Hcb3b/p5W0BHF5+n9VJMly6Xl9Qx4U1FKX9NQK0yVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rv2/We7U4AXwNWfsjUjDDNuSIZu1LTS7FalcHJ3vXdc=;
 b=AzGVVc94ebbtlsP+8VBUmsyDtH9v11sXRgUejgXD23OQ9YLdtBgzi/1ny5GFUcommuHrpoJckHlHqvjwDRiZQt2vcUn3qreqmt8842ePWxBTS6xHimiVelZVQv38vSZzEggHwExkxlfbpmc+MmSSwI4ECECqacmPku3gcvX5h647G4QKHcVByfmGdjdZk+mSkdL+7a0f2v0jSffDMVxvs7QTqglR1cI8I+nsnMhwPAbbbA/0IqWlIZSp8Ru8VfeEwsuhMQkfNErCxB0Jqvg77n8JpZfPPX8H6Z9n1ubvk+zDSuDNgssKd3W4Beb5Rbz+Jm+rLtnYJgmeJNUR4tFUtQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB0057.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:91::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Sat, 12 Oct
 2024 02:34:28 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 02:34:28 +0000
Message-ID:
 <MA0P287MB2822E1F15C9C2FD25847316AFE7A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Sat, 12 Oct 2024 10:34:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
To: Sean Young <sean@mess.org>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, inochiama@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com
References: <cover.1728355974.git.unicorn_wang@outlook.com>
 <57cf7ac3b4c092df1a6962d310b6d2603ca26995.1728355974.git.unicorn_wang@outlook.com>
 <ZwTsTQiTkFFu3pwX@gofer.mess.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <ZwTsTQiTkFFu3pwX@gofer.mess.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYBP286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::16) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <a8d31b73-2e87-4973-8bd8-ba641335f6d0@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB0057:EE_
X-MS-Office365-Filtering-Correlation-Id: 0990507c-9f68-4fcf-8b08-08dcea6664b0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|15080799006|7092599003|5072599009|6090799003|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	Hkqs4B4mbAKUdSx+h8EXOBksGLybj6cNRmL+fujlchZaHcVH2o1TPmo/9sAZRQq9dhWlJDDRyoqy3jqJMXwRf7T1Xe0R02JwxJJkMquRx7+wUtfW19bYWCMXhohjsLAnaD4f0XxTmUwu+c2vpGED2CiTHupeMUglD7yoquxHcMUzMWVGa13ZTQbifW9L6omys8VhlJxaO9GFDTs+IkJaFv8Qf6rhXTFlZMDtuSFIli6PUhHHcdHbIWPkZZ3Sjx/PuMIAlZt+04ow8VEPJ0wl8eI2ts2618CY2H4D451PMZDkiXCXZivIgtNXbNDVHMLO+Ues3WtxVtYanuiTyMxIf8Zi571k0tlI1i5oH9nBL6o8eG5xDiXDQqWSxD2YnNLj1896k3B4LOh+bUww6A6e6Zb0iiXqRPfbxlKhx6VwvqrS/HkRdJtPgyDz7lN4ZDaiEeH8svxuSM13DWM5obG3REC6mvwkPIFeWgj1h7qJ9Zk9tkOQ6HyABJXQDbPEJIKSJQDZjajspZMF4CIc87El+fmts4rEFwyZ5Lc4AkMdcOtIUgV1y5/ybpNlN5h9tv/j0C9vCZyBfhDO9zOQaGbwHpJH310ZJVsBBKgpy7OYtyDmz3NMCE0k9MNNIeYroMaB6rdk8HTH0ZOlU2KUJZZW6vR+3a3cRa3d5VhnfutEKiOCDGN4f0PPAsjHG25uET64LlRv5SbDV37UVxS8X1HrnE/w934A6szBqfw+SJna7S7zFsWW4gA94JsHwPo5bHdQBf7h/fYk2T+pYJbtgVYFYA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekJ1dTA0UFU5T0c5NDMxUVUwcXdNNGhCNUdIaHhLQUpxZDR0Z3hPbVJwNjE4?=
 =?utf-8?B?cnVsNm1MekVNVkNMQmtGTlIxVysyL2NYaUZ0QXpwRmlWdTBFYnhHVVplSnBM?=
 =?utf-8?B?Lzd2OC9jS1VSazVBcVFXNS90c29lcURKZDJGa3dya1paY2lCQ2ZRbEhQSVpY?=
 =?utf-8?B?YnQ4cE9OYlkrL0twUVUxbWtsdTNCQmVEVWJna3R3RWxJUGhVTnh4Y2h6djNn?=
 =?utf-8?B?RTdGSnN6elRjK1BHRnVPaGFRVW1wTVpOM3lYcHQ2WHRaMWFJZE5PdVB3cW84?=
 =?utf-8?B?RzE2bHNwa3I1SENkMzlQZmtLakpaOFFFV0NHb3lkcTdZeHBHS2hON0xacWhN?=
 =?utf-8?B?aDVXSzFzTUlkM1J6WC9ZZ014UitiQ3I0ZTcrdElJV3JKblBuQkdnSlVxL205?=
 =?utf-8?B?TVNiVWxsZG9XcnMySVhIdVhYQ2hqeFhlMTRKc0hmYjREcldkOUJvUzVMNit2?=
 =?utf-8?B?dE5LRVI0WUR4QVRsTy9iQVg4UzVHUUpSb0pGYWthMFFLbkxpY2oybFFQVDdY?=
 =?utf-8?B?TDY2YjRYVk5UaW9tcmVTd1U2Sk5mQW5SSTJkSEE2U3Q1NWR2Qi9BUzdIWUd4?=
 =?utf-8?B?MWJ0VE5xM3dhWitvU1hVODZ2NERkMkJ6aGRBVkFaL3F4SlE4S1FkSEtlOHVV?=
 =?utf-8?B?Uyt0M1FEb2d5VW9GT01ERkdUNW9uZm4rMjU1ZHVaNEplVzUyditQSnFIUnFi?=
 =?utf-8?B?RXBrZDZpNFZiSm5ubFMxaWZmNVZnTDYzYWNkM1ZDTGRSSkJ4R1doa09Rakx1?=
 =?utf-8?B?K3hlcDNVUnRCTEFad3FLUGY5aktveVk3OEtSNW4yQXBVMldSY0VzbUJGV1Zm?=
 =?utf-8?B?dlRQbzZPMG1rMmI0TGV1cG4wM1FXZG1LVk4vN2NmZ3NIRWFiYUFPeE9wNXFi?=
 =?utf-8?B?QkNPZzBXR0k2QlhDb0ZUSVlEYjJpYThGZnE1NTV6N0dHVlJWMFBjYUFVNUF5?=
 =?utf-8?B?aXd4UG50c1d2ZHc5WlVhT2oyQTZZV3g2ZUU1bzJSSHFJN3pnM3VwZEgrSVB2?=
 =?utf-8?B?V0pjNEtwMk92ekVZRzRwcnI5STVGYzM4SmNiWTVDamNLam8zOVpNTmV4VUxT?=
 =?utf-8?B?Y2l4dmJVNDhvai9OSnlzT3h2UWU5QkNiK3FOdWZFVTFKRjBUVkllWThVczBT?=
 =?utf-8?B?VUFhdElBam1EeUxuS2kzdGNpZFZQYlpSYmVtNUI5ZmZFZU4xcXV1UXZHcExQ?=
 =?utf-8?B?ZkJwUk9lRjBzc0g2OVoraVRRQ2JQVGZIQWt2NHNKaHhqMlFOdE12Z01NTjUy?=
 =?utf-8?B?aXF2U211RzNuR2hCNHZjS2VQMWFlR0hKaXJxS0RlSWtEdnNYVmdiQUM3cTRR?=
 =?utf-8?B?eUlzOFBWTDVEU1cvckR6cDZsejNrMmZhcFJxNWtySS8yN3FEVmNHbkdFU3l5?=
 =?utf-8?B?QXF2OWFOZWJ3enk4OUtHWEN3NitRTER1NFR5SDNDNE9yeUV0WlNFYW5HZGc2?=
 =?utf-8?B?ZUdiZHF1aGJyeWhYN0RNbm56M1BmcGN2ZVM2TS9OM0F2dkp2MFFWTlpBU1p3?=
 =?utf-8?B?RmdmaDA4ckZOLysyc2FYQ1VVZFk2SitzbndKcElPbkxKaWZSbktsQ1piamtW?=
 =?utf-8?B?dC9mL1FTbnRCcGxvUGx4MlJVUEFlSFA2QTlSU3lxM281akhCZXMxNlJVVlp6?=
 =?utf-8?B?T2ZvQzBpb2tsVUoyUXV5QmlIWnpOYlNqT1NncWdyOWZEdXRFRmtkQlBkTTlt?=
 =?utf-8?Q?n2CPcSOzJZa9PDxe1cgP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0990507c-9f68-4fcf-8b08-08dcea6664b0
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 02:34:28.0119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0057


On 2024/10/8 16:24, Sean Young wrote:
> On Tue, Oct 08, 2024 at 11:04:14AM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add a PWM driver for PWM controller in Sophgo SG2042 SoC.
[......]
>> +static int pwm_sg2042_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct sg2042_pwm_ddata *ddata;
>> +	struct pwm_chip *chip;
>> +	struct clk *clk;
>> +	int ret;
>> +
>> +	chip = devm_pwmchip_alloc(dev, SG2042_PWM_CHANNELNUM, sizeof(*ddata));
>> +	if (IS_ERR(chip))
>> +		return PTR_ERR(chip);
>> +	ddata = pwmchip_get_drvdata(chip);
>> +
>> +	ddata->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(ddata->base))
>> +		return PTR_ERR(ddata->base);
>> +
>> +	clk = devm_clk_get_enabled(dev, "apb");
>> +	if (IS_ERR(clk))
>> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get base clk\n");
>> +
>> +	ret = devm_clk_rate_exclusive_get(dev, clk);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to get exclusive rate\n");
>> +
>> +	ddata->clk_rate_hz = clk_get_rate(clk);
>> +	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "Invalid clock rate: %lu\n", ddata->clk_rate_hz);
>> +
>> +	chip->ops = &pwm_sg2042_ops;
> I think you can add here:
>
> 	chip->atomic = true;
>
> As far as I can see, the driver does not do any sleeping operations
> in pwm_sg2042_apply(). This probably should be tested with
> CONFIG_PWM_DEBUG and CONFIG_DEBUG_ATOMIC_SLEEP just to be sure.
>
> Thanks,
> Sean

Thank you Sean. We don't sleep when apply, so atomic should be needed.

[......]



