Return-Path: <linux-pwm+bounces-7860-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA3CFC197
	for <lists+linux-pwm@lfdr.de>; Wed, 07 Jan 2026 06:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE482301D59B
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jan 2026 05:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF1D25CC74;
	Wed,  7 Jan 2026 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LmB3ZY9n"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8B261B9F;
	Wed,  7 Jan 2026 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767764311; cv=fail; b=ulPnly9NiHt7IMB0NgH/lBwQJUwVG7etDjD71JcnuiJRMujYynSWlwuHOruLCwxQIppB6L+TItDuVLadJgj3HG/6oQrU1CMOUsWItgUcHsN424jj3lBh5seOfNX8LR3fQp/6d9vXVqTr3FX7+xaq3zX4sH5+YLqsL9vf9kWVDTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767764311; c=relaxed/simple;
	bh=OMpMMQq0MutIeZo+b2Q5geDHgKL/SqngrBL+i+4EBXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ACkC0n/lqRDGpXUxuxOLNzXustxi/9UZh+3vBBJ1davxnW4Bm4tgN/TyQE80qfnO13zo3/9oXAEsF9dry8pTnwdwXOPEpF60XjojilLjv7x6SGMfnVW8ijmj0SU/AF0QIKs8oVVcMO/1s+I6vsWDGIRbL+TdL/EENydVP07ipSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LmB3ZY9n; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l02Zc3SH9tLSJrG/gH7437MuAWd9gDencGseagakIScxS657kggMQ47RX0TxzK5oEATkJDvipgt6HTcmj8RueL+21w5Gx4UoqMZB/+KC1B4neEhnTaNajXigvUGc8kwKGPmqaKjoYDpEqIjfpP+Hu24x/coa11GH6I1Z7Q2fgSNN50nU0KF57Ags6BA6+A3fyF+ygDQDERZP1lZMVuO62jkRv0tscdN3TYSL9ft9yQ3fwk3uJxtCWwJZRFlTRm53AQu8J5qUATTtg8Do6AG+lpm9EYVwyWS3DHrje2iM2QHXMTnmHzYhgkgd9Ze3MSfOVtpQugueOR4gTW2PCwO4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhIPfWKhVYFwlaSAuT1366v7B1sa13tYPz9hTcIZN0g=;
 b=AlUJTGN8zTqQdhN1CyQ+2J6v1+l7EaceoEfn/sxcQae6MSodSVUMBgrrOeJlL/hHMECqlTDSaG1ygT1nzPWUuAHzagr+v3tHQ0Wh4fcuMTYaqsMLXji/D8nt7LQyyIqREig8elw7igrKnFquup7BFGH32dNzbR50KKrbUBT/j1FfXMKxDZ9CAHOjiDSNDN2jphqvFM+klgTfgdU5Fo9OLbKkInPulAtOCIe1o7hhFmaHw2A3ogXY1fk5ORwA9WBFMEMo3iOn9foknHQV0FqGQJz7DVGFqUgiqtdqqDItSuR//kgpsVNKMciUv6gITQfaXH7m7iluIYgatipWYxN5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhIPfWKhVYFwlaSAuT1366v7B1sa13tYPz9hTcIZN0g=;
 b=LmB3ZY9n0Qs6Skuij+HppNWFl4DGMDQXtwiOetbFy3ytfZRPErYHZLhCIrERF73qkmqrD2jZ0ne82700jwzyp2wIUAeA4OYTxkoyJ4OCiKQTm5Cx7amtdNClS5ZdivtB50EbUJ3IVLbiTrQmtW0017/QfibTKnhCopB/82u0kUE=
Received: from SJ0PR13CA0020.namprd13.prod.outlook.com (2603:10b6:a03:2c0::25)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 05:38:26 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::97) by SJ0PR13CA0020.outlook.office365.com
 (2603:10b6:a03:2c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 05:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 05:38:25 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 23:38:18 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 23:38:18 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 6 Jan 2026 23:38:18 -0600
Received: from [172.24.233.104] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6075cFAc007476;
	Tue, 6 Jan 2026 23:38:16 -0600
Message-ID: <e885a4dd-fcde-4c8a-a819-caf707360134@ti.com>
Date: Wed, 7 Jan 2026 11:08:15 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: tiehrpwm: Enable EHRPWM controller before setting
 configuration
To: "Kumar, Udit" <u-kumar1@ti.com>, <j-keerthy@ti.com>,
	<ukleinek@kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <n-francis@ti.com>, Gokul Praveen <g-praveen@ti.com>
References: <20260106105411.36033-1-g-praveen@ti.com>
 <4dd61e57-bc6a-485d-847d-8a86b854d358@ti.com>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <4dd61e57-bc6a-485d-847d-8a86b854d358@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: aef19236-5665-4801-0dee-08de4daefa57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmFmZitESytFWmJjVHpER1BlNisvTTRJWG1RR2NJUGJVWDVYek55eXBZN01y?=
 =?utf-8?B?RXdkOUJhUTQ5SWpVd0hyUkI5SUszdGNvTUM2NWZkbkhCSEZML0w5bjRBalIz?=
 =?utf-8?B?WnRUSEpRYVhZV09SWEVEdFRRVTZxNFRJdGVma0Q1T2gzeXNPTnRmQXg3ZDZI?=
 =?utf-8?B?bGpFNGlSSE1tcVNxWUZUdTcrQlllL3Q3WlJRYWQ2UjRvZTl3QmVIUEEvalJy?=
 =?utf-8?B?U0Npa3dnRENyVngyVXZsN1lReDRIbDZJREd2UkNoU3R3TkQ2K1FINUtUOGZp?=
 =?utf-8?B?Z1pUUUpuelVYdnVlRnhqcHhpYnFYbHBqaW9ZTXpTOFZXTXVCNEVvdzRyMGZB?=
 =?utf-8?B?cmZOSEUxNXFJVWw0OHo1ajAxZmFHaFVwSDJoVlBnQ0ZSbnpDZFdvRzJLM2Iw?=
 =?utf-8?B?L0NTMVFBSCtlRTNsUjgyeDE3NndEWU9iNDQ2RHlPbjc2emVTOHJYNFRpcE5K?=
 =?utf-8?B?dzJNWXZOeVNQcXI2ZEhDSTE0WG5zRGRiMnlqV3FNWCt2RndLdzlrSlFjT0RH?=
 =?utf-8?B?SlEzUVRKajJuV2lvYWw5ZVhLQmFEekFRSFlqRjV6Yi90enZIT2ZZOUx1M2N0?=
 =?utf-8?B?Zk0zUnJSY0FRcFNCMG5RME5JWjVTb29VdnRvaGM1MWtxdWQxT29hRm9tNGxw?=
 =?utf-8?B?U0lVcWtXT2dHUnlBYldsZkh4Z3hhSXplS213OU9udlRjMEgyajk4UEdtcnNY?=
 =?utf-8?B?SE5nTzk3WFZmdENENVZnYkR1aW9idVh4ZFRzMDI3dTc4cWUzeUlhN3U5Q3dW?=
 =?utf-8?B?TCs1aHBFV0NLK2ZJUW5va1pIUlloZXcvNjVnYXp5RmtZZXlOandpYjVHVEFF?=
 =?utf-8?B?VnFoazVEL1lFVlRTNE95WXBRdWV2ODJxNy9CQXdEdmtKVndoUUdqVjJvQ2lM?=
 =?utf-8?B?Q3pRQ2xTc2ZINUo1RzdnbjJjLzF3cks4WTFRTFhRVDZaSnhmdXRQSE1GL2t6?=
 =?utf-8?B?QW5vVDkvZWRka3FtMU9YVlhIVCtVTXlBNU1QWkZxTnZGREM5THJKZEtyaWZu?=
 =?utf-8?B?bFJNQ0MxWGdRRjdFb01MSmZPbld5SW9IUUhIT1FKOUpiNTFkSCtJbHJzWFBz?=
 =?utf-8?B?M3A5ZkFGckFHK1pXcnBaRGgyT0RZaG1JYUFtc2laSjA2K25rOEhvWUxEenpV?=
 =?utf-8?B?cnpnbS96dGhXeERvSUNnVE5LMjFHTElDZ2dWQndCbGo3dEdLeVorMm8vdnhs?=
 =?utf-8?B?bFBzWlFqRnhKaTlGRVc1d1kwU2FhbEFsMTM4ODRrUkV6RzdPTHg0bVk4VldR?=
 =?utf-8?B?dmJHbjlvM3pBVlMyek5MaXptQWxzTHh5Zi9WaStiUWZvaUVia3lHaG1mY200?=
 =?utf-8?B?b2R0T0NORm56M1RGb2pxS1o2d0lHRUJqZ25zNTQreGJCN0RXc0l3QmNlSDNr?=
 =?utf-8?B?M2R5ZkQrN0FSczMvbEsvR0syNlQ1ZlpyWlNHTTk2K2xOTzMrLzhsc0djM1FI?=
 =?utf-8?B?NkJ5aHpJUVVaWlBOd3BQbzhnbjJsMjJtM3VWcHljTlpyTE9Fc2RDNVpIaU0x?=
 =?utf-8?B?VnlJcHdoMXl5Z0piTTBjRUxaTWhuY2d4T2dPc2lvTWNxcEFyT3dNTldVRFk2?=
 =?utf-8?B?bWR4K0JWM0NqRGVWcGorWVRiOGorM3Z1b0NEQVBtdkxJYmJPOUZFT1pVL01m?=
 =?utf-8?B?T05JY1g4L2lybHhMQ2pVcWU1SDdFdmovNFF4MzN1TVpRTmNtWnpyRHZBS0FW?=
 =?utf-8?B?M1htRlN4Y00xUVVULzNZUmtZZlBLdDRoa1RTWjAxS1NWT3JnbXFnL21Ganhz?=
 =?utf-8?B?NjNkL1dPUTl2c1loV0NCMlM1cFFFOURLWDZ3eEs0R09CNlFrTkI0SjU4MjBa?=
 =?utf-8?B?aldVa24xNWhWSnE0QnJVb3JWdWhjeGlET2VQZEthU2tPTGUvTFJBNU9YeG5M?=
 =?utf-8?B?cjVNZmJCTkd3OGw0bzRFQnlHbDUzUmlncDVuWTl2WEFNb1BDUmVVdGFKbEdC?=
 =?utf-8?B?RWhrOGJRZXNTWmNnaWN2ZndMOXpId1owMEsrZzltQ29CWjlFbnE5SGtSRFdq?=
 =?utf-8?B?OERZNmxwdWtKcFFjNHk3QWk3THVNZCtkWVhRelpRM2M5VEhXWGdVWjhqdFp0?=
 =?utf-8?B?R01aRStHdHJPSllqNjZhUGpjejNFRmJCT0liSWpKV3NXeEJseWNlNm5EcGRJ?=
 =?utf-8?Q?fKJU=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 05:38:25.2131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aef19236-5665-4801-0dee-08de4daefa57
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099


On 06/01/26 18:57, Kumar, Udit wrote:
> 
> On 1/6/2026 4:24 PM, Gokul Praveen wrote:
>> The period and duty cycle configurations does not get reflected
>> after setting them using sysfs nodes. This is because at the
>> end of ehrpwm_pwm_config function, the put_sync function is
>> called which resets the hardware.
>>
>> Fix it by preventing the pwm controller from going into
>> low-power mode.
>>
>> 'Fixes: 5f027d9b83db("pwm: tiehrpwm: Implement
>> .apply() callback")'
>>
>> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> 
> No new line,  between Fixes and Signed-off-by Please ,
> 
> You can drop ' before fixes.
> 
> rest LGTM.

Sure, Udit. Thanks for that.

Best Regards
Gokul Praveen
> 
> 
>> ---
>>   drivers/pwm/pwm-tiehrpwm.c | 22 +++++++++++++---------
>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
>> index 7a86cb090f76..408aed70be8c 100644
>> --- a/drivers/pwm/pwm-tiehrpwm.c
>> +++ b/drivers/pwm/pwm-tiehrpwm.c
>> @@ -237,7 +237,6 @@ static int ehrpwm_pwm_config(struct pwm_chip 
>> *chip, struct pwm_device *pwm,
>>       if (period_cycles < 1)
>>           period_cycles = 1;
>> -    pm_runtime_get_sync(pwmchip_parent(chip));
>>       /* Update clock prescaler values */
>>       ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
>> @@ -290,12 +289,11 @@ static int ehrpwm_pwm_config(struct pwm_chip 
>> *chip, struct pwm_device *pwm,
>>       if (!(duty_cycles > period_cycles))
>>           ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
>> -    pm_runtime_put_sync(pwmchip_parent(chip));
>> -
>>       return 0;
>>   }
>> -static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device 
>> *pwm)
>> +static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device 
>> *pwm,
>> +                const struct pwm_state *state)
>>   {
>>       struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
>>       u16 aqcsfrc_val, aqcsfrc_mask;
>> @@ -304,6 +302,13 @@ static int ehrpwm_pwm_enable(struct pwm_chip 
>> *chip, struct pwm_device *pwm)
>>       /* Leave clock enabled on enabling PWM */
>>       pm_runtime_get_sync(pwmchip_parent(chip));
>> +    ret = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state- 
>> >period, state->polarity);
>> +
>> +    if (ret) {
>> +        pm_runtime_put_sync(pwmchip_parent(chip));
>> +        return ret;
>> +    }
>> +
>>       /* Disabling Action Qualifier on PWM output */
>>       if (pwm->hwpwm) {
>>           aqcsfrc_val = AQCSFRC_CSFB_FRCDIS;
>> @@ -391,12 +396,11 @@ static int ehrpwm_pwm_apply(struct pwm_chip 
>> *chip, struct pwm_device *pwm,
>>           return 0;
>>       }
>> -    err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state- 
>> >period, state->polarity);
>> -    if (err)
>> -        return err;
>> -
>>       if (!enabled)
>> -        err = ehrpwm_pwm_enable(chip, pwm);
>> +        err = ehrpwm_pwm_enable(chip, pwm, state);
>> +    else
>> +        err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle,
>> +                    state->period, state->polarity);
>>       return err;
>>   }


