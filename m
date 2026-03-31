Return-Path: <linux-pwm+bounces-8434-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI33OVUuy2n8EQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8434-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:15:49 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 487DA363640
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3324305D5C9
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 02:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DCD367F2E;
	Tue, 31 Mar 2026 02:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kc2o8ADw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E1236680E;
	Tue, 31 Mar 2026 02:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774923179; cv=fail; b=MNp+trGsto5wHeFOScpbfu2MfOGWTr1wff/EiRYMY9usTlBU8Qiv4Ica3cjitKNJQEtpF4HE+g7yXou87t02KBH59Z5WTdInw1Nu8JXyAzd/i/Jsqnu4xO9Sxz/9SNvUCqYVZlXWqzFGYzmEzT9xFEzIv5NuhpG3DRKR+s/eJ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774923179; c=relaxed/simple;
	bh=ZZX829wkEbStKuql+pnN7VobByEw3Wwgt4TVDHqZJtM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hJM89iFkH+qjNhDVRI8tljZqLbsBiHoNZMZlmw74/dIoGTIwkZ8rTAMX/X4nZRLBee/XBWrA13X/mJLFaay8LbJUCdPxmflyMbklPoz85NnwVtnLAB3IFxBUXcYQjVCYHktAAmwT5fTxEoWMG48sB48wvEKNPvXRK2tHMFeUA+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kc2o8ADw; arc=fail smtp.client-ip=40.107.208.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woLk6GznbXx1a0TWjWgk7Bab3J+aFK09AVgXEILferKQxB25gxRVC4Tlc+wuyd+UpVYOPjGNyW8oVEuL70YPhjl722CQTck8MuDxEBipD32EPrhc12YfJX/p54gSNpboanK8caGL+KMQZ93sxpsFowhkxInJBqev24JVi4lTtbor0+/XJbj3tNzAJbGv3gcabQVtuJFU2tGQ2CNa8bx7inm3i+fMYJrfMO6O30UB8dUlJwRuYslZECXtov7a8wOnMyytcXBAfg5lxYRGNws6RdCknK+O5XDQJ+2jFSwoSeileN95UhMIPK+wp4dJIpZaFkXXfvlDow7UwX05KjC88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb7yaNVzPG3NBK56+Bj81AVHoHwwJWxtZ4x75b+lKok=;
 b=u7MM6Mdvtpj+KccYEqZkkLGGh2npjgYcLnHi790U2Xyr3hhe4PjR7WkLGesIa3GFXFHLpaFm6mJ5C4riNmImR4+en8kK/+CbuT1Vq1sxoKZlhC/cXhdumprn7g8XtD5Z4Sah+5GnbBGHQYM59MOPO6htW1XNufMJVNY3vM47XCu+m6BMyMAU3slW+6q3v+29SLMolvQ+bvDCccjGRFycv1kmdeSojxgTNp4WB2PDV567VRW99HNsk+5CZbPZ6ANgabQHEk5Qx9fyB7/irVVixpnXRqpniCQvLGz8ZbctNHAENDvV3MG4T73MsRmENes8Q8SEYbyeY+NEtaGJMrCwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb7yaNVzPG3NBK56+Bj81AVHoHwwJWxtZ4x75b+lKok=;
 b=Kc2o8ADw1KeKA1JVixsFukp/hNUpXNEWxkGucaK6/HPbae1VIzoAcbur4OdVdWkHcKI3vJVDJe3Rv+Q4sMYtGRJF0teiiEeewVWgpFiPPjUs81jpvFYvWWwknyp1IfC2fGykCH8nPKV88d6JZ+F26gd7edahkNpSKnIuYSw4yoeJdec58AkaF44YeMqNTBEJiG5gwvPy2P7ytJ/7r6laYBFpOBOd9Z57/SzyejFxWyTG5Qrn3SFInJk9EplXyLnAAJV07VW7nengNAF7wXwBNd9ATCR+z2XfmoLBRHXnvif2jaGdoXEqqfq78EQFLnQ+L22i300vxZrHf7e6YfMuYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 02:12:53 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 02:12:53 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 31 Mar 2026 11:12:17 +0900
Subject: [PATCH v4 5/7] pwm: tegra: Parametrize duty and scale field widths
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-t264-pwm-v4-5-c041659677cf@nvidia.com>
References: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
In-Reply-To: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Yi-Wei Wang <yiweiw@nvidia.com>, Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4P301CA0109.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::16) To LV3PR12MB9166.namprd12.prod.outlook.com
 (2603:10b6:408:19c::13)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: c80b8f4d-77e3-4b44-ec80-08de8ecb03e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mmJSLXeFuC2hI67346QZpcHz6n8Li/Xig7aQJcJYwgu4mpIAwzvV6Kw0owT1ny4jVDppGEAd05uMphOxnULP2GmFuh6nyaozKDnl84IaBCmW9PE16r2wM2ccAS/f+N1B7G8fR7O68oeWonXqkLoLsq1NA4fPBWt8FmmIkEUdAN4nFJF8AXIZ6bf8SgEm5aV0bNhes31EtQ8lpju1NYX+pH3xVXdMolzNtqaekCZiahGZwYp2j5JRLV82da/4bhHbtEzohtmK/JcPvFkpb8/a6orGK4W2pi3CxzRVV4OY/lcB0xGUERde6BPoYXioXy2BrZ3UHshQRsRUbdRhwerNL5PIfPNcSJqLLMYB7ffBNWs4vnSNwgqqGswN7P8avXFEUQJTCy2RuFO5je8R6117Ax/kLy/UprSsL815GMscOca/HzN1e27A4O2t5hPNwvAuCNKB4swJMw59KXFb4sbv31BW5qYyC7EKDzY8yq58LCdgdoQJGp7G7lBie+Tgyw+DLXsIzg934ZmchNVfCPIQkZiu6k62saBy41LsxFDtkBOWQdEaCpEDvUhYQpHvIFUnedIXdqC4TVILBY0jBfiJ9uEEAzkQQP9I0BR15foTikVjzbxx0uWtqpuB55Ufke4JmmXHFE8Bdc2wSLOmVkM/yRmWXVQGKi+liW+bu4lkRdQe1hlqqO+zwN2JWtWR3Z3arQeqRtvw7n9OvWSwujYgNp3TKFRR685Twkv/gZAzK3s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eitDVGdjS1p5Z0d0S0kwSU00UVRreDVGL2RKS1lrMUpYK3BTQUc0NXI3a3Zj?=
 =?utf-8?B?bms2SERSTlJSbW5oeTEvOGJlQnQwYVlpaWxpeThmaCtsMGxtSVlaT2FaUEI5?=
 =?utf-8?B?YnhETnZYMW9mbjlRWlBsU0hkSXlxQXd1Tkh3VXN6cTRiSStHazIwY1F6S3Uv?=
 =?utf-8?B?ZFkySkdKSUR1Y3ZVOU5kK0g3RXJBbU1ua2ZYWXFjZ0VaekhrSk4rWm9OS1A5?=
 =?utf-8?B?a3FFbFBCSmlmUFV6S2lFSW9BM2VPTUw2ZE1QZDRFcVRablBxRnZaWm5QejJK?=
 =?utf-8?B?TTUxb2JaS1UzL053MlJCRE1JQWNPOTdyMjhWZlZTYVFJU21XR3dadFI2eDJq?=
 =?utf-8?B?V0k4WnltSldXSkpaa3RMOGwrTFoza0hlMGwwVTc5RnBWYkUxR0I3dmZ5NzFi?=
 =?utf-8?B?L2Q3ejk5SGF6MFJ3UnFOT0pWM2Nlc1p5N3dkOUFMbmRPNDM3QWVydjg3MExR?=
 =?utf-8?B?SjRndDFVWlRXL01pQ3hoQVBGeitOcW1FWUs1NjdiOXZjTkpacGpWVDZ1M1lm?=
 =?utf-8?B?SmNHdTdtUzRRcy9qSFFVZEphTmNad0g0b0hZT1BiT1JFbGxiaGFpSzEzcU16?=
 =?utf-8?B?K2dqVGF1QzFCN1ZJRTRUR3Q5bWZMbWdaaFhaamNCSTlzVFRtYkJZSUJvOG9w?=
 =?utf-8?B?MnErZzYzMmVIUWNLd1Y0dDJlUGN3akZZeHlSM0FkQVllK0pXVnlKVjNoVE0w?=
 =?utf-8?B?VkFXY2NSbmo0NEhDMEtjV2JrVEpJVEFBMVFxdHZNbUg3dVY4YzdGQTQrdS9B?=
 =?utf-8?B?OXVrUlRCY0hLMkx2VGhET0JWWDNhZm1CcG50aHZGZDhxajZhN0pIRDVMSGxy?=
 =?utf-8?B?K3dIVk5rb1dGdHVtMitJZElnazdXRmNtOTArQnBpMGE1UlVJTmVtM2ZyeDhV?=
 =?utf-8?B?RmlJaHVLU0NwS0hObjdhbnlEa2FxaVRHL0pMdFRJdGFzVkt1WURZN1hTTS8v?=
 =?utf-8?B?d0tjdmtvWEZyUkcvK2VKcGRZRm9xZzB3b2dKQ1VocnVrVjV0SFQySng3TEN1?=
 =?utf-8?B?QjVGUEJ5Ri83emRtY3R5V1g4dmpzcHphQ3Y0a1BSUjY5V0plRG9oOVVrVTY3?=
 =?utf-8?B?R1V3MGNQUkxYNVNPSmdqVnhDQmNHWitiRlZpYWc0andYU0xPY3A2cC8rbFZD?=
 =?utf-8?B?WW5CRnA3UHpBbEladG0rWlRFeUl4dGlrTzl6ZnE5VVBBWDNlRHprUHNabkdn?=
 =?utf-8?B?bktwY1FEVXVoSjFvREZ3M1RZTThWU3c3UzdRYVRzaGRpaDBBeld5NHJKYXVM?=
 =?utf-8?B?VldhUlZvTU9qSzFZM2NUY1JJMVNJemZuWXNPcTdpOWxBajNIWDRNTnhqVkJR?=
 =?utf-8?B?R1F0N3Z1TXhteWFRV3VZZ1ZqUE1heTY5TEdFekJUM2N6WFNhc0hFNExVNHZJ?=
 =?utf-8?B?NTV4bDREcm5xSTllYm85U2R3NFNPWEs5MzF3eDMyMGlueGx2S3Z5bXN0RFZw?=
 =?utf-8?B?YmUxdGkvdHV0UjJJQk9ENHM0MWM0Q3BmVzdmQTFkME9nc3g5T2xZMmhvM0dt?=
 =?utf-8?B?UUZiM3huaGlENVNRZkx1OEd1amxQZHBONnRNSVo1aElKaG96Zm5rV205MytL?=
 =?utf-8?B?S0RuRjAzYnMwYWJZOW5yeE9uc09wbkVLc201WG5rckViQW0vOEtLQlAwSkRJ?=
 =?utf-8?B?Q045VzJkNFZDbm5aclRFWHUrbENWL2lHUDQyYTJ2Q1BrV1JzcjNuQWYxTWpM?=
 =?utf-8?B?Z3RaZ252cFRPdGlHQXFhRVpQU29QWitnMTZNTWk5cnpHZ2pBYWRmY1Y1ZDRU?=
 =?utf-8?B?TnBKaHNQTThBY0l2dFRDdm5aNXN2cGxuUGlrVy8wUTVrZXd3NWYrRTdyUjFJ?=
 =?utf-8?B?ckoxSml2WGdUaDlIbWZ6OXo3MjFrZkhIM2ZWRXk3ZHJMYlkyaEc3dXNoaWw4?=
 =?utf-8?B?NFgrc05mL3pMZ0xWUEVqWERaSjRxdVYweVJhd0VFZ3J4MlM5emJFVUpuTHJY?=
 =?utf-8?B?OUZXeXg2YVBidUNCeW9aUTRyMGxiWlIzSGZyUXJLVVJyWEw0bUxFZXNzZ1Uy?=
 =?utf-8?B?ZmV5dGJSVTZTSGRrTEZEcEdidjd0UEwwL0FIeVJKdkk1dmhZcUVmN1ljYndQ?=
 =?utf-8?B?L3E4b2FUOVdlcEJHRU9STmtBUmw5SEYvTEUzYXRPY1pNZ1d3amFEUWFFTXZG?=
 =?utf-8?B?QVdSNk5PdGFwSURWWnJmSXdyOHhBQlVtaDNCK1hCUjdUUXM4bjUva3FqSnUr?=
 =?utf-8?B?MHR2SzJvQ1RIMlNnVDN1WmVvQlg3S3g4ajJZeEgwSXJ4RGxNWnAxTzQvSTZG?=
 =?utf-8?B?UUZ5M0ppWWVWbExaWjJZbkZBcy8xTEd1RU9EVjBSUFNtalJxNVc1bXpTb3Q0?=
 =?utf-8?B?N09pY1lYSk9SQ1lHVkhkcGQ1clhtejVnUnNBblJyTUI0YjdzVU1CMThvN1h4?=
 =?utf-8?Q?nYOzeaoAIjaA2t/zsKk/CQkxKwLzK8XYBrnrnDm4aE75I?=
X-MS-Exchange-AntiSpam-MessageData-1: r1+sccdx3lyWFwJFKDItXZqezJzjBRymcPY=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80b8f4d-77e3-4b44-ec80-08de8ecb03e5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9166.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:12:53.6006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwnzXEF1y9mC6vFrdG/AjtBgI+HXu+gHPU0KkJR/7fvy1qOLNkFB6gYDQyGyqpPMMVi+aYykTL2+JhomjiKYoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-8434-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 487DA363640
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tegra264 has wider fields for the duty and scale register fields.
Parameterize the driver in preparation. The depth value also
becomes disconnected from the width of the duty field, so define
it separately.

Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index b925ef914411..d7968521fbfd 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -52,16 +52,19 @@
 #include <soc/tegra/common.h>
 
 #define PWM_ENABLE	(1 << 31)
-#define PWM_DUTY_WIDTH	8
 #define PWM_DUTY_SHIFT	16
-#define PWM_SCALE_WIDTH	13
 #define PWM_SCALE_SHIFT	0
 
 #define PWM_CSR_0	0
 
+#define PWM_DEPTH	256
+
 struct tegra_pwm_soc {
 	unsigned int num_channels;
 	unsigned int enable_reg;
+
+	unsigned int duty_width;
+	unsigned int scale_width;
 };
 
 struct tegra_pwm_chip {
@@ -106,22 +109,22 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/*
 	 * Convert from duty_ns / period_ns to a fixed number of duty ticks
-	 * per (1 << PWM_DUTY_WIDTH) cycles and make sure to round to the
+	 * per PWM_DEPTH cycles and make sure to round to the
 	 * nearest integer during division.
 	 */
-	c *= (1 << PWM_DUTY_WIDTH);
+	c *= PWM_DEPTH;
 	c = DIV_ROUND_CLOSEST_ULL(c, period_ns);
 
 	val = (u32)c << PWM_DUTY_SHIFT;
 
 	/*
-	 *  min period = max clock limit >> PWM_DUTY_WIDTH
+	 *  min period = max clock limit / PWM_DEPTH
 	 */
 	if (period_ns < pc->min_period_ns)
 		return -EINVAL;
 
 	/*
-	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
+	 * Compute the prescaler value for which PWM_DEPTH
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
 	 *
 	 * num_channels: If single instance of PWM controller has multiple
@@ -135,7 +138,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	if (pc->soc->num_channels == 1) {
 		/*
-		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it matches
+		 * Rate is multiplied with PWM_DEPTH so that it matches
 		 * with the maximum possible rate that the controller can
 		 * provide. Any further lower value can be derived by setting
 		 * PFM bits[0:12].
@@ -145,7 +148,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		 * source clock rate as required_clk_rate, PWM controller will
 		 * be able to configure the requested period.
 		 */
-		required_clk_rate = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC << PWM_DUTY_WIDTH,
+		required_clk_rate = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * PWM_DEPTH,
 						     period_ns);
 
 		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
@@ -169,7 +172,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
 	rate = mul_u64_u64_div_u64(pc->clk_rate, period_ns,
-				   (u64)NSEC_PER_SEC << PWM_DUTY_WIDTH);
+				   (u64)NSEC_PER_SEC * PWM_DEPTH);
 
 	/*
 	 * Since the actual PWM divider is the register's frequency divider
@@ -185,7 +188,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * Make sure that the rate will fit in the register's frequency
 	 * divider field.
 	 */
-	if (rate >> PWM_SCALE_WIDTH)
+	if (rate >> pc->soc->scale_width)
 		return -EINVAL;
 
 	val |= rate << PWM_SCALE_SHIFT;
@@ -324,7 +327,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	/* Set minimum limit of PWM period for the IP */
 	pc->min_period_ns =
-	    (NSEC_PER_SEC / (pc->clk_rate >> PWM_DUTY_WIDTH)) + 1;
+	    (NSEC_PER_SEC / (pc->clk_rate / PWM_DEPTH)) + 1;
 
 	pc->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
 	if (IS_ERR(pc->rst)) {
@@ -404,11 +407,15 @@ static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
 	.enable_reg = PWM_CSR_0,
+	.duty_width = 8,
+	.scale_width = 13,
 };
 
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.num_channels = 1,
 	.enable_reg = PWM_CSR_0,
+	.duty_width = 8,
+	.scale_width = 13,
 };
 
 static const struct of_device_id tegra_pwm_of_match[] = {

-- 
2.53.0


