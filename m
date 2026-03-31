Return-Path: <linux-pwm+bounces-8436-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLvrM7Uty2n8EQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8436-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:13:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBF236357D
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F054301909E
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 02:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3895368962;
	Tue, 31 Mar 2026 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TiWsSAKB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE01366DDB;
	Tue, 31 Mar 2026 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774923188; cv=fail; b=Lu4t3ylkhbb9iNXLmUtqSLzLEFx3tzIXusv2VcYLp4mgslaAAc+15Vs6DxRx+d/4oB9pvc/InSi+jvVTpNhzD3Y9mGsFTbDNRavbgF9vy/huV1yBac11M1PaGURMTT/8c51+2djhMcOvXWwiPcV+1xHDgYxsL22huToOqOjP8fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774923188; c=relaxed/simple;
	bh=furNPDXZTeGLEC7MAFEiX7UOWt4MEGKhoi99hd8j7Jc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HE3s/kqWKLnCXOM50JkoIde53qfa71VoSGfysHxm7ugbtkYHJrBC63gQlqsXOm6MwvbpHymliEXBn7raLLmjSYJWQyC1P3npR9zlvxnQD/1e1u8ir589LSkoQF3jCEJvsT3KgI37y9905PIo4Bs0Iu9fEDJdM967vpo1P9z++gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TiWsSAKB; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WH5l2IwePNmcXHLgiHSNdzFP7OD0Ql2pAh+DdM8uDhdf73/ZeX3L9zBh9YmO+yQdoy7/YTEFw+qQ9nPk36nnclDEvKHkpBSLWk6v6X47kE8vWCxWXTIetuX4s+oGzneCwdC7mjEb53c7SFQ1StGY6MkoBAJ9M2HGA+thYqS517vCYTZeM1gmXFjPwYn1r03QIXT/KCM9ukxK6OE8UUAkwHFyoKCcKWAvqyjZ6QcLTJuqSycP/tcpLe0sk8jX/OXv9NdQxByuNrzwDlvC4/80Eh0JPl8Gd1w3l+uwl7PHviELflY+QrFexs7aAzsBNlvwzVUQ3srDfUXDLG+1cl7+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4e3T8/wHGH1MGCYChzTeTntjX5tt56SeqPBDudJ3NY=;
 b=p73UPdOO5qaF8oV5MiToZJVDf4aR3nmlRTDZ1aiz5x3cSaeqpaVooQ7bB18y/DN6ba+Jt7jcX0cW7kJupebrgzRDh9oCBt9bcEKjAUVEvtv81L9SuqCfi5WFY1MFaXTW0xjKCY03htHTOOi30KcYgVtvVjqi0m4FvWkoh4W5v695ZFacJ7A+lHmfyBHx9ZHkCF0/twkGM6clH6Rs9Yx4+3vJLMKcFnKQ3yNAWpP7yseJJVd5jYFnVSt/DnqBEI3Cy+oYsgToI8BPHYZuklP87QztxX/q4sAEumhECH8fxGNe3y3aMxTs53KhHeh52FvKDLnupllcw4rjMWZDnD4Xew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4e3T8/wHGH1MGCYChzTeTntjX5tt56SeqPBDudJ3NY=;
 b=TiWsSAKB2qycNJfLJRBQvfWLNA1E1w2WLG1DGRMH9YnaT3/xzOksC4AE2ZFW2ZV+LMMqK11FR9WulOHjqrdH+TMK+zcOoPE7DfKIk+vL1MxnofTsVHmbhnvhD1U0bIhakIdPXa39tAgPSRzy+roDYWfZW3XBFh+zLDuxjjZNHSCnxehOqk0s0Dr1w4xXEbB4fAMciZEKfTNKvRSgOToWQnKwRUZS0/0Na9i50Ifek/2mMkHtI9PJGbWkH6k9/iwgLgzgnxu77MdBE0cDaevoUgHQi76RPlX1jzU1bXMC/+LKs6Pw34xv4LbYaI6l8LhoB4CRhApyVPWjlngRbcd6Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 02:13:02 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 02:13:02 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 31 Mar 2026 11:12:19 +0900
Subject: [PATCH v4 7/7] arm64: tegra: Add PWM controllers on Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-t264-pwm-v4-7-c041659677cf@nvidia.com>
References: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
In-Reply-To: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4P286CA0047.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5af6af-ce54-41e1-c6b5-08de8ecb0975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WrZtSliAvEZFj8gvLmDPkfaPUkvwvmIjP0i6CoxxF0W+mQJI0oofZJLDBkmoGWnosOSHWgLVyal0Ry8T5oVwWRhZIOH6h5egMkulbJoUAb+QS1xprfsRFswQRCcqS6cvdtiBTpZLADgVkO4Dr8LgW5hC2vtnDmG0LfI/onCzeO7NWVDv2WsYLyP+IJhi3LBUE6oP+T/YDPQrKyk3ETTr9EPKN8FfuXO9cN5JU+benT+igRtbN0CuZk8qD/gNAWBlG6YNPRv64/8xTUEhcl8rimfh7xwVM+nnMDGZH7nqY2iNYPt1SVNMFzY2t3q2rxo0/9WIOUeypQnhqw8s+Sd4gVjEDv2LHiXOsYGayIbZv0h2arU8nJPc064ZMTp7wsnRFxkOEDdLTopqjwPs3XojNrZ7MdTS0QOGJ38SlIr40CbnrdSa8uh1sEvTQsJ4WIKjYFfVuyUnCnUrpiulVDAieKescFviT9dUfzEW6qmEllBQ4TlBVxh36a+GHVisjO2mNWMOzC0ofIikg9TRg5udNj6wwu+qxuwSecs4GV3Q2rSeARfEAcLZgJjC1NZlPGecIuTZekrg8Ae3tR6NkNz0Oo/p1RTI6EGTHJn7iHF6Tl8qUxS9neUlzW9b00uln74U+G75lOzOA/Luw8xNobUL9Y4E9HO9lBlYcD0swj68GuCyKFmOBq227V+IuR4iVOmdh2TfcWp424NBrG20SsUqW7ITNzM4RI5m/8yya4O8kc0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTl0SXFJYmxydm1WOTl4STRUcTN4U28rRkdmRE00YjlPRFZCZTY0d1JnTlRm?=
 =?utf-8?B?WEpHOEt1OStZRkNCU1R1OHNBT0x6bkZnUnJaaXIxWng0SHRUV3FLdVN4MUJL?=
 =?utf-8?B?RUgrVE1ZeE11Z0V1dWtZc05qdUM1TDRzaDg3a0RyWUJ0U2hmK1VVK2pPOUZD?=
 =?utf-8?B?SVRDTGZycThqVkk2Wi9xUm5GMjVvcGJrczBHQStJc2F0dDBoamJQUUdwRTNZ?=
 =?utf-8?B?UnM5cnRLaVRrM0grU2w1UmxMTnRtT2FRRGQ2U21KYTBhNGR2K2R5SDk2VUVU?=
 =?utf-8?B?YzFyU0VSZjRpM0QyR2M2bFBYMW9Yc2VGOGo0d3FseGlCa01mQ0FQWGlORE8v?=
 =?utf-8?B?dldCaVpsWE1oWjAvaUozY1VBc2VrMUlhRnBJSkt2YmtFTkU4Z0ZPOHhua0hX?=
 =?utf-8?B?MStJYlQvN2hqSHJDWFE1RjdNYm5JdzY1RGMvdmdmdUI5TWYzQTJNRWN3eGtK?=
 =?utf-8?B?a2pjaTNTSnc2TGFtTXQ0OUQ0ckdXVUZhQ1hhVzc0aC9kV2FiWnIwck9kSmt5?=
 =?utf-8?B?MmpMZ1BmU2MrLzY1OGtjNEtSaFpWVnU4UTZ1QmhHQkxqajFuRDQwS3VRQ3Fu?=
 =?utf-8?B?eGRweDRhZVc0RnZxbjhrL2NaVVYxQ2VIUmFBSFFjWWhMYnhRRFBzWHZsVzBr?=
 =?utf-8?B?a21TMFdZRzdIU2tzYURzWEhEbndiaXVFNWF0ZjBUa3VjZ01YNTNYZzJ2NEZ5?=
 =?utf-8?B?TkI3NmdwWlBnTXZwL3pWU0R3UmVnU0Z1eDV3T1lqakVGOGpwOTF6cXZZeENr?=
 =?utf-8?B?OGw0OUFtNmYrZlpNOUpsMmhYSWxIbTg0WHZVUUp2NkltQlNvUjYzUnZTTW1U?=
 =?utf-8?B?N3gzczZqc0h3K1RCc1ptS21paWg3RFN5ZCsrRUxINE5GNmIzTmszZWNDZ0RZ?=
 =?utf-8?B?NW1idm9pNUFMNUJCa0hRWHlkbzFJQXl3ZzFLWkR2SVJOeTIrTXNPcGFyU2kx?=
 =?utf-8?B?ZXVIWVVHK0pUOUs2bTJ2QUlTM1lOZE1xL2ZHcjdZTXRVRmt5UG5LSGpWbE40?=
 =?utf-8?B?bk1yY3M1NXFsMVRvaFp2dDF5SzU2dTNCVlJJbWlDSjJwZUR6RVNQMVpnOURN?=
 =?utf-8?B?VktrcW8wZEpOZlVDS3N1eUI4ZmlqejVLNDJ3M0U5UldiRmNEaFB6WDhPMTZn?=
 =?utf-8?B?Vm5yN01IeVVROGlBTXhsUGpqN1JaZzNVY2JUQjE3VkNVdXEyTWdmUW42RVVB?=
 =?utf-8?B?cTFERzlZL2pXNzZRNlRBeHlZR25PdndHRlcxQXBiekhBQks0YUZGU3VkQThw?=
 =?utf-8?B?QkFWaCs4TTI1djFhRXdqMjJDbTlrQkRDSys3REhKelR4ZGVyZFpwSzI3Unk0?=
 =?utf-8?B?MFArYy9XUHAzeWFkbGtRS0RvU1hxeWdRTWplbGJCMWNaNUxMbS9kbHB4Ni9j?=
 =?utf-8?B?UmVjUXpXeGFmOTlTRGxNckZTUkFFQkFHT1hISzk2ZmFUNit4QldWY0dyVUR6?=
 =?utf-8?B?aTFYbk52K04xQ3p6RCtvRzZZUnF6TGtFVm5aMHBlellQV3IxMTBKL09SY2tT?=
 =?utf-8?B?QUJZS2htYVJDTEFaUnhWcjg4Sm1scStmNVdWaVFjZXc3RERCcWdYRmxweUZB?=
 =?utf-8?B?TTBsbGpVc3dEMHlYcVlxN0xSdEovZy9Jem1TVTg3S3g1U0wyUmRPTXRHbWZy?=
 =?utf-8?B?OEdRU3ZJT2Q3cGF4d0Vld0plWnFJbFg2Z3RhRlVaSDIrRzhMY3A1R01kR0Q0?=
 =?utf-8?B?S2FKLzdtQjJZQTZOWkJGZHhjWTlZZXorR21EdGZiZDhrT2N3ZzA5NUFLUUlW?=
 =?utf-8?B?ZFR2ajhDaEpVZHRDQkFhSDVpNzVWSysyYzZycDVwN1dWR1BsbmdvSFpDNFE5?=
 =?utf-8?B?Nkhzb2RyaG4rckpJV1ovclRlVlNpaE1jRlViYmFFVG9iUDU0Rlpzb0U2NVBG?=
 =?utf-8?B?cURveW96cEZtRGJQV1hwSUFDQzZNdmw2S3NHYmpBUFM2ZWQ1UVV5MStneWtl?=
 =?utf-8?B?Y1VYSTUrRnVJbk85WUVqM3dDSzM5UTI5TjRmdkQzaGR6Y0k3Y3F6bGgyc3Iv?=
 =?utf-8?B?aDUwa3JKOVhIUERMRk1la3k4RW0rUnZSbGJqT2Y4b01UZTF0V05MTmhCUFBW?=
 =?utf-8?B?dWt0bkpxRklDWW9MMnozd21EV1VjMEg5YXlNNWdIUmIwcm9MYzhodEswbGg2?=
 =?utf-8?B?UGlSVzVobVZWZ2cwaTNLVGx3WllUQWtURDFUcUF4ZlVkTVowdUpFc1c5R2U2?=
 =?utf-8?B?TE5wRHhNYW9tSWVGVGVJZ2lnY25Hazc4aHFTNC8va1FGT3pDenlMSVZPUGdp?=
 =?utf-8?B?N01EcDZ2UEZlZ2JhVXQ3SGtBQUUxRWU4amFaV1Y1dUN0anNhYlY1d3NrYkdR?=
 =?utf-8?B?WUY4MUJWSkl5WlNIb21JQVpnVGFLL0xxc25MSUZiZzZuUVMzSzZtb21PUjNO?=
 =?utf-8?Q?z0RRU23VmQV40eqSayiuulZ15nfL4SjETOa7x2O9mD1Jf?=
X-MS-Exchange-AntiSpam-MessageData-1: fnQ5WvHoko0VgV3PhPIjKWvbORe2s6mmHXU=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5af6af-ce54-41e1-c6b5-08de8ecb0975
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:13:02.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0E1ytClEqtNHdMXXAAyTAxR11w5mGXFxod9Qp5cUzci2yr5AhrC4dRNEhnhbGOaMM520SpDf29dn/S3vaOAxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8436-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CBF236357D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thierry Reding <treding@nvidia.com>

Tegra264 has a number of PWM controllers that are similar but
incompatible with those found on earlier chips.

Signed-off-by: Thierry Reding <treding@nvidia.com>
[mperttunen: Adjust commit message]
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 72 ++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 7644a41d5f72..13fd04068016 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3336,6 +3336,18 @@ i2c3: i2c@c610000 {
 			status = "disabled";
 		};
 
+		pwm4: pwm@c6a0000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc6a0000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM4>;
+			resets = <&bpmp TEGRA264_RESET_PWM4>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
 		pmc: pmc@c800000 {
 			compatible = "nvidia,tegra264-pmc";
 			reg = <0x0 0x0c800000 0x0 0x100000>,
@@ -3538,6 +3550,66 @@ i2c16: i2c@c430000 {
 			status = "disabled";
 		};
 
+		pwm2: pwm@c5e0000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc5e0000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM2>;
+			resets = <&bpmp TEGRA264_RESET_PWM2>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
+		pwm3: pwm@c5f0000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc5f0000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM3>;
+			resets = <&bpmp TEGRA264_RESET_PWM3>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
+		pwm5: pwm@c600000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc600000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM5>;
+			resets = <&bpmp TEGRA264_RESET_PWM5>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
+		pwm9: pwm@c610000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc610000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM9>;
+			resets = <&bpmp TEGRA264_RESET_PWM9>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
+		pwm10: pwm@c620000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc620000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM10>;
+			resets = <&bpmp TEGRA264_RESET_PWM10>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
 		i2c0: i2c@c630000 {
 			compatible = "nvidia,tegra264-i2c";
 			reg = <0x00 0x0c630000 0x0 0x10000>;

-- 
2.53.0


