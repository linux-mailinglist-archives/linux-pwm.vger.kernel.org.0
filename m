Return-Path: <linux-pwm+bounces-8429-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOCFHc4ty2n8EQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8429-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:13:34 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E281136359F
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFB3D301AB8E
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 02:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EDC36606D;
	Tue, 31 Mar 2026 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mtjU8ozj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4050A95E;
	Tue, 31 Mar 2026 02:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774923158; cv=fail; b=kTojxniunYQCXILrikW69pb+ATi4qUIouKDQl/ZwKJn2su8/6fYQwIunFTedR+TaNriMULkkux8AI2FZiAfUQOmHEWFd8Ja2BA0pom6qh5q4sXFDHzrS+sUc+5BNnitZ5rJgxHGbhX6skeJ6jw5cGW1Aq4Xv+4VRlWVGUFvtjf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774923158; c=relaxed/simple;
	bh=tlrSDCUE2UjLR52l+21YO4gbwl+bv/9DTWmxc/JzFOA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RZSKm37IsennzA7tpxe1bJAk8igC+YNJ7nvXJK34xt2kGG7ID2EYstTGliK+KGyCx937GAx5by5pugWJH/mvQizwR5YOUvdLMPvoXYNEfnn1PXPAIwMNud9oKz3EEgYhYHnOTA/71q47/5Nta+vCtpzVLsKDaQquxC4B6c6JBwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mtjU8ozj; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LK+t9+el/slrfmHPYTWoKkyW9UFW7aH7MRqu7oi41lX4etHBH1Hu85o9t1+98Pvbfjo2QYHrYblGT0TahALK6oK2182vtNG4d/q/72FFWhMCv3G73wzXBc6ttdoVpZ+6F10G7JE1NGpclwjseEyZxiepGL01QUCJkTlDo2JhRF0f1TNH9nzJuiuPFST2UF1viEzjJMAcWFkIXvg9CU+CwBxCIpJkaNePIFo2xo+AQpBttmJLF4p0bjt5quFtZseo5NVP9vJll34NUW6hOiMWLByu3uF76dp2SIc4nsE4mRtJ/AZfH7Qxuw0thZqkRmbVvMzN0QV+U+rO2BGvgz1iww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7nx+hIrS5IrKIV0i7hW7FBku2wT+Zyk1R8KJS4P0gg=;
 b=cdOyxInIloAYb9iLr68cHGQLRkCs4a0vg2x0LKVLTiVid7f3LLbqsx/nWEYebtknkKMEGIi3FAQfDTvhDW3zNorRAqtayc5AHX0Pz2tci5czYYpadVrwCoaX/+gHndGkJhG4lCHpu30peS8Gbtqp6lVjKgvupY4Mkd6M5VuGdzBDbFC8lOP5HCEMyigwR+I6k8qTYvJcrklsf2SHfBzO4Qa0EcEB2StJsbNmgikHJvTRAwXDbVsJWH2YyYuvHcYJ0J7UhTrB4ri1dzkvAeteuyOl7wBMSH/lX7kv7ZdVoDdNFbakl9fj/35qR/eZlMPFTJ7LcapcZE2eXQaQRq2PBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7nx+hIrS5IrKIV0i7hW7FBku2wT+Zyk1R8KJS4P0gg=;
 b=mtjU8ozjHBhoboEaQ322zT+ri61JEaCy32MyJsWTtHcn6hM9wuhR3tbc7FoiwniNtyg4BIwoLg12Gn8PEsrJlqT6yKklfLjtoKMMrgOBpDIaq7bp5UEot/x4yIYMCUd6DoCD+5Z+kHWz8o/uNHahAGAxffiq5VXxqk3GrL8A9ru8OjFbTMH7crYgveKHL7VuSt0VMJ3glyP6i7tlVt3Pr/OT3tDBGuCiumIpW7rocVooopAp9wO/CSxmcpjftZdLL+871alLrhqULPq8pk+WZpuAELeZtjHK4wLDesLyHhFBr8K5EsPFyqpA+APVQE7kJidr3eYkeBz4jyCBblMLKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 02:12:32 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 02:12:32 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 31 Mar 2026 11:12:13 +0900
Subject: [PATCH v4 1/7] dt-bindings: pwm: Document Tegra264 controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-t264-pwm-v4-1-c041659677cf@nvidia.com>
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
X-ClientProxiedBy: TYWP286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 819430e3-909e-4fa0-5079-08de8ecaf7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WV2vsSByZFyTLgnEAPVzR9+aWKhsBXFRV+9gOCdWK8wtpbkcAkH4aOVoHvBAa2ZN4HZmWoR1ePp9Bot4k6ouoEvTnbFkqD4S6ROeJRjMMHNGC4EiVyfsZNsQQxW9k2XL/jY/8iv4UfFV/u4oYfnBlRMekpsFduRKQVJUf/WoO7MqaiJtL1DtXH9IuO2eE5OodyzXf7n356vexJGTwoQb0PWEAIvhW8oWwno6pPPuugcHDmNyips7Fpb4yAuaIk6+sio/Qus7YVWKW598I9pkIe27xIMGHhwVJieFzEpYs/JIPWnm480T4295tCnsFpP867756p0XW512ppgwUD24g2BqQTKBcT4Kw82ErFXoOrSz2U4K2crjFEagV18K9P1Xa8LZukxkyvbPE6FnsYcM8P1qe8im4tW6lmh14qsPSt4Fr+wIjL9/dxoZYNVfrVUf4Hvj6mfB7ap8bNiEW5SK1KqwEUabu4fSoVWq9TQ/QASssj9Yb4wM5D4+Nh2riVzewSiF/dnTOqZkGv3OkZZG7cEBaD4dCNhrIDUhbhJdd3R2OHCozWNIgUGbwJi7eoMPK5RXKORuzmjNuJMf+DgEHlAr2bee1t3gWUhgSI5HxXVjfe6ztq/6HUVSdne1Bcpss9ldt6/IsYa/YWRcli3TbdnrdzrP9BvJLowIUHvDck+aYmT/J6k/H7X4zN4EmHQiyhObtdsA0eWpokAUhWN+1goQweneHn6q9ySghfUFuJQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2E2WHZJSHVCSSsvR21tMFpQRXJ4RlQrbmxUWEgvWXFHRFVGSFN6TGFab2hW?=
 =?utf-8?B?RlljSlR6VzJmNXpJWEpxNEJSMHlmMDRUQ1FIQkxKVkhHSWlvZEpSVWlXdjU5?=
 =?utf-8?B?Nk1SdTFYRHdSM0hDM0c3MTZIbERRWjlFYnJRVVp3RGRwMkFpbys0YlZaVVhN?=
 =?utf-8?B?c0xmQ052RTArdlpCeWdaSGFLeldIcjlTWGdSaVFaU1N6eHF3ZXJxUGE4OVZ0?=
 =?utf-8?B?cUxwOTliL3RKeUVYaUpBS3RibGVldGtTMmZKS3J5K3FtMXRaN2FIbDdleTJi?=
 =?utf-8?B?Q1lmUFdFeGtOdERzM1JVWGRtdGRXZ1hLNGRqSk5wNStEM29wQUZYR0tadkNm?=
 =?utf-8?B?RERUdHBBUEdTanV5RXU0blNqQU9LKzBIUjdIeTFwdVNzRmsyTzI5NWcrWTZu?=
 =?utf-8?B?Z3dLcko1Rytkb1dyeVQ5U21USmU0dG00Wm1UY01odVJKdHRvR2ppdDd6M3oz?=
 =?utf-8?B?WXVMODZxU3RUVUVKT1FTN1JVMzRvek1QUitMdDgrbFZyaEgxRHBEKzJwMkIw?=
 =?utf-8?B?dTlqaVJQMFIzMjBHTEJNWTFmOEp3N1BZNXZ6YU4wWUlWWXQ1UWVXa2xpMWx2?=
 =?utf-8?B?UVZodkYzSHM0N1lvd0p4T2M2T3RHeFNRV2FRNGFUN093clJUK3hZWHpKMW1z?=
 =?utf-8?B?WFJjVzF6V2dNSWRicU0wYlFaQkNqRHhYMndSdzNpMUs5blhjUmdlOGVDTjg3?=
 =?utf-8?B?T1NjZWNIQ2F5a0lua1dVMVcvSk5CSmozK1ZweTBpZlZHdlB4L1Ayb0M1U3VU?=
 =?utf-8?B?cnViZUovS0VtK2FocWlQZ085d1RETG1CV2wya09LSHdPT1JSdUltTmhCLzdD?=
 =?utf-8?B?bzU3aVkzTWtPTjNDbEtXZzB1UDl6aE9uOG1JbkNuVmVlYkJhYzNDY0FzSDFE?=
 =?utf-8?B?eUlxT1JOYVdDYklaUnp4a3RtNTE2M1duWnlFSStBU0tlek53SDVwNEFHdzg3?=
 =?utf-8?B?NlRSR3poUjNtY0o3WUx2L1pkelJLNWdyYVJqcUg1R1Y5dG8rdGpWd2g3MjBU?=
 =?utf-8?B?YnpTendFMmh6T1M1aHhaY1pON2QvUHI4Zkg3WmVKTTFxUUFoOWRXeGVIM0lF?=
 =?utf-8?B?YUZPSGMzQUNyZWNpY0h2TWt1QkdUb1p4aHdxd25xOWYvVnhaSFlsNnpDL2NE?=
 =?utf-8?B?aisrdW5rNUpEQ01tOFlkTFhDb2ljR0dmYkN4bFhlVzh2N0ppcmsrSzhqUGFP?=
 =?utf-8?B?eUVuUmtSenFDaHJLSG1tdFV5ZmQ5ZUw4YVVxNzBHaVlDLy9oTlZEeTBKbG1X?=
 =?utf-8?B?Sk9sc1FVdHpVRjNWa1BOTC9WWkphdnc0YTNka3hnMHU5QTJXZ1NPL09STmYz?=
 =?utf-8?B?RUpReHFTR2tOaXF3WnZ0Ym9rSjY5aW5SMmlCa201L0tNUVZPbGM2UDZFL3h2?=
 =?utf-8?B?RXRDaEZrSnp3ZEExcElGWk0waVFOR2ZVZktnSWllTkYvcy9GRzlGQkNHbURk?=
 =?utf-8?B?Z0tCSUozbmZEWGg5NEs0WlRMc3R2T2FkQjRkNDBNa1dpNGRlRklNRWFiUHBz?=
 =?utf-8?B?TW9xV3RmdTdjeXB5STZxWEl4Y1phMVE5K3hGeTFqeXAxeXRHb2ZlZnFHS2NH?=
 =?utf-8?B?Z1dDRkNuaHZsV2lGRWtnbUdtMHpPSkVtSlJiZUhuOTJGbHVUbXJzT3ZxMjJL?=
 =?utf-8?B?QlBSK3lOTU5tNnRNa3NMV01WbUVDMDcvUnZ4bE1GLzEzakZXQ0pUcmVEdG1J?=
 =?utf-8?B?VWE5b29pZjFtUjNZSGVveEQyY0xOMjhNTjhEaWY5Y2tIUEZLanpacUxWVHBl?=
 =?utf-8?B?M2ZxQ0dUQkNBVG1GLzVESnF2TSt2V1NUZWorRUhNbG5odlVUQXE4Q0lVeFg5?=
 =?utf-8?B?VXB1OWNZSHdzRHdSc0NtQ1FnY3ZsUmpOcHRmMXBBUjZCTm5nQmgvbmlGSWxB?=
 =?utf-8?B?ZE9yNWY4ZXp0TC96ekpHZHhaNEZScHB2WHJkaDhyMTQ2ckdUMjV4NU16TWRy?=
 =?utf-8?B?a0x0ZzBMT25BN2ltY05zSEp6UG9NeDN5MldISXk1M1lZYSsyRzc5SHM4bXZa?=
 =?utf-8?B?djBQNlpYUjkrellZVmVEajYxa2lIRkoyRVJ1bnBQckhtNzJUajBwYkgzNUdw?=
 =?utf-8?B?TXB5WkI1Ri92N2ZpL3V6WjBKVlN2S2xFQVZuVjBCTWNYOXQ2dzgxZnZkeld5?=
 =?utf-8?B?amI4OG9qNnl6RWpxZEJZQ2ZXdnlQdmxpcXlLNzVsV2k1RElqdkVkMXpWZzVQ?=
 =?utf-8?B?T2ZITmN0K3lwNVpZcTBkcFRqbjVFR1BYOXdCN084dUZGV3ZhaEpZMitCby93?=
 =?utf-8?B?UWkzVGE4U0xQa0VTRFpxMGg2NHlIYUw2K3kwZWhoVTZqU1AzNnhQL2M3R2xr?=
 =?utf-8?B?RlNMTHV1eUlCaXc3dlBURVczYWVabkVMWEp2bVdhY0xRN2NLS29vdlZGWDJq?=
 =?utf-8?Q?Dy82dVwQA31E56kT83Yv5+PXEn7F/5WLfu9dRSL6eFK6M?=
X-MS-Exchange-AntiSpam-MessageData-1: 5KOam0GyK8mWvw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819430e3-909e-4fa0-5079-08de8ecaf7de
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:12:32.7358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXMCAJAMsixJlDm6nO36pIkwoOzf4ozRKXdPCqsAfBXuJ00YnTGepQncCPvFXLPcmKVwQ6oJVgHgn0AK5R33JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8429-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E281136359F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thierry Reding <treding@nvidia.com>

Add a new compatible string for the PWM controller found on Tegra264.
The controller is similar to earlier generations but not compatible
with them.

Signed-off-by: Thierry Reding <treding@nvidia.com>
[mperttunen: Drop extra Tegra194 compatible string]
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
index 41cea4979132..cb2f36e7b5d6 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
@@ -16,6 +16,7 @@ properties:
       - enum:
           - nvidia,tegra20-pwm
           - nvidia,tegra186-pwm
+          - nvidia,tegra264-pwm
 
       - items:
           - enum:

-- 
2.53.0


