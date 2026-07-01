Return-Path: <linux-pwm+bounces-9496-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oJQcBqWHRGpswQoAu9opvQ
	(envelope-from <linux-pwm+bounces-9496-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:21:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 646766E96C0
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:21:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=IAjIYxm1;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9496-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9496-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1899A300EFB6
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jul 2026 03:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C5F340281;
	Wed,  1 Jul 2026 03:21:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0612D3A69;
	Wed,  1 Jul 2026 03:21:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876064; cv=fail; b=qNxD/NmEf7cxqlEvIP/NEqdHiEKQhaSpZ4bkBfwGXV9W5EToctLdtlo7VGShChx0MpjeNFuaxt9cHSlDzMCzDN9CdnmXcNMuXy+uIysMDuId4e6O7E0CK3z7aLVU9/AoVVkibcgF/Wkwtbm+7dZr25BHyWU/gg7+h9Oz//Vo6po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876064; c=relaxed/simple;
	bh=ehs1PdK8MQBeJsuiHZ6Tfe2zfnGG7L/wxxNM5Qlz/yk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=MVHJjj0pYeIulz0A4/tf2HIOthzhc2DH3uP2Ed75dqXc3KVXtuweLvPHtRRav+pXD0gi9hkJDyCzNC7qQoAMcxZat/GKmH4zXO+AiDg4K+RgUUYDVFQO1vnI9SZ3v5m4F98ES09Inbsu5zuyM3cW8ea9TN0/HrCRVum1Ej6yAa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IAjIYxm1; arc=fail smtp.client-ip=52.101.46.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjoXGNesA0WwydOz9HLe8Dv9MNYwtGKDznO0NHd+nQaQKrKrX9ilhkUyTTM8BCYWajE5a0ZHBxbEkklZF6GjOJqndIpZOV+uj7b08USCyLjpLx7xRswg1t0qyymMRY48V486KvG6mu2lMBfCv5if3bHYKrlEJaHTEyyshkA3BcQuyH1Wi1E3ubZqZM+jrCA+FOw9L5afkZ8g2ytIGlZflSisX+AW5qTN+2c82HQD7aSc3WaifRTlcvXWPCJRVQ0E12AMj8aZJ2uMNv66qdJnAzBC+HObSzhfekoZJwcUDGWxwCvOdPLQR03GfVSGMzrTqjyWfE/bOVvmnXL6m9YWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOklHWvBl17QGA1IrCdQq45lQp+0a4KeASo+T5jCL0I=;
 b=LhEDIIGzW5+c82xfOigjoTQCuyOjOTpxwDRcHhVTSfgEaQdg9/QOfxuSgv/XoILlMFOGgEYsIVxX7hoeHDftYAAslCk/KEu1BXnjPkRz+ts2QVZJVZUIexg++48WO1KaGfh6W6B6A6e47MiKgSA1BNq9Ke1iYjCnzJexNbT1GJeH2j8KRpmVIpbrqZIlZRRLAJmNMsHl3PlN11petdg7BpdxynE+s9Te0U3xnh2dLhxQMAdi6GWncBjLfDG4qQ5x9XOIqWmojWLXvbyRgHPvUTinexzAwxGVI0eTSN8OMgGBdnMVv8Ve9I+RkOUpPrvFQc1IQkBJWLxIRh38CuimEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOklHWvBl17QGA1IrCdQq45lQp+0a4KeASo+T5jCL0I=;
 b=IAjIYxm1Tof+QI4/NYs/jHUSrZOxOR5vnC8Vv/zvUM+TUQKLlcD8+6n6oF2sukzy2zTpsqtZSq0gDReElkBUohmykAmljdGcVRZBUrRPdEXDSyLPIZ4ZOF6CuW8C5CxT78WkB7phz3z4YnJ5Js+MuVEoJeof6jknrwsUcT7kaDwtVV88P4Vm/LoQS1HnRP+fDPseqYXeDMO4zV/soed1YcSsOgRqwAMZYstrY0FZv2VFZXCQABL8OMv+ABHcGFaFaXISjIgZRt3dTSEfydrZ36ulBlqdNABw2w/2KStZZByrkrLRyYne0JRGsJpbXrJIEUGiSRHBCPTkmZXtRehavQ==
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 03:20:59 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 03:20:59 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v6 0/7] Tegra264 PWM support
Date: Wed, 01 Jul 2026 12:20:29 +0900
Message-Id: <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XOz47CIBDH8VcxnBczwAx0PPkeGw+VPysHW9Mad
 jem7y4aEzE9/iZ8vuEm5jjlOIvd5iamWPKcx6EO+7UR/tQPP1HmULfQoC0YMPKqLcrL71mSiwo
 CGA5Jifr8MsWU/56p70Pdpzxfx+n/WS7qcX1FdBMpSoJEjyk5NECQ9kPJIfdbP57Fo1J0K6mRu
 krmLnQdcYdHs5KmkQYaaaokpxC1C8TOriS2UjUSq/SAyhJb5/z6t/SWpLmRVKU7Jo4I1LPtP+S
 yLHfhl5CFiQEAAA==
X-Change-ID: 20260303-t264-pwm-57e10d039df1
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Yi-Wei Wang <yiweiw@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY6P286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: e60bf79e-761c-4f88-34fa-08ded71fc57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10070799003|11063799006|56012099006|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	2kAWJeKRU6rr65V9BsKomTOHW24sDZ8bXGZha5SdSnljbQF2MF34YYdrtRP18srb/5iIXlauNTsGaPjzIy/cnI3jVbkxAyG3JYzGGKQK5crudG3IcYAQr64l2A6py/fejQuP+0vopD1fYZiYnuV5AqWDLWuv1Z9EP6g/JTuxv2zYcfb5A6Ab4NXXqdtAvyIa4XFMTvNwES/eMbp7xjgPNkc73HYYZiWzfmwlqn97BePGsIoiiLeIgKZbh429/WkwNsPFoUL9sebiUsHFXutJVEKWNwG1FPxd0AOW2gx70w1xoL+PLdD6KG0y3tz/rSvBpJzrZ5vGFcN1Sma0TeBykJN2jhGHwLxgFiNz81wAdrCuvZ5/bixu+0ctvJYFevIODL4WUrvOrq+uNvCT2lmn3u3L+ooaWUga1YPia+pOT4xJmyRjf8lcb3nN7F09o1HeKjiZdPhsk44J9M+YmpwwIGmwsgX+xOHp2FXcwiapWG1RYHnMg0oKUjAIHKVpe0uN4NamVcfmEiRSVFZ70HHJVidbgETHtI0XidfVHGnIejCoRtqpExZOvkvYiwzb0lv8U9YEAE+eKanN/TCq4dH7NofQnCr4VX/ewt1UBaJAmMX37qeztd2y2jPYT9yrHJC+hpGlDwZqSHU8RXtWj3WpbkTUhdWAgY6DE2Co/VIgI0s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(11063799006)(56012099006)(6133799003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0cycFUxSDA2UlVBciszQ0UxdDZjSGVsYndpNnpqSVN0bkU1U0xBNEo1ek5w?=
 =?utf-8?B?SlF4SVZ5aDBjNElsWW9SVmZiRncrcDdWdURTZm00U3BvRzc1U3dYY2FTVCtD?=
 =?utf-8?B?SnhQUzY2R09TeTNiWXFvK2V0U25uVU9wQlFmOUVSemtTb29wVURuV3h5UHVB?=
 =?utf-8?B?THlUU0l1SjBTa2hHYkxGVHo5MHVuT0kvODA1RCtCb3VYZ1NyU1lvMmNiYWJ2?=
 =?utf-8?B?UzlQTjlqMnE3eTk2Vjdnbjg5dmdMSGExU2pIQTUvTGtoL1REMTh6QmhtUkd5?=
 =?utf-8?B?Q2hHZnVlZnNCYmpEQkY5Vzlzb01zaVhRUDB0N2tYeFlkWXVkVFh0SkYwc1Vo?=
 =?utf-8?B?NjFsNWV6SWVPMnRzZlhTSTNYM250Sks5K1VTMDNGaWV5bW1td01GV3cwTEdH?=
 =?utf-8?B?a080QkxuY2tySEhzaDRydXpQRXhCcWMyamZxaXc2ZDluNHBBTUswWkhkZHlq?=
 =?utf-8?B?N3d0MVlheC9Nd3ZUdzErN0JYRHY5SzYvblp2N0I5emphUFVoRHBDUUtoQVRn?=
 =?utf-8?B?Tng5SG9DbmMySVZBS3JqenhrZ2E4TDh2VS9CSktKZmE4OUh4L2RISS9aTW54?=
 =?utf-8?B?M3dDUHJ1ZHlTTngwWmhQcGtvYzVOem5nVEpVYzA4eEJFSE9tb25qeFF4NTFN?=
 =?utf-8?B?YTY1dzRCWEJXdG1rOS9KM0xhblVqSkhsanQvMDlIajh0TUlQVzdmQ0ZSVGhl?=
 =?utf-8?B?Qklhd05WY2E4M1hxMFhncE9CTWlNUVB1Y0k0WjJZZSt5ckNvbjNHN3NDb1hp?=
 =?utf-8?B?QUZKczFIN1hJMGhYSFcydG05Wk45YzVlRGdrbWwxMVhKbzM3bWdSRVZxV1dD?=
 =?utf-8?B?ektXYkJrRURCR0E5NTR1WTExazNFSC96SEhJTjNIREV2TXVvVk5xU1VncGZV?=
 =?utf-8?B?TytoTnV0NzkybVU3Vk9aRGVsemcvcFl5K0lzd0FEc0ZreklqWTZHS2E0d2lx?=
 =?utf-8?B?elB6a0JKS3MzaWpneDZ6YUo1RGk1WEhrS3RlbGVmVVhPYjNzd25ydlZGQUdB?=
 =?utf-8?B?aDVGdEx5T0tGY2FYT2VoNEhGb3lMSm1xMWY0MlZnZ1hyUmRtVFluUmY4TGRl?=
 =?utf-8?B?MFMrWWhhcTRtZzByeVRGeVpTRjg0cGl1a0dqOUZJWUxZZkFEWEhuWlFsLzVJ?=
 =?utf-8?B?MXRjK0VENkIyblRJc0JKeUJKbzY3MlM4V2I4VmQwSG42d0w3N3RiQ0Q1NGFW?=
 =?utf-8?B?RHEySFZ4OGNML0VsbnRCb3gzRVBLWndqd2JXMXFvQUtCblJQSkVmdGw3U1pH?=
 =?utf-8?B?dlZtUXQrb2NxanlBMjFsbFhOelVZUDF5TlVRNXdwQXpudFIwaDkxWUQzdlEx?=
 =?utf-8?B?SWFyZVVvSmhPVTVnRStBbEdURVc4TCtoa0s0SnhsVk5QbThkem5YRFF4eENY?=
 =?utf-8?B?d3RvZ1M0NDVBbmpCY1V1NDJ3NEU3enQxbG5aODdLV25kbHRISFBKeGJoQzll?=
 =?utf-8?B?OG9aemtIdExuY3JhTGVYTGpaa1pvMlpIbUJqL1A4eUNLSm5ZN0ZUaWRoMi9s?=
 =?utf-8?B?em1yL0Nsc29PZkJGenZDME8vOEswS0dxRGhIZ21EOTcxZkhqRUdRbk9XTWRS?=
 =?utf-8?B?TE9TeTNtSTdWVERCVHJwbjFvOXROYUlRaXNpWXl0Vjd6SEpjUld6R3NjQVRj?=
 =?utf-8?B?YXoybTAyOXlyRkJoUk1ndGlXMVUycGhuNm9yZTRieXh0RmVIY0RlQ3NmNkZ2?=
 =?utf-8?B?VTlRUEJPSk9mcmJpd2s5NmlTUEFYSStiMzNIMmNYd1ZlYzlNVUpmNjdJY1Br?=
 =?utf-8?B?Zk1obFBLSERQekNxU0V2ejB1c2Y0blo0Z2xrYUY4R0kxc3FjZXZQU2pBczQ5?=
 =?utf-8?B?UlhZUHJwY0dRYUFUTXYrRWQ4dGlNblFSN2JybEZYTmp4TVJzUlpzbzFVKzlR?=
 =?utf-8?B?VHYrUjU5ZlNqbFRObTJtZk5mSlQ0WjFmd2hyWVFGNURSUitDRnRaYTdaN29r?=
 =?utf-8?B?VUNBUy9SM0VZZUVDc2dwUmRoaXVHM1J3RlZoSTZlT3o5cHB4aTBaTmYzaGEv?=
 =?utf-8?B?c04zSGtxNlZuZExidVdqTmZZcGVXTEFEOUFXZDdZdXB3aGljSU1na0RTT2hS?=
 =?utf-8?B?NDNnU1EySGx4RElkMzNmU0kwZU9kVER1bURDajR5WWZhQTlUTU1sZ3lXOGZC?=
 =?utf-8?B?TGlBcXNNQnJsZEhid2FQd0tPZVFPcHBvTmMrWEM4eUJVQTZVYmxId3JDWmFC?=
 =?utf-8?B?Y2RLVHhqRm9BSzdFWTdoQnpqMTVQdlM1d1lxQnNac3FOQ0Y4MWtyUFhrZFQv?=
 =?utf-8?B?a3llVkR5UllZempReGdOQ3ByeEtRODhwT29hVTRUdDdZcjV1b3dTamZtZDhq?=
 =?utf-8?B?VFpRUHlLOFRvRTRZbUlVMU5aaFRXYXRhdUYxQml0Mmt0a1k5Z3p0VzRHRFpY?=
 =?utf-8?Q?Ie1wH8BeuDqp0hWw2NCaCR9HYrjS8Bn+jw6rB3j+LSmuH?=
X-MS-Exchange-AntiSpam-MessageData-1: bftG12azxZ+7DA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60bf79e-761c-4f88-34fa-08ded71fc57a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:20:59.2792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WItHIvoE1koje0uYShTRbfXt5FfsXBVbBS4Km5t+jpGUkPRSS/w8G9AeIhNExVgcHCuz0HEqFNg295lTGd+Lxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9496-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	FORGED_RECIPIENTS(0.00)[m:thierry.reding@gmail.com,m:ukleinek@kernel.org,m:jonathanh@nvidia.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:treding@nvidia.com,m:mperttunen@nvidia.com,m:yiweiw@nvidia.com,m:thierryreding@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 646766E96C0

Hello,

this adds support for the PWM controller on Tegra264. The controller
is similar to previous generations, but the register fields are
widened, the depth is made configurable, and the enable bit moves
to a different spot.

This series adds only basic support with fixed depth -- configurable
depth will come later.

Patch 1 adds device tree bindings for Tegra264 PWM (compatible
  string).

Patch 2 prefixes driver-local macros and static helpers with
  tegra_/TEGRA_ to make their scoping clear.

Patches 3 to 6 contain the PWM driver changes for Tegra264.

Patch 7 adds device tree nodes for the PWM controllers on Tegra264.

Thanks,
Mikko

---
Changes in v6:
- Add sanity check for clock rate returned by clk_get_rate to avoid
  possibility of division by zero.
- Link to v5: https://patch.msgid.link/20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com

Changes in v5:
- New patch: prefix driver-local macros and static helpers with
  tegra_/TEGRA_ (suggested by Uwe)
- Squashed the enable_reg parameterization into the "Add support for
  Tegra264" patch
- Rename pwm_readl()/pwm_writel() parameter `dev` to `pwm` to match the
  rest of the driver
- Drop an extra blank line in tegra_pwm_enable()
- Reflow the code comment text in "Add support for Tegra264" to
  fit within 80 columns
- Dropped duty_width field since it was unused.
- Rebased on latest -next.
- Link to v4: https://lore.kernel.org/r/20260331-t264-pwm-v4-0-c041659677cf@nvidia.com

Changes in v4:
- Use ULONG_MAX rather than S64_MAX to avoid overflow on 32-bit platforms
- Link to v3: https://lore.kernel.org/r/20260330-t264-pwm-v3-0-5714427d5976@nvidia.com

Changes in v3:
- Fixed device tree binding patch.
- Picked up trailers.
- Link to v2: https://lore.kernel.org/r/20260325-t264-pwm-v2-0-998d885984b3@nvidia.com

Changes in v2:
- Added device tree binding and Tegra264 device tree patches by Thierry.
- Link to v1: https://lore.kernel.org/r/20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com

---
Mikko Perttunen (4):
      pwm: tegra: Prefix driver-local macros and functions
      pwm: tegra: Modify read/write accessors for multi-register channel
      pwm: tegra: Parametrize duty and scale field widths
      pwm: tegra: Add support for Tegra264

Thierry Reding (2):
      dt-bindings: pwm: Document Tegra264 controller
      arm64: tegra: Add PWM controllers on Tegra264

Yi-Wei Wang (1):
      pwm: tegra: Avoid hard-coded max clock frequency

 .../bindings/pwm/nvidia,tegra20-pwm.yaml           |   1 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  72 ++++++++++
 drivers/pwm/pwm-tegra.c                            | 160 ++++++++++++++-------
 3 files changed, 181 insertions(+), 52 deletions(-)
---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260303-t264-pwm-57e10d039df1


