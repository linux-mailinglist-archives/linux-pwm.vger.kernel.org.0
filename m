Return-Path: <linux-pwm+bounces-8437-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL8KERE2y2l1EwYAu9opvQ
	(envelope-from <linux-pwm+bounces-8437-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:48:49 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D5B3638DB
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C6E930157C1
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 02:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CAE36AB47;
	Tue, 31 Mar 2026 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="kwTr6TCq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022101.outbound.protection.outlook.com [40.107.75.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755511925BC;
	Tue, 31 Mar 2026 02:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774925323; cv=fail; b=sTHX98dz0STIyxsR7K3ICX0u4RYPbPs4c/6NEGF2S/mCVlxduYua7xjhBDGDuD2CR4/QZTprA08EMvhJh42CN6RZFCfcaOn1xnsvIEZCvGEyXU5k8uW0GX/4i3Mx9dnvsivQewvYOlt3zNAHPdnao2dqiexJYlyp37IEtWmkiMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774925323; c=relaxed/simple;
	bh=uscb8PoLjh3eWKsxuB6EcVgJ4+Q6D83vb6C5G7pd4Is=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KZx9luXERxJaGYGcrN0AmyAGSuFqUxESwcZAmOsb9LqpeyHf7YgeQAUiUpx3CXfinf8pSKNw8TELo77dXF/goCx7BQEgeCRflo3ygwJVt6wpntR4hoYfINYrTNpT3vaHfvpHr4EaJE6RYe58ahdB7uERqvqbCcUniRJ9tOJqLwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=kwTr6TCq; arc=fail smtp.client-ip=40.107.75.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2qRYRGNrDDfjJvwA/dBVk3g1u0TYt22tlwZn0ALviBN+lcTqSOa8PIDCuwgjcyu4z5decuy0vM4D2K3lP709Nr2jxYEi8hB00z7r2Hmq8U/c4bNKUrILiwu4wxAHKa0qz9bKTRoTurFW1oKT4MB3nL+5UZ0Hrblru3QaCFOFzFkjhIcHRCk4nqR4qpBMxGLqzn2thGKMv/qwhbS3U/OqS4S0dZDpoFtXAx632u3SQnbHuwfyRMMr3oT5oTZWKj5fdtUX00Zw0J7cDOlbyLgLC7iJ52CNlQEa+uMjNjho5uaOTfgw+/Ge2ocFd+MgqA9oUKE6cr+vgDZH/4nwYCJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sozgCNhtywv92zdUZwDHpgSAXrEUvj1kf8dSd6QpfRw=;
 b=ikYgL5IvNyANUdzwPcuHzxrimdhvTub3plzSX65VKiy1BM5VzOctEfrP//jChrBov9628A+4PCJRwBs6ZrOz25iGNefv0IGuou7RC6nSqPGimk2QtvuEzwAPutjRm0EyNzC5KIzXZl3cjg8VwOt0ZKjz8eQtMHKGaPSHCWD60E6RW+F4ifHQkI5TeKW3+w7QLTiXUgK/IO+JBrCkjH6Kre+QNEx4UCi0HfdrmQNZS7wbx9B0SawvENzEdHAKXD35YP9/ICLRG17Wy64Elv00WmjzdVkZ6nmtuFG5orteD8+b4Rox7u9hVewmawBpEce+LHc28kYLFJjzTYpvskWkMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sozgCNhtywv92zdUZwDHpgSAXrEUvj1kf8dSd6QpfRw=;
 b=kwTr6TCqSE5WVug89MfGtPM7UqfABVCNokbwerBHFp/ccnIDbRSNhlJmA2sx6kRwI8kUPAq3yQ11UQtQ9cC7e+war3EcwMKaHHcP0oFhSptCVGvNmYd+F4uQTx1RfSRi1jqcMbRaPG41wi7cr20KynR1UZACqp0uiHT0AWTITr0EksdM66xOOPnPVdXO1HdWTeBFGwsa9eDFVzWCQVdGC1u9+oceugOjcOMM0MSYqNI6brJBsXYsV9olhCI77GadOUM0YtoCMcOA+FTy9VDKv9+USxrxhXlvAUe7tymH18CZNQhnAjb/xr/9LZOgyym9+YseAolcLSru+Edb9eBlqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by PUZPR03MB6988.apcprd03.prod.outlook.com (2603:1096:301:f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 02:48:38 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%3]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 02:48:38 +0000
Message-ID: <59b5c878-dad8-4ce3-9864-f4706c993d4d@amlogic.com>
Date: Tue, 31 Mar 2026 10:48:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: meson: Add support for Amlogic S7
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20260326-s6-s7-pwm-v1-0-67e2f72b98bc@amlogic.com>
 <20260326-s6-s7-pwm-v1-2-67e2f72b98bc@amlogic.com>
 <CAFBinCD-4dwp7pmM_GHK_N1kag_5VBZbP9VAwQOxcyg6aquj3w@mail.gmail.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <CAFBinCD-4dwp7pmM_GHK_N1kag_5VBZbP9VAwQOxcyg6aquj3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0039.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::8)
 To TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|PUZPR03MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a65925-24e5-4394-1921-08de8ed002ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	81p4gaxQ3I3MacqJQAKKOFTms6bAPfdVJOlFs3yqHi7Y7ungsVsuuuD/wHHLgoX+zjvBDNMknCepyvy75jQ/Zn2MdKmcQcAR9yertTeZ9j1Nv9RRQQepwH1tVtxV3tpjxHd4GIPrnFwbyps6EQclGtQlT8Zelikv4S5v0OeJ8fMsaKPC4EHxILxXGbshbvGat/bxrTLasoJNeN0mjYFOSoXI4/HDcapUPoxxoZ1W6Whg2KImtI2RWHq95iuPN3Gsm319LQL7H/kOFNvnBo06x/Tsvzg6zOa2lRD1+PHaoudMZKPvcpHFkm+zvDFEryCWCgrIGFANHDIW78vxwj59J4M1fQTcjKZmuekcglpHPW4/klUFy+J6az+HfwhOyN5Ws+p+bHt0BJZ+W4dhVE9KyGP/qNUmN92cwFR6oVHCDAbQ4h1k4DN8sJzgxNeECBF8R6bl3XwJ3h5FWl4ev5wc6Ac4NG6GvNbjeYtEFBy3OIqivLNULIsLZ1lLo/pC1ZmT6khmAjtVImXm36oQ/igaCZ0J9lf0i5bnRGT/HxE/QPbdCwFE2dS/v+2DE+xI/QaV+m/6MYAGJLgawXlPp/lPyC5hsNB7ZEzV1Ak/OdUwrv9bPb03zci1laD8nRD2PEjeK1pXqDPtJqyOPUeQxWRtYZKN2XNYcJ1zXZGRTmxvbWaxGoUhl7Ne/zKYuVZzhVpiPWQnGKVKXinouk5JS/VR3ugfcH+OjEoudRHblBMNYWQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlV1WC9GZlFNMTBNR3FNM1FITHBxTGd6TmdqdmdIUGN5NGc2N24yaHllSUVz?=
 =?utf-8?B?WTNxeXF2ODF2Y1NzUlFyRVFScEwvZDFJMlNxZXU0QmRjb3JNN1FVakQxQndP?=
 =?utf-8?B?YmJ6eUFtVmwweUxvQ0hraE5VRTRneDNOc3locHhna2xFVVZ3T0xjUHRDdXhy?=
 =?utf-8?B?eFNSdENBRGRZVzRwaFlDR0gvVkNJT1JUYWpiZytieXZXcEw5bVpUcTF6dE11?=
 =?utf-8?B?dGFxajRlN2hodVFFbWlXUXhadzcvSnB5T05YRUVUVHBVM1V1eStjRkZoTFhK?=
 =?utf-8?B?eUFkTVZBQ21NV1R0TmNlajVkcklyeWVjM01oUUpmOU1QNzN1RU1ydXJqbkRh?=
 =?utf-8?B?VHdMVG9iRXFUREo5UXNnSWtnMGFMMnVLZGFSR3kwU0FXUnViVXBSV0NRZHhC?=
 =?utf-8?B?TVpJUlBiRVdnVm0rVVhzUXF5WlcwbEVIdlRIVkh4RnlhV0pCejFuNnJiNzFq?=
 =?utf-8?B?bEpvbm5ob3JTTUhxYXg2ZFdQWVVoVlFhZGx3UW1TNlI5dFBkbXFWM01RR0E5?=
 =?utf-8?B?cWhSU0FySHN6YUFMb1J3bE5FemtBTzNWa1dYeWUvbTAxQUNNdG9FSHVDZ0c3?=
 =?utf-8?B?ZlJBSVFzQm51dVlkdmJ1Y3ZwemM5bjBEdkc0OFpSNlZUbW5oMi9hMmtLSWRM?=
 =?utf-8?B?ejZtclF1ekxXbXhmOS85WlRMT1RhQ25jTnFyUGhLdTFwYUlzaVhxQ1FMcFdq?=
 =?utf-8?B?OGphOHRackVpNHEyckJtUXZabytncFpvQzVOd2k5WUQwbGcrWVpoOEhEOEZt?=
 =?utf-8?B?eUZiUUtkcHFlN0VPRmZva1RJaHNBTDVPeDI2anFGM05KV1BkOEFJUGMwTDc3?=
 =?utf-8?B?aDJoRHB2azlSdkxiVjEzTHo3b0VXOXBMM3RXZHZxN1hJa25YbHI3a3dCL1lS?=
 =?utf-8?B?ZXFzZ0dSSStxcXMyWlQwckJLNzlCekZVeTVyY08yZXNrbnp1TTlLWEJJN3lO?=
 =?utf-8?B?REJOa0dCQ2xXMlVGUzh5YjgwWWRHYnJCc0tVMUh0S0lIM05oWjc1YmFYd3l1?=
 =?utf-8?B?cW14RERsT0U1V3JaZDBuSS9CKzRvQjdrRHlzNzRlRkVNZEFiMXljTVNMYzh2?=
 =?utf-8?B?R054ZSthUHlpb01hZUF4anU2REoyN1lLck5vOTZVS0ltdERLNDlpZ2pQNlZy?=
 =?utf-8?B?dHEvN1BuaU1RNW53MmhrdGFOZ3FTdU1DVTRkS1B5dE9iRWFaQ2VFWmtkNDh0?=
 =?utf-8?B?WkNLOUM4L3AwaXBRV3AwZ01OdDUxRzdTZVpPMEE2cFNQTVZneFdGaXlic3N6?=
 =?utf-8?B?KzVNSGtlclJIR0NDM0llV0FhbjE0NkpXS2doUmxrWXA0eTFxWlpGS3c5MTg0?=
 =?utf-8?B?d2hiL3drelpCZlRvVWlIa2xRNXlhOGRjSUIxbHZPRStCVU82aUVuVXZVQlZL?=
 =?utf-8?B?QzkrcDRIRXBZUmMxdmo3WGJ5SjY2cHhzdTBNdW91NE90cGd4VGNCaDgybVNC?=
 =?utf-8?B?VTU1UklDOWJNQzlpVnpqYTVhbmxOWSs1UVZQdlFVbmxaMzFGVXpqcHc2UFNi?=
 =?utf-8?B?ek81elJUUlpweTY3UjNURE83bmpWWm1KSjZUb0RTL3lMbW9VWmZaT1lGSWJl?=
 =?utf-8?B?aU9xYUF2QXJMYzZBaVk2Z0t0Z3FzQlc4T3VlTFo2NVhzU0cycmpqOFk4TVV2?=
 =?utf-8?B?SlEydWxLSDVvZU4xYjZoZ2RaQ2h4WUZZT0QwVG9MZ293ZDVheVk1dE9MMUtr?=
 =?utf-8?B?Zmg0WGdtc2t1am5QMDFkKy9aUmcwMEFzZjlZclNaeW9oMTNBTnNRVnZ5aU5J?=
 =?utf-8?B?UVl1d3ROTzU5NWZ6VDJiaXRhWUI0Sk1ETFltVk5BTWNrbUtPRVR0dytDZzdZ?=
 =?utf-8?B?Q1o0QnMwa09GMG5WMHNYR1k2QlVnUTEraFh3c3NmUzl5aG5DQkxtRWdHc1RY?=
 =?utf-8?B?TGx3K00vWnZnSFJ0clZNK1RSUHVEbElxRzZGMS9ZZ1E4bzYydkF6Unc0dnEx?=
 =?utf-8?B?UWhzbGUvdkh3RkhhTmJ5dk9VeHNiY05tVUZxSDJiN0MvcVhLWmRKSjVmNXFv?=
 =?utf-8?B?dGxFVFBIYU03MUNzU1JsbHh4NXNWaGNONkpibzY2b1RLd1NDWENYaGNXcmFQ?=
 =?utf-8?B?OSt6Tlc0dURxNDh5dmhCd0pRSUR3Q1ZwQXhTblRGUi9jVm1TRE9vb3FreTMw?=
 =?utf-8?B?UDA2WlBrMytOK1RZUmNyRzk5R1k1SVlkdlgrMlp6RlNJZEVWQ3cvcVV1bms0?=
 =?utf-8?B?aFA0a3hoR2VXeHpKSVlOS0xJdDJHNFBadHcraFQ4Myt3OTdTMk1WU2JPYmlB?=
 =?utf-8?B?V1ZiK1BYZzJ0NC9CdG8rQjJ6R3ZvMjZBOHlydmwzOHRSVFMyaHA1eUVXMndZ?=
 =?utf-8?B?V1p0R29CZkdnRGJLYmdTR1dJc1FkcVpqa0dKbkxwdWg0a01wRElvZz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a65925-24e5-4394-1921-08de8ed002ab
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:48:38.3458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfQt1QaD6iMJZw9e89wYDrAXz53rvakNwGT4qjlFgQrLhcXR97FIKFk8U+rIz13tRk3VBJIPokWLPUg/HTHqhOq6mDu7Ky5v/gR+d2mFt7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6988
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8437-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[amlogic.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49D5B3638DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Martin,
    Thanks for your review.

On 2026/3/31 05:44, Martin Blumenstingl wrote:
> Hi Xianwei Zhao,
> 
> On Thu, Mar 26, 2026 at 7:35 AM Xianwei Zhao via B4 Relay
> <devnull+xianwei.zhao.amlogic.com@kernel.org>  wrote:
>> From: Xianwei Zhao<xianwei.zhao@amlogic.com>
>>
>> Add support for Amlogic S7 PWM. Amlogic S7 different from the
>> previous SoCs, a controller includes one pwm, at the same time,
>> the controller has only one input clock source.
>>
>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
>> ---
>>   drivers/pwm/pwm-meson.c | 32 ++++++++++++++++++++++++++++++--
>>   1 file changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 8c6bf3d49753..3d16694e254e 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -113,6 +113,7 @@ struct meson_pwm_data {
>>          int (*channels_init)(struct pwm_chip *chip);
>>          bool has_constant;
>>          bool has_polarity;
>> +       bool single_pwm;
> At first I wasn't sure about this and thought we should replace it
> with a num_pwms (or similar) variable.
> However, I think it will be hard to add a third (or even more)
> channels to the PWM controller (not just from driver perspective but
> also from hardware perspective). So I think this is good enough as the
> choice will only be 1 or 2.
> > [...]

This is not a third channel added here.
Compared with the previous controller having two channels, here the 
control has only one channel. It's equivalent to the first channel 
before, while the second channel is reserved.

>> +static const struct meson_pwm_data pwm_s7_data = {
>> +       .channels_init = meson_pwm_init_channels_s7,
> I think you can use .channels_init = meson_pwm_init_channels_s4, if
> you change the code inside that function from:
>      for (i = 0; i < MESON_NUM_PWMS; i++) {
> to:
>      for (i = 0; i < chip->npwm; i++) {
> 
> [...]

The method you suggested was exactly what I did in the first version, 
but after my subsequent optimization, it's what you see now.

Since initialization only involves obtaining the clock, I modify the 
code less in this way and the logic is also simpler.

>> @@ -650,9 +674,13 @@ static int meson_pwm_probe(struct platform_device *pdev)
>>   {
>>          struct pwm_chip *chip;
>>          struct meson_pwm *meson;
>> +       const struct meson_pwm_data *pdata = of_device_get_match_data(&pdev->dev);
>>          int err;
>>
>> -       chip = devm_pwmchip_alloc(&pdev->dev, MESON_NUM_PWMS, sizeof(*meson));
>> +       if (pdata->single_pwm)
>> +               chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*meson));
>> +       else
>> +               chip = devm_pwmchip_alloc(&pdev->dev, MESON_NUM_PWMS, sizeof(*meson));
> I don't think this code is too bad for now.
> However, I'm wondering if you want to make "channels" from struct
> meson_pwm a flexible array member in a future patch. In that case it
> will be helpful to have an "unsigned int npwm = pdata->single_pwm ? 1
> : MESON_NUM_PWMS;" (or similar) variable to future-proof your code.
> What do you think?

I considered this, but chose the current implementation. I will switch 
to your suggestion in the next version.

