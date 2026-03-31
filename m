Return-Path: <linux-pwm+bounces-8433-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDMcDTEuy2n8EQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8433-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:15:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 885FB363621
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17276308FE7F
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 02:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD1A366DB4;
	Tue, 31 Mar 2026 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rx7tNFa/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0FA95E;
	Tue, 31 Mar 2026 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774923171; cv=fail; b=d2beWsGaqF07vQmSoR4xZgrVK17WNKeC7GJ7TfPJEuOcKELJMQi+1gQKAhvzQvR//WNDg6/ncdvOI3Bq2+VkIFKi+fr7ybNCdGCPydDXDh0ivjdl1WPrVAtoVLmiuytS/EzDNlwBOgvATcyaHSfT83eLXrC/eCuLck/kkROzh6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774923171; c=relaxed/simple;
	bh=8S1MIoJ8wR46obwZjOrE7DpGaytUPp46LG3l35ccAbI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CJW+iurc3v6+U1ZzZANn7+ofwictPFe2gvwnx4AfUyvohcXjiLt5uXWGA0c9Z+StTt9arJlRmOPrPgaLNOCaZgEucv9FZqECDMGVPrN3YBQ9bxMRtJsyDY4iM+ItqmA2H6NgCN1hCuKhVd2hMmcdmebauipAsXp2siC8JBHX6CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rx7tNFa/; arc=fail smtp.client-ip=52.101.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yI4DfXPI3gjBeITJxgKvi9IZcA8RrO7lA6CrnwwSL/hdXFRX6+1mGx2Nr+XzmVWvMGIB8KBj5Lf5x4ncif7nofkDRrrFU2zx4/XTmVxZ6Hm7/NkV+zPUNb8CZ6ofq+yszZ5Xao60JJr5BDmH64w66HM45eqycDbNo7276mrTJl50H8p25vqgU6q19v3GCmK1aY8lnpkxmxdp+6NrbecxMxtlL7vN8PzV05tieHtmO3q68SPbkBTw/Ka3E8dl6Vd8MdLOpf+Eaq6ey7p8X743HKSF2W74xPj7+mR1vGNHvidlDoGY5PYEvXbk9wNYXZGHJNge3xpwhitDYJHJeZlcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wde3v3hGQAO603CGMv1VLnFtEovKA+Cg4tknNxjKT54=;
 b=O0mMn8pxr7rqC+dtKLiv18/qKE610V2YPUbylBRRJ+0JoDhvXj+INvTMUKqFhQdGgw7MKhzRXPyuDq1D8Ov5yTkXVLwhdPct6US4LBL0kH7gk4eTGH9FskqLYeG4jaAzrMWRHNijmNZUQS4cAbMJtv2EKurgazTKDs3VXAWkh1oyU3U+XWPw9YnGo9n72Ft83AY0l4zCPKuTBPsddRkoYYzwnGmg4O/zOZe+dISAf9F1oyek3qkCVPxHjBJ3ofHPAN8kNk+xmSoJEDjapRhaEzvnbblQTumvKCoksEnMQBUhT9oVqqSH27qnEnGZdM3PtL1DugDjIQu4BTuY0pGhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wde3v3hGQAO603CGMv1VLnFtEovKA+Cg4tknNxjKT54=;
 b=rx7tNFa/z/aPwvEoQQlNwWoveYbY7V548TOvnhH7wdtTFuwYi0+HrYFeM3lhcgKIwxC9atayoA6tJ1qVza+L9sKxClDlO8auRG2bwLezJAdHWhkwi1NOb8nOrL3U+Uj3VQ+NGVk3asTpLC6+P7vW1GwHtjDPK9qpuFmnJzf2D2I8IbEUd/YmtBXX9d/r19OX1W8nNx3Nwkjel3dZB0aUsTAsGGXQQgHMnZaaFclAJH7mJ4mse531NHlJ+BRBdv33/kUY9IhGtekqcbjY7T+o1PHe6Ik9W1uds/MJDLwTjPlkgkeO4Wxus1Yep2pl1gQFv1FXfHXFQ3deDC+cOlJDog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 02:12:47 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 02:12:46 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Tue, 31 Mar 2026 11:12:16 +0900
Subject: [PATCH v4 4/7] pwm: tegra: Parametrize enable register offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-t264-pwm-v4-4-c041659677cf@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0374.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::9) To LV3PR12MB9166.namprd12.prod.outlook.com
 (2603:10b6:408:19c::13)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9cb4a0-f8b0-4f8f-1244-08de8ecaff22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EhPEZhu+dpzxq0UCjL2/QFMTRB1TxXjI2pnvISN38H7Krwk49putTrHdus6T0RwxPLUOrNUqUSt0wWAMIgG5kmpMNyU+4TIoIDxtiSesiRWwTurOMMi9PZq2gpUAkUezQvy+9cDfqtjte0vZ172YcpzCOSOdC5aoyIxUJZ9+9hTdgVzUlmVT8E/7wn/wB5XLeJVjXPb1p18HZo66O1LeC5D6E/vpjFme2w0pXMK87eaiR4EWYNp3jhzH2n2Nlrax5sBTzt1ztORcSoPueklBpGldnlaA2uww4PrKeZlIv/hXh/dxlDNhzNeGvksMPewdDNDhqnNAmR0dIpT746tgcycljZZ3oDNV7RLjiNsobl9+PNUEqTC1WlNqRKSMXgDZjbiuO9B18qWYxCF9RHHOmJSXltpvfaqnB2gZHeloHb7dwYMlmE07P/K9lv4KMFdrzv1MyqeVTAQ357VgjrZ8HcItpl9UKWyrwZckVokbQ2ugr30Ddc6ovsTAXfywjtJw0lpH7eo+mgXH/sDICyV0WaSGh1tSZdsx6Zu5DHGW/fqbgG0KMLqsno9nOdBCqjPRWTOcgL3ekOmW6B5ct+tjRwNN4y+ah8kZqACt0eQQmS+GY4lEVk+Vq4zCHaAEFWNPPNuysj8YCNtyJix2uaO5ABQPrJGROAzv/l29i+77IquMv2lyzK1aqBsrJXQHQGCGdvAoUD4h0mrwzE2bqsOQOCyz3lh8a3psEJXb9XSykdk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N25EYnJyN1BneFJxMGFiL3dkdE5QQzBLUHlwYXlsd05pM0g1b2NIVG16cHZS?=
 =?utf-8?B?RHFyeGZwM1hITjdCYm1IdXk0S2JuNDE3akV0UFM3cy80Nlk2NWlnLzBVMWZU?=
 =?utf-8?B?SXA4bDlEcDdVY1JGcTM2VXlSQUhzbE9lN2JnOFRqSXJONjkxSWdXME4zRWFa?=
 =?utf-8?B?UUtOQ3lVQUNKOW1kZExIUGdYZ0RkRDc2OElkWDJrdGhWTG9NN2M5U1lGNzN1?=
 =?utf-8?B?c1N5K3BlcEYyc0EyeTFsRHhrZkVFNWc1NVpFc2syd3plT05YOGNFTmJrYW1T?=
 =?utf-8?B?ZENxcnM5M3orcU9ZNjdEMkxzUVluSjJJQTZRbWZjT2U5a0VaNjJEOXpZMGZu?=
 =?utf-8?B?RTFyWStKVlFScUYxLzdFRTlON2Z1ZnNINXpxb1VzSWtFK0k3SmsxaXpUVUIx?=
 =?utf-8?B?cHV6NXZiNnMxa1FnOWZHMjlXUkdoSnV3RUhtUThNeWE0NDRMckExeGwyR1BP?=
 =?utf-8?B?eHNxQVVGZU90cGdNR3JDQjdJRlNITEhHY1BGNzBEZ1loRzZGVkNwNWdFNjlz?=
 =?utf-8?B?Vk5UZHlWS0EweEN5eWQvRWRjZERaNXR1bi96MVh3d0d5aDM2dWNiWXVad2Z4?=
 =?utf-8?B?TVBiekdnTDZMbzNCUmpBeDd2dy9SSWJDUTVqRzROa2s2Ny9nc3A3TSt0UmpD?=
 =?utf-8?B?RHRKSXZZZnE4MWgzVFY5ODBKYkJRRUJodEZ0czJidkRjaDg3VWVHS0w0TjJj?=
 =?utf-8?B?NEM1TVJidzFyVzZNQ1JsZUdXVnJpWjNieVQ2eWplb1hnY1FtajhoVnpCQjhk?=
 =?utf-8?B?YWE2UDZqSm9OZ1EwUWo2elluZytQNGEwSXFwZXV2ZzlMQXJQWXJ4L2w3dzNX?=
 =?utf-8?B?VTllK2Yxak1leHpBQWs4QmRsY3ZLaG5IcWVSUWZBZU5YL0p5ZG00cFdCOWVl?=
 =?utf-8?B?aWN6YnVrQXpCMmVvUHJLTnNGUmVqcUFvMkhOUG1FVERRVTU3MGhFTlYwSmJq?=
 =?utf-8?B?UGdaQkVMUkNadEZsWDlydEp6cStGVmlicTNMbFdmcmhQTllBdE5zalQwVkxq?=
 =?utf-8?B?OGNOTXZWTUk3cG40M0N5bFY1YUc2V0VXMWg4T09xb1NiUkxTcFVKY2RJOUdR?=
 =?utf-8?B?WVNZNHlaZnlpOUw2NHRPenNrcFFQZkd5eEdlZzFzZ2JxTFBRWWNJVTUvSnhz?=
 =?utf-8?B?T2E4cVJMTEFwZ001dy85MlZsQ3ptc3lDWjJKcjRwaG95b0dsU3hPVWdzbzhY?=
 =?utf-8?B?WDhReTRKNHZ4Vk5URVJhcE0wWjdXRi9yeGdkaXRHRjBZeDVkMEltS0h5K0pl?=
 =?utf-8?B?aUdRbXhVWWptYW9kSHQyVTI3dW5NS0p6M2t6eDZUTUNHTWg1MUp5cW93dUxX?=
 =?utf-8?B?YVdjK0wxVHk4cFlNVG1oUmY0dXNEWFl5NWlvZWtXdm5oeHRXZ0doVTZFM2Vp?=
 =?utf-8?B?NStFYTVmVko0Y05ka0hpbkNSVkdnNVhwMWt0N1dBaUVWZnV1cFExeW9XaktT?=
 =?utf-8?B?UnQrTDJRN2FuMVpKVnVkcDJ4WXp4MlZsWDQzUk5BTlBYRUJCdjVJK2FwRTBS?=
 =?utf-8?B?WWFtK1RadXRTYTNZRkFvVXlwcHpCU2NsTytGUmZpcU1rVDN0QmRla0ltL2Fl?=
 =?utf-8?B?Z0ZtTzBHYVFpK0FicnprRWdRSUtMS0JTUHExY28wMk5MeWhISXBrbDlSblBH?=
 =?utf-8?B?cDNWQ29zeWJCOWgwLzRvSUs3a2Y2ZXdrWkZyMmkwQk9wWGVhWUJsdGRMamhm?=
 =?utf-8?B?Wmw2SFhxaU9QOVdpU3crL2VIaGlmMko4L0RLbjVaSWVKM3ZlNytjK1ZGZzhD?=
 =?utf-8?B?ZVVkY2pIek1zRHppZU9NOURHaFhOenVvb0tmTk02RzJvRXNxR3FkZWNWdHkr?=
 =?utf-8?B?eU5mWnp1N0hsdUlsaDJielJMQVIxWTZLQkgzMGVwT2lFcEtNK1RQU2xyZkhi?=
 =?utf-8?B?Q24zL0pUeEtLdVFGek1sNkhYTXgvOEs0bGhERU0vZGY0cVFxdVM3c25hZ0tZ?=
 =?utf-8?B?ZXNxd2tvK0dCbU9LMjVOWGxqVitaWlJZVzlwcUNzOGM0c244azdPTzZHS0p2?=
 =?utf-8?B?NkgwTUtVaTZYMDJQeUhaZ3JJRExJMDVRellDVElRTlFic2lYT2NRV21CTVZW?=
 =?utf-8?B?UFJqczhMeXlSNWN6S2tETW1kY1hmTXIxakZ6MDd5dTFXVHlrUzQwV0VUU2U5?=
 =?utf-8?B?cUNLaWhGTjhlUHN6bnRUZXBxRGR6NUdxeEVVbGxHNUdSR2s3VFBSc0RGbWRO?=
 =?utf-8?B?RWt1VkJtQmFUeERaOTRtQ0lMNmRtWHp4bFMwZSszMTgrVnBicjBrOENsUXZP?=
 =?utf-8?B?ZmplMnhaRHdWaU13V1JUbEFob2RrczdzUHZ5VnpFWHptdlNLUU8xTWthZVdu?=
 =?utf-8?B?dzlUOURpRjVadW5JQlFxWUxoeWRmVDNXbWYyRlQxazNiZkZQZTZnbk90dDlG?=
 =?utf-8?Q?t08bkg5P15J9XRgxpLkQbwM1+5MSefK6pu16sSEW/qO2A?=
X-MS-Exchange-AntiSpam-MessageData-1: tPeud1fxwaOnC5AxP26ZhTxjeRpkVnP5Pm4=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9cb4a0-f8b0-4f8f-1244-08de8ecaff22
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9166.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:12:46.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiecMNfYdi3OgrPoB+CZqaLCSwzUfGVXEPdCj4U6Y1uGSmNzbja48j7hgzQVVwBvhYFhe4d/29DntqMMRcl4+w==
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
	TAGGED_FROM(0.00)[bounces-8433-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 885FB363621
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tegra264, the PWM enablement bit is not located at the base address
of the PWM controller. Hence, introduce an enablement offset field in
the tegra_pwm_soc structure to describe the offset of the register.

Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 358c81cea05b..b925ef914411 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -61,6 +61,7 @@
 
 struct tegra_pwm_soc {
 	unsigned int num_channels;
+	unsigned int enable_reg;
 };
 
 struct tegra_pwm_chip {
@@ -197,8 +198,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		err = pm_runtime_resume_and_get(pwmchip_parent(chip));
 		if (err)
 			return err;
-	} else
+	} else if (pc->soc->enable_reg == PWM_CSR_0) {
 		val |= PWM_ENABLE;
+	}
 
 	pwm_writel(pwm, PWM_CSR_0, val);
 
@@ -213,6 +215,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	int rc = 0;
 	u32 val;
 
@@ -220,20 +223,22 @@ static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (rc)
 		return rc;
 
-	val = pwm_readl(pwm, PWM_CSR_0);
+
+	val = pwm_readl(pwm, pc->soc->enable_reg);
 	val |= PWM_ENABLE;
-	pwm_writel(pwm, PWM_CSR_0, val);
+	pwm_writel(pwm, pc->soc->enable_reg, val);
 
 	return 0;
 }
 
 static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	u32 val;
 
-	val = pwm_readl(pwm, PWM_CSR_0);
+	val = pwm_readl(pwm, pc->soc->enable_reg);
 	val &= ~PWM_ENABLE;
-	pwm_writel(pwm, PWM_CSR_0, val);
+	pwm_writel(pwm, pc->soc->enable_reg, val);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 }
@@ -398,10 +403,12 @@ static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
 
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
+	.enable_reg = PWM_CSR_0,
 };
 
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.num_channels = 1,
+	.enable_reg = PWM_CSR_0,
 };
 
 static const struct of_device_id tegra_pwm_of_match[] = {

-- 
2.53.0


