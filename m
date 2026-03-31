Return-Path: <linux-pwm+bounces-8439-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDbcIaR0y2k3HwYAu9opvQ
	(envelope-from <linux-pwm+bounces-8439-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 09:15:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F11364EC4
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 09:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 168E83048616
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 07:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E863B6C11;
	Tue, 31 Mar 2026 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="qnJN3Zsa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022133.outbound.protection.outlook.com [52.101.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A4540DFCA;
	Tue, 31 Mar 2026 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941030; cv=fail; b=Qy1aZJrYz5JQsdIOJFUBE9JVfh98H2AfVNu8jIV9ha2CUJHKmIv89Mof/ENn2RJzkMmDCDaTaluigQ2+dpEu5hloFRSW93ZaBoHjsXasA8RUsRLmlQ5evzVziXNRAuoAGq8NJ/rvZy91BnHEbs8im+h9ZiykjRpCOsQA7VEYcBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941030; c=relaxed/simple;
	bh=hDld2upoHvtBG8tDwoj91G4EcKtVoc+2X9/B9V/+YpU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dRejgDh6NV3YUfmX7e2VGhTy9+OQiGkkYiaXmM8qlAiqstXIFDFDeEGJJZPNdKkT/bHrPBwCvQl4yE3jeDIto17p2PPT0zXIdDaapc75OTCrzSViLCWGQJsDEJ46c9sjYW9ywH0txr4FeRXM9FTa+DA4MVp1SkNkaBHfzfwuHyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=qnJN3Zsa; arc=fail smtp.client-ip=52.101.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ux+YnAWqFo+9a/ezG9f46J63459HzkbVpEef42YTA9B9JBd4Y+R7/6wEfsMv4YRbnieD4NKlFYZBRQW+cVxlPJTrFMtmuOmcSk6hDyZJIRrlTHsMnGd+hCF7F4UHuMcYtXjiMdksZ9Rg0HzE7Zc+WCdUhgyBMTfedipaPFqUXlR41xVdT7RIZO7gqbumOTq8jWfW6lCtyqvMY2AEhrApXvCXdIghiWOpJlmKN2bOZgS4DA4U92GhUjIANxW3Ea5ZiISZ9nBklhb6zzI/EzjXoeZ7UZN4X4a23WPvxoFofalnImsGIdJ6HK21XZJKHbxLj0zY9XL2E0v3GoErpd/KFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7sCxAQo5KUWXDnG0T3DVpfFsu04UXEfoOoLdVgxNOs=;
 b=WtlUa/embiQ5oPxZn7KFk702PuUO9S1RK/v4B3ZOmWeTWvTc3VJVAcspYrquxjgaYa18NVtBWLfk78WJAJ7AN62Nr7iW0meBgS9eWMIP2wK89u4goe5nyceyeIJWaTJ/AVxfCXE7U6cQVMBbd5EC4P2Qk93gcN2Vu6SJuB7TQa6gjE0XZUSdyeXpdS303MdwpoRxJmngQQSG6tUk4cSbuP8g609Js4KfN+LpT7jmbRdM1lTFTWLdoAYz7o+3oC7Y/IQNF5DYHhbPfpXdN4mlWr79+w1wk/AAhlanmNoh9Zxm506Zc1mighyQ5kPCBMO+sC3go2VVQXHG/cr9rNKnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7sCxAQo5KUWXDnG0T3DVpfFsu04UXEfoOoLdVgxNOs=;
 b=qnJN3ZsagsL1zXYEVpb11QTBC7/0JITo0OFzxLaScLvkdqI7fwHh90gaaY+l4QcUOTgqmAh2uoE7V4vSmX0r3UrKI9MbdzRCgnHKiiUdbAk7XruSnprQnWzApKjyj0T0CX854xf4Y86ZHD8/7mJWuRPKpb+nUqKt0MXCM42LKHZmbJsjAUQ7ANYI+WGgDckUZNt/kqIZqvoxM46IyGh/tSeP85BcwWIYUgi7aPdiFmfa7PIIo3fB9z3Cdphr9AZuFhRuvZ84F819IjX9xcFcM1E1R6kQoQkyoSyUHPGZUuLuJcvZoE7R+zEMvRGqpKHU3J34Zdv9ZyJ9uSY7K2jaFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB7864.apcprd03.prod.outlook.com (2603:1096:101:16c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 07:10:22 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%3]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 07:10:22 +0000
Message-ID: <70a637b1-a76a-470c-9a97-0b4599a40a1c@amlogic.com>
Date: Tue, 31 Mar 2026 15:10:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add PWM support Amlogic S7 S7D S6
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, Junyi Zhao <junyi.zhao@amlogic.com>
References: <20260326-s6-s7-pwm-v1-0-67e2f72b98bc@amlogic.com>
 <CAFBinCD1GPP82MEBDHg3BwCJg6JY5k2HksEt+kCB=YjnYTO7Tw@mail.gmail.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <CAFBinCD1GPP82MEBDHg3BwCJg6JY5k2HksEt+kCB=YjnYTO7Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0139.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::16) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 529f9229-6533-4db5-ac89-08de8ef4930e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	80qJ8YYcptynYAYB8CPeHBXYjf5OKGVBhIIMLupxMOZKy5EuvBZ0Z3p9fSpBLvzkUdkm4AP+d2bMoTK/8ZDt08pKFwt9rGB0nq5pozbMzrc0qkt3NejI/mYeLFYvdR8/HJ9IsxVEddO5OE3uxulT6yDp/EwBav5SwLJrzj0oFhRqdHQWrEQH8FqN3SEz3T/YLLPpFCAAoCbLxAK+PFtodA16A0OkHpuYpLknZGJX8yiXeif9JfWIwKB0u/XFvqlq+Pwslv8qAvYiLeO3aPCXvcfsrDR9riXmMl7s5CNB/2n4L0VsEzLc2V+6Iv324TpKzK6Eotzgysd2jTKsK/ev81qC/6kyLLgUfnjADlB3EFMyNnxYK8ZXFxAwWJDDheyD3lUJO3W5Fb6tPhabldl9MPc2BHHW//uK3PHx+S+i74FE7rgCDfxVk+ndLd3VJmRqu4d2kFzpVzDD88NcSZ9DYLiBSLbhsiHNyTi9fyKCcjx5xgIJFCZNGvXF+lkvAgmm5e50zYWtXno0OHTiOWo9zxH5+CWIPzMBIlOuKG3sTDSw4GILHzOSZS2LVetcoyNCOYSPmfzHv0qsY9bmJcrCYyyAkZAANZIqC3TGjKP7BAwyeLyP+Zv+VWxB9DJEGDWDrEGKl2J+Sm/5HUaswR9NuSXGNFFFijK6QCmS1uLjybnAPVjnBmqD2w5AjPTIrrze13em3ykOyew4+ca8GxAeADudIcB600fv9vIUnmk0p0M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFZqdFBlbkJReWk0TWdIRmhKbGRwNXRoZU9jNWNKL0lkSEpQUzIwZWpkQStJ?=
 =?utf-8?B?dkFtTFNKUkVNYy9WdElWaFUzUERhNjMrRHdabXVzYjlpQVlmYlJPUWptZEZ5?=
 =?utf-8?B?U2h1L3lzcXdDYTkxSGUreDJWNmluVlNTTEdpM29wNWdQTVdSRGFJYUgyN0hS?=
 =?utf-8?B?QVJ1Ym4xaTd1OVMxdGJ6SmVRSFFWbCttdWR0MVJNWVV4cE5IVjBrWWJtWWVl?=
 =?utf-8?B?KzZhbHJHUDZKd0JnRU5aU2JReFFwd0dyZVdTNGpOUWJnMDhBUEd3cGkvZVpN?=
 =?utf-8?B?dHBucEtIaEhTZjdiSlg5V1lnc1FtVGNUMXFCVXA1YUxTVUV4R1NRbjRXWFJG?=
 =?utf-8?B?VHNpV01HZHBWYXF6aHhwK0Z6TnVYVDdBMXNUSHEyK1lEaGxXRVh1ZkJQQWlW?=
 =?utf-8?B?TElicVZtQnZUdURFR3JWeWpYR0xXUnQ3M0ZiYkRIYjBBSW5JSjN6N0ljSUJ3?=
 =?utf-8?B?cjZidFFmcnA3d1YwczNlY0wzNnBIbi8vbm5HU0M3NUhqOE5md3o4VFpjNlFR?=
 =?utf-8?B?Z0ZuS1NvWlpyNm43UnlONFZlQXl5SWRFTE1ER0MxQ1hYQmtvTTFsYzd1ZlJ5?=
 =?utf-8?B?YkN2dFJOaEUxbUI0Lzg1UjlyMXVLSHlyS2NXOHIvcTdaS3lqdHZPK2Z1M3E3?=
 =?utf-8?B?UVRlK0R6UWJoUURPdHU0YXZlcWE4MW9qYVYrVkd3NERGamsybUZUNENDVDR4?=
 =?utf-8?B?Vm5vQUpTaG02SE1odFM2VHZJK1Y0TlFVcWVJaHB1V09XQ2dWV1JDVVQ1R0Nj?=
 =?utf-8?B?b3pOWUZFNkN3aUN2bzR5V29OaG1uYXYyOTY4WUdqYnkzMzhoUG5JekV3dUlJ?=
 =?utf-8?B?SGxmeUgydm5TQVIxS0VyVDBhZUI0OVNjUi9uWnBlUjlaRW9PeGRISDBma2NH?=
 =?utf-8?B?Z0pxdTgrckJZbzdkUHdMV3FmNis5UnNieW8vU2xWdnltS0tHcVNIWmhLMUhY?=
 =?utf-8?B?VGJTWFZoc09uSWwzc0IyWkdtb1JyV1FSWVQ0NG9vWklLZHBGbUVYZmtHOTNX?=
 =?utf-8?B?cFNrS1N5M3FDN3FnYTU5UG5tSVhJMkhNaUJGTHcyNkFJVHkzOEs1dmpESDZh?=
 =?utf-8?B?OS9PVllrUTZHUWJFa3p4cUNsUk9KZzA4R3RsMWJkRGNHWmNHQlpwK1BHY0dZ?=
 =?utf-8?B?ektmUCs3clZHakh6T3dxT2x3d1ZFK1M1MFV0MkhlYXZyVWlJbjZkZXpLSTky?=
 =?utf-8?B?YW9POXk4ejJ4KzYrNWZDYmZHV0ptYmVUZVdQeHE3dzR3TEZucWxOWGpYaFdS?=
 =?utf-8?B?UXVDUmdjajVUd0dNakVRK09iVHM0SUwzWnJJY1VuVVRKWEhQM3lqTW1EYXBu?=
 =?utf-8?B?dVFwSVRhcmpmTGtMLzZpcUl2Mlpra05oa2YwOTlibC9wQk9kT0NkK29pekV1?=
 =?utf-8?B?bm1wQ3ZOQ25qZSszKzhUeHdPVTZNdnd0REpWdEF1OFRPVnplZGw4dE45ZGxL?=
 =?utf-8?B?UmRUeGowS3FpL2g3b0Y5R25JM0NmdzYvcTNqR3lVR1NQVTFJdHQ5aVhEcUo5?=
 =?utf-8?B?aTRSeW9nTElJc284dnh0a085ZkoxTjlucGswYyt5bXFuMXNwODBZTVRpYmdw?=
 =?utf-8?B?bjhhUDV3MmZ3SzYrOVVYU0ZUenhnQ09iQ1F6YVhoSXN3WUFaSDhsYVB6dnhw?=
 =?utf-8?B?NHNxYjNnZTU4ZkQzZnp6NmdBQXNBdC80ZFo1NmNTVXNMSFFjUnRUQmY2RElz?=
 =?utf-8?B?TVBsK3JMTWNHOXMyZnhSN3hOcktFeEhNemd3Wm9WYmZPMFdPdm9UbWtKaUFE?=
 =?utf-8?B?cHBiK095dm84S2RnVlk3MGZkQjQxY2dqMVd3VU5WcUFlVy93SnB1UWNBRXVC?=
 =?utf-8?B?dG16aFBFZnN5c2RURlRMZ0ZnZEd2Y1hyTHNWN1JlOUR6Yng3ZmdZaWxYTXdL?=
 =?utf-8?B?bVlhYjNvWnVucnNVS3lidHZLYjROOG5WSzBzT0RZY3VXa1lGMDRRWDZxaCtx?=
 =?utf-8?B?a3V6cGI3aG5uU1Jyd3BLWi9uYUJtV1BtWld0QmkzK0NUTkg4RHZLWmhwb2c4?=
 =?utf-8?B?Qm13V3BBOFY0LzV2Tk1iYXBzOTV3b0I2K05HakJpYWhqQmhDQVRCNVc5Wm9s?=
 =?utf-8?B?b2tFZkFtYTZsYXhxNDF2TG5QZzBMd0c1OEFGcEgzNW8xa1NPTmtocWpxdmps?=
 =?utf-8?B?dGRDVDQ2c01hNWtyKzB3WTIyS2xFYUhKVWkxYUM4NGlBNmxzVGNoNWQ5TSsw?=
 =?utf-8?B?b3p2QVpJTUFwa3pPSWFTTllWL0Q0b3RFTW9sU0FoUVh2Szh5NGNGQ2NtZFFU?=
 =?utf-8?B?dG9BQklraTEyaVYzSVh2NmVvV0MzWWkrS2N0OVlzYS9IVjUvc3hydFpVcW83?=
 =?utf-8?B?b1BKMGtMRm9mcmo2VEZmK01GWTBvcm9wQlJSNFY4NStFanJkczBxZz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529f9229-6533-4db5-ac89-08de8ef4930e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 07:10:22.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kb0CeX3LDy2TtMJ9iS3SyzbNCx1UqLtZyWD0vJOkU5IoDKxA7+B+nrd+LIhzPa/JCVxzrf9F7w7FO6fqDn/r7B/xUuygAseivBaN8kQp9mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7864
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8439-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,vger.kernel.org,lists.infradead.org,amlogic.com];
	DKIM_TRACE(0.00)[amlogic.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87F11364EC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Martin,
     I confirmed with Junyi Zhao that the current implementation counts 
from zero, so this submission is correct.
We agree this should be fixed and will address it in a follow-up patch.
Thanks for pointing it out.

On 2026/3/31 05:54, Martin Blumenstingl wrote:
> Hi Xianwei Zhao,
> 
> thanks for your contribution!
> 
> On Thu, Mar 26, 2026 at 7:35 AM Xianwei Zhao via B4 Relay
> <devnull+xianwei.zhao.amlogic.com@kernel.org>  wrote:
>> Add bindings and driver support Amlogic S7/S7D/S6 SoCs.
> There is an old report that got lost, stating that the current
> pwm-meson driver has an off-by-one error with the hi and lo fields:
> [0]
> Since you are working on bringing up a new platform: is this something
> you can verify in your lab?
> To be clear: I'm not expecting you to work on this ad-hoc or bring a
> patch into this series. However, it would be great if you could verify
> if the findings from [0] are correct and send an updated patch in
> future.
> 
> Thank you and best regards
> Martin

