Return-Path: <linux-pwm+bounces-4537-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC13FA019DD
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jan 2025 15:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A532161C55
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jan 2025 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BFD38F83;
	Sun,  5 Jan 2025 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="gpUJLEaW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2060.outbound.protection.outlook.com [40.92.50.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F942F3B;
	Sun,  5 Jan 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.50.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736088688; cv=fail; b=nQxhrdVTzCzyE4XFcKSj3PSEnKsXE4Z+q+290RQZwn5lTYT9fNIQSnzyPVi+tFFKnXCJXMBfiGLxniS3x75RbeIfSoM3qbDYvvtY7kxzm1lZkXr2nGJxTdOZ4YxegOUl+flEZ+sH4PEayGFHnWIFefR0aZJ/6cxQEINait+YgoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736088688; c=relaxed/simple;
	bh=leFNIRvfPoz1F5tDCcrcnbiA97S1dCMUNExYiwoJEgk=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WDkw6OEwuJ24zzUc01sbG+Pw9lJ7+RH+HYsAW0Uy8voqtZUTAhtaLxo728jqLtzdpNhgJF1XAvK9y6P67ZBuebM0jp61aS0DaR1Et1v5Vs7n6UzyUOZWk4L8qzL7pmpJ3Pt0duiWPpjIQmP/1k9Ql0Dr6lroXbOxHpErgxCPhdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=gpUJLEaW; arc=fail smtp.client-ip=40.92.50.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gy3c95RHpTiCyJQ45cwt4uwfLzslSCkiHajNk0D1OayaUokmRX8J3q+cXEdKc7FdVeGOrevPWN7TBpiQYg4HvKSvWZ/HqG9cn0SrdhPGbIUTmLkMU51+y+TS/Y5hoWrqAE0931867dpp1jg7SUKQQV2CTm1OvGus3YoNSc0M3GSbloNeRA44Cnn1qSw2IAYz1E1LjvUvjCcoar51+LhXGWLdGw2pm0HBPaH5Fld0HXC2LRR6Qj2QZSHNjS4spHKOEuFOrUsgOZlngDtd/k9zE89xBwJUODPaKzbYgp56+QCSsEojG/5m02eAqd3lMzzm2d1QACoHrl4WNu/w1KvuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YohwdOTLHZqbvIdOchqnps3CdfC8TpVenRt7KYDKn2E=;
 b=S0qGBCXxZejqUPlf6jj+BPUmEkwUlSfJpDJyU4BXwK+HZOUK6Nfw45poN4iil3PUWq3eXZ24Ug8YxMnooJ9S29uq5EnqIuEALo6VBv/928+l9NVerCibG/PP2HAtsdTw9oE+27ljqW57EI/BUPOJhTMvIDt2AyiaVM0sloP6NrnddkZrFYP6z+SsxHBM4z8bgHwbCuii9S/9G0EplhcU125skmNVLlMLPLYzX+eQvU1D3c9svl1+K0yiBVdiN1ZdJHsIEuV67Rnnmv40kSFWN2w0uAjkzmJEpU+pGOi/isDrd5NYq3s7qHxrEihGROVl6aRzITXDyuKGufpizC7eLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YohwdOTLHZqbvIdOchqnps3CdfC8TpVenRt7KYDKn2E=;
 b=gpUJLEaWE1S+/tlJVCgf3sBMyYYO+7z0XiaCdOrC9QBMB96EsEc921ywSv25usOdE5H1OtK+bgHERrALLszmKVihiKpFdUeHuvc7/ySsKk5MK5vo5GqdpYgpgMF7aLHYCv/PDg29T86PJk+vPSc8o288bETIiL+A00/42lFdne5EpCxg6oetPBhli09074zxf5hhCDP2oPmQzA2GbHY2D4//TrX60i3enLI7tPGPJQIkLUVLZHGAYucqtqfMxENqkCy6Ynqq4RCozRo5fRxVfheR3IdoGzH8J/zUH1bi+UzPxjOvoKmiK2+u2MPkqLYSEW4nRz58CWjTd/Afjb/Bgw==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by PRAP189MB1873.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:278::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.15; Sun, 5 Jan
 2025 14:51:23 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a%5]) with mapi id 15.20.8314.015; Sun, 5 Jan 2025
 14:51:23 +0000
Message-ID:
 <AM7P189MB100935C2EB7BC185C6567A7AE3172@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Sun, 5 Jan 2025 15:51:22 +0100
User-Agent: Mozilla Thunderbird
To: william.qiu@starfivetech.com
Cc: hal.feng@starfivetech.com, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, p.zabel@pengutronix.de, ukleinek@kernel.org
References: <20241028014609.153997-1-william.qiu@starfivetech.com>
Subject: Re: [PATCH v16] pwm: opencores: Add PWM driver support
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <20241028014609.153997-1-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0172.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::9) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <231ac075-1fb1-448b-8043-72342e05ff1c@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|PRAP189MB1873:EE_
X-MS-Office365-Filtering-Correlation-Id: 58988899-f14f-473c-0f7f-08dd2d986c7d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|15080799006|8060799006|5072599009|19110799003|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2xqVzNOVHpoZ0c4NzhQbU9INE5DL0thclZ3cXB1akZHM01qRHhMUDBOSmEr?=
 =?utf-8?B?azJleXROWkgvMkI1Z3ZjS1NlQjJEcmlBV0VkbkxoNTBFTnkrNHNlR3dWTUlV?=
 =?utf-8?B?R1VPeUx5WjVoTkx0bkFRbEJDZUtFTGg1WDFyVlNWTkpEMVN2aXhpcTVFeU9j?=
 =?utf-8?B?R3QyQnFOVjNrajdMeWREM2RVRjhJVDY5b3FtWDlkUDVUZ3MyZWpMU2R1SGg4?=
 =?utf-8?B?ejB4QlBvNGJ4SGFkT01yYUhoSlREWlBnMlFKNkRucXByUEsxb0VxSUh5U2N1?=
 =?utf-8?B?WHVLMzduUExUTDljNUtjd0c1ZTdobUhWdy9odGI1NjNFSTdENlpvOHYrL2c0?=
 =?utf-8?B?eUlYK004eEp1aWVTZUJSREJwdVU3cWY0a1c3QTF1NEh0cUhDTUk1UVhSeVBu?=
 =?utf-8?B?Z29DQmliWGN0ay9HK1lEdUZvUXN5Q3d3bDc0NzRRbHQxZVVnRGRiWjZvRlNw?=
 =?utf-8?B?NlViRHMxVW5xc0txa0l2L3A5R1AxUUxkamdrQlIvdnBjYUJ1bmRTUFhZYms5?=
 =?utf-8?B?T1FFTm15WEE0c05MTjJuQlBrOVJPOEVXZWVDMWJ2eXhjMnR0OEtiNWN0cEdw?=
 =?utf-8?B?SnI1V3BMTXF4NzFTdUVBbm04eVFyajFsdlNUWnljZFJlNUV5b3J2ZVRQaG1x?=
 =?utf-8?B?V0dlUWd1MjRjdVJTMmttRjlLZSswbW9WalpmeGhENEhLQ2JIZGY5bFkrYmRD?=
 =?utf-8?B?SExKOXo0cEllNFl1S1NlMjgxTURkU0UxeStYYlpoNHBUVXVhNTFWU3F3Ujd5?=
 =?utf-8?B?eElydDhkSXRxVG1kQjBSWEtyWGlKVTdBQytpcmhERFNMa05EU1dhSVVYNkVp?=
 =?utf-8?B?dW1RalpkTHhsNlAzQVNxT29XcnQvU2trTEVFOHdpRDIrZ1lRdG9RTjFqSFRz?=
 =?utf-8?B?emU4MjUyOFNPQitiN21NNm9KRTJlRFNXM3lhM2Vud0JZNGszYjltY3dLVitv?=
 =?utf-8?B?b1RhMWhBT2NuK1F5V2g3OFlHTmpwa1NOSTI4di9LdXdwYTFOdlV1Y3NZNFFH?=
 =?utf-8?B?ZjJBY1lBSjdYY1dEVU4wWXpOTlh4RFpZenJrc2ViRUZ0ODlOQTdybVcyOFpU?=
 =?utf-8?B?S1BYR0ozV2JRVm1zL3NPMlFMcUc3alNvOW9PaVJab2g3dForMDJjYjNnVlBX?=
 =?utf-8?B?a2dZaGdNVkFrYnV0U1l2RWg1L1JsNituaG9OWG4xeTJiMU5zRzR3Y1A3ZDBn?=
 =?utf-8?B?cXE2ODlmR284YVBtTmlSQS9BRmhsU1NMLzVhcFpSOU12bEo4dE5Ja3JWZUdL?=
 =?utf-8?B?dnB3bkZKYkNLY2ZzeTJWLy81dnM4d001bDJDSWNWOVJjQkVqOTdQTEJlMVhk?=
 =?utf-8?B?NHVvQWFudWVXbm5zU05LOXlrRjhLcWNSaWQ4RGpSdlNOT3c2TWxSaEtWcHE1?=
 =?utf-8?B?OVB2RWF4blFEaEhxMnpDVDF3SGFneFRuN0hQd2wxSjFWcDdic3dtZ3BEZWFh?=
 =?utf-8?B?aG1yWEF0Wlo5OTJ2ZUhFOWNQM3BPWVpqRS80dGRRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckZ1a1VETGlwVHVyY1RDcDNOazZEVzZoMTBaZVM0TkpLTGpncjM0U2FEb3FS?=
 =?utf-8?B?VW81bDVRMHBPOEZUMmVwNXhuZTJpUG1DNlM4UXpwR2Vqei8wMGtBN3NVZTNX?=
 =?utf-8?B?endPbnU5cFBDNHhEWVg0R3JpMjlpRWQxeWVFZFRSWElRYTZWekhWbkNyZkpI?=
 =?utf-8?B?cEVKYnJNbjFSd3lHV0lwNEkzbUFMai9DbXZUUmN6RzZ0bEdzQTFQZmgyYkMz?=
 =?utf-8?B?K3kyajdDdWZmdUtDODZXQ2RaNjdWWE9KMzB0dU8yeTMzUExRc2xpK0paRHVX?=
 =?utf-8?B?dGpudWM3c0oza0NiQjcvaG5VUnlpQi9LNi9mK2E4OXI1QzMvalR6bU01UHR3?=
 =?utf-8?B?YzVETXErcC9JYVJ5NDdEdU1Cd0hyY0cxaHlCWlBLWG94U0JGQklvVENaaHhX?=
 =?utf-8?B?R2xvUnlqY01wVGVCbDRMWEhCaUw5YWxEY0dGZkpNUWFlZnU0TmhRTURQdll3?=
 =?utf-8?B?U0RRL3ZrSTFxdXlFWDJFb1I1QjM2SW5wVFBBYVdnbHZoWHgvc1dQTGNNQUw2?=
 =?utf-8?B?RnhtV2RSVERTeXdlK25tRm9FT1BuaDZNWHdHU1JwQnBFOG00YTgydU5ud3RW?=
 =?utf-8?B?VGViZzdUa1RFVy84Q3Z1YUZGd1ErTTFzdW5YQnUvOWJ3T0NVcC9JWVl2WmhZ?=
 =?utf-8?B?ZlZPK0g4YUVmZ3BFOXRyR05lTXExQUNqakhneGpINjVIN0ErSXoyY3VkeUNu?=
 =?utf-8?B?clFBbitsa1Q2b1R5V0ViVVVJMk5KUVdmNTV6NDRLbDNaMDVXYjV1UzdTQU1t?=
 =?utf-8?B?NHZMTjBBR21Bc29zVjAvSjB6L0FORCs4TnFPLzlXWTV2YVJ3ckdGNWxFOEE1?=
 =?utf-8?B?MDBFdDZPZ24vSVA1VGp6cXdHVGEzdWFRYVdDVmpuaUZIQnBiT0UzdWIzbVcr?=
 =?utf-8?B?VmRFWXdpOW9HOFgyL1ZJaGR4NjBud3hDS0k4elpTZzlEejhtUVgyOFVHcWtY?=
 =?utf-8?B?SXN4Mkt3VmFwWllIYUxoc25acFFNSjFONFM4N01CUFZRMk90YlJUakFYd2VF?=
 =?utf-8?B?alpnSzJOdElhdWVXM1dGS0wyWDFtd3VQSDFvdHVydHMyN2RCWHZpdzhHdW5C?=
 =?utf-8?B?eDR0R28zd09YNWZPWnh0YnMxZ2l2VmJ5SzZrNWd1TEhyQmhnZ2VENWZ2NnRj?=
 =?utf-8?B?KytDRlVxOTVPSEk5T1dycVVicVZvMmZDNTlKb2d2Q2Yza0lldlJXSXJVRVNp?=
 =?utf-8?B?T3NJMnI0aDBmRUdIVi9LNkRhMGhDZHpLazVTQ3FYLysveEx2TUZUQ3lVcTU4?=
 =?utf-8?B?YjNJRG1CbjYvUFNuNmptRERPY3hmankwZm1UaUJxWk4xYmhHTjVHVm05SDdN?=
 =?utf-8?B?dEhmYW5TOFN6TXZvUWVGeGcxcTY0OTFGcjJzbllkbjEvT0JVWFg5bHBTMXQ4?=
 =?utf-8?B?Wk0vM0NKYmM4UU9MYXRkNmVXcGJqRnNRL1VoV1p4ZXJuSHhFZGx3ZjM2cnIv?=
 =?utf-8?B?bVBaYjhXeWFZcFA0WmdHM3JxNEswWHNSamhYYWtvNUF6NmJHN2ZyV1lycWNV?=
 =?utf-8?B?SkwvTVo1WWFNc3hkdDlyRnJmQmJ6VDNMajFTb2hwN2phdnRLZ1kxVEdmNGZP?=
 =?utf-8?B?dE5wQnc4ZkRtTms2VVluWnhJUGZLNmh2UHdma2Q5MEpIQy9WTlNibUFYL0xQ?=
 =?utf-8?B?ck1TNGpCdFdpNENOSVdHdm5wNFRPd1ZsdVJSYlIwZnlMV1pMWGVOV0NwQXd6?=
 =?utf-8?B?cEtaZ2hkbkJkSjBOYlZPWnh2WkkwS253NlZ1a2pFVk50U2tDSnlOQ0xYV0px?=
 =?utf-8?Q?lpRRdmJQkGfI81S6s/aMD/l90iUsN6NCQTEj/Yo?=
X-OriginatorOrg: sct-15-20-7719-19-msonline-outlook-3b3e0.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 58988899-f14f-473c-0f7f-08dd2d986c7d
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2025 14:51:23.8319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP189MB1873

Hello William,


I tested this patch on my deepcomputing fml13v01 with a pwm-backlight 
and I am getting an oops:

[   10.308290] Unable to handle kernel access to user memory without 
uaccess routines at virtual address 0000000200000001
[   10.319038] Oops [#1]
[   10.321318] Modules linked in: pwm_bl(+) sfctemp designware_i2s 
snd_soc_spdif_tx dm_mod configfs ip_tables x_tables vs_drm 
drm_dma_helper stmmac pcs_xpcs pcie_starfive phy_jh7110_usb 
phy_jh7110_pcie phy_jh
7110_dphy_rx phy_generic overlay jh7110_trng jh7110_tdm jh7110_pwmdac 
inno_hdmi drm_kms_helper i2c_hid_of i2c_hid hid_multitouch hci_uart drm 
drm_panel_orientation_quirks clk_starfive_jh7110_vout clk_starfive
_jh7110_stg clk_starfive_jh7110_isp clk_starfive_jh7110_aon 
clk_starfive_jh7100_audio cdns3_starfive cdns3 cdns_usb_common roles 
btintel bridge stp llc bluetooth libaes ecdh_generic ecc backlight efivarfs
[   10.375483] CPU: 3 UID: 0 PID: 307 Comm: (udev-worker) Not tainted 
6.13.0-rc4-00032-ga27a3464e6ab-dirty #16
[   10.385227] Hardware name: Unknown Unknown Product/Unknown Product, 
BIOS 2021.10 10/01/2021
[   10.393576] epc : ocores_pwm_get_state+0x22/0xca
[   10.398204]  ra : pwm_get_state_hw+0x10c/0x132
[   10.402651] epc : ffffffff804f8d48 ra : ffffffff804f81f4 sp : 
ffffffc600f1b5c0
[   10.409875]  gp : ffffffff814f8658 tp : ffffffd6c3efe400 t0 : 
0000000000000000
[   10.417096]  t1 : 0000000000000040 t2 : ffffffff814a0498 s0 : 
ffffffc600f1b600
[   10.424317]  s1 : ffffffd6c0b9b800 a0 : ffffffc6007b0000 a1 : 
ffffffd6c0b9bbb8
[   10.431539]  a2 : ffffffc600f1b690 a3 : 0000000000000000 a4 : 
0000000000000000
[   10.438760]  a5 : 0000000200000001 a6 : ffffffd6c07fd918 a7 : 
0000000000000000
[   10.445982]  s2 : ffffffff80e6b2c0 s3 : ffffffd6c0b9bec0 s4 : 
ffffffc600f1b690
[   10.453204]  s5 : ffffffd6c0b9bbb8 s6 : 0000000000000000 s7 : 
ffffffd6c0b9bb78
[   10.460426]  s8 : ffffffc600f1bc90 s9 : 0000000000000000 s10: 
ffffffc600f1bc40
[   10.467648]  s11: 0000000000000001 t3 : 0000000000000000 t4 : 
0000000000000002
[   10.474868]  t5 : 0000000000000000 t6 : 0000000000000402
[   10.480179] status: 0000000200000120 badaddr: 0000000200000001 cause: 
000000000000000d
[   10.488096] [<ffffffff804f8d48>] ocores_pwm_get_state+0x22/0xca
[   10.494019] [<ffffffff804f81f4>] pwm_get_state_hw+0x10c/0x132
[   10.499768] [<ffffffff804f8338>] pwm_request_from_chip.part.0+0x11e/0x182
[   10.506556] [<ffffffff804f8640>] of_pwm_xlate_with_flags+0x26/0x64
[   10.512739] [<ffffffff804f7084>] of_pwm_get+0x146/0x1ea
[   10.517967] [<ffffffff804f84e8>] pwm_get+0x14c/0x1d4
[   10.522934] [<ffffffff804f8582>] devm_pwm_get+0x12/0x4e
[   10.528166] [<ffffffff018ab2ae>] pwm_backlight_probe+0x102/0x84a [pwm_bl]
[   10.534963] [<ffffffff805a05c4>] platform_probe+0x4e/0xb2
[   10.540369] [<ffffffff8059e0b0>] really_probe+0x84/0x22a
[   10.545684] [<ffffffff8059e2b2>] __driver_probe_device+0x5c/0xdc
[   10.551694] [<ffffffff8059e3f4>] driver_probe_device+0x2c/0xb2
[   10.557529] [<ffffffff8059e574>] __driver_attach+0x6c/0x11a
[   10.563104] [<ffffffff8059c1c4>] bus_for_each_dev+0x62/0xb0
[   10.568679] [<ffffffff8059daf2>] driver_attach+0x1a/0x22
[   10.573993] [<ffffffff8059d3e8>] bus_add_driver+0xce/0x1d6
[   10.579481] [<ffffffff8059f114>] driver_register+0x40/0xda
[   10.584970] [<ffffffff805a034c>] __platform_driver_register+0x1c/0x24
[   10.591415] [<ffffffff018b1020>] 
pwm_backlight_driver_init+0x20/0x1000 [pwm_bl]
[   10.598730] [<ffffffff8000f12c>] do_one_initcall+0x5c/0x1aa
[   10.604306] [<ffffffff8009f992>] do_init_module+0x52/0x1b2
[   10.609796] [<ffffffff800a10f2>] load_module+0x1374/0x177e
[   10.615284] [<ffffffff800a16c0>] init_module_from_file+0x76/0xae
[   10.621292] [<ffffffff800a18e4>] __riscv_sys_finit_module+0x1b4/0x31c
[   10.627735] [<ffffffff80983cf4>] do_trap_ecall_u+0x1a8/0x1d4
[   10.633399] [<ffffffff8098d8a2>] 
_new_vmalloc_restore_context_a0+0xc2/0xce
[   10.640285] Code: ec4e 0080 3983 0785 8aae 8a32 b783 0009 b503 0089 
(639c) c399
[   10.647772] ---[ end trace 0000000000000000 ]---


kind regards,
Maud Spierings


