Return-Path: <linux-pwm+bounces-8431-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BmpJOwty2n8EQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8431-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:14:04 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF63F3635CB
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA8D93058BAA
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 02:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361CD36826D;
	Tue, 31 Mar 2026 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V0+9elzF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5316368269;
	Tue, 31 Mar 2026 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774923161; cv=fail; b=nrwv+vhEVnfKjeCyZs7EcMs9xGLdFuVwNqLa0wR+mz6cyVj6ybx0+C4U4C9YgpIXiyqm67MAFaWMYV60rLmOjvzap/XosBNMPLhtn43CKh9TYTPPyvSW2HJCVy2pL+34GeBD+ABqw5cblEgFlHaTRAuygs+O8L98GxjFNlH5deA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774923161; c=relaxed/simple;
	bh=sIrW+zqQa5j7X1BwYl3TNCV+Nc04mLF4kFKItEfY8KU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hoRpCTgDjJNnal0foF929Y4gXnkj9kBsgpWCWGSKmWgKYR5rpzai2fQE7FwkLkcCOCq+oHPl6xkFPFk2/tcnBWbj1k1yiAl0hSrx5KsRNuxcXuCJuIkivk2u6BNZynnP/TUPiAiayKF1fYIlGqJku+yvWw2aIZuFuYvg9SKuaDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V0+9elzF; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpMc/XKRCY+7FRqePl0uPfHM09AyfwEfrztQVlVnOhPoB69MjYcIOvxbyCHltw8F8vwThzKVvDJYV77kWjLn8fzx+woAp+v2h/1aZ6leFOy0XiNReP7C8iUZreE4abB1FlNZ/eYfN9nO6p1aUyHUkz4C6sa+xlEPX+RrSMEyRz7Klm8Ps0p2Ai+oHz30UMu61y+Hh1INlxM7xDIAP0Ngh4DSH/GuMUNMn1+KIWUgd8D10vbxYEpKs6DAqDa//Zyj4wrKjWokg8nJwlQdRrpFLn/vQNVI8vD6X6LiVzgPKB+Gla1VIjNGWlf0oUZoum3fLYxtxz6mNmfeYUAd/fpK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2c/BzWy3S3JVMDhunFNtRx0qBS5klsK1w9bsQu0VlU=;
 b=P356oh+EZw1yUK864lwQ++ODxZV5BSCfAgF1fl4aFQDSGgHvpmcRr9iq8gL9nQ0QKEmAeHT5V6ljWoIOQdZH7vYvZsSomw+2ZIGnLedV+4hWsqsCjxiLDMzvVHy1tkMUTJOeyEJXuorPySI1aLsM0thoFt8zlI2lRjb4kD4JsX824cJpIE0AdzX8+DTgartEcHW5NU2CWtwf0Rsid9ZMj5ZHPsX3eQmMd72QCQTjpl07V4piimq6Rkf3A3whXrciIWJY35XPjCHoCjlUDXPou+hwWPid5m/gL8UQhfHQxPaS7onB3Owm72icVtUdmDcX+8UB9QrvjhrixvnETiyXmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2c/BzWy3S3JVMDhunFNtRx0qBS5klsK1w9bsQu0VlU=;
 b=V0+9elzFuEuj+QYBRYhk/f7ASO8/Q1wMvWdStzw6Nn5yuvuyvpvtBfDxAP6PUk7BXHHvlHxVmukYrgE4uZSiUooeTBpA7fpSYVYENCFEwKx7sIdUfFgGc/1eoJr0airRd8xMD2yVoEJAuTbXqB6o3qhINYRSEsIQDJ8MCPVytfe/ecXFaPb2c2x/G+dZdEIyTk/1xXAM1nmI+UmxbvnE9NluASjpfdTL0UY8pePNPtQDuks0uUJELNJtulrEbJhmFeUeNjaGUzxP7m/3evYLVmn+j/8Cjg5VV9E2EFMf30YlZQS73DbdxkEfDZfMfWVSGtVc3kiN79p0sR0KrfUW/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 02:12:36 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 02:12:36 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 31 Mar 2026 11:12:14 +0900
Subject: [PATCH v4 2/7] pwm: tegra: Avoid hard-coded max clock frequency
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-t264-pwm-v4-2-c041659677cf@nvidia.com>
References: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
In-Reply-To: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Yi-Wei Wang <yiweiw@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4P286CA0043.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3aa5d6-3e55-42ac-11d4-08de8ecafa15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OWpjJ7yoz12l2LGOHXcXX6jK8YE4+vmfGlkmUbdeKDgPBNV0CmRFS7C0UeO2XS+Wy9knk5/JvgXDb5dsDV0Fm7Bdj6kCVEWP9CGSCznqyZFf4xY+BcaG2L9J/1XFpeI0W/u3I5z57pEa5ne8Ntzu6rkr+MJwgPuyUMNvKJkE9pfqSEMDa0GFXKUBGrZGtjPtQmjwRWNqDy17aMsx587hvRSvTfNuMnNdry61HrpbMXW1/LvKjGay1cxjwW71Idpue71TfhDEvYw2NFYm5PjflfhPZyNS6nDm6J6ubVjuiTYrlmZo9b5vlMzTlxi93y11up3ebQojKzQ1289RcGfY60pyhuqzdQfRDHedZJvGjJSLxLBNeoKX+px+J+i2sRzcBsTh3dF8m9ehqSF9kqgl9VLXzBXC/EbK1jtTWbSA7BShVZcu55OrXpXgMUK8/WE6W/XBjngwLmHsqa9z/0Xll3mizJWw8KReI118QP4mfm+elc2LwvEoIoa7lSF3m0vWP7YA7JEiWNyVZaDHsvCj/aBG0aG5a0uAsEuWuzM8B3z59toa9KfgT+GtnSb529zjeM50VeznnLg9tWP8v7h/xw09lKt06nKQYBHT/UkWWKNbXKQxvtPJHvQP7oAjag3sj+hekjEcmJeBhjobpP4d7844Y0cM8Akq37qIx+ct2nv1U9A3+SyWh/W/i6XCLits1ZVc/6m9KxGpH+C6fjcdGIHKlE67k6GA21o9RxD5Spc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M21zT0llUTBXL2V3U2M2MGpjcDBZeVEyRlJkSkFnc3hnbkZ3OGtHa3RWSnZ6?=
 =?utf-8?B?K0JKZ21lUVVSZHVuclp3YW5NTmxmdkhEQnAxUjRhTzJWQkc4Sk44Sm05RFVy?=
 =?utf-8?B?Sm96V1Q1ZGdFRVk3V2NtejlLUWxDUWg5L3ArSEYwenhlTlZ4ck44U1dqRUNt?=
 =?utf-8?B?VVo3MHNGZDlyYzI4YVZvaTBxOFQ4ajQwL0xzQnB2dFYxNHRCTzJXYlBUZVE2?=
 =?utf-8?B?SnBpUjB5Y2g4UGY2dTZJR3RwMmVTYTIwWDAvTnNBaUM0QS9lelRPSENKUUZk?=
 =?utf-8?B?cm8wZ25YMDc3TllKU1EzTzZMTnFXeU5YMk5CWWpoMUc3VlhLWHNQdXhHVFk3?=
 =?utf-8?B?a0lPUHNEVG1QVHNjdlBRZDFRdmd3Q0hZVlZBQnJCaG5ibTVERGk1TGdmaDJN?=
 =?utf-8?B?M1c3NFdxeHR3WWw4dXQwWUNpU3pzQWdqYWZ4czlrNFMzYml0N3c4MWxLbENk?=
 =?utf-8?B?VlMyMC9YYUtsWllKazgrUkhYK1UxUGtzTXl0Tzl5a3FJSlFURjN1SS9SQnNJ?=
 =?utf-8?B?ZXhFV0Y5eWptWTJtR2lPeDQyRUIwT0krZGJxZThPbkxoWXFBeWxpekdzajFx?=
 =?utf-8?B?VG94MXhRRUpqNjF4RTB6SWlkbGdKdXd2SWdQNC81aENyQ1hxM3FtRVFidy8x?=
 =?utf-8?B?aXZIendSU29KRXBMY1JpeWhFM3MxaVFXdkR6Tm1xZVFFVXRobGo2Z2d5T3JF?=
 =?utf-8?B?aHkvU1RBWERhTXhlcTZlcW54Z3BLK1VIM09NU1ZZWW9vYTFRVGRnT3E3K0c4?=
 =?utf-8?B?RS9wT0pPZW4wU2dSUGJUZmgrZElLSXcyYjhtd2F0VDcycVVabC94V2RqMmIr?=
 =?utf-8?B?dWtUT29yQmx2MTZHVVg2V29McDFQMlRpV2d6TFBkNnBrQXpNaGZuMEg0M2dP?=
 =?utf-8?B?QU50cVhRVFIzWVRSc0V5dzZVMjF3eG11NW5Pc0F6MjJsN0dYSnBhNEFwRU8r?=
 =?utf-8?B?WitUMGNDNElkaDdGOVRCZkEyL3h2ZG1ZZm1tZkdjY1RQbVRVWVQ3bVZNK3Av?=
 =?utf-8?B?cWVxbWVyNldwRG5lNVVHOG1Ib3VMM2FUcklhM20rT2ptaUlVQ1FGcWtnbllW?=
 =?utf-8?B?NUprb21hZGlZVkVoeCttWnl3N2pUaDR2VEhRK2RUNko2Z2JJWSs0STY3WE9C?=
 =?utf-8?B?RStQUlpHRUttdjRSREwwMkJTK2FhVFBGR0ZYcXJDU08wSmsvczAvOHh0OHBt?=
 =?utf-8?B?bC8yRkQrTGFIb0Vac21YVnVsa213bElRTWsvVUNtRTgrY0I1L1M5eEtTM1Q4?=
 =?utf-8?B?VVZVSjUrZDQrTi84VGYxR3RnQTNvNm5BUjg1dHRNN0tnL2FBcFdnMEdQazJJ?=
 =?utf-8?B?dzFkS1d2cUVKcUFjRjd4b1pxazJ1UE4zbkhvVSs4TmswMW5DOXViQ25wTWZQ?=
 =?utf-8?B?Q09rTXNuWmtkRVY5V2FqWFNGbU5lOVk1ZktJTHdDM1lnMWc5NmN2SnF5QXR5?=
 =?utf-8?B?MmErWGVYaHRPdEpadU9TWm13MWJPazNUK1k1aG5uOEtoaDk0cHI5OFovck9L?=
 =?utf-8?B?N0dKdWtycTNvOG9NRDNPUWJEL2ZScXp2dyt4WFJqZ216K2JMNyt0cGgzc2Vw?=
 =?utf-8?B?VzFVd0J5VnhnYmduMGpaWG5iKzAwalRzSFR1Mm9scUZFSUx2aDdsZGF0aTV4?=
 =?utf-8?B?S1ZSdHprcEFLZHZCdjZabnUzVlhkMTJ2cDdsUVJYNHhsS1lkdytoR3R3Q1dv?=
 =?utf-8?B?YS91VHB3d2ZnQnFvZWNOM2Z1SGJiNGpoY1ZHL1NoT1Y5TlZKbXRVZVVqWjlK?=
 =?utf-8?B?K2hBUGJPbDZIZjhTU2NCUmVHdDl3cnR2dDdMZnp0dXBTM3BMSUJVT216ZWNk?=
 =?utf-8?B?UWFGb1F1aWxkcXhsSHNmZGJMeUI1NEJ2c2JsZjBXQ2tYSy9EQkdJUUFSVE50?=
 =?utf-8?B?QjRyb2xsUStkZ0Y2Sm1SVTFRcy9zRjFPS0s2LzVMdVgwcnFBblQ4SndrQ2dZ?=
 =?utf-8?B?b1pxdmlHRlhrV1lnd3ByRzJIcGZTbnUxemNNbjlRUTA1RXZWZERBTlJYNU83?=
 =?utf-8?B?dyt3RlhXRk9xZkc5N0hBNVdJb0pTZGVmY1JGWkxEU0FETXF2SWxyZHNwVXo3?=
 =?utf-8?B?L3dZa2V1SmxUdUVuQ3llbUloUWJ5dndldlhTWkhFSFZ5b1VjY2hJZG1uSFF3?=
 =?utf-8?B?MHBUSzVLVVFGT2hxclF6aUIyeDI4NUhCdW93Sms1NWRkTytmb05iU05WV0JX?=
 =?utf-8?B?Ly9tZXZUV1pTZXh0bzNza2hCeThMQnRVa3prSUdic2NXbGZDUGZpaFBHdzdw?=
 =?utf-8?B?WktFUDNMVVl4Q2NnT1luZWxXMFVQWmsvQWp1L3FtYmkwbnlYN2s3QUpCLy9I?=
 =?utf-8?B?UE92a29mTU5KQ01MRkRMajJCbnRRQUhhbGhhRFF6S0RidzRmaEVOQTRtR1o5?=
 =?utf-8?Q?v7mMc/bVcnetaNRM0zthIGS6Hyo5LVdIlwZUf8Z3MvTgt?=
X-MS-Exchange-AntiSpam-MessageData-1: z9GbsvjH7meK5waZzB4F8/UCrJ4/Y/eIulk=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3aa5d6-3e55-42ac-11d4-08de8ecafa15
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:12:36.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPm3XCvndQeCxJgopkIYjg+/LRm08pvfCkufvdRGI2EIy8V8q6Aa+BDFEvco2waEdrC7CbyPORIbq+qU0NcOFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8431-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: DF63F3635CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yi-Wei Wang <yiweiw@nvidia.com>

The clock driving the Tegra PWM IP can be sourced from different parent
clocks. Hence, let dev_pm_opp_set_rate() set the max clock rate based
upon the current parent clock that can be specified via device-tree.

After this, the Tegra194 SoC data becomes redundant, so get rid of it.

Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Co-developed-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 172063b51d44..8a330169d531 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -59,9 +59,6 @@
 
 struct tegra_pwm_soc {
 	unsigned int num_channels;
-
-	/* Maximum IP frequency for given SoCs */
-	unsigned long max_frequency;
 };
 
 struct tegra_pwm_chip {
@@ -303,7 +300,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Set maximum frequency of the IP */
-	ret = dev_pm_opp_set_rate(&pdev->dev, pc->soc->max_frequency);
+	ret = dev_pm_opp_set_rate(&pdev->dev, ULONG_MAX);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
 		goto put_pm;
@@ -318,7 +315,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	/* Set minimum limit of PWM period for the IP */
 	pc->min_period_ns =
-	    (NSEC_PER_SEC / (pc->soc->max_frequency >> PWM_DUTY_WIDTH)) + 1;
+	    (NSEC_PER_SEC / (pc->clk_rate >> PWM_DUTY_WIDTH)) + 1;
 
 	pc->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
 	if (IS_ERR(pc->rst)) {
@@ -397,23 +394,16 @@ static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
 
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
-	.max_frequency = 48000000UL,
 };
 
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.num_channels = 1,
-	.max_frequency = 102000000UL,
-};
-
-static const struct tegra_pwm_soc tegra194_pwm_soc = {
-	.num_channels = 1,
-	.max_frequency = 408000000UL,
 };
 
 static const struct of_device_id tegra_pwm_of_match[] = {
 	{ .compatible = "nvidia,tegra20-pwm", .data = &tegra20_pwm_soc },
 	{ .compatible = "nvidia,tegra186-pwm", .data = &tegra186_pwm_soc },
-	{ .compatible = "nvidia,tegra194-pwm", .data = &tegra194_pwm_soc },
+	{ .compatible = "nvidia,tegra194-pwm", .data = &tegra186_pwm_soc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);

-- 
2.53.0


