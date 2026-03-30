Return-Path: <linux-pwm+bounces-8417-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIcfJCA8ymmd6wUAu9opvQ
	(envelope-from <linux-pwm+bounces-8417-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:02:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB41F357AEA
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3BA2308C176
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 08:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E023B530D;
	Mon, 30 Mar 2026 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fDEn/68/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCBF3B52E7;
	Mon, 30 Mar 2026 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860860; cv=fail; b=m/UlYa6XExwSRld7/Eh6CPpzKw24afbBMBfa7dWG48zmQPnwjxYm70XnnYlVYwkAjDttqBGBwfvDOVuddkLQ7rmzq0d09/qlGFmEB36JLTAUY4CfNJ2X2xwaR81jwQ2ZB1k3FrRrVx7TgyiGL08LDTkcc5CxutvcDAztsgShJBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860860; c=relaxed/simple;
	bh=furNPDXZTeGLEC7MAFEiX7UOWt4MEGKhoi99hd8j7Jc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dU31IFTJnJnJGfBXn1aUjXb+pT/enmy6Z4Sq872m0IBuJX3+OIuN3QehebHGtRlalSE+lsUTvTWo1Ia0crhFqztqAwIrXRa/arTiKdQ67hCUdIvgehSKEhfvkJ0iFWy0fWVV5PcJUvHubDgaMhkmeUAXZ2Gv92/wh5SX0pYMjrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fDEn/68/; arc=fail smtp.client-ip=40.93.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaCw6ch08UFZFDitQpHfVPsF16/us8NQb+qZlid7r6hqb8gjACE2tkCopKQXCrk2d9N2j7tcpcWvz07VU7zjhTuIIHdqARtxhc+wJCF/c6B6jDdToB/KrnltiGP7f1jv5CxYgXTGTQZenrUReTc8K8pG4y94KKzODFMJwsVfizrf9a21kBXsELojTLHzLnTifXgBryXdBwbemIIS9eciGuLXbPwHBxso9W6v7znYMofkndfWPM6bNuLDlxYsuC8LAALpbSCFMv9DoFRPgtRkZuTS7lFvJ6EU3QTkyqCyckz2VTe3N6sja7nUdf0AOt4ONlPFrahts7sd46J8Hg5blw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4e3T8/wHGH1MGCYChzTeTntjX5tt56SeqPBDudJ3NY=;
 b=VrKEPAKULzR7ucg3txvy1uPk13ExXe1Z8knZKoBNtZ2WUv7XMyw0mcr+odROKoOzURr7cb2vtyDxWx5RCFF3bRfEU+yWnK5YRUjQQFRYLUA24LjkdA97OMy48eZp8WL2Wt5dkDApkRiIKyovZ44nptF76TXhzCHE/t1tyRJ8lZOeZ4NFCcbG6v0+c9nYz4BNEpppakx2ml95cnAIu+I8AImHCbUO5Zat4OYDfcnzmCAapZj/5WFlqxf3kgajoA2AlWQJ2aI0uwFKNFI3XTK4fQlWiFDsUh/17arB9DVMYwBhQg7yC523wqB9Jjxn2g+hHz8AfLeS/h4EZVXo+sEf+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4e3T8/wHGH1MGCYChzTeTntjX5tt56SeqPBDudJ3NY=;
 b=fDEn/68/XSiFWvWeXB7Yp1wWsPDj8rKaFWwPyULZojPBr87+XjERGAVAevr3yEvZ9h7DqJsYRmqfz0bufcRsHuevY9s9SD/DrUMR9UuM2YYBdsB/rrbaqvg4u0eV5YlaPr/cxMhxygatclBHcIQFcB7ILW40XLbyKi7bWfDAcsZiQmS8RjPIALQQSQwjjTxP0NyZbCog/Kp0jKiLvtMcsNBqlShMHjL88kEjCDZoUroAbyb4maHbw0LUTpiV8/49F4fv/w0mx95AbOm3gVYyhmMCuOU27sk8iXBvKbWVUHpcs3fsvfdf/jvfhMFhTykxHE233IdZKe2o0F5wfk0/Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Mon, 30 Mar
 2026 08:54:15 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 08:54:15 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 30 Mar 2026 17:53:56 +0900
Subject: [PATCH v3 7/7] arm64: tegra: Add PWM controllers on Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-t264-pwm-v3-7-5714427d5976@nvidia.com>
References: <20260330-t264-pwm-v3-0-5714427d5976@nvidia.com>
In-Reply-To: <20260330-t264-pwm-v3-0-5714427d5976@nvidia.com>
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
X-ClientProxiedBy: MW4PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:303:8d::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH8PR12MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 9600f592-fc5b-4f73-fb59-08de8e39ebb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hW8FUb1lGSGi6N3EZrVFzr/Zd52KIhf/2gjXHsPTAy1eml2Oxi95IhWxtYqCpnp34JD6YvfcIyX0/MCDDy1mgs307GRLhqwzBEK/5759sSHj9UhqamkVF561wbT8lQtpB0mxXZZPcgHZq7u8DgcxlAG/jefMGs6D1WG6BvZTTY42SAIY3uXFiqqEBk2WPr9LSVebid3aS2GdMlck7nZTMr0fGbbajhb7IZ/x/TCaZWgrYbyElEpqW3/2W69AKQOlkftFSAMnJj1sx9SXdpvmw3bY+BCYmQGrHpdqudMuR7NeX9r3S6t0OUaU3QSUCTZZMJ0kDa9DhnOLruhFNkGcGRKIHQ3U/I2Ga78AQOzChHH/Ne5tMYD4QodWu0E9FvZtJ7/wrudJ1PF7twdTdaZ6VOUoCFNJysAXEunRQODQvlSh24mSMcCdUuDkBZ0OWR4Xher5OBWWbonAGuN4AyENaZbPfdrZwERFhDBarrrC3VaA4QjXEYDzCQeBAYUH48sxFxYnCULrvwwL1bXBGc3mI9GqWBvb9zqVSfjkFET/wPGeQ1nL8CbyRN3y94NOmxltQ275Wr6ONzo67MGGzpEnZnOqftovIDFOR+vmcr7RXLTkc0r9WGUEpI6c1ORoUc6U9+TylDpqwxQvK3AHQ17MGKQpxlmeu3+6drGC8Wgri4taMAT5HAqCbIFA05simH9LYPkepvLv4rrsZjqb2Lzm6nyuUuaSNKg75IfhbHPPePc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmpLcGpqa0w4SkRXaVJPbFpXRTFHNUtDRGRaZHU3VVp1YW5SQXNrenNmQ3Mv?=
 =?utf-8?B?UFhuZmVSeWdML1BBaEtrUUVuako5M1huUHZ3bHc3ZHJ2SkRVNkdYSU1acU8y?=
 =?utf-8?B?VENHZGI2MDJaMUtOMGcvSDU0T2sxc3RUUndPbVFST0NkbVVvbzJRZjM3OWE0?=
 =?utf-8?B?aGsvVHpkMHRUeXlSaWlHTWdibStxMUdlMTlONHhvQkxzeG1weGZUQjdiUUZK?=
 =?utf-8?B?MHNqV0ZFYkw4amhEZkYyZzRKZytTWmcyRTVDa3lWMlBwbDVWb3JaelRyR3hP?=
 =?utf-8?B?SzQ2SkxhaGFzNUNHajdPUWUwdkN6MlppTVV4Mm9aYWppb05EUHdROElpS2du?=
 =?utf-8?B?ZTNFM1pyVnV2Y1FKZ0VnN3d2TG9VdEw3QURvNkkxcWJBejdCakxlMi9NQ0Y3?=
 =?utf-8?B?WmxGbC9sdERpbGhnZ0FTa0d6b2JvbHVPLzRkd29iNmRKTFdwaDVWUExlZFZM?=
 =?utf-8?B?VjhFdUxTT3NwSGFncHBKTnZLbW4xV2NnbFBZcXluLzZVTHpKbTl0QW5tdDc2?=
 =?utf-8?B?ZTNKdTUrVGhNd2xpQ1ZtaGQ2UkFqdXMxYkRyckZybmdrYzdwY0pQRGRpdVZW?=
 =?utf-8?B?c2V5ZmRrWDBEVllzYi93MTVsc0JOSFd2c1prM0RsejdhdjRrUU9aVUltRnV0?=
 =?utf-8?B?eUFoY1F6aTN3Sm5KQVZaV01sc3FuV3hZQ2g2bytha3l6Y3owVU9Ra0lBU0J3?=
 =?utf-8?B?VldQTGtieVJFTzk3YnE2L2U3eHNHRmdEU2draXpvWHFBclJTaDJuNnAzTENP?=
 =?utf-8?B?NzgrUi9iNWx1VEx5d2pyQ3R4amRKTUtLS1p0LytLOEMwVFBhV3U3N1lDaHhp?=
 =?utf-8?B?S0FYR3l3OFZaaGsyZkRnd2k1T200U1pkeUpKTWhaeWVyeGZGekJPb1FKRzFy?=
 =?utf-8?B?cWU2TEdKcDVsc2hNWGVhT3p4eENsbUVlTTF2VlNhZ0oxTE1RZlQ5UU9pWXVU?=
 =?utf-8?B?blF4NlRPNGRTc1FnRGFMYnRkNGt5TVBtS2hiaGhZYU10NnNZUHhIYmVhVkdk?=
 =?utf-8?B?RDRhemZTOXo1QnhFeTdraUF3TkdNdjQ2WkhSalZkUUJnMmM5NlhudEg4R25i?=
 =?utf-8?B?enhRRDVCODk3OHZ0dzZCQUltVk5FUzBvdVZwSURYVjBwZTNFMzY4WTVTeDdT?=
 =?utf-8?B?TTZnUWxkbGpBL0hxQW1PSXVld2lxVVY1YmU3ZXRaVXRxMkxMQzhWcitUSzN3?=
 =?utf-8?B?VnhjSzZ4c3lPeGx4aXo3MkhXc0MxdGRXN2lkR2RBWmh1OTNYT2UwWDRpTU9E?=
 =?utf-8?B?T2pjemp6dmlpcSs4Rkp0eHQ2SjRXdHQxK0U2OHR3OG44OHA0Z3Joa1NteURK?=
 =?utf-8?B?bHc4c3E0MmVrRVF0bFl5TkZrdG9EWXhMQnFOV0t1TGx5UW16UWNjWFl4UE0x?=
 =?utf-8?B?ZlRDTTlmR1JLREJFUDVJL3NhVGlTR2VvZTFYbWVTeVdDajVSaFBFWXVKZTdQ?=
 =?utf-8?B?TlB0YkdBMWpGKzhlbFlOaXNkWFRCeXJzMHliYnczTDBRK3drblJaSWNueDJj?=
 =?utf-8?B?ZWRmcnFsUjlrbE9pRWJ0bkg2aXovMmhRTGlEdnk2L2t2aFNuT2FWTnV4QTVC?=
 =?utf-8?B?aHZEZGZQMHlQeEVwNjdlMEF0NTh0c2pLS0t6YmI1MjFDRUljKy9Cc1VudWlQ?=
 =?utf-8?B?SmRnZGRZK21OdWNqbE1RYlhWOVBjYzNqdnJ1emJWVmtGQUhTTjZ3REdGM3Nt?=
 =?utf-8?B?bHJVK3ltbW50TU51RkJON2xENW1panRzQnpXNWpESnQ0SmxkVVhBN0lWSEdS?=
 =?utf-8?B?bE00cHRlVkxSM3NlSWpNdVVnZ2VDNTZOcXFHcE5PVUNYNXp0cVNQeG8vWjUy?=
 =?utf-8?B?OUhsTkp1ekF6OFpMbXNpQ0JuRkVKY0ZVd2VYZ2dOazk0NEN3a1pBME5RVEg4?=
 =?utf-8?B?UkFVbnJtdzN6T290VEVZL0tLQjNLdXQyWEc1VEdYUkp5Zkd3ZHNoTTBmdXp2?=
 =?utf-8?B?S3dVb3N4Vy8rS3dVN3FTU1NHZFZHbFc5b2ZmVEQ1R1JOTkphUkJKTldhZDQ0?=
 =?utf-8?B?QWJ6SnFzRlBoc3BTVmwxYjRhVnJXc25NYVF2VTQ0VzlYYlV2WjUrcSttRnMr?=
 =?utf-8?B?ejhwdVllQWRVZGJ6Z1EyQmJYdEFFQ2FZa2ZFZ04zZDVQQ1JObVpLTFdPeE1u?=
 =?utf-8?B?ZHhtOXR0OHMwUm5RV3FxbVRYSDBrc1RzK3JkaWhPZ3d0TlQxV0NscFJTNFZH?=
 =?utf-8?B?SytPOWNwcUt6YjhnbzJVSHpSNTRFL3JzVCs3YzhTenhnRkVuOWxBZDJZMVFD?=
 =?utf-8?B?djhVcW1RUE4rYVVuTGxRMk5DOE9HNHlyTkpyOWRQNmJjMzVpUEFMcGFUVHpz?=
 =?utf-8?B?ZkJiYURmeVJDTC9tbnVZOUZBaC96TkZZRFdYcDZWQW5CbmtqRkIrdDNoMDVh?=
 =?utf-8?Q?+pmTrXN+oq2Q/NXeJaiBwadAyuhrXAqWHVdrCoIa90bsY?=
X-MS-Exchange-AntiSpam-MessageData-1: FUcX/PfnO3r2ZJxwUrVoDvJ9C7VEdOnvHeU=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9600f592-fc5b-4f73-fb59-08de8e39ebb8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:54:15.4079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCwVzKgbNQtvhQFwAoaU16YJmxyZvKZisF5V9b88VMl3ZOAZ2KmZeaDvy7PYW+xhSxqzS1TgFFSoRVJKQjtBeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8417-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB41F357AEA
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


