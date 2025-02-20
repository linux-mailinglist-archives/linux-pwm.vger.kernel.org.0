Return-Path: <linux-pwm+bounces-4963-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 488B7A3E3C0
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 19:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BAFD7A4E20
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 18:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4DB214212;
	Thu, 20 Feb 2025 18:25:22 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2119.outbound.protection.outlook.com [40.107.117.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D23E1D5CDB;
	Thu, 20 Feb 2025 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075922; cv=fail; b=ZsfdYtTQ3dnZ+EMzb5LP7C0Uje8rZheLpX3px4Xu/u1aJFDZHL/FcB2o/qeEsdzcgvd7IxfK6klIP6uRm9TrgjbtkfmmfoejD5JBKgCbuwJuAaTfoXhqeyVuOMhgfnpVTBzODweQRtwyYZuR2hrDflYr99l0pECVzorVg71LOu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075922; c=relaxed/simple;
	bh=AKUP5+Qxt3ZWROWpMTqqpr7u1SUjmdYFQn+VlV63+oM=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mtchdzIlpyKD6TpPflgrrR5lQrFC0oyZjfFd0lBAUe+W6g7wLyVwSWK+sfZzJKcn3Bbyg4SVnpe82hdoVu609DfX6F5N967RZFCVhqWyW28+ST8fSyRWlHPbm37BC2jG2jTu5GDhEkF1BVGXdYLrAfAfaZpZcfQtXr7uX2AmLcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; arc=fail smtp.client-ip=40.107.117.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPixFXR+Aks0GR/qY5f1sc/hDKeRMVNVapkuHNTP9tp3FBWNWsa7jykOxqEHaI4CxFhSigRpisEm94aQ/xfafDAwRFn/kS/oSEnvMFw+r9GsGTZdhDoDAgoEoexTKxYV3YxlQZvifsJooBjJtaHIF4ohdYfgF+zBDUBHxmhoSiiUyPvu8zQJIKTu4iZCR8+JkB41Ge1niaHjkDhRRd5UcHrfkMUYj1FmZAp2lO6GbWBhj6b1sg+e/qF3EqYc82lQxpPvvJ3Bu8qqUch/qDOlfQwUXIRLatfUqRNNMRIRmZYfYQNVoDDTlEqDjd5oIuZZuIftD2fsmNAZP4QSGYbEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJZD7/TAKruQu19KQAVwNVg6yYRPuMPWA5kXBs8za7Q=;
 b=IzAH/rlTVKoL7OI5JAbhvFa8AvI6ducO+/Dm1f4y83c0IW4+UbGlzY181pfaO0Ps9DGkbXqd6G8dtNxTB5KZwd5iFW0Wdkv9Eiu3hOE0ae0OfuTiUXjidirDOxSDRCbGZjnOo8s5TWSbqPRtncbwjGcehF5H+1/OkmD65aq0H4/ThrUAXinnBZtDv6Y+nPYmLAK037iKkZs8xKB6oXKL0s3XHmHi19qHX0axMSEeMTWDrouSs3KCB2yn5OAgP4OL9rPBr0Xh3wZzhV7phJz+n2IseEfxTZgIUPiCGS9DbeeT2iwm6ubl2cxu8GmpILV0PGvx+NYxbghQ6R6IQ9UWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by KL1PR06MB7012.apcprd06.prod.outlook.com (2603:1096:820:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.11; Thu, 20 Feb
 2025 18:25:14 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::9e42:3253:9a2e:b565]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::9e42:3253:9a2e:b565%4]) with mapi id 15.20.8466.009; Thu, 20 Feb 2025
 18:25:14 +0000
Message-ID: <c3990108-2963-4de4-98a3-d3aa368ed13a@linumiz.com>
Date: Thu, 20 Feb 2025 23:55:08 +0530
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, Brandon Cheo Fusi <fusibrandon13@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
To: Aleksandr Shubin <privatesub2@gmail.com>, linux-kernel@vger.kernel.org
References: <20250213094018.134081-1-privatesub2@gmail.com>
 <20250213094018.134081-3-privatesub2@gmail.com>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <20250213094018.134081-3-privatesub2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::23) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|KL1PR06MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: acff987d-d5a4-4f45-2fe9-08dd51dbeaf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dCt3akJVcnJSNGMrdEN5SHR2TzR3QmltNFZZNDVNaFZEZlVaMUluQzkxcFhV?=
 =?utf-8?B?bGx0bWVsM3EyYkZPeTlIcnZxUHFjZnU5UXRjQ1EyYkR0NWVjM3JnaFhYSG9L?=
 =?utf-8?B?ZzRqVldla01TKy9NNzVESmUxV0VRdUgwb203OXR2bTB2WU5LOVNqSHpRWGM0?=
 =?utf-8?B?ekR5bXdSQi9SdTZmZVA2SXlXUWN4US9TYXlKTW9Ya3V6ODRtTGJNdWprR21h?=
 =?utf-8?B?bjF4V1RRYTl3YXBPeWZJRjhJOGpzSkNucE5CU1pMbGlyODBJSWZ2UWNSa3V0?=
 =?utf-8?B?cW9SUFpueFdaNmpTdGViOUdYZHgxUTBFOUNWd0RKSXlTd3ZmdnhjNi9mSzg4?=
 =?utf-8?B?b083ZE1VOGlEUi9HZlU3OEhmL0F5QmNtOXdDbkhHZFkwR3RsYnhHa2xjaE92?=
 =?utf-8?B?NDVPSkNyUWtRZWpOeUNiMFcrb1FSRUZ6dXpSN2xtbXluSWVsSFI4ckJnRys1?=
 =?utf-8?B?blE5dkxyVktDQ0hKZGJrd0hORWtOVWJBUUZPemMxRzNqMFhaT2VoQ3FuUzBS?=
 =?utf-8?B?ajBIdlA5REZaQ0NreVgwZnZXYVZxNkhyM05Tb1M5empQeWs2NzBHNi8vdGEr?=
 =?utf-8?B?SFJnOHc5a2xONW1mRW5jTWs2ZmJIR3M2UkJhenZBeHdzWGczamIrVnl1QkVR?=
 =?utf-8?B?RkNyREFuTm1oS0hFT1FBbDdpSDVTWEVWaHZ6djd3V0p0OG85QVBLaVhacnVI?=
 =?utf-8?B?SVc0TnVYYVhjN0ZHbUlLa1Z5N09zQ1dxby9CRGplTkFnUVJwWXhpTCtwTXdB?=
 =?utf-8?B?bExnWEJaRXBGY1o3THAyd2EwMWZjN3ViM01wNXJFUE1TcHFFSXdlRGxVZHRG?=
 =?utf-8?B?SFJVNFc5QUtKUGJvMDFmQUlnU0NNS2FVQUxPQlRyVEN4a3JMbEhYLzFHazI1?=
 =?utf-8?B?MlNaNHVQUDMvbzY1aXVHVldYaU1MNDdnQ1NGMm5SZ0UwQ2xiQWwyeWk3aHZD?=
 =?utf-8?B?dmpaVGI0MjlKbzMxdFVjNGpwbXFsZlFwUUlmdU96dWVYb25GL0kwcXpJaHNm?=
 =?utf-8?B?UEUvU3o4eEVsZVR3cnV3M1ZZRXQ2MEhPcFNZRVFZMmNhbnBDbTVuMnRYNWZV?=
 =?utf-8?B?a29meVpkb3JSV2FwMmtva082UE94dTdmeUdPOEw2MTBNMkhxZHJUOGVGKzZ1?=
 =?utf-8?B?ZGE5RTRlZWtDUkRyTVEzeHF0blZKM0lCdVZVV0o2Qys3eFpaM2h0eUhoRngx?=
 =?utf-8?B?SFJLdWdNYmRKNHRtTDVPQnJWNjdkaUdOU1RNWGxGNnhPb044M0N6WDFMWUJz?=
 =?utf-8?B?TG1pZXp4SG9VQnZvbHNDUTRMaU9CL1BjbEc3MVZwaXpaZWwzS05VcndVMW0v?=
 =?utf-8?B?OUJVMWFyNlU3MUV5bTBVWjI3Vk40a1UrWFhsN25JNm5aeTl0T2lBMkVqMC9i?=
 =?utf-8?B?RGdPK1BlR2VlQ29vTmlPcXFSRG91SGtPQmR4ZXdQTS95cHNNVngyUWtFYjc5?=
 =?utf-8?B?NldmbXc3YmFYM0JsKzViaHVESEl2NnNHOGNKOGxVS0tvczJvRkkxaEtoKzY0?=
 =?utf-8?B?VkV3QmpNNGxNWVZyemVud3NlZDBzaGdOMlhOWm9Ob2xJSDVIMlZtOHBnWmNE?=
 =?utf-8?B?c0cyTzBta1FEZWRnSUpsSnNmTHVURDVzeGN1ZElxb01PS0FPdE16aFNaaktL?=
 =?utf-8?B?cThZb2t5ODBqRVczaG5hbHZOS3czZU1Vd05peGNQaXViMWtROTlrTWhkcWdF?=
 =?utf-8?B?bTJwVXVhb0RzN24vNHNTZU9FTXZnSWpKVnNGQkZEZkd2djZjM05RZjJSeW81?=
 =?utf-8?B?TzVLZTFON1YyTVRJLzNSSkZCRG12Z2VjQ1BLY09YRUV3cVhKZkR6eGRyZTlW?=
 =?utf-8?B?ZWRBM0phazcyR2o0SGNsUVlhMXhESlhKaWFFQ25ZRkwxWW8xVERKMm9tRmRi?=
 =?utf-8?Q?+2wMjeM7Gsvm9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6935.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWpqYjQrMkVBTWc1UWlpZ29qdDdidFVoVm4yamRSRXFRWUkzMit3MTFTL1A4?=
 =?utf-8?B?d1BLemFhZHpWM2V3elg2SHpaM2tHV0duTVA0cytzQlF1WjBpY1pBS2RHSVFl?=
 =?utf-8?B?WWM1bkgrT0RvUDhUVDhVTnFxK3YrT0RsYWUwcGNGV1pETXNmMDQ3dnpYdVAx?=
 =?utf-8?B?Z3AxVy83TFlxN1FoekZZSk5MejY4VkhxZ3VITlFRTTFUWlFJN2sydWE2SnI3?=
 =?utf-8?B?M3JHUy9yZ1kvNkN5d25HK0EyYmpxL3M1a1ZRcGt3bkZ1YW90d0F4MCtDaUE4?=
 =?utf-8?B?RURXSURkV2VNZGdPWjZTMGVoUEcxblhZNUtoOXQ2MmdOeGkxeVozSCtrdHpk?=
 =?utf-8?B?dmd5RmJ1dVVqOWRiOXpQeXk1NVFzMm9vdDBBdy9LNG9uakRlb3VROHJpK0t0?=
 =?utf-8?B?YU5vRk15Rm1rOEg0VDVYWmNPOVV6bElOcVppMkZhUHFHb3VJUVp0QWp3Uk00?=
 =?utf-8?B?L1N0ZG5VMmJPUDZuRWNhZWs4MnVnRFBwMy9hVmFFK2NOT3ZvUzZhNjdqREx3?=
 =?utf-8?B?Ym9XLytXdlVVcXdUeDZFbjkxUGN2Y2k4UmZQZlhVa1ZITURtQ0tlb2tQa0Mz?=
 =?utf-8?B?b25peGRhYWFuUDdPV24wLzNudWJ1S1dQbWJYaEs0alRnYnJpNVhnTUhpdjgv?=
 =?utf-8?B?dGtzekVHSmoyTFRyWkJVejRiSER0c0t4L0U2M2szSXlKRzZDcWNodHl4Ulc4?=
 =?utf-8?B?WDlseVQ4S3BrZDJqUGFPNC9HWU9CcVBWamlLeTFOWW03QjhKUTB6RUx1Mnhz?=
 =?utf-8?B?YllsMk1vK3pmU3pDYW5NbnZXWml5bzdyb1pkNHc5VUFWR25yTG9tZFduK211?=
 =?utf-8?B?MEVSektqTEptUUNTc3BaQXhNNHIyVFdxNlhNclVwQ1YxUXVocFA2elZ3RDBh?=
 =?utf-8?B?Z0ZJbEdFMVFTMFM3bzFhVHIyOWNtYklvM1RITWhYZS9ITkR6VWNabklIK0Y4?=
 =?utf-8?B?UnJqOHpIU053ZEIxTXVySGJRekZoQUFzeEZldzdEcE82WHhVUjdwYWxhVzJu?=
 =?utf-8?B?MElMdDI0N3hlR3FMa241Ry9pOGFHcTBLVE9IUUN5bXVIU0V6QmFsTkZrRWcw?=
 =?utf-8?B?TXd3VzJxREUrbXgxa2hSM0ZLVVlMc2F5SU8yK1hOSm04VENLcnZQWDJZL2Fy?=
 =?utf-8?B?L0JrbktwYndVdU5iUk9aUzVlVzByUDVvUWtSRVNmK3IwbjltVTd6SkcrcCtF?=
 =?utf-8?B?YzdJL1RmL010ditLOFh0dG15MmxoNjNrN0FGWlAwQXhCNTZjNXZJNDVHM3hl?=
 =?utf-8?B?SmRYa1VLdmszeE1jck9Oc2N4WHllajgrS05ORWJvMjRpd0pmbDNmUm1hSnpx?=
 =?utf-8?B?UkRnZDhGUExJSWY4UENCMUNjRm5ZcjBHUlBoOHNMd0ZHQStsQmRLS2ZCU2sv?=
 =?utf-8?B?bjgrTE9FazRSalA3UUFUSWd2V21qeDVmNEVGeldFa29xTUFveXo3MksyZVBx?=
 =?utf-8?B?YUdLTWdGTTRvQ3hsdlNzdncrcy94NDhnMXMyeXl4QlB6VHZ0SjRKK3dwMEhJ?=
 =?utf-8?B?elpWRS95WWVsblB6SHdxWkdYZ3ZiRG1OT1VLOGN4YXV4NEhVclloUXlDUldq?=
 =?utf-8?B?MjFoem02WjhHNVcrd21penVlZkVzNTNWYmtuY2tEMTVjLzNXaEI2ckxhM2pX?=
 =?utf-8?B?UERabHJXVVpDRlZlNlJGclVIWVprMjV6M0Jmc1U5N3k3NlM0eFlFSWIxVzdl?=
 =?utf-8?B?MklybWcyZGJVZ1B0U2tqVmpkMWFOc0NFOHNnRWd3SDFPcnhQeVVhS0tBYmxv?=
 =?utf-8?B?Q0t0M251S2lqdDF0RzhHNWtNMXB2emF0ZU1HVFJpRlNMQW1mT3lmZGROdTgy?=
 =?utf-8?B?UnlwZG8wRWxqak5MVXYrNk5uNUU1akF3UVJsZzQ0eHZJSS9TM3RWemE2ZDhq?=
 =?utf-8?B?alExbWZQRHpmb1cwdHdlcjc5OWd2dWZMRmFUUEJ1VnlPQnI1WHdLcEtUMkV2?=
 =?utf-8?B?U1VvRVJ5TjM3Yi9ibzh6ZkxjaGxRNG5HY3JMWnFmVzIzZmlwWjlPYTFRUUxZ?=
 =?utf-8?B?OGRmMG0rdi9IWE5CWm52VE43QURMUVk0TldqUXR4S053Tk1pbml1Mno1T28r?=
 =?utf-8?B?V2hMRzM5cjVRdDRCaENMY29heFZrOEo3Q3lQTVlOVVVUK1Q1OVAraVpZUHUx?=
 =?utf-8?B?WE9JWGd4UmZLMnU2eVpQUFo4N052S2ZWKzhiRjNjYVVXU3oxKzZCbk81YTNB?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acff987d-d5a4-4f45-2fe9-08dd51dbeaf0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:25:14.0245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjV8Ewp9BISijm3WBAK/udDqhgRO/HHsKu1Un9iMnxYsmyP0hnZru/tHd30tNleplOyswOUQhtVBn2GXtfrudA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7012

On 2/13/25 3:10 PM, Aleksandr Shubin wrote:
> Allwinner's D1, T113-S3 and R329 SoCs have a quite different PWM
> controllers with ones supported by pwm-sun4i driver.
> 
> This patch adds a PWM controller driver for Allwinner's D1,
> T113-S3 and R329 SoCs. The main difference between these SoCs
> is the number of channels defined by the DT property.

Thanks for the v11. Not sure you had a chance to look at my
comments [1] for v10? In short, this patch series fails to
work for A133 which shares the same IP.

[1]: https://lore.kernel.org/all/2f7ee626-8416-4a05-9add-26e100b16268@linumiz.com/

Thanks,
Parthiban

