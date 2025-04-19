Return-Path: <linux-pwm+bounces-5577-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABA8A940D2
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 03:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B97D8A5639
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 01:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA83A132103;
	Sat, 19 Apr 2025 01:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VG6j8+VH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011026.outbound.protection.outlook.com [52.103.68.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E2378F3E;
	Sat, 19 Apr 2025 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745025877; cv=fail; b=RjLuGqBb9d/elGC8Zrd1iRlyhllaxHqmu5M3BRL9uZxbT0M8YcrXdYpq1huVllDZGk+QlhWAqEmFHEWlPl6bOOHnrsINCE/bWHtKSnJ/SYCH2q/g6PK6kBVuTK5+kiFap7CKdrR+N/KaAPzZPbTMkjrQU/ZS28eDuOhWCjIKzHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745025877; c=relaxed/simple;
	bh=c/or11aib3pUyLa9WIBbhm7DhklXlyX7PCo8F3s/OsA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dLcCg/2SasvbdWDXr3QZQITZ+D3+XYQzoijX4DvYKCxVXhiz8dL3SEstoQl5mJyXdIv0OCdwbji0WV7AeLIWtAW8Wx5QZJ9FNjQzjaxtiK1zKw/fNw6qTRxlPtMTg9IcBI9vulx89JcgLgNFKwOQ2cb/L10e3ygQ+fMnmFO1Hhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VG6j8+VH; arc=fail smtp.client-ip=52.103.68.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWjlK4i0yksn6y/t8McHop8I28jGHXqnfoIMeALTdurbs+Yo9fcAzmCcXddj8nS81jJM45lPv8FwbRHd9ulGB0r4J8BEDrvjptnJivXELbrxCTJDnolnRoUZe96P0ymPUEcq/opY6hVJuReyaSRXZ97211yNiftP90pzlk6Axo54kPPPYnbcmc9e6Z5ge4BjwITKMXBYKrh20fkiV8+yNy3iktX7FhXKCjEFzSYn5G0IGNXhmE+1dsAIkOToK9qTYTfe/FIaRuCK5xrDZMX9zhFluHfNS7Z7evt3Q0vg+5Ok2wZGWlduFdziqa2X7bkYaFIEDpZQ/gxVKNgCLSVuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1nfxXLtIeG3VjYqwFfmPfVdCeUKTA3fRNoEFsGaapo=;
 b=mAJtRBkHe7HCYq1v4wU4ogf0FnGajw1ZQbPj4AWq8MzUPKgmrnzh3dK3JO4IOckR500yfakcwBF8VYXeasETj9pusBcQ+Hs4rE3/lbwbrlfOgFFiHmHpgzzAnOZVqSPrJHL8uHnFXCxAqMQcWY3W2QtnA2h7CIKAMEd+/8O4Zip6feVmyV0oFhTQxS1/UkDo0dkk48/Ku05XHqzvK+UNjGl5h15pyuCYT2NRSk5zdLQa3duZNeIdbxbVElfJ2jL2aczhrWUMsH9/35rKlcGFPGsEmMrnRmdE95n7pXtJ6HCrmL1UwjBn2IqDtm/jleb0uRkoHwtN55Z2WZjDHJlOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1nfxXLtIeG3VjYqwFfmPfVdCeUKTA3fRNoEFsGaapo=;
 b=VG6j8+VHLI0/DLSHSJjv3hceM3wsoQqweNk9YP0gHdkpgD3tFv3gT2ThGl2JljLiLdykoNN6e2dE/NiBjnzWKQOhHBp65pPHoXCVa0cK5/2xljry4D+/dfXDWoPyTTrwbpIvTOvnw/vvCkoR0iWP0Ym6zaswdS0P7o/RXtTe21YPT5s+bRGpS6UpVGky427fGrX/g2muqENjnxgim6UWh3cCHyzVgDWDoFT5QeKAsM20Q8Pv/guUTk7xJHTVZdlc5HLKajSdS8QGVSJYjE0gzIM8YbHIe9EiOCYJI54xQ3P5ImA6v2mf5p2jjMW1Qkhm77Y5ORM+WbjW9SfAiZE41A==
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:100::6)
 by PN1P287MB3646.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:24e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Sat, 19 Apr
 2025 01:24:28 +0000
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4]) by MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4%5]) with mapi id 15.20.8655.025; Sat, 19 Apr 2025
 01:24:28 +0000
Message-ID:
 <MA0P287MB2262E14F6F9758646320F7CBFEBE2@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Date: Sat, 19 Apr 2025 09:24:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] pwm: sophgo: add driver for SG2044
To: Longbin Li <looong.bin@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20250418022948.22853-1-looong.bin@gmail.com>
 <20250418022948.22853-4-looong.bin@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250418022948.22853-4-looong.bin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::13) To MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:100::6)
X-Microsoft-Original-Message-ID:
 <410c31fe-1c13-49c7-b2ff-7ef03e59d0f9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2262:EE_|PN1P287MB3646:EE_
X-MS-Office365-Filtering-Correlation-Id: a63b2d83-315f-4450-aad0-08dd7ee0ed81
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|7092599003|19110799003|6090799003|5072599009|8060799006|3412199025|10035399004|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0ZEZ2lBY1RuSklvbFZhZUVodm5tc0wvMVZBVEtoYnBZRjFaNkF0TCtQWTJq?=
 =?utf-8?B?UUlqZTdvdm1oMjFqOWMzZDFta0F0RzV0eEhkWG9kODF0N1hSZ2JvbWt6OUN2?=
 =?utf-8?B?NVIyUStZQWVkQ2JzVWMrc215TEJGNWZnTnNzYTNnZ0tKOHNIY09STXhjeDZC?=
 =?utf-8?B?WWhmY05yNTVWaUtnNWNIejlHcGxuL3RZRlUwRTJJVWhTeUUvRm9wNy93Vi8z?=
 =?utf-8?B?T1B4WVNhSmxYdVRYYUNBMk5SSlQvNkdkTldpQ2xVU21wM25FZkNPTkV2SjZ0?=
 =?utf-8?B?WGpzRE51bktLU05rYzJKbkk0QUFPbXpnUy9HdFZPUFB4ekh0Vi9ISUg3V2Fn?=
 =?utf-8?B?bTBXeEMzMzVpY0VscXdoRzJ4Y3hhSGQ1V2RRdmtaOWNHTGpwTFp0QmVPNlpJ?=
 =?utf-8?B?Sm1laGswblBDYThUdExUVXUrN2ZPUTZzQ2xFSGJCOG1QRkYvRjZiNE41MFlT?=
 =?utf-8?B?VU5GQitpSWpBR2FZN1BvVGJhNWUzdkl6ejNoeW91cmZ2NkE0WUhVMWJnWGZZ?=
 =?utf-8?B?TncyNzErKzBESGo5cjlxdXY2dUpnbWRqTDFMdjZOT2ZZdlpCYis5T1I3UFEy?=
 =?utf-8?B?NC9KSzRERHhrNzBJUERkU1NadDl6K2ZaTVRwbHVmZERmYTk2T3JuWVhFWFFx?=
 =?utf-8?B?OWpEWitUL2RJeUhnZjZybWpkck42cmtoZzZRblZ4bmRlbE15aWNobk9NTTk3?=
 =?utf-8?B?TE5iZDAyUXUwUmtGYmlzMGV3R3BqSFVob3pUV3FpbUhaZ0ZDTmdSM2dwL1No?=
 =?utf-8?B?MmQzblk1NTMyZlNWeXdLZVIxeklDTXVaRkJ5cnJLZnRocjhmR3RZemlCYlJk?=
 =?utf-8?B?SWkxRE9tTGs4VjB3Z21YZHEwTjdwcjFCYTBPbzVTNDNoVGlEYnA3VTFHbS9a?=
 =?utf-8?B?Y0VOYzluMWZGZjlBbHF5NzBzdGwyVG0xQUxPSjhMUjhhQy9qVHNYM1ZCVzB0?=
 =?utf-8?B?d2RSWG11ZUZLWGRrR1JDa3hCQTg4K2F3TkcwS2xjRkxVNG1qT0RxRktjbDI5?=
 =?utf-8?B?U2pEUWc1enZFUithL2dsWW43YXM4ZXBZQWRQSnZvQnV3bno4U05uOXZxZFJP?=
 =?utf-8?B?NUZpd0lPaUtRWExoRjhuM1FvSjNYdHR0dCtjZ2JiWGxvdWNRNjRlcGVrRmI4?=
 =?utf-8?B?Z3VTUVJIc01BMXBzT0d3Qy9rY2sxRzVya0xHdTdoWmlKTnBMWVlCYW5KS3Rr?=
 =?utf-8?B?YUUzbUhxdDg0dUZib3d3SVBTNHFzRTVOT2hTdTNLV0JhZ1BNbTJUejBGWXN2?=
 =?utf-8?B?WUo2K3ExUCs5ZExtWmhrc2RXMzFWNHVPV3hzME51Q0VJckhlbEJ0bkJvQU0x?=
 =?utf-8?B?V1VVTEczSlFPcVBOSG5JbndVMWlEUURYZk55eWdLenRTTjc1N0pDOXExV05m?=
 =?utf-8?B?bWNTNitjcWJWUHJmZ09EOU5hd21hTC9VMDNEQnBVTk0xamZCR0pVQXpHMVo4?=
 =?utf-8?B?Ym4xb3Z6OGhtM20xaXEzdkpoSG5DZ1h5OTk5UTd0WmhHMkowOFg1WlVUNlVC?=
 =?utf-8?B?dVBEdFlpbTg3NWgwSlFtUXBhS0tsVFFYMEptVlZJQVdRSGpKK3cwV0tVRXVT?=
 =?utf-8?Q?cgM3hntdMt68T/HOHWWFFnmKg/otOah19eR9FN5Lhrv5Xj?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alJwZG9GQWh3VitEL0RSVWJhOC9FWmdvcGxKajkyZGU1WmRjYURkdno2SUt3?=
 =?utf-8?B?VDhNa3lPdTFjamYwWnd1dTk3MWVzM01wS0RnTzNPNjQxQ1N6SlFLUHRPMmZm?=
 =?utf-8?B?cjNyRlJZUDd0QlhEWndaSVF1cVhqeFN4cFpYcWdyVG80NXB4UGZ6NUd6RXUw?=
 =?utf-8?B?QTk2b2wvSTRET3VpN2I0ZUdvdG1LZDdMNlZBL1A3d2Vnamt4eW0vZktsdmRZ?=
 =?utf-8?B?ZFB4enNZcVNoQ1hYc3lhZ2xRb0lrd09qcEpCdUJzRTNYS2NmcVFtOEFDTG9k?=
 =?utf-8?B?bGtkNU9DbFdocHhVdXVHbEQ1Ym9yTXRxOVhzZzNVSGdkcVltSnBFNGc5UmhO?=
 =?utf-8?B?TEdQSy92ZkIxZktWUUc1RmRtaVVZYlNSUXlaVWZMTXUrc2hHeENjLzFTSldj?=
 =?utf-8?B?VzVWWlN3L1pEMlkraTZ0Wkk1MTFjMm45ZEZnSzJiVy9FOTZNQzFIMVNHRTBl?=
 =?utf-8?B?MDBjRStzSnhka1VLWlQ4OWMrQTdOQndYaG5IdVdsSk1qNTFDaUE1SWxvekdQ?=
 =?utf-8?B?UUc2ZExLVmg1NXArdWVNcUFZcmEwY0JvMFkrR3Fhd2I1NnNnekZ1WFRnT1FK?=
 =?utf-8?B?YnVJTVNnMHdFbktveGsxUUlYUFl6dE1lcUJuQnV1bUw3SitaWG1NMFJYT2pt?=
 =?utf-8?B?VFZEVlFsdlZnbjJjZmxYYXRSampKTjFYdVh4V29QbnVxNU9UQm8rTlBYZkpl?=
 =?utf-8?B?ZUg1UFZLaHd1dkZ0S3AxV2JNNGN0NjYrQm56angvVE95T3RIV3BPN0Z6dHFs?=
 =?utf-8?B?d1g0RW5CQXdvdlRWNVpJMVJzYnlISDR4U21zRzFzcWNEcTVmb0N2UzVmWlNl?=
 =?utf-8?B?bkdzUnBFRHFVdmZNaEE5cGlkbWgvM0ZPSEtXaFE3cG9rY2p5UHM2eXdaQ0xR?=
 =?utf-8?B?NEViaTBmYU1ncXVhaGhOUis5SnBJV3FnZDlkMUNvbVByNW5zamd3dVVGY0wy?=
 =?utf-8?B?VkNVUzRoTDd2NmJKRzJ0b0JnM2s0SWdva2l6REVtaHd0YnZnU3RadFJEQ0lZ?=
 =?utf-8?B?bDNUN2g5ckluUHdkekFZKzhqWlh2dkdjdWkxSVI3RVdqVDB2VjFNOFdHd0k4?=
 =?utf-8?B?WU1wNm5SdG10aTJwZkVqZWNBc3RrYlV4QkhZS2dLTHBhZG0vZWhzRW9DU0hG?=
 =?utf-8?B?TnVWQXF1bHNDeEZsRU5md1dOOG5lRTgxUVJzSXRJNWNsRWh1Y1BsbSsvS1Z6?=
 =?utf-8?B?TWlaRmJuZGRZdUdQMDcxVmN1UEFWRmQ1YlY1ZGtVSmlaKzVBSktPeHVjLzI0?=
 =?utf-8?B?UURKdlN1U05BMWJsNnpRUERqNGxSdTFDMlZwbytiTG9lQk1zUlNnS0FBUDVz?=
 =?utf-8?B?eFBxb2NzNXFydG9Dc2Y4WFhFeEl1dWdPVkZPNHpXU1VtL1JJMEZVeFBoWkN1?=
 =?utf-8?B?ZVJqdEJRYk9NNzBsKzMxRDAxQmhNRTI3aEg5aEhoNzd2MEx0SFdsUXArVjdp?=
 =?utf-8?B?ejZzVnNnZnJNeXo4N2ZsdDJSdFVTMmNhMkNpSllEalhKTkdPVVpUS1ZBQkxG?=
 =?utf-8?B?VDVFVEJYLzRoT282dExZdGltcWdjMFZEdGUxQTdTOTlaSzhhd0xHbWxTeXox?=
 =?utf-8?B?aS9tY0Y1d1hFZ3U3Ny9EOTJPaHh3Z1llV1hGRTE3WTc5YjAwV1Qwb1FPRFRs?=
 =?utf-8?B?a2xSZHZQdG13bEhOU2YxT3pCS093bnFBZWZReklmMHlZNHZGdjZ6WTJxSGhi?=
 =?utf-8?B?YzMxdjRGajZQL3NFTXUvbGZoRysvUEk4czJsK0FPUDlkKzQ4Z1d4dk5iZnBK?=
 =?utf-8?Q?XSZvvGoih2+FMyTc65w52FaazZf8d2obqvcXZpv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63b2d83-315f-4450-aad0-08dd7ee0ed81
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2025 01:24:28.1879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB3646


On 2025/4/18 10:29, Longbin Li wrote:
> Add PWM controller for SG2044 on base of SG2042.
>
> Signed-off-by: Longbin Li <looong.bin@gmail.com>
> ---
>   drivers/pwm/pwm-sophgo-sg2042.c | 89 ++++++++++++++++++++++++++++++++-
>   1 file changed, 87 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
> index 23a83843ba53..26147ec596c9 100644
> --- a/drivers/pwm/pwm-sophgo-sg2042.c
> +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> @@ -13,6 +13,9 @@
>    *   the running period.
>    * - When PERIOD and HLPERIOD is set to 0, the PWM wave output will
>    *   be stopped and the output is pulled to high.
> + * - SG2044 support polarity while SG2042 does not. When PWMSTART is
> + *   false, POLARITY being NORMAL will make output being low,
> + *   POLARITY being INVERSED will make output being high.
>    * See the datasheet [1] for more details.
>    * [1]:https://github.com/sophgo/sophgo-doc/tree/main/SG2042/TRM
>    */
> @@ -26,6 +29,10 @@
>   #include <linux/pwm.h>
>   #include <linux/reset.h>
>
> +#define SG2044_REG_POLARITY		0x40
> +#define SG2044_REG_PWMSTART		0x44
> +#define SG2044_REG_PWM_OE		0xD0

SG2044_REG_xxx, the prefix looks inconsistent with 
SG2042_PWM_HLPERIOD/SG2042_PWM_PERIOD. Can it be unified?

The others look fine.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

[......]



