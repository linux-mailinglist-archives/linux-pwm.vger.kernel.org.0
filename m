Return-Path: <linux-pwm+bounces-7605-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA52C46567
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Nov 2025 12:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CB03A40C9
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Nov 2025 11:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B663090EA;
	Mon, 10 Nov 2025 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qoU/0Pb1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011060.outbound.protection.outlook.com [52.103.14.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FB1DDC1B;
	Mon, 10 Nov 2025 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774927; cv=fail; b=APm1SQZZsP8y9743hXojOjSueZnBJEghLCQSMBC8lOPpuAdCE73hjUve+TW7PvrNVg1/phkdHLeyU4rYgaKHUARZs5EbbpidK0BeejvbqPYF+i+PnMqsR9MlcT3uf7qbdOQ2a0eq5Ca8S5/sqqYddZ+/S56fHZMs9HDRu8dFV/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774927; c=relaxed/simple;
	bh=hRq8MWoVrx8hBuTU8EignojYqRVk+0T/V4u01u4kujo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QIYcFejOzcirDuHHamO5wbkj7PJ+DycPZi9dSJWmptL6+js0FHIYCZi4sSDA/cW1dMDzVEATCe9rI/gEk48jStA7kCN10MPiF2a5rSvK58mvSM6KKA+mDDS/+hMFsoHOhuk0g6a7Lg7OapCD3ZZjOa5O3PQGuPiIwvt/460hWbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qoU/0Pb1; arc=fail smtp.client-ip=52.103.14.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGoHcM+KyOZsRCL4XRS3cNLFPVeZeF3rybruTzJer0SpU+AV4sQU0oXqs11Kjj+clw994vEVbly+oE4EmtT8VCPTxllszITxYI5XcjGtDTkA0cw0hPteOXW96jYkd2lqVQEoDSnP+qMtPwc8yNdzA71ApNlkWnJvT8msru7Bl65hKv//3bReNqaTiQLNS15yHNnUMFrV2N71Li/zVdHbcU+LHYOpPTu/PFVctrMPC6QN+pNeOYKzgJK7lkyl+W88L4sHq+/7j9QABi1ZwebrVWPU7hJdr76g9ZB7IK7VqOnv54C5w5RnTBcYTmKtP1D6/1gFufdQr4E5Nbz+WVfrZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCoar/bsCPXxTlOsNmC/Eq00BeoJXTeyH8W08QHjwVk=;
 b=SUVG3GTes7sZ43YtR/qBSXb/D3xLAGyy7BR5XIetM2EtIVBBRsWGO8+UxYSBX+KTkAWFu/6VtHuEtkClXcCZiPbNYbMPglkczSZhCxEayEDlwmx1z4EK18EdI+TEqucUFEbOhtXwDe22O3pLdBQ9BkY67wk7humGwzhYUEWvTHNorItq1MYC4tfEZD6uHO3vo3JBvqXNpQR71hko6K1rPdZ6zRXv9I4eNsMcp+a6sUEg+Q+xMe84Yy8m4XBXc9Z/lffsyEPp1RldkhAZ267TFJ/OgyO/oR0/NWjM71ckLow3kYhSKXweRoLNY9f3JBfqfYLM0QOv7FdNdB0K59TDdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCoar/bsCPXxTlOsNmC/Eq00BeoJXTeyH8W08QHjwVk=;
 b=qoU/0Pb1NNheVWiWxwwR2AJVO7xGHplvzpMMdtFso56qfihYINfvaMm74ArQiQth5kop1T/TVnNUZSY8r+06DGljLgtKTGvtpY2D+wGGoEkGCAQnQ+ZoN6r4jYNq2JTyBUjS5Y38kGznRF2iX5AadaC0RsIZXve3CVSSRxp26lkStt0QbBc9nF+LyYtLqfRUTt/9sE2DJZEmjVVNThjwUodOJ/N1x/JKE6INdUtdHSYWwdTYv8LPrqyMjjKCtuBak5Rxq8WxwBro85+2RcIk2U7xq/ruejz6RihrkT2odWCMh/WESWSu71i15/+qy5GahjJOX6kBuDKIKZ6MgKptOQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CY5PR19MB6339.namprd19.prod.outlook.com (2603:10b6:930:21::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:42:04 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%7]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 11:42:02 +0000
Message-ID:
 <DS7PR19MB88832537DA9998530BAAC9C39DCEA@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Mon, 10 Nov 2025 15:41:49 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 1/6] dt-bindings: pwm: add IPQ6018 binding
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>,
 Baruch Siach <baruch.siach@siklu.com>, Krzysztof Kozlowski <krzk@kernel.org>
References: <20251029-ipq-pwm-v18-0-edbef8efbb8e@outlook.com>
 <20251029-ipq-pwm-v18-1-edbef8efbb8e@outlook.com>
 <gkvbziqeae53bunqd556r4swaye4s4lcnwthryouynwfwqrnsi@6o4cjgxiwxco>
 <lkbwgakmqknqptsjrb7hvxv3bxi3fo62vml7tmf4avo7nr7cue@dwsovmchu2pp>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <lkbwgakmqknqptsjrb7hvxv3bxi3fo62vml7tmf4avo7nr7cue@dwsovmchu2pp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DO3P289CA0004.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1f::18) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <5263c80a-c279-4320-b18a-3645ad7d9db2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CY5PR19MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c240e71-c50e-496e-05a4-08de204e2a06
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|23021999003|51005399006|461199028|8060799015|19110799012|5072599009|6090799003|40105399003|3412199025|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlNwWVJWWFpMUUFUZmRhS1pqbEE2bTlYdWRFaVZMb3liblJ5WTAxN3ZCNDB1?=
 =?utf-8?B?M1BmZ1R4Qk5YZWk2WUljMXgxMXZ0SWR1L1AvNzY2Q3dDKzlxbmdqQUFORUNs?=
 =?utf-8?B?UFlBVHBneTRsR2t0akR4Zjk3bEczcnQybVpZelhUVXQwblI3ckZmMHUrb00w?=
 =?utf-8?B?WlY0SVZKMWV0QmxRcEtwL3JnWmlBY2ZnbTlPQlBLd0l1S1lEWkt0VHJnUjZJ?=
 =?utf-8?B?eTNCV28vNjN6bUxnM2JtMjV0RjljdTR2VEtUbmdDc05xOXNxbWdFOFlmNE8z?=
 =?utf-8?B?R2E2OFBvOGpESHdpSU5sOUNFSHBEc0NrWlZZSTNweTRnZzZ1VzJ4WWQvNUtk?=
 =?utf-8?B?RmxQalpCUmVWUHF4dDVyOU9wR2kyM2NlaFhGdVYrdEtSTVRIMnRRVExpZ0dG?=
 =?utf-8?B?QlNTOEJmclg1QlFzTGhIUFFiWDhFOGVaRERRT0RoWXBiOHRNL0hEN0IrdE1O?=
 =?utf-8?B?YzE2cGZOd1l0WFM3b3V0WFBrQ1N0Z0E3UjZKazZpUVhWMzJCc0VlZFpVSWR4?=
 =?utf-8?B?OEJKMkJmM2pzbXdXdTRPM1pKN0dPR1YrRmVCQXJQMm1oVTVwNG4wZDV1Z1FH?=
 =?utf-8?B?MGcrb05jdTFLT0tEOCt6R0xuNS9UdGVQNmFXWExNUU9vQTFrUFV5S0dKbW9U?=
 =?utf-8?B?S05tU3dIVkJyQXdySzNvV3RUUVVQZGFPMmFHVlc0SklxM1VyWThJaUZ6bDU1?=
 =?utf-8?B?Y2hLNS8wMHNzcXdSaXRJaVViWllFZGwvUGg1eEhXV1JKSG1FWks1aHNGWklT?=
 =?utf-8?B?YU8xWnFiNXdMd1RwemJCUjQwQnF5ZXJIUXhpZU5wWXBCTWhxL2hEaUxTbTM2?=
 =?utf-8?B?ZUtTRndGVlNkVS81K3lTZHBVQVFYbFlLUDlSbXlnenhHdVNvdHh6cmRlcC8w?=
 =?utf-8?B?cW1DTVBYRmJjMStyUFRCblVreXJ5cWZHOUR3MjB6UFlQaTJ1U0xKZmM1RlhC?=
 =?utf-8?B?bEN3VG90ZDRrQ3BSRUpyMmxNM2hmbjhJaG9TZWhyb25ERUlTaGJCZnJQdDh2?=
 =?utf-8?B?d3haRTlKRzdIbXlubFRXQkhZa21ZSk9IMXdXY0d2dGRQK1NpSFE2UTh0MFJy?=
 =?utf-8?B?M2FTTHo5VnIyR2k1SmZ1TTU1b3ZZUWh0cUMydko0MER0anZCKytGRUVVcGg5?=
 =?utf-8?B?VythanBqMnRFWDNmOGhxdHp5cHdwRVFFQ3g0RXE4bng0S090ZUVuQkd2QlUw?=
 =?utf-8?B?cW85QnQxSzE2TzRKYkxidzZHMnN3eFhNaU5xWUY1cHA5RTFZN2tmejZ1S0VO?=
 =?utf-8?B?aGZEb0xIZGxkd0hVUFJzNkpLSWN3VWkzR05hUWh5aUdjMXRteFpnaTVJSndK?=
 =?utf-8?B?cTluTkJMaTd0c3dJS1ltbnF5cFk3VitpeUR3NGR5c0YrdFZndWpZUGxjZmFn?=
 =?utf-8?B?YXllSlBaRHpSdzVibUJERWREWG9xb2o4N3haRWN0TmpkcWtoVkEwbnFsT3d1?=
 =?utf-8?B?aVladFRraFl1VlZRMEFwMmYrV1JmMy9STkJvckNaVzZHNE5lQWNZSUJ2aEp5?=
 =?utf-8?B?T2ZZSHQ1YkNvaEhrTkw4c0Z6QlNPL1d5Tk9hZzRTZW9qTkkzSXhHbC9VWFE2?=
 =?utf-8?B?ekd0WEMvQVZaRG1ZMWliMFdxMTViR29hekxPbXIwNnpOcGlkNlBaR3hMdFg4?=
 =?utf-8?Q?diskoG7URsVhDU1KtCom6YPYPQ9PkW49uVbCyhnTkB4s=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmVHSmJiR2NoQVhmOXVzZ05ISzhISFJ4WG01NDJUQlcxR3R3NFVkL3pmWDIx?=
 =?utf-8?B?ZDZtNllzdUVjUTJSQkZnM1lpWWp2VUd5NXpTL1pXUkpEd2ZPOFpOZ2tBbDQx?=
 =?utf-8?B?QmtaVWljdnFEeDlDUTI3SWNyTjJYY3ZpMkwwTHlJMjBta2grV29ERVpTKzI2?=
 =?utf-8?B?cVZzRTc4d2gvZlNUaEVUN1FkVHVESXI5cHdXcFFXd0ZmNVh1b202c2xlNUxT?=
 =?utf-8?B?ZkF1cVZGcTNsM2RZTE53RUVxc2pqVVAyUjNtZCtQSTFZWU1UZXZ5YUd6VFVi?=
 =?utf-8?B?dXBvTlY2aUN6L1FPTjJrbE80WWZRd3RtNHFkcDdlM1VFRVJZODdDTVNkdDI5?=
 =?utf-8?B?cGc5OTh4cHlyNFVvenZSbkVPS2pSekxNTzVGWHJLdzVvL084V25DYUFwMnhB?=
 =?utf-8?B?M1lsODQvZGFxS095RzhHb1hJM2FVT0NzcWVlOEtJTHYxVlJTdXFRVm4wdTlk?=
 =?utf-8?B?Y2JaK2FKaVRyWVdnWjZtYW5pUFJndEhoV2FRQVBxai9rL3h5VmwzWEFvd0NM?=
 =?utf-8?B?MnFuL1o1V3hsY0ZiaFZYREVHVUNJMWh2UitzVDZXMXpzVlpZc0tXNkZTVitY?=
 =?utf-8?B?aXEvL0pOSmcydCtIZzk5ZW9TeDBsQys1cUdXbGYvMG93NVlRTWRuMU1CNVhN?=
 =?utf-8?B?TS9PRnVDbldhUFFaejVKTDBwYXkxWHIrNGVzRVoxUy9xUkpNbWtNVlRsZXB1?=
 =?utf-8?B?dHlwNEE1N293Y2duQjFSL2FGaGdubWY1a3RTNit0dDE3L2hmUnpYd2gyVlNq?=
 =?utf-8?B?ZWo3YTJVZTlIREhOK0FnMzUxZElmRE4zekdvd3pYUnNMdTdRZmdaUUtqbmk5?=
 =?utf-8?B?TU5OOXZWa0I3a3AvSDJYR2NlMHN5eHFDaVpLaU9QWFptd2tNRysvQ1VCNjlX?=
 =?utf-8?B?aEhwQnNLU2kyY1RhSnFDbVRuZFNsM0s5ZGdMclZVL0xCZldoa3RlWk1UUFRE?=
 =?utf-8?B?bEJWWWZLWjJIU3lmOG92dTZ2WFNzT1ZscHgrazZyZk1UVlc3NWlDOWpVYVR5?=
 =?utf-8?B?N1dTaDRQbkh6bFhvTGUyenVhMWk5U2VMcThua0xzY3gySXFpcmp4c0VsWjRh?=
 =?utf-8?B?NlVPYVBmemlHd3YyVlVGY1NFeDcvdEtlWGkzVnRHckVWRFlyZlRWeE4rMGpL?=
 =?utf-8?B?N0RXRzdybTV3R0JxV3o3dTNDQWFsRkNPMHNkcWtpU0lSNW1CRFhrZXM2QWRJ?=
 =?utf-8?B?djBZbGdXeUxVNm0wYTdVNlZ4aytNMnlxbk52cVgrQlpqMU5rY1NrM1B4S09S?=
 =?utf-8?B?SldhSzZSVTBGczY4NmUvcGlaMkFSNU1QT3ZwT254SG9FV3hBN2xJNzZEcWlR?=
 =?utf-8?B?M2dIOG1kb2FOWlZvVlFzTm0vZUY2anZPUjNGUlY5ZUc2SWl6UEQ4MU5CTlJJ?=
 =?utf-8?B?eW41ZEsvQkcwN3FnalREeFdMR3RvUkJCUDROUzhKWHFycmRERTJmZ0t5K2NG?=
 =?utf-8?B?Ync2VWZnNWFsNGRZVFA4N1lGenZLSFRHazRDTWpaQm9Zb2pMNS9qSlhubkdm?=
 =?utf-8?B?ak5IeFYwUnlvSHkwNVplVzRIdkNKQjVxNnkyTjNUaTczaXo5YTBGT0RjdnA3?=
 =?utf-8?B?RVh0MEp1OWl4QVpoUGJHalFva3hoSitmTWN2T0RZTUZ2QzBMR3o5VGVGdXZ1?=
 =?utf-8?B?QWpYYzI2aGZLaGRoZ0xrQlE0U3pKeWJLdUtJMnRIWFpOQjBUY3l5cG5ubmsv?=
 =?utf-8?Q?hiWPCn+BU0hUytqMiFdb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c240e71-c50e-496e-05a4-08de204e2a06
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:42:02.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6339

Hi,

On 11/10/25 15:32, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Oct 29, 2025 at 10:22:41AM -0500, Bjorn Andersson wrote:
>> On Wed, Oct 29, 2025 at 12:36:57PM +0400, George Moussalem via B4 Relay wrote:
>>> From: Devi Priya <quic_devipriy@quicinc.com>
>>>
>>> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
>>> [George: added compatibles for IPQ5018, IPQ5332, and IPQ9574]
>>>
>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
>>> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>
>> This is where we expect the [George: ...] comment.
>>
>> I'll leave it up to Uwe to determine if he'd like you to resubmit this
>> or not though...
> 
> Don't resubmit because of that. BTW I only think this type of comment is
> important for changes that happen without involving the mailing list. A
> typical scenario is when a maintainer does some changes while applying
> the patch. In this case I'd say not mentioning the changes you did since
> you picked up the series is completely fine.
> 
>>> ---
>>>  .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  | 51 ++++++++++++++++++++++
>>>  1 file changed, 51 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..ca8e916f03276e93d755d574e2567b0e4b86a8ce
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
>>> @@ -0,0 +1,51 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pwm/qcom,ipq6018-pwm.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm IPQ6018 PWM controller
>>> +
>>> +maintainers:
>>> +  - George Moussalem <george.moussalem@outlook.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - qcom,ipq5018-pwm
>>> +              - qcom,ipq5332-pwm
>>> +              - qcom,ipq9574-pwm
>>> +          - const: qcom,ipq6018-pwm
>>> +      - const: qcom,ipq6018-pwm
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  "#pwm-cells":
>>> +    const: 2
> 
> Please use 3 here.

The driver doesn't support polarity and I don't know whether the HW even
supports it. Hence, I kept it as 2 as originally submitted by qcom
(Devi). I don't have access to the datasheets. Would you like me to
resubmit a new version anyways or keep as is?

> 
> Best regards
> Uwe

Cheers,
George


