Return-Path: <linux-pwm+bounces-8340-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD7+NyOowGm6JgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8340-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 03:40:35 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 613692EBF7A
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 03:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06210300FEE1
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 02:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28043264A86;
	Mon, 23 Mar 2026 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G/HowF95"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726AF18FC97;
	Mon, 23 Mar 2026 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774233452; cv=fail; b=TWaNnwyqTbzqUGhJY0HxoHoPVjNssRhkll8gFpHZAuoVpSKxXGrWysoS9Hd5s9djSUuPApSJwnhNTTZYg+Xv/TZzFJu9wZy00axshU80rLEDi3hNHDCv1aVu+DO9Ym+bLdOBTSs2Ruk38VD/SntC84BJ4JXCs2nhMs5szFa+bS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774233452; c=relaxed/simple;
	bh=/Ta0Axt7KJjBrFu00qLjZJNsY3MmjgJ0zry7Jm+m/dw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ajjp0nqgWjL1fXd+eRgLnzW7Ub8ELpN69nYQr+8/eJfRUE7q9d+haXZCatzpeTDLbB5bzMxhdiNG3AbnSF4j+cyH4suxfJmUFcMnzaH6IXTwb8L8AGzXpnz7vqlEw/V//EkPUkJn7wI2j42gdq92LEZkJO/apaqSiZT3XNjDGpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G/HowF95; arc=fail smtp.client-ip=40.93.196.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGPNrSjvesTciuOmrysndLB51mkFq5gBz2BLo2NWn1N3Z7boMK4RmusizHC/se822fRWpmpSuPDr1GnXFOVo5mTstjBNZQdaJMSZxSHHzPdMFtcRqGgtxyRIPg8qqdyI1RJbN64ZCr0WlCci/y+SPbtArctNFrpaUMj3bF7YCuRKOtCMUxf1k9tdbOC/rjYD3OyOqGlRHS4ExEneihQRA8JZi/SvHJuWdfYl6ZKsukoWHe3r7YwrkfqF9Zr/nJnxkLex70DpAtoZwPdYse1tKrG7MoPvLcV3x9cvvzytS6LYTbi5VkwLtSnymGVP9d2xrz7UgadwK/9qXeuJ4c3iAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lI5vCtTJRWEYYBs6iFamPe8E0USN1Uctqb9jRn6Rgs=;
 b=mcqH9O/prxlg1EG5uflHISta/pC4pMMMYKwqp+EryVREuCSyPv9ofO1Cz25dlZJ78O1Hb9uGzpK13Z5We351etyCUUNeCK1PZmTcK8nIIWNrzk/6BU5wFt3WJ1vg+6UMbpYSq81p8dWagbgcC04yKK3OhqucYIjpaVadQqdIQLNN8dqzdE0lcfewAGhB2rmU7Mr+XDUsRRm08afc3pFvYwvj7jBuE+5Mix3/6dsdRJTSDKURPoNiVPSBVwCDaXH7w0UK729Rn/8ef2KhvBaNFDoISicFnUSTND/1gCymGgNAo/VCrV0PxieECG6NFtWaLBEYo4XUgwtBGcf90Gg0VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lI5vCtTJRWEYYBs6iFamPe8E0USN1Uctqb9jRn6Rgs=;
 b=G/HowF95v5RBRblqPnIoTbSyOU+bk6dNF7DVIrBIPJlU1x4s6cvwj1Bd+pWdlwCKRJwSLXC5c6qdbFwKYpeuHg13TppdNNQVD4cK777XKBBeB9H7UjKzXISU0euY117mlgasTmzETmBy8Gge1cWicwvfw1aemduO1tIsEDrzDSQJeuW0CHRouruKOHRwkpS1nNYERtaxqq62uks/BcvvGWuty/KjakyS6wkMcGO2NmU2Grj1rL9ChUQhL1kO9++m4X+sVyuR9e9USgoxcQ4eszCS+XylkY0KIa30SkTEeSbIdqp1kSjFs4NIxwVjk94DXaRYHegusBgCGk77HNCXRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Mon, 23 Mar
 2026 02:37:27 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 02:37:27 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 23 Mar 2026 11:36:41 +0900
Subject: [PATCH 5/5] pwm: tegra: Add support for Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260323-t264-pwm-v1-5-4c4ff743050f@nvidia.com>
References: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
In-Reply-To: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TPYP295CA0043.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::11) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b9a641-045e-4e4c-4740-08de88851f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	siezgzp2Vj59klhkEGoXAazZiFCvSzI/JLgChNo9a3kV9MZL2qdERF2cdmBqbpHAXG1YVV8/Hx+PvKPDFyruxEBzA63bQLGPMDuiNCAsjv1KT9jxj+uNHIVMF/MoMdleZkMhKnF4eA6bG1zwrF0zlrYAmgTFiBjLq0xuPoZZ7ZvVoOF1fU3u3eIslq8WObeoqsU39gQ8zbv1ffQpSCn61oKXFEZLyOluenDtw3Gpxpo7Eg+iUHCUzQdKhINO6vM7OVsttJocTWE6rAVcAcWnlmHjdtyZQuANMsKNk6OyXaC52lC8egpQ4d9Y6G2DBX5+x9JF7CpVRFj6YfkdSmsrW+ajGQ1QhmDzeR8DYazfYsxSnBEqlYKTu5yBepyW7XOecUUfIGO0hp4stOiWA1F5G0df2hnpay1Ac1TLxJrKPJUHOTZvvpCbIbG7AZD2VDiu7I2Y348RZGXeE4tRxtKmyEUXejgmkd0hP8vexTS3hhAcd2UI/aMtJ0b+SezYTr0DfV9w3X1XoLhayyF6JMDpgqqSh5EPm8wJt6SaIEBDYjLr4spgK4CSSIBQGYADag7YeinFaamuP4I5G/KLgg6Z6poF3B8FqK/5rv3E1gHS0VBjG527Mq+87FNVKvXExx+SBhq6HfdIjiqkKUDADZzShzxursfBEY9a9R4DzYUXE0Xa1etp3U4V5zhvG7yuJ9frnbT/FTI9F2lSNr7KLc6Fa1bVicJUfvgDhP9UHS/ri2k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OSt3RjZYSUN1aGp5ZzNzR0x3S2FXaWJ3Tkw3a0w3RWsydjZRcm1aWlhFbG9s?=
 =?utf-8?B?QnVUL0NNc0ZsdlFFcCtYWWt6dXBIOEozcnJhZCtXQmNBcmR6YU9BaklHM3E3?=
 =?utf-8?B?SEdGSGlzZXFPMzlIajJtYlU1aUJyTE5CSERzZ21EdXNPUnBjL0huMEU2SGcx?=
 =?utf-8?B?NmlWMTViQk53YXRtVE12Z01VVnNpY0I3ZGs5Q01haSttQUFYcXkwSFJMNlN6?=
 =?utf-8?B?ZktkQUt0emJteWFUYjBDRWNsVHJITnZhS0x4Mm9NaFpMbkV5UmNYOTUxUDFM?=
 =?utf-8?B?SnV2eDlKL0krb3pqam5jOEFCSStpVG1kbUxhTnFLbzk4c3BqMWVacjhxb1F3?=
 =?utf-8?B?TWV5NzMrbHEvbFZFOHVwKzU3MmdybHBHanN4Q2JydHpYMmlLbVVsNGVwKytE?=
 =?utf-8?B?MTJ4M1VFWGluOXFDV0x2OUZRd2oyekt0c0g2RW10OEdsNk9NeWdLbEVpYmJo?=
 =?utf-8?B?TW1CVkRmTFk4QkFzMDFyQlVXdk9uRXREZHQrK2NwWURlcGRpK2hTRmtWbUM3?=
 =?utf-8?B?UWxITHlMcWpUcDRoZjBIZDNId2VOYkFEeEkvS1NMZ1FaTjc1aWxlbkhFVzV6?=
 =?utf-8?B?dnJWbTgvUWxFa09weEhoSytiOFY2QUdKQUc1K0gzaXZ2cVZ2SVZGVHJtTGZK?=
 =?utf-8?B?dzREbWNNdUNHVlBTSmZ2TGhHaTAvdnFtbWVMa1RGTGEyYzZGVzUwWDZ4emVl?=
 =?utf-8?B?KzNIZkovenVxWUpJb2k5QmlqRUdsQ0FFY3lma1MxTjczLzhYcHJScU12N0d1?=
 =?utf-8?B?ZUhNYUpBMXRKakZVZjFMVU1mVjJ0K0FjZmJ3S2dKRTd3ODNiZUhSSDVzWk5h?=
 =?utf-8?B?aUwxZlkwdFQzSEg0ZlIwdGptcHhKdnlxN1ZIUW1vdE1wSWszRkxMUVU4T2NV?=
 =?utf-8?B?S1dBSFFDUUF0eWJvc3RZNGRHOUhzMUx4RUZoMnBkODBZV2ZvVFVSYXM5ZVdn?=
 =?utf-8?B?SkNmRGtTVGdCTU1rU0MxMDc0OWdCem9KaGNrK1FjbitrUWxwNHpVYi8yZmtB?=
 =?utf-8?B?THVBQjhBSGpIR2pEbWFaQStWZTlRWFlHL0NuV2lWUFo5Y2Y3ZnNzRGNHZWx4?=
 =?utf-8?B?Q29scGIrMy9va2orRHlKYWlHZlR3czRpNjk4RVRrUnBRdGVLSDl3U3dEbG1T?=
 =?utf-8?B?bkNsd0RLQXQ0ZWtwZmlBZnl0ZjdyWFowVHNSU2VLTkVOODRJUU9OMmMyeCtl?=
 =?utf-8?B?Vnh6QnlBVjNFQk5mUTlkeGpaS3ZPWjZOVHZMY2F2ckhuVUJFa2JiSGR4Vjhi?=
 =?utf-8?B?Mm83QnVWQXJ2cy9zdzlFNXI5aEtNOHlDU3BGR2xxMFczby96elk0YVlWOU5v?=
 =?utf-8?B?N1ZYcWRUS2Z4R1RmWVRlV3VtQ2VPSU41dFhkZVZ2ZkJhVUtNS2VHQXZTeXNl?=
 =?utf-8?B?RWFrV1lleFNxYVQ1Vy9acVZ0bC9rbW1DbTA0SUp4TjVmMnZFdTR4VlpZL09a?=
 =?utf-8?B?b2xXRnFTMHJVaVZ0RFJhSTNLRU9BdFh4QmttVXFoSjVneVIxR3h4MExseC9K?=
 =?utf-8?B?UHo4c0xkMkttUThSVjVaS0cxNXZPVGlrcWY2Y0d6QUxsRXdFdW5ONzVPd3dN?=
 =?utf-8?B?ZlAyc3Vid04xNkEyMWRtY3RWcEZBMlFoSno0SFhDQlJ4U3FMRE8xbmVueFVD?=
 =?utf-8?B?OTZoWWJ4bzQ3S3VTWjNyejBncGYrMVR6UkQvb1A4a1RRZi9oNlI2VDh6dE1X?=
 =?utf-8?B?Um1QclhTYzZOWWlDdDhUR1kycVF0c2Rab2lKbnVyZzFzTktwUXJPeVQvd3lD?=
 =?utf-8?B?alJ0R0s0RXRvQ0cxeDlDSThId2JsVkFtYWhDdlRPblhna0ljZk5hMVpzb1U4?=
 =?utf-8?B?NkNlcWxiRTVPVXJ6Q3JuaStHaGZ4RmVPZUlvV25TSGNDQUo1aTg5WURhd0hP?=
 =?utf-8?B?ekpJdWxyUDhDdVBQVTllUkdXcXZ3clhGM0lSQS82UWYrbytOTTk4MzhuNi8y?=
 =?utf-8?B?VVk4UDIxck84ZkJPbG9EdGM3TXZzODM2bFo1MXZxQVQrczAyb2lMS3FnZllh?=
 =?utf-8?B?cEo0ZHdNUVJPUld2bEZyWGZvNUVGQXZDRXFWa3hFMEY3M1hTT2NwMS9lWlVM?=
 =?utf-8?B?cTFKQzk2eG5MT2o4U2RSckljUWJyRk5jS013V3B0NEVGZmxKbHY2SnVuLzM3?=
 =?utf-8?B?Nmd6OFZBS2U3SHhFUGNTVXN1RzRwUkpDaDdkd3hrYVhSTklpRUxacGp3Q2Fv?=
 =?utf-8?B?OE03WVQ4RUFhNGQ1dmNtdTRRK2ladEgyRFBZaERBVHRwMUFJRGFyV3RUeHlE?=
 =?utf-8?B?TE9HYnVvcjZkeGNOcWsweUtNS01kVVZsUkFkMUhmdDRVZHZRZFF5a1hyZURl?=
 =?utf-8?B?TlZSeDk3ZGxkYi9KZkpSam1HSUp0cVRRYlZvd3hhUExxc3JjU2ozTHBkZkpr?=
 =?utf-8?Q?nT1R4YpTCJMTo96bf6qKVagV5rtNh1Q6br6SlG94rifkU?=
X-MS-Exchange-AntiSpam-MessageData-1: 9yC6VtLRw85png==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b9a641-045e-4e4c-4740-08de88851f85
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 02:37:27.6527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18c5v9DeNyVeI2zcjG46k5phddstJ0ze0+JV6jvJpoYDVl0NXONoeoFWdkUmo/ot1OgYQqywPmvfYQv0xp8Eog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8340-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 613692EBF7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tegra264 changes the register layout to accommodate wider fields
for duty and scale, and adds configurable depth which will be
supported in a later patch.

Add SoC data and update top comment to describe register layout
in more detail.

Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 75 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 857301baad51..c1e8a804d783 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -7,22 +7,60 @@
  * Copyright (c) 2010-2020, NVIDIA Corporation.
  * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer <s.hauer@pengutronix.de>
  *
- * Overview of Tegra Pulse Width Modulator Register:
- * 1. 13-bit: Frequency division (SCALE)
- * 2. 8-bit : Pulse division (DUTY)
- * 3. 1-bit : Enable bit
+ * Overview of Tegra Pulse Width Modulator Register
+ * CSR_0 of Tegra20, Tegra186, and Tegra194:
+ * +-------+-------+-----------------------------------------------------------+
+ * | Bit   | Field | Description                                               |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 31    | ENB   | Enable Pulse width modulator.                             |
+ * |       |       | 0 = DISABLE, 1 = ENABLE.                                  |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 30:16 | PWM_0 | Pulse width that needs to be programmed.                  |
+ * |       |       | 0 = Always low.                                           |
+ * |       |       | 1 = 1 / 256 pulse high.                                   |
+ * |       |       | 2 = 2 / 256 pulse high.                                   |
+ * |       |       | N = N / 256 pulse high.                                   |
+ * |       |       | Only 8 bits are usable [23:16].                           |
+ * |       |       | Bit[24] can be programmed to 1 to achieve 100% duty       |
+ * |       |       | cycle. In this case the other bits [23:16] are set to     |
+ * |       |       | don’t care.                                               |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 12:0  | PFM_0 | Frequency divider that needs to be programmed, also known |
+ * |       |       | as SCALE. Division by (1 + PFM_0).                        |
+ * +-------+-------+-----------------------------------------------------------+
  *
- * The PWM clock frequency is divided by 256 before subdividing it based
- * on the programmable frequency division value to generate the required
- * frequency for PWM output. The maximum output frequency that can be
- * achieved is (max rate of source clock) / 256.
- * e.g. if source clock rate is 408 MHz, maximum output frequency can be:
- * 408 MHz/256 = 1.6 MHz.
- * This 1.6 MHz frequency can further be divided using SCALE value in PWM.
+ * CSR_0 of Tegra264:
+ * +-------+-------+-----------------------------------------------------------+
+ * | Bit   | Field | Description                                               |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 31:16 | PWM_0 | Pulse width that needs to be programmed.                  |
+ * |       |       | 0 = Always low.                                           |
+ * |       |       | 1 = 1 / (1 + CSR_1.DEPTH) pulse high.                     |
+ * |       |       | 2 = 2 / (1 + CSR_1.DEPTH) pulse high.                     |
+ * |       |       | N = N / (1 + CSR_1.DEPTH) pulse high.                     |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 15:0  | PFM_0 | Frequency divider that needs to be programmed, also known |
+ * |       |       | as SCALE. Division by (1 + PFM_0).                        |
+ * +-------+-------+-----------------------------------------------------------+
+ *
+ * CSR_1 of Tegra264:
+ * +-------+-------+-----------------------------------------------------------+
+ * | Bit   | Field | Description                                               |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 31    | ENB   | Enable Pulse width modulator.                             |
+ * |       |       | 0 = DISABLE, 1 = ENABLE.                                  |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 30:15 | DEPTH | Depth for pulse width modulator. This controls the pulse  |
+ * |       |       | time generated. Division by (1 + CSR_1.DEPTH).            |
+ * +-------+-------+-----------------------------------------------------------+
  *
- * PWM pulse width: 8 bits are usable [23:16] for varying pulse width.
- * To achieve 100% duty cycle, program Bit [24] of this register to
- * 1’b1. In which case the other bits [23:16] are set to don't care.
+ * The PWM clock frequency is divided by DEPTH = (1 + CSR_1.DEPTH) before subdividing it
+ * based on the programmable frequency division value to generate the required frequency
+ * for PWM output. DEPTH is fixed to 256 before Tegra264. The maximum output frequency
+ * that can be achieved is (max rate of source clock) / DEPTH.
+ * e.g. if source clock rate is 408 MHz, and DEPTH = 256, maximum output frequency can be:
+ * 408 MHz / 256 ~= 1.6 MHz.
+ * This 1.6 MHz frequency can further be divided using SCALE value in PWM.
  *
  * Limitations:
  * -	When PWM is disabled, the output is driven to inactive.
@@ -56,6 +94,7 @@
 #define PWM_SCALE_SHIFT	0
 
 #define PWM_CSR_0	0
+#define PWM_CSR_1	4
 
 #define PWM_DEPTH	256
 
@@ -418,10 +457,18 @@ static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.scale_width = 13,
 };
 
+static const struct tegra_pwm_soc tegra264_pwm_soc = {
+	.num_channels = 1,
+	.enable_reg = PWM_CSR_1,
+	.duty_width = 16,
+	.scale_width = 16,
+};
+
 static const struct of_device_id tegra_pwm_of_match[] = {
 	{ .compatible = "nvidia,tegra20-pwm", .data = &tegra20_pwm_soc },
 	{ .compatible = "nvidia,tegra186-pwm", .data = &tegra186_pwm_soc },
 	{ .compatible = "nvidia,tegra194-pwm", .data = &tegra186_pwm_soc },
+	{ .compatible = "nvidia,tegra264-pwm", .data = &tegra264_pwm_soc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);

-- 
2.53.0


