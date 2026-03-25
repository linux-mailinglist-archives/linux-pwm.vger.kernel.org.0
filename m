Return-Path: <linux-pwm+bounces-8359-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eH6yATq5w2nUtgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8359-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:30:18 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F018322FE8
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A336311A43A
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 10:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DFD3B5310;
	Wed, 25 Mar 2026 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TNHGT6uo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3F63ACF17;
	Wed, 25 Mar 2026 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433873; cv=fail; b=J0byu7ky/bRurDw4LK29vqnBKwqIo9TILVbHyJEpsEgSLjOXNr+hVxTbyntl6rpV0tUsynHL9ngGns86shKp77V72yDPWO3e0hMB80iC2Q2WqTn42TzUMM+qJU353XNJG5DHS+h+wImoFfdgG0/RZ1XzVPXOTewTfIAPwMQPvKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433873; c=relaxed/simple;
	bh=gwfZQNWBWxoyNzQ8CFlQALVbozDu4ay9nAB824R2taA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=T0O3H6bSjY73NaKnZvrSSBxM4lLmloK7sOe6CJf6pKPxGCBvs1cmXqC/CE2uMT7E6C3gj4nJXUftxj+cuhygbGpuCdO66sD5+mA4PWlQ2UsUyqcnak24Ryzm+9T1TcH3f6s3yFvRF8vAngjKeBY6m+mttYNl0YHds/XRTuY0r5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TNHGT6uo; arc=fail smtp.client-ip=40.93.194.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycXFcyUwAGsPkcWJDA4zbrp0CggHt1045UobuGLOiIAnDLC/YxEogw+q1fWYCZ6FWT9LS4pzA/5yzYlz9XIMash46uCLN50CLTXgogcUuq3m18mFasyGyNc7HKYJ3c6hGBjaSJFaFdhbbd4VxyhKLqUwNYe/rHarbOu1sz1V+M+9OPH559ArkTQYUQWkohZi9VExUJMDhvOPIMrh5pEu48bhOL0iNgBVOyi69g1wfOa8Pqk9HG5zZ30UhYj3rZlsnaAxbg8BAF56i1LiWI/X1J+oFc1HL4tRfyyIwmTz97cGRytAc7ZpkIA3Po2InKj7wdANF8oDIcspp7miVILiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQExniY/fbSpmugBiJjHKjENNl0DOkT3zT8DJ+f5VP0=;
 b=H+AArlx+4/Q6qrxkawh7vAcqLEmCjsEl2ytG6DvNJX/keBpWyzMfLIgAoLah3c52YlnQ5bVQEYwk62JbrKbX0cxjYsSLzDHubWhbT5g10phgASUuE/eBmmhGaWiOB4BBPhcmpESNHCeUMwG7OLajFXNMP1c3PtB3rEBxduWD2W/g3Fmh2hY/4zup9MDduTYayhT8asKKPuLkDxxIGj9Z1DoV7jbUZN9nGW5vjqXg6c7Un73cxjSrtVLjKemyM/6ugJ4kNOts90xjfaYY/hXoevspnn9xZ81p3lS1nHYvbFxq7Dq85/csUrICPQDJyvkW/sVaW8PXvGDwmb1YpcFLJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQExniY/fbSpmugBiJjHKjENNl0DOkT3zT8DJ+f5VP0=;
 b=TNHGT6uoE1svCd99/vOVahYCpLsSXpqzrKT8L4CLptMahpQpUtzasGUmv6bb/8/CkFNXsJmAY+CtRc/SbQ6wJZUE1EbOY5r7pyktYCMz7UOdhmppkoNuFQ3vziB/Z0Off71CycwxYDX7kPZL3lTByQRoj8h8QjoNKd0tDWjr2/6E4ZUFG3snHf63B6JyKJg6ckguzX6VJqFioIEtaI57pva82rn0zmC+XBDs4GOVZiedKCmQ1ipRvQdRTReALlOHoxSDV4FoTy8iANcQWbHleT9RvTC1te4jTUEXCoy4a+Eu27nOKtY0Y6bvOgIsPiPvntRWtaJtsoormiO2ibjC4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 10:17:46 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 10:17:46 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 25 Mar 2026 19:17:00 +0900
Subject: [PATCH v2 2/7] pwm: tegra: Avoid hard-coded max clock frequency
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-t264-pwm-v2-2-998d885984b3@nvidia.com>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
In-Reply-To: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Yi-Wei Wang <yiweiw@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TP0P295CA0049.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::20) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bee6ed6-3ea5-4cd6-b234-08de8a57c2b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Es6/3noNAyOugZXd6wlUWgxV6moNwX65LqdLpkFUmUx0PWYvQPgHhqBODfj8InepSgZ7s7xoMS78Vs3TLaTAEvR192c9UWph56XRp4Js5pF/o2Q4sJi8mz/V9C/aUmiyRbiqjGcLt6fc2cz6ZAZHIhy4sR6/AZhm0sgbGjY3mR88uG1xr1+kKm32vPem/0Ex1m2GWu2UPfa145MNySv5EZwWrZSbL/kOwFeOeGyeXfXDxUIR0KLMcJ2lRFGcsDHiHAle1+qG98p5UhZV2hUL8McF+c/xQxGzlolWwlJgxaFf0fAmvdhRkhf7Cxz9LD8B3NNU/5Ipt0lToy1oQQNE/ZwwJEVNZ+opP2ssiOqmNyjXrgngONvuolBS8U7HVsjUZHeoJzqxqXqaXnXn25e4sLn03XJb2DtsARt4xGlb8dutTRvzvktgxtBx46+3h/aDtSMdgWhRI1au7eldlphH8xfJ1qau4jCR8aPYbsN+UckKvulnDFG/PAnHCMPcirn9N4affxXzKM6KQiZrSlQAVhusJS+8X9u0NkAgbz7pzQcxQpigz+0SfhpACpuDGLWPl5uxlatv0Rmc5HMdKY2ddbfUz/Q8mJ7hvWSIEGWVf9aVjGs1jug55uQYRbhJ3aAzZUcvcFZqf2Da1oo2wTMudj1hJ6MT9mYq35vu5NhewOL10FJcjWAAG2MJUdzfEguCWSETDWVVpLfEYubjDcsuzmiMru9Q1vjmxaQFVP/o/hI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzk1M20vOTRUN0ovbG11dXl0bHl2ZmFxVVR4RDBoL0M5Rk9IRzZxTU1zcjlk?=
 =?utf-8?B?ZXJvSDNKMFV5QkJNMjQ0NXBRemhtYVc1OWpYVWhqQ3djNGpmYXJtdXhuMm9l?=
 =?utf-8?B?M01XVUZrcWZQWTg5cmFGOWEyelhSbG1mOEVTR25BVENJUWVHYUtBN3Q5QVdX?=
 =?utf-8?B?UWJXUnRibVpSaG8zY2pEWUk2aUZGV05rbC90NUxONGNLWXZyRkk3d2tyWVNJ?=
 =?utf-8?B?THA5WlFzaVFORVlBRXg1d200WHFWMVVCc2ZDZkZzbVhVT1JsK3NsNFh3c1NS?=
 =?utf-8?B?RGdROWczMXBQd1IvWW0vYW1JWWg2REk2UUh0THEzNHFPRVN0ak8vb1hJSUFY?=
 =?utf-8?B?R0ZlUVRMY3EvZC9MV1BSc3pYTU5PRkJ6cDhnc1BIQWNBTjFKdGRqL2I1MFJF?=
 =?utf-8?B?WGs2ZG0xU1BkemRiQncrdWIrdnBQZXY0TWdlT3lvaUNpM1lyaDNuN0FYYzBY?=
 =?utf-8?B?bFlHMm9qRytzNUp4WVdwZmMzcHk2c3o4em5LS1AzSXdNdDR1SnhFU2ZqcTYz?=
 =?utf-8?B?SElDNlZWbmlaaUVjV1NtaFo5cmRLWjE3VFpXNzhIMjNxWkZQek05UStrOUdz?=
 =?utf-8?B?a2pmUDNaNUFCQTVJSUJaZVVOOTVxb29Bd0xNOUNPS0JBVk93MGxUbVdNOXVw?=
 =?utf-8?B?SmpZcitKeE5kVFl2R0V4T2ZZSzZ0QkN1Q0ZMT3NDbXFqL1FMUjZKL1MrNWtn?=
 =?utf-8?B?bVVaYTZmR3A2SmlTOVp3V3RGT0t6L3kvd3p2TUpzZXl2a1BHNTRoRzZTODJ0?=
 =?utf-8?B?NndTRFdyZGIwaExmNGZ5RmxDQTZoKzF6UEs0NVArMSs2eWk5TUcwRm1FcDZp?=
 =?utf-8?B?enEvVjF3ZlVvNFdGeE5pREpFNFA1dEV2SVRvbTI5aXZubUcwM09jc2Y5a0xw?=
 =?utf-8?B?Mm5sVE9kOVN3cWo1ZDk0Uk15N040Z0J0UGhveU1EZFNZZlp3M0pRRlhOS1d3?=
 =?utf-8?B?NUY2S0l0ME5BZXBpRytTaE5FajRCd3BKbkE5dlBPYkhnN1dVOWhkc0dKSGRH?=
 =?utf-8?B?eC9XYVRmQzNHbjhsSXowaEIzcjhjVE0yUUV6VCtlUG5udm9nc3JmbFYwcE5I?=
 =?utf-8?B?a3daYjBDbEczak5peE1DUGpGSzBzanRnOUsvMDNLb3c5MmF2RDh6alpJWXcv?=
 =?utf-8?B?cWFWL3dlTWplUHcvb3BVcDRZbWo2N1V1THo1RitIbTVNREQ1VTF3YzQzSkFn?=
 =?utf-8?B?Zk9KaFdoczZXM05LaS9Ib3BJUUJKVFUxbUxvdnlEbEVmbEM2TFA5ZmtNek5R?=
 =?utf-8?B?YU1yZUFMQzM1WWZHd0V3b2lSYjFoN1VFTUE2aXRHc0dmYzVUMk14ckVCbExz?=
 =?utf-8?B?aEcyclQ2cVZicG03clo4VnlMMzZrNFRoczZHWloyT0ErdTBWN1FKRkFMZlUy?=
 =?utf-8?B?UFBBanBBRVRNQ1YzMlFEWWlRcmtCczRjS0M2SmJNVDB6VDM1SjE4Q2RQbUZQ?=
 =?utf-8?B?R2htcXFkbmRkaUdaMm9BdDkyUnNZUzdGMSszaWpvTTJZekpKN1lzbW1IZEUx?=
 =?utf-8?B?Y2QvaDRpbE9aWWFWMnpTdS9UbUcvWGMrS1hDYUFFdzBaS0t0NkxzOHlMTXlX?=
 =?utf-8?B?aVlXTnRZNndqTDdkQUFWeWQ1T055eVNDUnZNU3RJMVJUc3RlcWxoOEhweVR6?=
 =?utf-8?B?MjhHdEQzbCs0VFo2UW9VaThJVGVVM29jcWVsMjVCUE9qSFBMRFhOTnJUd2ZM?=
 =?utf-8?B?Q2p1SGVTL2lxM1Nkd0lEYXFZK3JQYXlac3cycW1WMFZmOXhHSzRDeDRlczk2?=
 =?utf-8?B?SGpRZldyZ2k0NHlkejNEaGVIRmxBbkNiUWlqdW42cTRlL3U0Z2tOZlFxVDRQ?=
 =?utf-8?B?b2p4VmZKd1Y5bXA0d3EyaUMydTcyWExodW5MQXN5RzlaR2Y0SnRaYVJkUTY0?=
 =?utf-8?B?cGxoa2Y4dVBHMjF1RlpkYmJGSXF6eW5nbU14TExpSTVveVlWbmF3UHdwS2hl?=
 =?utf-8?B?M2c2dVJNUXIzbU16QkEvK2JiaVZCRlQ1Z1U2NExzUU9CVk9Uc1VpdlpON1dT?=
 =?utf-8?B?WmhkSnhCZHFxZ3IzcFlYbmdiUzZXTFk5bXE4UzJ0TkJDdUFLMEJRbm5TYzdQ?=
 =?utf-8?B?eC9Ld2dsVit5djRIMzRKNHhoRjlnOVh4TEFKNm1CRTEvc2JOdUJxYUM5WWN5?=
 =?utf-8?B?Q1ZkQ0E4U2VzSmNSY1ZRK1NVd2tQYndKeGZhZTZ3YmtCTlpaRk5nVHU5MmlJ?=
 =?utf-8?B?dGJoL0UvZERYbG5RODkzeDY4d2Y0aTc4dFVKZ1kvWnVOSFVKU1FacTgvbzAv?=
 =?utf-8?B?enVvOUZmVTh2a1QrenJVUGZMYktMS0UvbmFHL3Z1Tkk1RjFYMVlzVTFUVUxs?=
 =?utf-8?B?dGU3TnBTOE04elZTa3h0T2hFcmN1WTE4UG9FN1VSeDhRRTByemR2ZUNCWllU?=
 =?utf-8?Q?yOlVaPrZnSQK6xyC591Q55Q+muruCBdFyCnISRsqcDEJn?=
X-MS-Exchange-AntiSpam-MessageData-1: k/Gjks7tnLS7Vg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bee6ed6-3ea5-4cd6-b234-08de8a57c2b9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 10:17:46.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FlEs8U9lH3cS13cMxrbp6v8oFtCN10LV+yQv3Z9tkTnleKFvwXcVqmQbfbUZ/KACKS6EUYH1K8Wx88cfa9NkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8359-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F018322FE8
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
index 172063b51d44..759b98b97b6e 100644
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
+	ret = dev_pm_opp_set_rate(&pdev->dev, S64_MAX);
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


