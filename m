Return-Path: <linux-pwm+bounces-5722-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B1AA9D8F6
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Apr 2025 09:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1849D9A26C7
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Apr 2025 07:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EEE21ABC6;
	Sat, 26 Apr 2025 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ejt9Hs0x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20141AAE01;
	Sat, 26 Apr 2025 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745652331; cv=fail; b=RGq5bE0CVHHkCUcxuXav8M/bdrM7moPkV69rp9wF1wY5S0FYB/Dqfx415lnDDlYqiah8qWzbxY1bfzMhza2onD2a1ycvSrefSmUsghRZHrfBXfO5kRjq8bNLuNdixAn4eCUy6dnvudC7mU6+fdGmhI91lLp7Xs/PB15eCQM6jhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745652331; c=relaxed/simple;
	bh=6UgS4Tn8QSE4M2KSFigYDHBdrYDaemZ9FtQTv5oh9W0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TkmcAzrpECvxuyETZL84lR0dBuA3aA/8+Gxq7DzVw5ssod/2TiOxZ6/sqRo7Pp/mZw8Awknc7i9oCG0F6oTKtJ8PNaFspH9NydUwxbNLkcsqX4Msjvys7pPbNEGJw7uyAzq/Z2tYGKNr5w2U/HTOzNENio4cfkdSKNbm9V/kfew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ejt9Hs0x; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOCdvpsUurWCAdNW3Os/6XUwVlexqAquJWlr3HpHFSN8dsBJ5VLnA3wP1VzeLlc2HM4kKflBhXGcdGjd5xoDW55CNFrZOnyHUbBTAlQJAIH2cf756truFn5qNDzp1bfbnaVPYEnQDwCjOaYDIffyPqQbD4WhXmMgI+jyxxbLS8m6uTmjGRQcfR6rCEAKWVfk8vbUQoyowODmmiAxSz3OP/tcspeX1ukjt+fs7ErDhtGiGeDa7Jsv0U+qshwn5uKjNt/cAcJn4QFrIa+SCAHofB9VZs5uY2B5x2Yadue/5vw1T7oqJ8+uAjxlamBYiWzE1QUHHwlH8r/0SBg/PaQUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OjfAV2Upp0b7yI5RAWPIBQWMY8vDy68ZLaHWrAqyfM=;
 b=B/lbbPw+fYbrCqM8MQAdWE8gExjwVmNC0EKZLWwFn6bf/ObE63B6cJ/AUXipE8IX/n6s0L/mU9iEubqcQayuiHjE+cLh5mo6FGYJD10GLxnfCZ2xdfaIgK7l0L7s26a5YeNpduJdLm+FWXrnirljvH+fNqZ8vOAcfq8iQTUy3w0U9iR3K/8w43CLERxMILJetNDWJIbSmOKKmYlw1PwBlHF8kR9OXpcSplG4+3FDRS3WC6U+xfV0AV2hFB2SObmG+NmkCXXpINxzsaQaUzIFnjJIddWK6Ny+I5r1WQdTeF16zlUfrTINAqc6KIPreimSHDTED/Xl9NHSvBvXFXshqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OjfAV2Upp0b7yI5RAWPIBQWMY8vDy68ZLaHWrAqyfM=;
 b=ejt9Hs0xsAMhIO2kuiL+607am1HPN5+Kt0LUllbemLK8grYjShTKlqG1cnxLDit37Ds/oHcbla1jTF502qzXw6M9OZBAcy6zMVkA/8ZLk8S9F1PAQs5yh7giUF2NDjKRObj+ovAcEylbFM6+nArsTFLEzPJO+giNXFHP903zCZk7d1uwkmFFWqtJzVRoZ+1B9ma0KJyCH6wTjaupew10c4wIaT0NfKyJewpueQqR0ZuCynFyxq9b1R5wznYlonG7P0n0lAS+wfC8OIeZywietxNKkgydoN4V8kBDQsKLvn168XbS9MZPHS9OPdAM5CgVi69Omz9Yg/dqhGhkZUk0DA==
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:100::6)
 by MAZP287MB0076.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:47::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sat, 26 Apr
 2025 07:25:22 +0000
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4]) by MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4%5]) with mapi id 15.20.8678.027; Sat, 26 Apr 2025
 07:25:22 +0000
Message-ID:
 <MA0P287MB2262EA042510853498EDD60CFE872@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Date: Sat, 26 Apr 2025 15:25:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] riscv: pwm: sophgo: add pwm support for SG2044
To: Longbin Li <looong.bin@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20250424012335.6246-1-looong.bin@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250424012335.6246-1-looong.bin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::15) To MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:100::6)
X-Microsoft-Original-Message-ID:
 <77c47a0a-1f4f-4f27-b8f8-e9988e70407d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2262:EE_|MAZP287MB0076:EE_
X-MS-Office365-Filtering-Correlation-Id: 02af8b6e-c128-42c6-c4ee-08dd84938149
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|7092599003|15080799006|6090799003|8060799006|19110799003|1602099012|10035399004|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2xSRzlMUi83c05sQjRtc0pFRUJKQ0VoZ1R2eFI4WHpFSzFaWGlmMGpnS3ow?=
 =?utf-8?B?V0hTTDhabGh6dGxsMU9zbG1ySG9DV0NaWHlZR3ZTUHJZRzYvTjBOYXB3aHBX?=
 =?utf-8?B?Z1lRL0tTbVNlTldCNWpVWHdXNlhzWmFTR1U3TUZ6NElKdm8wdkZmeTBGd0FT?=
 =?utf-8?B?eldvMnFMemFSNUVFQ0w1czZlODlJenVxR2VoTXhPL2tndUE5QVUzaUxTR3Nx?=
 =?utf-8?B?Vy94dTJGamFBUTNLNzBoemd1UTNLYnovYkF5WndwQ2FOOFFEdFZZVVJ0WG8r?=
 =?utf-8?B?dzJLWllYRnBmemlyM01KcTZiaFpHYzF3QVFNT3hUQTE4TGFSOGpmTTljMDBt?=
 =?utf-8?B?aG83S2pGMGhtV1pRYUtMdHRtc05tKzV6SlZja05xVkRpdE5UZWdKYzFTNURC?=
 =?utf-8?B?RXNUMGh5cjdLZ2Q3K0ZVZ0RnVlFBRjB5akozRXNIOTZRZDJzUUNuK1puZy9F?=
 =?utf-8?B?cnFwYUxpWllCZ3hrRlFWZkRpWWlRYTJydVRlb1JVbVBtdHd5OUZSMGtPSEpv?=
 =?utf-8?B?cTZjb0pmbi9iN3M3ODYvTDIzcVRkVktJVHZHS1RhZWEvdk4zczI1UkVxSTU3?=
 =?utf-8?B?c1ZUR1Q2RXlGM1pxb1A3cGJzWDRsR0N5bWdXVjZQaVJORXRkbzBxMy9iQTZz?=
 =?utf-8?B?SUYrM0NEVEZ3ZFk1V2tGeEJhdS9DNVdEd0I0TWRyc2JyQnRXaGFXR1lCdFNO?=
 =?utf-8?B?eHZUOThrM242ZUZCVlozaUY1TllqZUZwV0xHa0ZtZXFqemkza1Q5TFlYZ3RX?=
 =?utf-8?B?OXBmMmRsZE9zQ0dEdU50MkZ0VU1oRFVTSEVUNTRveFdGSkQ4cXlVbFZ6ck1N?=
 =?utf-8?B?QjRMbmpPVm1kQVc1eklwUjB2OVBVaVRSdTM2dDB0TzgyQmJRbUNTRzZkL2Vr?=
 =?utf-8?B?dnpGMVdCcUYzdTAzWm1sZnpSTG5udGQ0Sm5VQzFPU0IrLzRlMU9Ea2ZvaWV5?=
 =?utf-8?B?U29BdGoxWGlBWk1IQmxCaW5mazVwNzR6MzVBWkxpTW5uMmdOMUdVN2p5SGNp?=
 =?utf-8?B?N2MwZGtmTGx1ZW8vc01jdUxUcERzckJJZHFHekUzdVdvaXFjTmp3L3NBSHpX?=
 =?utf-8?B?bThqZThzU2VxNVNxekhWc0F6eEx2Z2I4N2pWd3gralRNOG9mQTkyNkVZbHR4?=
 =?utf-8?B?Tjk2SDV2dGh6aDUwYWVPVy92MzduazBXUWtWUm01WXY4WGtNZ3d3VFVjcENX?=
 =?utf-8?B?REppVDRtdXdMSFRSRFY4MVkyTDZoRzlXdWR2U3ZRZC9sZGs1emZWYzE2TU80?=
 =?utf-8?B?MXQ4NWlWQnhUdXVJbGJWa1JiWWNqazJJcTZIbmpoZUpJT1QxamhCSCtVQjhJ?=
 =?utf-8?B?Z0MzV3hxeDlOY1hHbXdPZVQ0UDIrb3JJNndiZW03N2lGZStMa1BtVkVyYitR?=
 =?utf-8?B?YnZzYTNhSlY0OTlRZHA1ZHkvZnY5NFZaeThTc0NDT0J5THdhOEY2T2NpRlRL?=
 =?utf-8?B?REE5R1NnL0luOGRxTFNkbURScnU4K0J2Rk5MRnk0NlhFaCt3bmxkSjM2SUhh?=
 =?utf-8?B?cFpDNm90NDRSa1NqWU1SUlRNL0xES0VSS1NJVzRvUEFOVWlYdjZZbTEyUmJM?=
 =?utf-8?B?ckY4Z21FRXF4dHE3RjFhenplSktEd01YNW9Lem1pSHlYb2hqbVNHR3d4a0dU?=
 =?utf-8?B?UjZZaUJFZm1lQ1VpNnN3b0syMlFIVURDUHhZSU95RFdhSjkwNExIOWl0QUZh?=
 =?utf-8?B?SzBnUldoYkRpUWI1cmN4bllLMlNBNUhJWWVNcTAxV21GZmVNNmtVRGplL2l3?=
 =?utf-8?Q?eITH0k08W34r9zoGcGvnj5Hq/of0kkRiKZ9FCgB?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVl5QXBnVkl2RUUxUXNBZk5yWDUwRy8xdDdtNWtmazlmb3FndTk2L0xxUURZ?=
 =?utf-8?B?YnpyUU1KWURxdysyUFFYUHRManZPN252NGF2Y3h3MUF1aHpHa3RhYVdHWmd6?=
 =?utf-8?B?T2VyVDZOSHBHRis3MjI2eEJvYUdERjVlaW1LanE3UkMyais4R1YrOElza0hC?=
 =?utf-8?B?V0FiT283M01PN1poeHJoNXZoaC9yS1RJbmpQNHZjZ0srTGo2alh5U05Hb28v?=
 =?utf-8?B?enptRFlQREhRMFR6aTU2M1FuSlo2aCtTL0J0V3pya3pXd0ljSWpJV1o4cFBp?=
 =?utf-8?B?Ky9obDh5NkFaVU5Na016NGs4R01wSlJHR2tXQVowT1o0R1duS0R0V2pZaER0?=
 =?utf-8?B?aUxaUlJBMDRPYll1TDQ5SHVrWEdFR0FJMW8rTHI2cU1uUy9haDV4eEliWmV3?=
 =?utf-8?B?RzJtdXgzOTBKRUtJeUlkUGFSNyt5TmhjVGhNZDFiOVNuaTkxa3BjMlV1a1ZO?=
 =?utf-8?B?ZGMxRWdXZitOLzdJZTFyemR3aTJYZjRvNklGUDdIZ0xFak0wcnJxYWF5N25T?=
 =?utf-8?B?elhvaXh3a2ZjOGh6M1QrNnVkL21IcXJqWVc1VTVHa09rUEdFZXlqSTVZZ1c4?=
 =?utf-8?B?UDdMTE9UcURpZ2MvUW1vMEZQZmlsRUsvalJKckhDdUZsMkRDZEpHdUtwa2ZL?=
 =?utf-8?B?RWk0WHRIN1Q1VmQwQUQ4WmtaZDJSUllCcjNlUXVEQzF0cVB2b0NzVkNDQ3VV?=
 =?utf-8?B?cG92UDVPWVRmUnVpSzc4V3N6QW9jUFp1ZnhCc0dYN0JJcE90STdkQUVxb1JJ?=
 =?utf-8?B?ckpieXd4cndvblN6UjRqR21HQkhWa0tORzJsVmh2aXVqQlhUTEdCVVdwMlpQ?=
 =?utf-8?B?Q24yU2JMSitVSi80elFtd2o5UW80U0xNTHRaQVEraWdZNzh0dStmZXJ6V1da?=
 =?utf-8?B?NEZrRVFpRjFRVFVCSHVzRlZkb2pTeWcwN2o3TTZ2dGVEc05OTUxCUENmVzF0?=
 =?utf-8?B?SmFKREExVWI4S3hoRlBaQy9JSW9BVTBDYURQT3pDVStFU0tBOHVqR2c4elNa?=
 =?utf-8?B?UDlBQ3gyVGViTUI0VEZhNE1TUUY5bHA3bVVWK3NGa2NUY1JpMFJmVUxob3F5?=
 =?utf-8?B?TFh4VTlBMTRIOFFVOTRmQzk0clZVb3d1cVVYSWg1ajRuUUdQQU9na0E2Z245?=
 =?utf-8?B?dDhwaGZMbzdNTTdTbXd1UUpQcUhreGNEMzNTOERlOXZ3Rlg2cExFcHhaNnkw?=
 =?utf-8?B?UFRPOWVJZFRhRnhpY3pxaVk3VE9HcDBrWEI2eGZZVlhZVkxBZDhTcHJXODFY?=
 =?utf-8?B?Z0c2VjFNQXdlcXMydW1mSEQrTnQvWENUYjh6eTR3M1hYazV6Skc1eHZXTzl2?=
 =?utf-8?B?TXRmL1VhOVhmQk02QzJIclZlakc5emVDcWx0aDRUdG95aXl0SVRNUytReHdP?=
 =?utf-8?B?SHg4RktEVnF4UFlYNlR0V2Z2eCs2b1BEcHlCZjV0c01ZK3FhQ0VXZDVFdXBJ?=
 =?utf-8?B?S0NvOW9Qb1c2ZjhpSDZOVkoycGhaNkNHZEpRUDFQRWFrZUdvelZFUkVDUTNq?=
 =?utf-8?B?MHd4RFJFLzJkYnZkbEQyRUdqWUh1MTFJa0p0aGZ2SFo2TXZjQ1FEZmNnYWNw?=
 =?utf-8?B?Vm5KbXhMWGt6cy8veWtWdjJab05LSit5ZENJTzZBOW5LT2M2OUlzQlk4WE54?=
 =?utf-8?B?K3czYXIvNStuUjFucUxsQzNsQXM4UWQ1Q29RWjhpb3BvTHhKRCs4dE4yNlQy?=
 =?utf-8?B?NEliUUxUdkxCVGI4eXBDeUZMTzZNL21Db2xtK1ZtSHZiYnNPMXJJa0U1NzFF?=
 =?utf-8?Q?udMs6dA0MEBZHctOJQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02af8b6e-c128-42c6-c4ee-08dd84938149
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 07:25:22.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZP287MB0076

Hi，Longbin

Seems you missed my "Tested-by" tag for v2.

Others LGTM,

Thanks,

Chen

On 2025/4/24 9:23, Longbin Li wrote:
> This patch adds PWM controller support for four independent
> PWM channel outputs.
>
> ---
>
> Changes in v3:
>
>    - Rename macro definitions to unify naming.
>    - Modify code style.
>
> Changes in v2:
>    You can simply review or test the patches at the link [2].
>
>    - Modify variable naming and code logic.
>    - update "MODULE_AUTHOR".
>
> Changes in v1:
>    You can simply review or test the patches at the link [1].
>
> Link: https://lore.kernel.org/linux-riscv/20250407072056.8629-1-looong.bin@gmail.com/ [1]
> Link: https://lore.kernel.org/linux-riscv/20250418022948.22853-1-looong.bin@gmail.com/ [2]
> ---
>
> Longbin Li (3):
>    pwm: sophgo: reorganize the code structure
>    pwm: sophgo: add driver for SG2044
>    dt-bindings: pwm: sophgo: add pwm controller for SG2044
>
>   .../bindings/pwm/sophgo,sg2042-pwm.yaml       |   4 +-
>   drivers/pwm/pwm-sophgo-sg2042.c               | 151 ++++++++++++++----
>   2 files changed, 125 insertions(+), 30 deletions(-)
>
> --
> 2.49.0
>

