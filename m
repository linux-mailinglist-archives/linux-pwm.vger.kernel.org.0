Return-Path: <linux-pwm+bounces-9498-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P99WKOWHRGqhwQoAu9opvQ
	(envelope-from <linux-pwm+bounces-9498-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:22:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4486E6E9704
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 05:22:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=M0QDt6ce;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9498-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9498-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A7BD305816D
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jul 2026 03:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3F3364942;
	Wed,  1 Jul 2026 03:21:12 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C706E2D3A69;
	Wed,  1 Jul 2026 03:21:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876072; cv=fail; b=HgfNDS+K6Fojrv/Ei9WthzIdqMfcq6bm3q4qkWNeV7vID8BC6zOgb30HXDwNA5k1rwMkXYzYUhDdgPmCMUhpYF7AowTpkAwA4LWSpqHR9Bvelsvu6Og4XBKyzls7n1Ry9xdESBeD2wusD3+qD/sIyphBx7kbFNEG8JTlX1tRkQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876072; c=relaxed/simple;
	bh=J30ckZVC+LVvnbEeqVB12O10Lw40acyBbbfOXpoK1nM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=shBvCR5IPwSiInAjB25KrUoGQ8X4fXGlUeGUJwIW3VsVUznLqGe2PRWVwFyAGKkclIiJdD7RyUzzy8VaWTO/FdYqT5tkSa7xdyQ7sJXvGICSaL8t87/X4f/R4zch6uxJ39DCwTNWQzocn6qVPAvHzMLo4N44Xk3arLZgv3bmc3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M0QDt6ce; arc=fail smtp.client-ip=52.101.46.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cN4xh2Nr0fObpkiwKU7ZaEF1W1IjW6Sdw4sEsxYasibAPHSyGr+L5pFVdCIzhNiCe5bFPCHHcs87FUgHXth+vmrJm9s+MXjMU0NRxyl8rb4kWTlXyWmlIv/kiJid/5D72TXrJwWCksIWXucOWmycEL4MnD/6dE+3Al9RH2XwEzPK0QeKAVsbm2OpBaWn+zKuu0QtJeRuVcBMxvmMbeC8Ovu3DRgD8MQKKKobUe1Kx0igFntNGpryyRsYJLrRNtnmoOzQfFSPUHKVdwn7BFW9a5Q6wNRpTY63PVTlz7Vc44ISXC1PTO3xnXt0uwj0ntLlXKghGLdIiLkkOT3p3MWR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATglbpRNTGolB+U6F2IdD1kP0uZX7sVZYopkSNWb5UU=;
 b=jPaGr3rWmdXdPgTVQ+7S+W5uysFCL8OB4BphK+SzWC2nroac9WWOwlQpjF7oxsRAgmIaFG2Yjl8CjgBDes01BeZwIUBVqFoPnAgYBDylpJ8WjE5GVrl++Om4oeTFn/H+1hcUSwcWu1ayec8bstDc9SGg6jmJr6PHEVuCcXQwpg3M8wqP/z1sY16kWH0tX9UOc4uypHA+eUNno/xbimLLN2eBK1abubE2kGTDdHw+RPrSlwnzBAZ780c0Rz1xVtkzGckrysbOIquY30a9VH7V6NN+0YvcAazHhhj/v+AzWphSBZUnogtikl1ngkz1USwjsVU4F12mfbLQ9XdBU+UpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATglbpRNTGolB+U6F2IdD1kP0uZX7sVZYopkSNWb5UU=;
 b=M0QDt6ceRuG9JMwRAM91PtxCNpHSOZtj0I06zpQ88WFJYjUP2fBiPQtOySdTqnywSUTFdfKQS+os/9NUB4hwUid4oy8qcMq8uUSb1Wz300w6TkpLmlvecfTOCVSXovagvSBPKqUoq/X8giKYoQlTEPDy03DsfAWvNiiyotkggQQTxELPw4DxCxMrMy/e8WudXM6dIMTWiMDkexfNasrWbFnURaXluqKmOrJiO/MBeSFhpWiDMl+4/EIWUTgXNrNVnvU30sNu0Ul8IW8XtVmyo9pDoChf/LdywES39WAfVPkoMJtpYgohO7NFo1TN06unU/vYm0wlOGx7+qFYuSYz8g==
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 03:21:06 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 03:21:06 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 01 Jul 2026 12:20:31 +0900
Subject: [PATCH v6 2/7] pwm: tegra: Prefix driver-local macros and
 functions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-t264-pwm-v6-2-2718f61f411f@nvidia.com>
References: <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com>
In-Reply-To: <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP286CA0088.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::20) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: cb60dda5-fe43-4cf4-5a25-08ded71fc9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10070799003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QBUI7NbSANI9v5kAFIzdS1k0kjeauuDFnop2F3xc1JO00JM7U8QEDD2vvR3XTfJ07BY5dJ8WoVMKr1bB+tOL5nMHrZO46ofnEQvd9D6BI024meKPGy1k9ZNEcSVouEh8S43plVgqU6eERqlAeYdfIxhjzUHQnvLKOy+tH8AEBt53UDAecVccjh1XtHWq0h4kB3EY3d4lv0657b0toK0b0SzRL7H8kECKK1bhHgtAhcxg1Yg6w6+gnGT8G2zvDUk2MJBoyBeWzLN/plrQyD39wBOcSbpsjN/C8ENLZpKtjQiVwEzafHpohaEQJXsfUKOgyiafPV+LuoBwUNo4jBzz9oIx3njmxGfeRnePwm3eHhtqOmPqGfdkO9O6TfUcvov0ThyrOLWiJfiIHUlNwU1s5Y40fQ6/MJJgunjHtqOnfThDIdGtLmKxbtYXtUho2PMuGghKG/FcQlo8+/Manfk8dz4QWBeCBR6kf9rcxlkAXJJl+lCBpyOXuAk2q+WvkTXNXG48512FhXF8WicFDU6GMxK5++J85kwN/clZvlc+vnZ8SRVbvDMpY3BhMFfQjNhscbLUIjaX+AMubNm0SmtNxfpC4RUK+NL0uS8o+x9rgp0BA5E0Rc85N7lzIEWxzE+D4KDn8yKIyfMxAggsrU9DN2L4/sL5tPsBxvtntv6DrR8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk1WeUZ6amw5Q29OYiswTEY4VlJCUzliWGoxb2pjZ3BJNmN0ME95T2UrYWUw?=
 =?utf-8?B?NTZJc3QvNVBGaGZVeXBMaXl5YmtOOE9nMFBDYXBDcDJlSS9pK2lkbk45R3pC?=
 =?utf-8?B?MUxFdnVtODJ3c1JpclpOYmFqYjZySTNUN0sxdk8ydEFFbFNnZHNDSG1TUExH?=
 =?utf-8?B?MFdEc05vSlA4ZkRneVB5ZUJwbkY1VldINkI1d2hpYjlraDhWV2lDc2Z6dEVO?=
 =?utf-8?B?M25vVVAzaTdjUE9zYUFJWEdOR3FsT3lRSjl0LzFuQStXM0huVmtWUXhCcUZN?=
 =?utf-8?B?NStuWXd3dDVOZmlvaVVzNkpVblMrRzRhb2NYQXBaSlh0L3V3YXk4UEYzeWVq?=
 =?utf-8?B?aFVwNkZhcDFKQndtZnZKTW83ZW5rQSs5M0pUcjRGMzhUZm5NL0Z4UVVlcXB4?=
 =?utf-8?B?VEpwOU5PSVVjSXZXUk1PSFdKTXFUSDhrY3JmODVDNkNKYlI2bmo1enM3Qlhs?=
 =?utf-8?B?amxidEZDZWVnTVhxOWtHZFRFZXkyMEZLbWhxdkpyZGRFaGRhWkdibzIrcldl?=
 =?utf-8?B?ZTdOUFZmMTFhYkRkUm1mSFVoWi9LaFpZRnc4VmRpcHV2eDV5Ni81K2VScSt6?=
 =?utf-8?B?TVNKMHg1U21pYTdMb0RDaFdMV2ZZcjQ4WWo0c3IyWnFjbHd4dkQ3eW1DemJs?=
 =?utf-8?B?elZHdFJobCtoZnpNNFEwbXlaRTIwaDlZdGJ3V0VKcm5uc0NvWmFjbnJpdFQz?=
 =?utf-8?B?L1Q0Q1M3UUpISnU3clN1aDBUdDJ3b0tJMUwveU5mREFtaE1hZDRSZEdBRVdF?=
 =?utf-8?B?dFNzcE9EUzZjM0F3NHQ2cXhKZGlVOW9xNDk0UUNzSzRnUlJOZ3IySnF3Y3Zx?=
 =?utf-8?B?MklhL0JoR1BXb293M0NlYkFiYVpCOHRmRGRKdkEwMk1rWGFqZHM1TnUvM092?=
 =?utf-8?B?c0Nrd21BbzJMYThodllNZDFjNFhzMDJEWTZsQldHK0dpTG9CeGtUVFBJTHh1?=
 =?utf-8?B?NHlNRXhKY01DMThYb3RhaWlxVnZPTlliYTQ4VnNWallwMS84SkthNGRpb1lZ?=
 =?utf-8?B?cmJVb05UdzIzR1FXU0htdG5mSDVLTVNaR1phQlphek4wYS90cURidXA2cEcr?=
 =?utf-8?B?djY4c0xRL3plaTM5MkRvTXdzK2syVVBnMzdDejVzMU5EMGI0akZ4Qmxua3Qx?=
 =?utf-8?B?YkhyNUc3U1BjMjNBTnhTWFBGUjlraC9aSllnTmxPM0dzenJ4Z2tudXNWYVlE?=
 =?utf-8?B?OVVIc3JsR1dpOFZhRkYyY0FmcHM3RG1zdVZ2MnhvVHk3eGxHM0M4V3JocXVm?=
 =?utf-8?B?ejhDZmsyVytRcmFyRUI2ZTdBd3V4YzFLc0JoTzdTRjA5Y0VOZE9wQlZMdXlK?=
 =?utf-8?B?dzVESGZScVdSWVR5cWR2dThZZHZqeVFFc1FrVCtuRTFmVitWVUhtMUJqUTF3?=
 =?utf-8?B?TUtLbHlTeGxHY1VXWXhTME9Fd050bTV3emhDWHlGOFJoRE9KMkRRK052cGd2?=
 =?utf-8?B?dW1GMVJMUno4QWh1cVEyNjBLUWFSZElJU3JlZzJweGNZdGF1UnVjV1VUd3Ir?=
 =?utf-8?B?dFA3a0h2dWhHRmU5QkVPZThsWTdwcHQwWlVGOEFENVBqQlZUdTlKc2RoOWhz?=
 =?utf-8?B?RVFuaGdxL0tiRWllWDRzcXBDNEkrakg1WDNpdGlsWXRPa1VrNTFuYUJUcFkw?=
 =?utf-8?B?NEpuOFBqK294Z3hJb2xZVGlJYmtSTmhnTy8ySXVWVGVEMStkaWZkVmJpYnlq?=
 =?utf-8?B?MXpueDdyOGRzU0kzL0VMR1EzWUN2cTd4dWp6QU14V1M0dWg4d24zVHhCcEt4?=
 =?utf-8?B?U3doMTJkSHJONmpRR1JtOWlza2l0MWhLc2d6aGROWU5QZlRvNUxQeVpVYXBV?=
 =?utf-8?B?bWJpUUEyK3JxRk9CMjBRZEFPTnhVYTlPNllWTFZGUUxka0JycnpVeFBVU3cz?=
 =?utf-8?B?cENiU0p6YmNYTEptUUN0RkFScVZ3aml5VFRUcUpPMFNwc2FDdEFCRGFzejgx?=
 =?utf-8?B?VzFrQ0tXM1V2bnJwcmd4VEdBM0JJeVhhcjBiN041ZjlTeXZPZlVzN2g1TllP?=
 =?utf-8?B?YmVOVEg1RTZob2cwL3d4bXlFUzJucHNjb1JEMU5UMFBkQnVCdU9pRFNxZ2la?=
 =?utf-8?B?VHhwREdvL2pLa2xGU1NJQVFkTnNNeE54Zzg4YUU0bWw3dGt3WUQ4MFF2Qmpi?=
 =?utf-8?B?aERyVFM4QnM4Skt2eTBqSi91WHhObU8rNHAwNVcyYkJqMHdLcDJiQ0cvN2xv?=
 =?utf-8?B?bFVJcVV4SFJhVFU3bzVBeTkzL1U1Tzl5KzdUTzFsYytNajBmZUp2enhlcTYw?=
 =?utf-8?B?S1pXWXU2bjIwd1B1bDhRbGttRFllcTd6alJ4Y0FiZHdxQUQzdTd1NjQ2VCtZ?=
 =?utf-8?B?djFpeDlHOGFpMkdvUzFSdFhGMkJzSitYMlJzQncvdkV6VSs0b0FhRUtxQ3Yz?=
 =?utf-8?Q?AXkNgI9HbpvzH9mE8Gyoz9PpHdsA52ZFd7DfcZ3NQCd1r?=
X-MS-Exchange-AntiSpam-MessageData-1: bFDufFScLUFHgA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb60dda5-fe43-4cf4-5a25-08ded71fc9fc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:21:06.7909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNiWODbMf2opYXCXl18zFGdnP7hcUOzkx0SyT0l7Wd2RS6cEMZQn4fGoGwWhUMjAyxOJ8OikbC+Hqw7O7pMV3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9498-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:thierry.reding@gmail.com,m:ukleinek@kernel.org,m:jonathanh@nvidia.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:mperttunen@nvidia.com,m:thierryreding@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4486E6E9704

Prefix driver-local defines and functions with tegra_/TEGRA_ to clearly
distinguish them from any general PWM related symbols.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 54 ++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 172063b51d44..f8c5495a56a6 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -51,11 +51,11 @@
 
 #include <soc/tegra/common.h>
 
-#define PWM_ENABLE	(1 << 31)
-#define PWM_DUTY_WIDTH	8
-#define PWM_DUTY_SHIFT	16
-#define PWM_SCALE_WIDTH	13
-#define PWM_SCALE_SHIFT	0
+#define TEGRA_PWM_ENABLE	(1 << 31)
+#define TEGRA_PWM_DUTY_WIDTH	8
+#define TEGRA_PWM_DUTY_SHIFT	16
+#define TEGRA_PWM_SCALE_WIDTH	13
+#define TEGRA_PWM_SCALE_SHIFT	0
 
 struct tegra_pwm_soc {
 	unsigned int num_channels;
@@ -81,12 +81,12 @@ static inline struct tegra_pwm_chip *to_tegra_pwm_chip(struct pwm_chip *chip)
 	return pwmchip_get_drvdata(chip);
 }
 
-static inline u32 pwm_readl(struct tegra_pwm_chip *pc, unsigned int offset)
+static inline u32 tegra_pwm_readl(struct tegra_pwm_chip *pc, unsigned int offset)
 {
 	return readl(pc->regs + (offset << 4));
 }
 
-static inline void pwm_writel(struct tegra_pwm_chip *pc, unsigned int offset, u32 value)
+static inline void tegra_pwm_writel(struct tegra_pwm_chip *pc, unsigned int offset, u32 value)
 {
 	writel(value, pc->regs + (offset << 4));
 }
@@ -102,22 +102,22 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/*
 	 * Convert from duty_ns / period_ns to a fixed number of duty ticks
-	 * per (1 << PWM_DUTY_WIDTH) cycles and make sure to round to the
+	 * per (1 << TEGRA_PWM_DUTY_WIDTH) cycles and make sure to round to the
 	 * nearest integer during division.
 	 */
-	c *= (1 << PWM_DUTY_WIDTH);
+	c *= (1 << TEGRA_PWM_DUTY_WIDTH);
 	c = DIV_ROUND_CLOSEST_ULL(c, period_ns);
 
-	val = (u32)c << PWM_DUTY_SHIFT;
+	val = (u32)c << TEGRA_PWM_DUTY_SHIFT;
 
 	/*
-	 *  min period = max clock limit >> PWM_DUTY_WIDTH
+	 *  min period = max clock limit >> TEGRA_PWM_DUTY_WIDTH
 	 */
 	if (period_ns < pc->min_period_ns)
 		return -EINVAL;
 
 	/*
-	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
+	 * Compute the prescaler value for which (1 << TEGRA_PWM_DUTY_WIDTH)
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
 	 *
 	 * num_channels: If single instance of PWM controller has multiple
@@ -131,7 +131,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	if (pc->soc->num_channels == 1) {
 		/*
-		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it matches
+		 * Rate is multiplied with 2^TEGRA_PWM_DUTY_WIDTH so that it matches
 		 * with the maximum possible rate that the controller can
 		 * provide. Any further lower value can be derived by setting
 		 * PFM bits[0:12].
@@ -141,7 +141,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		 * source clock rate as required_clk_rate, PWM controller will
 		 * be able to configure the requested period.
 		 */
-		required_clk_rate = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC << PWM_DUTY_WIDTH,
+		required_clk_rate = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC << TEGRA_PWM_DUTY_WIDTH,
 						     period_ns);
 
 		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
@@ -163,9 +163,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		pc->clk_rate = clk_get_rate(pc->clk);
 	}
 
-	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
+	/* Consider precision in TEGRA_PWM_SCALE_WIDTH rate calculation */
 	rate = mul_u64_u64_div_u64(pc->clk_rate, period_ns,
-				   (u64)NSEC_PER_SEC << PWM_DUTY_WIDTH);
+				   (u64)NSEC_PER_SEC << TEGRA_PWM_DUTY_WIDTH);
 
 	/*
 	 * Since the actual PWM divider is the register's frequency divider
@@ -181,10 +181,10 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * Make sure that the rate will fit in the register's frequency
 	 * divider field.
 	 */
-	if (rate >> PWM_SCALE_WIDTH)
+	if (rate >> TEGRA_PWM_SCALE_WIDTH)
 		return -EINVAL;
 
-	val |= rate << PWM_SCALE_SHIFT;
+	val |= rate << TEGRA_PWM_SCALE_SHIFT;
 
 	/*
 	 * If the PWM channel is disabled, make sure to turn on the clock
@@ -195,9 +195,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (err)
 			return err;
 	} else
-		val |= PWM_ENABLE;
+		val |= TEGRA_PWM_ENABLE;
 
-	pwm_writel(pc, pwm->hwpwm, val);
+	tegra_pwm_writel(pc, pwm->hwpwm, val);
 
 	/*
 	 * If the PWM is not enabled, turn the clock off again to save power.
@@ -218,9 +218,9 @@ static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (rc)
 		return rc;
 
-	val = pwm_readl(pc, pwm->hwpwm);
-	val |= PWM_ENABLE;
-	pwm_writel(pc, pwm->hwpwm, val);
+	val = tegra_pwm_readl(pc, pwm->hwpwm);
+	val |= TEGRA_PWM_ENABLE;
+	tegra_pwm_writel(pc, pwm->hwpwm, val);
 
 	return 0;
 }
@@ -230,9 +230,9 @@ static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	u32 val;
 
-	val = pwm_readl(pc, pwm->hwpwm);
-	val &= ~PWM_ENABLE;
-	pwm_writel(pc, pwm->hwpwm, val);
+	val = tegra_pwm_readl(pc, pwm->hwpwm);
+	val &= ~TEGRA_PWM_ENABLE;
+	tegra_pwm_writel(pc, pwm->hwpwm, val);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 }
@@ -318,7 +318,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	/* Set minimum limit of PWM period for the IP */
 	pc->min_period_ns =
-	    (NSEC_PER_SEC / (pc->soc->max_frequency >> PWM_DUTY_WIDTH)) + 1;
+	    (NSEC_PER_SEC / (pc->soc->max_frequency >> TEGRA_PWM_DUTY_WIDTH)) + 1;
 
 	pc->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
 	if (IS_ERR(pc->rst)) {

-- 
2.53.0


