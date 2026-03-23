Return-Path: <linux-pwm+bounces-8339-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDAfDiOowGm6JgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8339-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 03:40:35 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5DC2EBF73
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 03:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85748300C92B
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 02:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EAB25A2A4;
	Mon, 23 Mar 2026 02:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gP+MDUV5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ABF265CA8;
	Mon, 23 Mar 2026 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774233448; cv=fail; b=rfoJalWST2rDKn6eRNNvMOy1bdLFRVUey2hYArx7KxqyMWnzD0JvaRRuMu4Bs3YuPgo+GY26H+QyMWi266i3fMPKT0JSi47JN7DRHQnuYNahkAGNJ7SKh/qvHlxxxMpIvdq6onHVYL7oifxf96FNHk8ydxNmpW4uhKxk1ibBi0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774233448; c=relaxed/simple;
	bh=CvEDDxhl1fQITOzJwP9B3ngqq6SfzMFb3/Q7UMCe+fA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ekQ3HvDvYV0g0bFGyhz1+lBSXX10eHaM4q5lACHdnLMR0ro0gpI+N93cOLhZzqB4WMXF4K1WdFGuxSyTMoV0VjSu+/2jHTr686d3g2O+pjmzEGo+ARf273ykEvXDgSPhQi+H28kGqBjel5lj+mlh02mhMJFPpVyn74eXds+4xb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gP+MDUV5; arc=fail smtp.client-ip=52.101.57.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWSdaIK+kDLwfjVbTJ8T6Cq/nDo5jHjbLub5YhsocQrM1acOIpJGm4sa7mCmXoqAe67OlWbjcGM3NVx4zdVU6q4tY9BpgvaGzdviTj7scG8nA8d+Ybo5/baL3PewoIAzBH0X2zrvFMCOnP8lT2HTssYxEeIEgWcnbbIWh1ehGhAM3Pu19W22p2kDafwFts9ZY05FtPAQGQYNCadnGy/PlB3WSXqfhTyZiav6pdQxuDo61qimg+SD8q0oAN3zaBTrEmVmcj1l4gUvkB/me549YvIaV9y9ILiuW9qnnfmLIsMUFuZeXAeKT6eI/ZVr71kd3mX8UbjANfswSjET6G9foQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWTuFH2ku7rYybzhP0qo9F0sgEx2rGXM3tRrGkq4dlo=;
 b=Ujl1okUZeaZlWJ+nlyfQe1x2NzJfHzSvomCCgxFY44WbRLnHlrkF/0S+tCAAurXX3zDTjPIijGRIYLlki3//whuazpTgoiShfS8XvH3GndPMuS1oUzS3KRijct8Tv9/T5qHFD6DXt+7QGc8KduSNqDu1KvHQCdKEJuAgjEASqHVM8zDsxWOGhdF3MxW3MwQuN5qreTZ0piXpPQdwFkxPdheRoDw9TrTggT8gVBnkH/IUjs0bP8xZYPFBuMOHP9q6h9D2XQHrjkrmuRaeocgE4UKNtEPyphNwf3FE4lZ8N7pKmQL5FEnKbQOL8SW/UDHwgEruv5F1SsMOF+4GZk4FDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWTuFH2ku7rYybzhP0qo9F0sgEx2rGXM3tRrGkq4dlo=;
 b=gP+MDUV5k2uQ7aAACwt8VpsMG94nc7sb9XPUAmsKVnK3o1feY0sCBI/rX5WPZRju2XTa25ihvvEEdHDT9oBDNzbtcVi3+3OibyLxEy/EvggHyreIbiiS0Kd6sgfPwWtUk+KwvygQ7ppv06TPMRk+mKbRABAvK0f86coUmhBKNyQpPtW7gJibMyVR6wWNFy3wQL+y8JeCAdVEHZgVFOgbvsr58qiRNrH0d4YYYGtTGRstuyVKIVOiuKCUgvBDCoe/iRRMlBOdJh9eihQ3jBVpNTUVeXNHCcjrhUHXWTi+N/Y5SNQjjKlmg3NU3B0EpUGUEnx5hKJ/yey0Er18WldSMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.19; Mon, 23 Mar
 2026 02:37:23 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 02:37:23 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 23 Mar 2026 11:36:40 +0900
Subject: [PATCH 4/5] pwm: tegra: Parametrize duty and scale field widths
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-t264-pwm-v1-4-4c4ff743050f@nvidia.com>
References: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
In-Reply-To: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c85a69-52a9-41c8-c7a0-08de88851d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pRJoywXqCfj18O+TG1SvzS5T0hQoIVSo1hUDHQyRQ2QQY/Z+E0L1Ua2CkbAOxMTzNVgOC+iJIf5EfsOuOgWcFLTZ98KeRNMkRZHIx+lovtyxKUmkQ8SuMk3HyoSzuL92T/8Ngtc++JURdXzskduS4HeL+7el+FQAcbRzdK8jiShmHn9tc15jKNLSu4rxkdbYB0SMdVGltBXHb0Z3cqiNDwhdtzDXh38jNQaHx14Gdll0eezlwoduPpk5EfdEg9ks/0OzFlG42+70ZRvW2cGK+UzyLu/wmoS8Wh+PBSVRC5jfIED4oqVJ1dPFz5qLlp9SbLkJ5mXYXnF/eQ5XiNPjycBQ2higTYO/Yn8Y4I6vzR7g2WSYDQuWha/gAEW0h6uApCpjI4YGMiQUhK1897Lo4AVH8+Y/msqWckKP880fExDMG9cuyRCbP3zSjfFfUYC0U81WV5n7l1++YIjAUwP/F/83aO7KO/1g7Dyu8K5a8a2HHCWi+9hEclriZqXL3BZwEeuo2LkeEXkFruyEow3C0ItYTsKPPoybQHz5vU6zCposRF2Oh5gKBHcz2EHyJOOcm7HgatOtk5bsJ+w1A+gfYiCAtKTDmn3GDeEbOaYiDU93j+DU3NW4XlTU/S/PKtVZyRCmxnhg/uD7forxNNdTgpyRAMzX8ESzsqvCrUTNuMur4qxABzuMGTSgCGb6TOOqcHm6qa9zvMKIKMf0R6Y7+sQkdKEuRsXbS1KHjK23mU0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2VkQWV2aHlsaldKVWM0ZzZ5QTAxRjNtbGtWWm0vTWN1VDhHT25RWmkyQjQ0?=
 =?utf-8?B?WGlkSUczWSt4bHpIbWFiOXFpNjVhdktmZTZNdEQ5ald6Y1ExdXRuK0RtM0J2?=
 =?utf-8?B?VEpLay9GT0owNDRvb2FGcEdPVkh0dit2MFpFbE51QnZFZml2cU8xSFR2UUl1?=
 =?utf-8?B?Z2dndVFMTVBiTzF5M1VWQlhmc2tyZCtXUmRvOExxVXVGR0xUeXprTER2K01p?=
 =?utf-8?B?VnFlMDZJSStvY2xtWS9HUVVUQS9aMmhPdHpzdXdDWVcwcjZmRWRQNkZxcEhn?=
 =?utf-8?B?a2NCZHkzUVpVNGdodmN2Y1dCRUJQUFFPbDhhQzFqY3ZKMlUxeXNEODA3NGdH?=
 =?utf-8?B?TVZyOFFLSjBkUHVWU1JwSkNmSVRRbTRpNkZJZTFaQlNIaGl5SXhwZmx6QnRC?=
 =?utf-8?B?UUxvTVlibGNDWWdMNjgxZ3cyTGViVkpWcnNENHJSWnlrbk1HVmNldzFXSzcv?=
 =?utf-8?B?czRLU1RFQ0g1eDdTQnpwOGp6d2lXVEN6WnhmMjNBMFRzdmMwZi82QzcyS1pH?=
 =?utf-8?B?T3N4MTR6QnJUZUZGb2VpUER2NlZpSWx6OWQ1ZnA5U2I3SS9IZ2RCcjFHVmlI?=
 =?utf-8?B?YU5GbFhuRE9SSXRlYUt3VkNZcWJrd3RMZlRyYU1uK08veUZ3K3hMeFNMazBE?=
 =?utf-8?B?ZGh4NUk2dEpOWWU1MXg1TTZ6akVjYVpSZ1JiODZrR0NsODFtaFFzUVpiaFFw?=
 =?utf-8?B?MVVPc3RMaHBGZHJIMG1WUFdjcGtMVTRvMTVxSkxpdE05b1RmdjJ2SHpMYVJt?=
 =?utf-8?B?Um9lZ2lmRGlGM1RHYWNsY0RXMDV0TUpSYzY5T3J5c3BiVXJKbTNEWFU4NHZN?=
 =?utf-8?B?aEJLRDRuaDQvWU1JTEptamlOQmdKV0JQTzc1bGJDRmxJanZtSGgvMVZlT0cz?=
 =?utf-8?B?S3BQQnh6bm1CejVGUEFGNjdmUG1qN0NqcXRnZmp0Y0R0blR3T3pGL2JRNERw?=
 =?utf-8?B?dGpnVnhuT2pqYVBuc2pUc3UrZG1yZ0NibmI1Tit6WVZGWmhmOGh0N3lraXgv?=
 =?utf-8?B?OWk5QVJSNTFMVXJjVE1KMjE0dmo1c3c5cTZOWTZiQzFhY28vME5GQkF5ekdl?=
 =?utf-8?B?RUdad2dwRU1ZMVp6UmZCdHA0SnA3S2ZsVkpNNk5KUnJodW9XU0VYOHNEN0pv?=
 =?utf-8?B?Q2hSL2x3SHVTWlA2MnVyWEVwZ2VHK3BqRnZHQmxobjk1bGRGNWM4U1dFWEE0?=
 =?utf-8?B?ZVNHRktNMUp3alhVN29kR0ZQcGNHRGNCbzQvNHNsQndSaHBydUtBdUtMTmpz?=
 =?utf-8?B?OUx5c0tZcTU4d2N6STd2UWtoRlVkVDZxTm5HNEN3SWtTalVDY1MzQVI5eE5I?=
 =?utf-8?B?SXFKb002ekpaejdwbU1hVDFiNnRkaTRwcXZxd3Q0L2JaZkp2TktiZ1lQenQx?=
 =?utf-8?B?c0piRklSTDFXYlczSDZNYUNkZXdicjBnNnVYOEVMWnhKa3E2YUpwcWRuVTRG?=
 =?utf-8?B?QS82b21QTk5Jd1VjVFpLVFVINlprckUwZUp6ZmlwQWZhUVY4RHdwKzMrcmI0?=
 =?utf-8?B?NHpIRnlKcGpCUyt3UGh3bE1yblE4Q2lBYmhRN1VZaVJ2emhHRStDaERjUHlt?=
 =?utf-8?B?dmtqN21aYmd3NWp5SlkreDQ1cHpyYWl5ZEJISWF1QWFXV294Ri96SWt0Yndj?=
 =?utf-8?B?bHBZbmxEMlo0Uk9tbU0zMUF3TmJ1K0ZmSjJzV0lvTk1PaGMwbEV1S1hZUnV5?=
 =?utf-8?B?VGtHKzZ2UmhvNDlud2wrOUkyeUtCczR2dElKOW1MdDIzdWdHVjYyV0FudVhj?=
 =?utf-8?B?Q3ZIQ1IycHdndFhWTjFLOEh3UFZLSjJwSnBkVDNRTm1HNnNwd0J3Qkp5QkhX?=
 =?utf-8?B?TW1yeFZpN1laRlF4dy82QTFyVEV6eWdpNmx5TEs1VlQxZGZySEVzbGFBUHdz?=
 =?utf-8?B?dVhJa1U1K25iR0lrSFQyTWNxTjMvRFM4QU11K3lKN3NEbytvVEVhK1NKcmxY?=
 =?utf-8?B?eGgyb2VDSDNibk9HczhGNXZqcktsaElqSGliVytQdGhQeE10MElacWM3U3dJ?=
 =?utf-8?B?b1ovRjhBTlpGN214Sk5ZTnJVa2lSK21yT000TlRVTmlIdWw2clltK3pQeFZX?=
 =?utf-8?B?bHYza1pVUW1sQzlHa3lOZ1hOeUR6Mk1yVWZLZ0cxNUV6WEVoRTZLWjVDMVV4?=
 =?utf-8?B?RnBBSWNCaHRjTGlEUVBReU5jQ2V6ZW05UXRnY2RoK1lLWnhZdEt2ZlY5REdV?=
 =?utf-8?B?clNxVEp2YlVJaTJQTm5NcG56MS9ld05jS1BIN1F3Mi9GRDQxSDFlVVMyTW1L?=
 =?utf-8?B?dnN6Y1luWjFNUitlVzBMVlpSQWp0OW55UCtMREY1RjhacW8xcHB5ZGM3Sks3?=
 =?utf-8?B?YSt4a0JEcENyWnluRFZadnEwR3huQUYvdm5mTzdyU1lMcm82SFpvNkdHL3hF?=
 =?utf-8?Q?64ZpqKDi3nBf9sd/c/qXDpomnhVmGhFxYK+PTwUTdLV39?=
X-MS-Exchange-AntiSpam-MessageData-1: 4BxtZ4O188LhYw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c85a69-52a9-41c8-c7a0-08de88851d1b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 02:37:23.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yj42mi4PzZWUOzQ9i+q8DWggmbvHzTqoTJScZiomJEJk6a0exVaJh8gG8lFj2GKA8F1YOMYciEpYosjB4GRYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8339-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: AE5DC2EBF73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tegra264 has wider fields for the duty and scale register fields.
Parameterize the driver in preparation. The depth value also
becomes disconnected from the width of the duty field, so define
it separately.

Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 22d709986e8c..857301baad51 100644
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


