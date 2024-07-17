Return-Path: <linux-pwm+bounces-2841-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9A4933961
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jul 2024 10:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6BC1F23473
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jul 2024 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2043D3DBBF;
	Wed, 17 Jul 2024 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="F0NkZtWh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023088.outbound.protection.outlook.com [52.101.67.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C3D3A1DC;
	Wed, 17 Jul 2024 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721206142; cv=fail; b=d3T+GzoIBpsZVOD9FUaA7Afp8Y3wWpexLZd7q+9E3DD16tIhvJ7zszSNdWhwo/7lWRzg/7rp/dDyENncfFR7nPTJjytxmBmpAOYeZKPK3cplzmt+DyS1KydX+6EsUQ+uI5Z88+9+dyg4ycOc4Ht9MyiHa6qQagasH0Q32EJaWm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721206142; c=relaxed/simple;
	bh=MyxgP+IQ88y9dbgbsvw7Sq33z0MRIZFO+C3j6nFF/N0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DrDCbJc6/As4XGeJgsObEgquOETKF10OhVVYTtRyqv9N8YeeKuAPPc3OUyRiE3WoQVCc9Gbm/GsWTYtfpm2taaPt25fsZF6+GapL1NTaNe5eYv6vnMlWbLFNc6FrO4nfRLCOYJvW98bmdptYTZf385b6OO+kP5klI/2L4rJmhv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=F0NkZtWh; arc=fail smtp.client-ip=52.101.67.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbvDpJVaXwdKpqvN2wRWowSunw963cYLkI4D17x7/VoCv5jbl+r2QfiGHS9lhlN4yEtZ08RBHDUAVh3eP244RWmmxynLe24isuPm4Yzl8ThMICLYYXirGgKkVZIVnZ6fnvN5V2nqKp3htadc29EhQLLittQEYlAW1hi/npXfHYz/njJmreBDx8IfpMCCB+TGoVyAxWPWYR0m6raSACsDci3IuQtOdAk4LFiavuC4OcAMiT5yG9yUrI3bPu8XQqZijNVxkuHQ76VxSNypbizTRfjXcXAiYSbH7AVc3Gfghd0fJNgjos3U83h920TTUjpbCg/jAR7RWnIQ49ExzWJnkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfpWQqJb1Lfv1avR7mK5mCOMjst/DVDV+75ajOccN1o=;
 b=YxkEvF6HqrSvt7s/pW/qeRlbH+wX1gYY5KcZZVSjC+sxqF5Jm2ae0rYKeAjMNKk3iQBSm5UA3rSv7/hZy5BDdJFJGH3djl/IdmxtrWUVU8R3gEZ5hFmlDfXq9rjxasrZtQgQMrMbzvTX80MYVYMU7qs4KSvU/77c9Shi+Qfy5paCr9xo4Efuxj1xgLBLSEIOkkHUZIks0LSmCTgp6Il/BXZCAPjNSGd1FMzXYb6LFK9aJqUy9UB9JEQNpd1Ppl3eSVzPTZEUFwp78d8oJkX2bPIDrWZX1nJrE3y/fsx3x3rC2ekEqu5HIC570dLNm9oiSxRL0n2MztGtxS2qdhdOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfpWQqJb1Lfv1avR7mK5mCOMjst/DVDV+75ajOccN1o=;
 b=F0NkZtWhZ2PdbSTOkuBX0Bix6i89AydzitZg/rVoxRJNOUO+xKLSF8N3WNJvSReJ731/rV779q/PNtdx5wGY/t2Ww3bEK1kNfZq0gd2LZiY06Q9o4Zq0URNkbUEBa8b5JymH/degg3lCFfdzXRuTnjn2D3izHrL3iN+eyTwi85A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8493.eurprd04.prod.outlook.com (2603:10a6:10:2c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 08:48:54 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 08:48:54 +0000
Message-ID: <33d93798-459b-4d33-ac59-623a68ea48cf@cherry.de>
Date: Wed, 17 Jul 2024 10:48:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] pwm: add mule pwm-over-i2c driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Farouk Bouabid <farouk.bouabid@cherry.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20240529-buzzer_support-v1-0-fd3eb0a24442@cherry.de>
 <20240529-buzzer_support-v1-2-fd3eb0a24442@cherry.de>
 <5hd7fndgivgusx76wq6mbvgefngd3tllqsfsk6pppbphchczte@ujagkep4miet>
 <25d71c19-6e94-477d-8d04-758015ca4b2c@cherry.de>
 <e7b3bfpvtrvt5g637yy7qxsbvfiylyzrjvwsro4hzp5t6cmeux@eqafx3k7oaks>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <e7b3bfpvtrvt5g637yy7qxsbvfiylyzrjvwsro4hzp5t6cmeux@eqafx3k7oaks>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4271a3-c935-438c-ac71-08dca63d49c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWFBU1RSeVdxbnhYZmpjc3hrZklUYTE5ZnVoYzl0QVlIV1l5OEl2c3V2N0pL?=
 =?utf-8?B?ajRlc1Y4anROcjBZbE5lN3VabmUzZnVKSTBrOWpKdXN3cmNCNGFhVG9BSjZ0?=
 =?utf-8?B?ZDc1UzNidk5tQnN2WEIyK2RxdFdQMmtKYUl4cjRzeEVZYzQ2d1RTU0owOVZm?=
 =?utf-8?B?eENFV1daNmt5RCsrQlV5dU0vZm1vNTNJLzhJbFlkUXZVNTNGUG51WTZWOUZU?=
 =?utf-8?B?UUhDdG9BVnBTVXQrdFYrREFvNjVWZDk5T2Z0dEU2UDZlUHVHQVNrTVBVbFVN?=
 =?utf-8?B?VXFKRmhYRUJzZkFadjlKRWl4Q1VjajY2d0MvakpiUDNJUFJVOFprUXR4eitP?=
 =?utf-8?B?aGN1cHlNdGhvZE1Fd2twZ3BKM0lWUGdhNzQyRkwxd2pXVTMwcSt0S1pqalhs?=
 =?utf-8?B?djd0SVJ5b0xwSHp6b3lLNjdDS2xQZjZKcE12dTRIU2FlMFdCVkI2VVRKL0JD?=
 =?utf-8?B?YjY1TU5YSDhwZ3FyYmw1OU9CQW9LOEQweDVpbHlIYXFDK25US0E0WXN6Mm5C?=
 =?utf-8?B?QUFUUzFWV0pCOE1rSCt1d25DSTFVL1dTQVA0NWZ6NnFYL3RMaDRnOGJ2SFpR?=
 =?utf-8?B?cGovWURvTGJmUkhyQkhyTXd4WU5EUXlwSDAxN1ZDeTZEL0ZuTlNzellzT0ZR?=
 =?utf-8?B?UElYaTNnaVZwaTV6RXYzbExJaTJBejU1Ym1tZGkxWDY2UFFhMFhiNWRsQTVK?=
 =?utf-8?B?VDNVTkt1OG5VOXZabitqMC9NbXU2U0l6RG1jeFFaMUVjbzhDOFRJZldDZXNu?=
 =?utf-8?B?clh6ZkVaUDZEOUM1RUxiMnQwdXkxR3pzeENWOVg4WEwzSzVrWXc2WGg4cGV3?=
 =?utf-8?B?VEJ5RlVURTZyNENMYm5PT3lKTGE5VnlNbTBFOFBmV2R0Ykh1cGZ4Tm15MEJ5?=
 =?utf-8?B?TDJTT3Y1ZFZmS3pLRkdaMjRmTW8rb1N6T2dtZmtZMjhDN2kydVhGZVExeVY5?=
 =?utf-8?B?ckdWS0laZFJ4L3dHUFcvcUFvN1hjaGhoWFYzT09lazlxSktxUnJTR1VHanRh?=
 =?utf-8?B?OTd5TDNPMSthc2l2OGdIWTBjanRnd0haUjR1bG0rNWtkN25OSFlZL1hlbmw2?=
 =?utf-8?B?dGszOU1QckFHeThLaUw0NERoY1dBY0hDWVJCNnZuSjBBL0RuRXVGSk9hYTh5?=
 =?utf-8?B?NUVuNHZqNVdsVXloNzdYQ216ZTIwZ0FuUnpJaklvRGtxOGd1Z0piTG9kNHd0?=
 =?utf-8?B?TVArNW1rMENEaDdHNnhROW52OC85QWEyeFVuY3FEKzhCSFJ2RmpiQTZJZnZ2?=
 =?utf-8?B?dEpMdGhvek5aL3Q4VzF0bXpnZWlkZWNCUjNLRm9LMVFtVEZrTHlzQ2VYUjJD?=
 =?utf-8?B?UldBdlhFNStrQjVDQXM3R2duZ0FZTHMyQk4vNWtsbjdvdStrMGZEZkRmSHhU?=
 =?utf-8?B?K2gvaW9oWnVHaEdhYWlsN080M1RYNFFsVGwvMlV0Qm1nQXFvY0t6VVFVL3Ay?=
 =?utf-8?B?cXFuNE5od2tZQ3Q0K3hUYUVTM2d0bmNKMjBscmwxT1FvSWtsbjZobkJGL0xQ?=
 =?utf-8?B?ZDhxRjYvOFVHOXN2em5hR0ppWmR5UmExM2pZdzVvSmNuTTJXdGhMY3VyRmZ6?=
 =?utf-8?B?OExMaklXNHJYUHhmbzkxcnJZKzlBbndIOW1wRWEwZytRby9GaEIweXl2NTR3?=
 =?utf-8?B?S3Iyand6eEoyV29CN013YVNyN205ckdpNGFQZWlNMzRZYzJUcWVSKzJNRUp1?=
 =?utf-8?B?UUNZeUdEYUJoUlVKY1lwSHRCamU4ckdTS0doWGdPSHFnc2xkL0t2LzY5TFJ4?=
 =?utf-8?Q?avJqoxHxwfPDOwL2M8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VC9XWXZWMUtCQjFGY2dNQWZGdWJkNTd3MFRRUk1vQ2xtaHJCQkE2WmVQWDk3?=
 =?utf-8?B?NGhLUG43ZVR5R0E4R2FCb3NPUzFhM3hKUkhXZ09uTmtYR2pWUWgwUlk5cURV?=
 =?utf-8?B?b0RDZ1k3bk5teHdySVZTam1WZjlNQUN2Z1ptWWhQd0dUMW9PbEFCSUxlSnRw?=
 =?utf-8?B?OE1YaER4WmwwMy9nTUZuTEhnZGwyUlpXcEVSYVBSZDdTcDRUN1lFcWI0MU5i?=
 =?utf-8?B?TWhpUW1yL213K21KL1c5aFM1a0s0ZUFzaEFLVjdWeVJud29zRXhKNENrTWJW?=
 =?utf-8?B?dEtZM01ZNUVUTFpiT1lQcjRDRXFYbzNpMncxMEZkVFl2bTV4SWo4NERGUjdI?=
 =?utf-8?B?a3VHVlRLTzRRRElWbEJwdER5QUdDR3JtbVhtQmlQb2xRa21yWjZNdVorYlpU?=
 =?utf-8?B?eDJVWklQckR6Kzdrc2trZXJXSER5aDI3OE1BZFBQbXJwYWpuRmJ0eGtWZ0Nl?=
 =?utf-8?B?MWdNbUc5aFFmWnV5L0grREgwdTd2Z1hXbnViaWZDcmJTY3JBb3VPU1dOQ2R4?=
 =?utf-8?B?NmEwWkRWNjNkaTk3TURHT2Ztd0hNQ1YyRkFoU0RxNnZlUkVCeVorQnptby9m?=
 =?utf-8?B?d3o2a2hxOWtUUXI0bFJHUncwaDZXWlZtMEhiYkRTVHdkQkVoOXJXcTlrc0lm?=
 =?utf-8?B?WWU1K2NsNTZiRFA3QjB4SS9UdTlxZGZMd2NtRmVQa3VlZ1FTT09xTm5yb2Vu?=
 =?utf-8?B?ak5XVEttam5NS0NpQjZkYmdoaEtsWXYzQzhNblRiS1VRV1Awa2ErT1FxVlNC?=
 =?utf-8?B?ODdNcHVnSFVCMnZxdzVXRS9NaHJFbzQ3RW5pWUxkV3FJamw1aGZDYUtTU0VL?=
 =?utf-8?B?V0ZBdUMvRzVZdGRDOWx2NFR2NE5qVEoyUjg4aVlNNDhuMklHdDAxUjVjWWpz?=
 =?utf-8?B?WWhRbUdqTWdYN2dwTFhyWW02U1pUTUw2bHc5RnZvQXVhZFFjZEhnaUVzcEcx?=
 =?utf-8?B?bnpmWG11V2FpeEp2b2dEQW05dFFnck9DYktxclhyK3Z6VkJpSjlxL0hIT1JE?=
 =?utf-8?B?T3U5T3poZExJK0hvcUc3TW5ZYTIvb2RnN2JiaTdnOFV1TWRNUXFvcEpHNkZr?=
 =?utf-8?B?amQvaXNwMzQzOVVFV0pIbFVqc21ZTmlkeU5qL2E1c0c1N0JueXYwVkZrVlBv?=
 =?utf-8?B?Smx0T2dvM0s4M3BoOVp0dXpQbytBZmNnVXlXS0FleVZZcEZXR0U1dVo1S3Jr?=
 =?utf-8?B?NzVNcUZNanJudTdRUWZOVUdETHg4MXNXL2h5VVJrTW5BSTJWVlhqWncvc1VY?=
 =?utf-8?B?Y1VlNGtNb0xMNzFzaW5JRncxakxRZ3Y1cmVVTHowMXlJTWF2SG0zNXZIQWd1?=
 =?utf-8?B?Q2gvRitiMHZEMUIyVkNNVTFKd0RrcCtMWW1mVlZLYU1lRERWeCsrZnFvMGZi?=
 =?utf-8?B?dWpjVTBybkloNkt3N0dYMUtONFJSLysybjdLRjg3bjF5SFFxM1dDbldlMk5j?=
 =?utf-8?B?bWhGY3N2OVlsTU80a2N3K2p0ZHdqa0dlQ2E2aEE4NUI3QXc1SmtWemZlYzdF?=
 =?utf-8?B?dDViRWUxOWtWRmVMOEN3My8rMVB6UEhJTitQM25rMVZCY1hPUUFjRHU5YkZ5?=
 =?utf-8?B?NE9sUWJoakR1ejdlMzNYUmxGQ1hxU2NUZzBLTDBoRWtad2dqNmY2RkJ5NmVQ?=
 =?utf-8?B?SnU2ZWFpdXBhdWJlRGxzbkZDd1U1ekppU1FiRG0rck9TVGtFQ0FONXVhWVdT?=
 =?utf-8?B?eVJNd3VRbEF1cjVNTDJ6dHd0TktzYlk5OEpDQjdlMkZPTXcwUEdVZmxubTFq?=
 =?utf-8?B?TWVZa05QdktWK0pybmFUZzZUNWZSZkt4RzdlQU54a3BEOHBQUnp3WnhCZjVW?=
 =?utf-8?B?azRqM0tFZTgzbVdqOXE0d2xBemdoaGNJYzZ6OThvUGhlVzQyMEIwbFBvWjgz?=
 =?utf-8?B?NFZ5cllFamsweXBVbUhVQXBTdXVTMmZJMDUwNms1OW9sV0FTb3YvNDArQm9P?=
 =?utf-8?B?T3hORmZySksrR1BWb04yMVl3M2VHaVRkcjAyVDdJR0xwNmhya3pBclQ0c2RP?=
 =?utf-8?B?QXFoMmttMnZXazEyeXFzclVLQnUvNE9aVDJQZFNlVHhjZHBxSEtzOGM4Q3d5?=
 =?utf-8?B?VGFrS0ltYmpuaFpoSmU1aWFpL1dJWWwzRFdKQVJWZHJDalVTWW5HVXVia0dm?=
 =?utf-8?B?QjNFRkQxOXk5UVlGWnNuczlzOVZNZjRtM2tFSGxmM2lyRld3YnVwejBHOWNk?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4271a3-c935-438c-ac71-08dca63d49c8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 08:48:54.1893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpJRNZUBqQR7pLPFagISCMw776SGeJ4WtvV0R+6PXEiplcAitvkDk2X/pBfSOjyPXuh59ToUV7OZX4DksgcEqjh0EM7BjaZmpgLoyn/9e5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8493

Hi Uwe,

On 7/15/24 5:09 PM, Uwe Kleine-König wrote:
> Hello Quentin,
> 
> On Mon, Jul 15, 2024 at 02:16:15PM +0200, Quentin Schulz wrote:

[...]

>> To give a bit more info on this, there are two possible flavors of the MCU,
>> ATtiny 816 (datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/ATtiny416-816-DataSheet-DS40001913B.pdf)
>> and STM32F072CB (datasheet: https://www.st.com/content/ccc/resource/technical/document/reference_manual/c2/f8/8a/f2/18/e6/43/96/DM00031936.pdf/files/DM00031936.pdf/jcr:content/translations/en.DM00031936.pdf).
>>
>> FYI, on ATtiny, we use TCA in single-slope PWM generation mode and PERBUF
>> and CMP2BUF as period and duty-cycle registers. On STM32, we use TIM15 in
>> PWM mode and ARR and CCR1 as period and duty-cycle registers.
> 
> Wouldn't it be more natural with these to have duty in a base-2 register
> for duty, in the assumption that your MCUs habe this, too?
> 

Not sure to understand what you meant by base-2 register here? I am 
guessing you rather wanted to suggest a different unit/representation of 
the duty cycle in the register in the FW API?

Cheers,
Quentin

