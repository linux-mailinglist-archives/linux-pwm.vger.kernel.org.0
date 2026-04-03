Return-Path: <linux-pwm+bounces-8463-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEFXIyyZz2nmxQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8463-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 12:40:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E451B3935CC
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Apr 2026 12:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A79FD3002B5B
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2026 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D8D37F8DB;
	Fri,  3 Apr 2026 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Jn0Ay6Y+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010018.outbound.protection.outlook.com [52.103.23.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E204117A30A;
	Fri,  3 Apr 2026 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775212841; cv=fail; b=fdTw/juMKBfhJZDjXBAnZBNY7op/OiCs30ZFA88XhcNGU5scT3ICVFTKMDnpYyq/qVXey0uLiYxTvRBNx7MprGTZiI8mTGiFIiGZOy8VFhMGptsNaRgWR0dSZ7bEvRGgfr1t2o7fctOC/CkG8QXtZPYXuDu6g6oXuhfNr/06fMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775212841; c=relaxed/simple;
	bh=2VbXIFG+2r2hsGc/1QTTwYbz7xjVcWECpDOKUmIvA/w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QJDH1fyLJPJAQufDCIXMAe48B6tycLIOQaczV1fCxa5vyY+Dnljokvn0+jhF77D1GXx2P8ZD7lFhu4rgar+KAoHM5L6OaT/pA7PstqRrEfPqZWEiVzsH7EghU1o6VMAXjQ5B6OGg4Q2s/L8dvmphILgdR51HLEJYEZpo2fXCFqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Jn0Ay6Y+; arc=fail smtp.client-ip=52.103.23.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlbOKJ3ZUE4LQRXJ6b/jkpQn8GgZkcuuswnYnrldjAqABd3+YzZQ32YDoMI78UTbQlW2mnlyeIkZuZXNRINUGvhfdrvhkw7AqGwEPLp4Cx9FNcLbc6z8Kuyz1Mt9UnDTGKwxXHzzEJDuR54PXsjgpcGOf4bNxTQIENDZ3HHHmvER1bI8WkNqLAHBHY4TNGw8qY4us9h1Gq0JzmmJUaS/oAiqH0je0nPKpALMqMoOEx/dMsz0PTUJUlAFLMh52rSZqD1ZWZ5xHti8ykHKy4gnH9r5dgxEh+0A2WbVVf41SooLdporDZPoGGWSrXmiTA1rGTvr558nGR8n39fwODeObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yi8671fXhw4P+NTtGZOQdAPfKUvTa39OWKMmF6+3P+s=;
 b=Mz+AaUEcxcsDk1HT34fZGp+JkbweAieIq9I7hapznlcTsxnaz2xRh04QGaFaGfScBEzl7N79XpsLSEpkc+X/Nw6Joz+53yxDe3wRprHY8TaB6HaFdplwXbCqrtNd7KqCXrFReAivf7r8jj2rrqGN5d+qj6yJOBERc5pBul5LuqO0Uch6IRMhWH0g7EWOIeDbSaCATuBm2dJPU4Thuz1nwO925+c5fFOesuCpHvJBs9VsThIy01OvbYT7T5/bnmz/ha6f+HEtfcTok2VwzRNDwXsqpo+PuROvhcmXPrtwJwHWT2cu7mtOOiAF8Cpb6+n3WPMW2cBuqwmFu9+fqAuoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi8671fXhw4P+NTtGZOQdAPfKUvTa39OWKMmF6+3P+s=;
 b=Jn0Ay6Y+abT7nbr0563o+FzK4rkt7fD2eNzXkAu9kqNOgnV1ZR32C0ZAT4Be/uRNivFT8uYWBVdZ5UoLjf2E7IZ3FVyPW/VkYG74Fmko14thwsR1Q3SlsI4UR3IoA9kL8Oi94spA/tdSwfnwUnzIPcVMgcnhZhACs7icwC5iBQ0JxrdfKC8enWazLrOSRWRu6ZwKfOrV16ZMRV5yclmgOuK+4eUXhAKXg19onlA2SNmN8CbKQkxml+bYq6h1G8n9BtWaFGt6hn36JVejZc/aDP6d4ZAadrPT4/u+5wXF9V4ksV2aqrlgag+DegvMxVsOzJxCKIBmircX1tUa/d/kkg==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DM4PR19MB5833.namprd19.prod.outlook.com (2603:10b6:8:64::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 3 Apr
 2026 10:40:38 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::5880:19f:c819:c921%4]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 10:40:37 +0000
Message-ID:
 <DS7PR19MB8883555F6B620250D1CB55689D5EA@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Fri, 3 Apr 2026 12:40:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 2/6] pwm: driver for qualcomm ipq6018 pwm block
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Devi Priya <quic_devipriy@quicinc.com>,
 Baruch Siach <baruch.siach@siklu.com>
References: <20260204-ipq-pwm-v20-0-91733011a3d1@outlook.com>
 <20260204-ipq-pwm-v20-2-91733011a3d1@outlook.com>
 <ac6MP-O2MNDkleZB@monoceros>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <ac6MP-O2MNDkleZB@monoceros>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0119.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::16) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <68af78ee-a4f4-4009-8879-d703322ad141@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DM4PR19MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb05ff9-bbc0-4aa1-14d9-08de916d7112
X-MS-Exchange-SLBlob-MailProps:
	LVbdfIC7uFAyHke/CE1Ui/FW7barhRQEMAui95HjfkUTK1+6L5XYX/aAYMacBpa7yFJU6gek+D5o0/ReG+h4CyT988WVABVID1tfhaQFylisQjt/qPwSjohtgV+rkQsju7sQlaaFU9N/fyE4AV4LcE+Symj8C63i75LLvaF897IhuQAF0Gy68An7FxTTuhb77dfapbFj+bIM6QQIfaWuoprN4P16YR5Sw/RsyKQaVMuH26L44EQDa0w5L2QolugmtpypHi/XuLdDu6+mkPbebFNE+tC8byTE4Olm9KQ2Rz3mt4SoTC8BBZoRgcDifBrTHduUH/2t1oHML4dggGskEq9vIdA2eKklsTS4Ycy5gZRSjZCGlzaEtoPARLqXfi5dTMMncWBe4gYvhVbmkLAsli/ry0ixd213c5iHkoiJ7AyDnRwzwEZZL+cvip7dYEpF1y7VbcbgnqJZW1ai5voCojP2jRtT3Ycc2aIzYV25OxGP/FyfNxz3jqO66BBEndtf0vdgdBECXQcQ7uKw3AXLw2Pwkc2JpLv163gjUzln2kZrb3DSmW8nh8GzRRweyjnDuKp6GO0DWxuM9Fntt4bN6EmrdXsSxIcHuFLbneAG51ofk7+FYdK2IOZRYFqxvvAgXn5tTTBhCIY+t+PdVTSrVXL2HxAlZjMX9A9Ddao8bJy1oIILEv419hzZR6hLkeKDwVFFXiozRlBgKFsQXH1sGyD8zIpmdr0gHbIGNfoO2b2Rq2VzMchUYg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|12121999013|19110799012|23021999003|37011999003|461199028|8060799015|6090799003|5072599009|15080799012|40105399003|52005399003|3412199025|440099028|26121999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SENrTnhYWHNXRkw5ODhWK0VTUWFWQmU2a2NBNVlsMGMrUlB2UllCK05xNFlY?=
 =?utf-8?B?V3hsZm9Mb09yQ05INlNMcU5qbERwMDdIMjFTSFIyc3lWRUFnM1l2QTlYakRC?=
 =?utf-8?B?cVdwdHY0eGZzeVFGWTE2TEFERjFRQXdUUzMvbkdkeG9yQXNwRXhuY2VBdk05?=
 =?utf-8?B?VFVleFZhRXZxNCt0SHM1bko1WHgzdTBkc0dVVGI4N1J0MHdYTFVLT3VCQUNs?=
 =?utf-8?B?NUZxM0U5L0cxVUY0VnY1Uk00S0FJdjJkdzFZa0JtYTJEemhSbmRSZmlvTEpO?=
 =?utf-8?B?aVlNZDZaRVVjWkNibmI5UUJ0SXNQWlBGc2g4YXR5RVRzWEVRRG1lQXdqbnh2?=
 =?utf-8?B?QzhDZkRSMFMxby93UFRrczZaeEtodU9zdXM5b3JsMHNwZUs2SlVsOTZGKzJ0?=
 =?utf-8?B?MVBZK2hJSTZ0ZnFwYVdiSXdSUWl4SjNsVm5VZU41VTRjbElVcXlNK2NIVEtV?=
 =?utf-8?B?L1kyUktQQm9JUTlJZzNiV1BlSG1UL1lhd3ZiaXQzRWh4YVgvV1pQM3B1QWpx?=
 =?utf-8?B?azdqcmh0V2JSeHRUOVFaM2o0eFl2SHJCZ1JaVVhCVUc5bnNjSitoWXlOTUdI?=
 =?utf-8?B?TGdZZ0wwYUd2THU1eXp2ekVrZG53OVc3dnVMYjk1ektVSStaMzQ5VzVNL2RP?=
 =?utf-8?B?bUp0Y3JXNUtoTzV4TjZJT2tXWjJXQ0NkSW9DZHFLcDlpSjFmUWFKZGlYWExy?=
 =?utf-8?B?R3JKdDZrZTd4SzNrMFRoMmhSODZwWHBWZktSeXVRVzZhMUROS1dxQ3l4bmlQ?=
 =?utf-8?B?SGpkcDgrSnd6NUtKaG9Qd2RWbWVuc0RxalgycGpqdk8vZEZFbWxMV3l3OHVv?=
 =?utf-8?B?RWpIcDhZSlYwYkRpVHNOVEhwZU9aZHd3SzdUcExNZ3cxYk1qeENDNmc3NWNP?=
 =?utf-8?B?cEZWMFRMUVJYeXpESlVqckEzUFEvNGRwMG1DdjBuRzZJL3hEczBMTTMwbEV2?=
 =?utf-8?B?MjZDTXhCbjQ5UXZ1L1RSYVpJYmRwNWJ0azVMU3ljbGduU2tmdmpGU282WmlM?=
 =?utf-8?B?aG5ZNFZrU1VJdkdnNnc1dlJud0graWxyN3kxcmdlSUQvYWxFT1A2aTMzVEtz?=
 =?utf-8?B?RDU2Zk85MVlLOEpENVlCZktVQUFXZVN4UytKOWcxcmg5YlN0dnp5aTB3RGRM?=
 =?utf-8?B?YVlaRDBVa3JmODhINkZlTDZ3b2w3MGRLb0NWaGR4MEN5Zk1YRlFsSU9YYlB3?=
 =?utf-8?B?OVEyMkJpb2tRd29OcFFhS3UvbUZPNUVnanBtTXdaTm1lUmpwUEhzSVpJaDlV?=
 =?utf-8?B?bGc4SjVaY3QwcG0wREhsMHhlbmNIME1VK2tJeVM3SHVkWWNaVVlGVmtqUDR3?=
 =?utf-8?B?Ymw5b3VmS0tDVGUwTm5wY3YyOExTL1hMQTR6L2ZJNDR3Sit0M1FtN01qWC9L?=
 =?utf-8?B?Q1Q3S09ETjZNTC9UZ0dsUG91a0lJbEhVRENLTlhQRHkyZzhyTmJMc2V0SVo5?=
 =?utf-8?Q?sYodsWSC?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGZMMUFsOGxUaFVMUTdoY1BMUFlWdVpNYjlnOG1xWG9sQUY5S2V0VnhnMW94?=
 =?utf-8?B?SEIrbDFWcnd5T3M2Ukw1ZXZrOHViZGoxM1RGajBWbWxEbDVQblU3Sk11Ly9V?=
 =?utf-8?B?WW5NTzAyRWFFWEdTTk13MmlaYTIyUlVEdVo0YVFkYnNhMGNvTWtOZG1WcU1V?=
 =?utf-8?B?bzBmdVNrdFlJUDFENlBZYW5LVHoyZWcrK3dIbDhCRktnS1ZQUHpCM3d1MXNa?=
 =?utf-8?B?ZjVjeDNYamp4S0lLenBDbVMzQlQ3T0JMSFFJYnJCZGoxMlIxSzBFNXBLZ3M0?=
 =?utf-8?B?VHAxVUM1Um5EYTZWRVVaRjBmM2tSdDR0WFlrZ1JGZDlFcHVmUkNFUFJYR1ZH?=
 =?utf-8?B?eGZFd0R0b3c0eG01cWdiSnVPcHNrQml6WFdkeEJxdmN5UEs4U24yUExjK2FY?=
 =?utf-8?B?dmxPM3lvZ2hjZlFnMEZFZTNRTEZPcnFGcUxPNDN3ZVlLWnBuNHRLMEI4NWk2?=
 =?utf-8?B?Y2xzbCt0NGhvUkFYNUFGVGxMRFpMTlFZWkFTdzhXR1Vjb2hDSU9JdFZ0OXky?=
 =?utf-8?B?bituU3VVc2Z4V1ZJZEtDQWlGNmk2enZEeFh3bmZIaWdpK3FxeGkraGNxS0hl?=
 =?utf-8?B?S0hVV29ZajlWQWR2Y0dvT0ZkdXJYYUlIZWdyei9iWVJuRllzWHcwNDMrZWxX?=
 =?utf-8?B?Y0JUYnpKaVNWTnFheXBJdzRVemNPclc2WnVjbWdSSDVYRDRTM3N3RDJGdUZt?=
 =?utf-8?B?YlEwcEtsRWFaK2lWOWtSNjFXbEhFVDh6amQrb0lZd2dJYU5jakhYWlg2MytF?=
 =?utf-8?B?WFlPZkRLT2tjMjJBak9PUHdGVmVTZDk2ZkdsM1RaU1RMbjVzdk9GZUZxMWo0?=
 =?utf-8?B?YTN0dnVZT0l1cHVRWFJzc0locVlITXlzU1hHZW1mTG01ZlI1UVRMck9MUS93?=
 =?utf-8?B?V3YwelhyeVJ0a0N1S0JWYm0xRmxoOEJsUTVLdEdpL1d3N204T25HelNmU09O?=
 =?utf-8?B?MFUzSWRnK2tOY3FOT29HRGlZZWwra004aTY2WTN3R3RtT1ZQcUEwbkN0Zm1r?=
 =?utf-8?B?dDE0Yk41cERGVFp5MHU1aldBcUcxTVJGWUpMeDlJNUU2TzBRUFlrWk45cUVu?=
 =?utf-8?B?T3A3Zmc0bDZudEtSQkxXc1JxUVlkWVVSM2pOdW5EMm5iNC9KY3VuZWxXN1kx?=
 =?utf-8?B?UXRZUU1BdFA1QVUwcWlsb3pWTGNRakZhMWtjamx4cDJsVnF1Ni9KQUxPU2tu?=
 =?utf-8?B?eDF5N2N5eDZMakxJYlZBbFRwb21JaXR6OFNIdlJ3ampWOUlqUlBXUit1bStT?=
 =?utf-8?B?SWl0Y1lyKzdnT2VOWUQ2VWIrR0FmOVdiUUFidHFxQVh2U2t6TnQ0NWFQbHlh?=
 =?utf-8?B?YWwrVlQrcVd3NThBOVNrWE9HZHNVM2VZcUZKMzRUOWNxNHJqdmRGM05TWUJ6?=
 =?utf-8?B?ZkpMZEI1SCthT2J6NWIzY2diVklpaXFvaHlLRXhnN3RLamw1d2RvbkhlN3ZZ?=
 =?utf-8?B?NVE0UGlQdS9OcU4zK1dzY0drSjV0TEhXNjU2Y0ZLZ1kwbk9xb2dqVWkzZU96?=
 =?utf-8?B?MUszQ3VPMWl1N0hGclZOQ3dZT2h0bGdtbkxWa3pwWitPazJiZlcySlR3OTZB?=
 =?utf-8?B?WXhpRGwrSXVHRGRqcC8wbUJQc29VS3U4Nk9GMHNZMFBkQ0orcFJEZzViOGl4?=
 =?utf-8?B?LzBCSEI3WERQdk16KzVhK1IybXo4NktWZXVZTzRwM3dlNTJ3Wm9qc00xTlls?=
 =?utf-8?B?WHNHSHNNTDNCNUpXQmYvRWxoZmpMQy9GYnZWL2piZWUzRUdKNmc3OE85MzZ6?=
 =?utf-8?B?d1BYV1RXdnh2RDFzVHNDUXJwRmY4bFpuK2ppVzBrc1RYaDhZUVBiUHZmQnFE?=
 =?utf-8?B?UXd4S1NLTUxFNVRaQ2xHUmdab2x4UU9iRzRDdXBYbWZCcnFBRStUekRCT2hR?=
 =?utf-8?B?dW9HZWhsdjZ5VmpBM2VrcGlmY3JROVFWVHRiTldwYm5TN0E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb05ff9-bbc0-4aa1-14d9-08de916d7112
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 10:40:37.6978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB5833
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8463-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_MUA_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[george.moussalem@outlook.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim]
X-Rspamd-Queue-Id: E451B3935CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe,

On 4/2/2026 5:35 PM, Uwe Kleine-König wrote:
> Hello,
> 
> I applied the patch and reviewed it in my editor. Here is the resulting
> diff:
> 
> diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
> index b944ecb456d5..4818d0170d53 100644
> --- a/drivers/pwm/pwm-ipq.c
> +++ b/drivers/pwm/pwm-ipq.c
> @@ -97,9 +97,10 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	if (state->polarity != PWM_POLARITY_NORMAL)
>  		return -EINVAL;
>  
> -	if (!ipq_chip->clk_rate)
> -		return -EINVAL;
> -
> +	/*
> +	 * XXX Why? A comment please. (Is this already covered by the checks
> +	 * below?)
> +	 */

This check can be safely removed as it is indeed covered by the check
where the period_ns is limited to IPQ_PWM_MAX_PERIOD_NS which equals to
NSEC_PER_SEC as per macro definition above.

>  	if (state->period < DIV64_U64_ROUND_UP(NSEC_PER_SEC,
>  					       ipq_chip->clk_rate))
>  		return -ERANGE;
> @@ -107,18 +108,29 @@ static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
>  	duty_ns = min(state->duty_cycle, period_ns);
>  
> +	/*
> +	 * Pick the maximal value for PWM_DIV that still allows a
> +	 * 100% relative duty cycle. This allows a fine grained
> +	 * selection of duty cycles.
> +	 */
>  	pwm_div = IPQ_PWM_MAX_DIV - 1;
> +
> +	/*
> +	 * XXX mul_u64_u64_div_u64 returns an u64, this might overflow the
> +	 * unsigned int pre_div.
> +	 */

Theoretically, yes, but in practice it won't due to above constraints.
Take the max period of 10^9 (NSEC_PER_SEC) * max clock rate of 10^9 (1
GHz), then the numerator becomes 10^18. Divide that by 10^9
(NSEC_PER_SEC) * 65,535 (IPQ_PWM_MAX_DIV) and that fits well into a
32-bit integer.

>  	pre_div = mul_u64_u64_div_u64(period_ns, ipq_chip->clk_rate,
>  				      (u64)NSEC_PER_SEC * (pwm_div + 1));
> -	pre_div = (pre_div > 0) ? pre_div - 1 : 0;
> +
> +	if (!pre_div)
> +		return -ERANGE;
> +
> +	pre_div -= 1;
>  
>  	if (pre_div > IPQ_PWM_MAX_DIV)
>  		pre_div = IPQ_PWM_MAX_DIV;
>  
> -	/*
> -	 * high duration = pwm duty * (pwm div + 1)
> -	 * pwm duty = duty_ns / period_ns
> -	 */
> +	/* pwm duty = HI_DUR * (PRE_DIV + 1) / clk_rate */
>  	hi_dur = mul_u64_u64_div_u64(duty_ns, ipq_chip->clk_rate,
>  				     (u64)(pre_div + 1) * NSEC_PER_SEC);
>  
> @@ -161,6 +173,10 @@ static int ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	pre_div = FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
>  
>  	effective_div = (u64)(pre_div + 1) * (pwm_div + 1);
> +
> +	/*
> +	 * effective_div <= 0x100000000, so the multiplication doesn't overflow.
> +	 */
>  	state->period = DIV64_U64_ROUND_UP(effective_div * NSEC_PER_SEC,
>  					   ipq_chip->clk_rate);
>  
> @@ -210,6 +226,8 @@ static int ipq_pwm_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, ret, "Failed to lock clock rate\n");
>  
>  	pwm->clk_rate = clk_get_rate(clk);
> +	if (!pwm->clk_rate)
> +		return dev_err_probe(dev, -EINVAL, "Failed due to clock rate being zero\n");
>  
>  	chip->ops = &ipq_pwm_ops;
>  
> 
> Comments with XXX need more code adaptions (or a comment why my concern
> isn't justified).

Do you want me to send a v21 or can you apply the diff in your tree with
above deletion and comment?

> 
> Best regards
> Uwe

Best regards,
George


