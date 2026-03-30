Return-Path: <linux-pwm+bounces-8413-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLKjLvs7ymmd6wUAu9opvQ
	(envelope-from <linux-pwm+bounces-8413-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:01:47 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AC2357ABD
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 978ED304B352
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 08:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFAC3B2FDA;
	Mon, 30 Mar 2026 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mZBfxofo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C74A3B2FC9;
	Mon, 30 Mar 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860849; cv=fail; b=mjTEhE7gHvg45zkz+6FUAa4R6Dwm51IkXE9WLadLq7no11t80KTeevdlzD3g+oNWGe5iOqCVQP6H/5LiBK76cgL3womPxN4x/k4GOp4OP8blA2e11RL6dStLzgiI5hoxwFo7nz0klW3Hn9LnzpMn6r3gjp4DH0s3zCvoRlQBIyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860849; c=relaxed/simple;
	bh=nMmkVJSR6BhMuHorpkc7+tV3jZv/s9UqiGI/iroU+v4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GsWkjZVrvaBq1mPiLTT3t3VmtScuyL6Ida7WliYdKTPP2qjntbgYEn1eeAbpLUnKGd6SF0dbqv7+W3tqwjMh/kJzLmYG3dc6rUcIyFLPC/5FWXgro52gAO+9j1tFHyClAg0GbsvZGDLg6nzi7w/XHQum5BAIrmLEx5vL4XsguzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mZBfxofo; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2pSkIJRGOT2lgYCyhILO14Ffi4YUdnme+gvaLatMFa6oY9yPIrXXe7XnyZ40Nau7J7SqRDAqoJYQ0o6J3/DGiY2C7lQKgbpB5nql2nJnddXlLfBZmOl9plXIupg2U6BtEr6iepP5IVJS7sRarBDWiEsfsLeTIcHf9mH1LlR++YByj9EOHdT3hjps1gru8oyXalEL5pDwj2GY9yQKbEQznDk5vQWOe0eC3WXlIV4sqbuvNr+PKzbaA8Rq+9skJ6ofoQMsXjh0fNu5aiUfIMNJaFOZ+PdZrY1Isy2IXxKGTwwXlGOriT7dzleINkNfqBzSh4BquX3R6oErM2RIvkxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F96/LNq3RoF5Ql5c/qqGIS7TthtDvkww4fuyoHBpig=;
 b=rXgrY+xCn/JSYMMEisvQBzGzWuABbMopHKwdjU+Ndi3+5f4O4NROZt9ypgifFkIIYcFCXYEEzbjJfdI4qAO4RNFBSAuW0YzPgjomGYxggrZf0qxVm243HbE3OJ+TIa4tm82VS1Lb04tw8tuDP6LwjFfxQGzQdtC/9jHq9S6SJhYU9zAQMG5YYyZ4d6i+EwjTEmdNQMLxmxciptVS/UZ9LagIlD+niMVd72jnWTGUWmOU73f5eRA58Wl3L+EE02ddTTunVDjBrkHVR+pF+g+vNJ9JpqYfBEMgB9uiQw2cD1mH+nUI48v6bTzkyTlNoycXQ6nE8tJmuoVniOnO13TzhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F96/LNq3RoF5Ql5c/qqGIS7TthtDvkww4fuyoHBpig=;
 b=mZBfxofo6T/lbIoYH/OIqtK0QpIA/OmWXcBVe+mteF0/it9Y/g5GsR8xeJTGQIqHLveFBkS3RD+jjTKoXpookjUm9xfgTKAoBv9LnKH658jyqsUY4g5JNnJHnPbEqCHjI1fAeYD/oFWOUnyOmzO1GaBAV7YnZ9Yk32lpstZEohWKUpn/xPph31S0NJlBUctBbf6R140zNUGwno0HBNKV++hLdyXFXyhK/YzF6zacoDbTCM0Gz24mm25BjGI4MTYlQrvxk8wAkFidCgvvTatuS57/2LW8wEB0B/1HUqUPIIrB6Z9D7k52J9laKVph4+q29Yj4oX9yvymSjCl0IpNzqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:54:05 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 08:54:04 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 30 Mar 2026 17:53:52 +0900
Subject: [PATCH v3 3/7] pwm: tegra: Modify read/write accessors for
 multi-register channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-t264-pwm-v3-3-5714427d5976@nvidia.com>
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
X-ClientProxiedBy: MW4PR04CA0280.namprd04.prod.outlook.com
 (2603:10b6:303:89::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5ec844-f511-4b73-e640-08de8e39e53f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	octuo95hG6hx78DMil1TpkR4W45cdhiuOkq93CLe1IteHn49MM5d8hdFHO4acCJzA4MtU3s/M7LaR2TtBSCxTf0GLxQc3MuEWg/BNJffkkc19UvR/TrybTrFWXqx8W8dy+epNRZszjkCDKIzvnbeL6uJVqxGbOXhptsBS9cIsR4QAUcjhO/DXJm8uaNezt7epPbwrFMZYCLIS9fHm214mmC7sz4/D8hiqia0Rrg+N0/pkzQGVfmis5znxw42p9Ky6Sg7leHET7hEUVFKau0ji7hdN0KKV2e94BHFI8ZbDOjXstSN2a2JeY8GJLxYFi5JnzhZsSSVWfjA2tDQXmYxOWeynlGEkuEqZX+x4DaMXRiUhiJS/577jRZjvEpeY7/Djspw/a0xBMaHiGVkhkyY2OZ3NkgV3qcHoYRpbB7WJ/IelMwDKIcswVrSFLH09pM3q1Ms3IJDkjuuABqkppLS3+CZNVZPGRoDnmwZNxeLjz6cCGWXgrbKrpsW9KmW70d37SLpO2atAmkzgII4ETAgYFv4cnQhY2OztYJtTWu9P2vzRFbXwRghw7tK3RqzZ1kTOErjL6cT83aDnxppdXcqUE2eE8/wY4cjyjhjbCfZCaymYW2UgWSlxM7bldDQwRUtMZLU3vtruVR59lvS18zxZDcb/0/ZxR9z/X3g79elxPP/Mfc3kl/vUi7X1EBbSBtWLopy5zoUiPh8ilg4Z8xMrJ4iRwj+ZnsHzc4GutnKy4w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nnhzak5zOVVMbzNXdlNwZUVFTmlIczA5eklSeFRUdFpmbE5vRnNHa0EwMmJH?=
 =?utf-8?B?TTQ1b3FpYmE2clVDd3BUeXRhRmt1MjRmV1Iyb2xKMjhDOGZpYmU0eWJ6TUZx?=
 =?utf-8?B?bVBQbHBhWWN1WEtOT1FPTnZrM0lLa1NtbEZzMzNBMXRIY2RvWmt6WWJYSU8w?=
 =?utf-8?B?ZFdvUFJldXRsNW9yaDl0dXFoWEpwZzZkZmxybENCeXN5VHlRVWxiSGpqNDBF?=
 =?utf-8?B?dXB1SVNzM3Nvcmo0M1pLSEM5N3NWNHY3Vm1mK3h2Y0ZRbHlFdEFlNEpLQkpj?=
 =?utf-8?B?Q3Y5K0NHMU9qaXdCN2N6am1FMVYvamlWdDBSSGg3WFFRV0ZKOCtZcVZrNFNl?=
 =?utf-8?B?UjhQL0NrckFEQVdZVXBmaUV6cnovbUpZNy85UHYrcVlQZmE5QTR4REVnbCt5?=
 =?utf-8?B?Z2JYR2VPT0tab2VuSmJ4c2VDeEtReG8ySlFrYnByMnFGbHJZdnh3dHE4dm0z?=
 =?utf-8?B?dVN6YnpnSkJHeDlBNy8yRGVpWFJyQ2xucGN5Zy92L3ZGVytyUkVIUHM0Ymp6?=
 =?utf-8?B?NFVMLzJTNlM3citVcjdNU2NhMW1JWUdsdWxFVzlrOTg3b1ZLK1IrK1FTbXJM?=
 =?utf-8?B?RENtUnlSemlQajhOMDR6ZzVJVnZid1dwdHpRb01wNFJXdG80QzNwVHVKM2RY?=
 =?utf-8?B?c2V5SFBSb1FGV0lQQWdCaVN3Qmhyd1gwTzVTMlQwUXRNZ0ZBZWI2OUdiUWtj?=
 =?utf-8?B?dG03SXl2N3RYeHZOa0lkZ0hNUXRObDhld1pXMTh1R2t2R2F1YU5nbk1vZkhZ?=
 =?utf-8?B?WHI0ZC9LUmRFRWVlTTZZS1FZbHRMTDFpMERZRWk3Z2ZVWVlvd0FZcnFudzcz?=
 =?utf-8?B?RGpFK3RDc1NmclRubVRBZDJKaTg3WTVjUkEycUNJRzZHRktnL09ERUd1cEpE?=
 =?utf-8?B?SEZHV1B5OVlsUHdZeGttN2xVRHN1ZDJsOGFvKzNuTDJMQ0dzKzhVUTVoVWhw?=
 =?utf-8?B?cmwxZzQ5UWxqYTc2M1BzbmE3K2paTmttQ3J2bkZ2V0R1VkpBdDRHbFVGNjYy?=
 =?utf-8?B?Qnl4VkJ4SVlWT0ZaOWJGbzVhK2daOG5BZVFXYkE0M0VXVmh6dlVUa25FOG85?=
 =?utf-8?B?eWRkTWhtZmMrRGZJeUZKYXA5WTN2RlJ6RzNLVzIwdS9MZ2ZkZTI4b0F3RUVj?=
 =?utf-8?B?SnZzcFdkTVdFNWIwcVluR1RKcGZ3UjhEOTJnUk1RSUJsUG5WWDFqa3dLNW4x?=
 =?utf-8?B?Q0dmWk9tSlRuWFlObktJamZRcFNXQ05aRnZqT25RWEFDUlN6VC9jcDBmQ2tG?=
 =?utf-8?B?ek9EakIxYlQ5RzMxWDluYjZtWG9oVHVjQ1JKNXRNY0RINS9rengvWXlRency?=
 =?utf-8?B?VXM1UGJmazR4b0tIWktDbzltSnd4eUwrTzEwdTBUSnV3YUZTZlh6ckI3cEZ4?=
 =?utf-8?B?djY5SkI3NWkwM0JoVmovWmlDRnRlRFdCUjFqa0V1TGwvS0Q5U25IalpIeGdH?=
 =?utf-8?B?OVJLWHVVZ1R5ZXZkc0w4ZW9jc3plaXYvRTNkVXBOM3EzQ25WakRlM0JTeHUr?=
 =?utf-8?B?bjBvNExYNDN0N3pIYUJYNGJUSDU3QlVWQm54UFcycG5iZ3E1OHFkZG9WWEVT?=
 =?utf-8?B?RUF3enZrRFhERDBZdURWN2NCdjZYQW5raGtRWFpVamd2c0tJcHZZMkQ3Zk5t?=
 =?utf-8?B?LzZLMGs3V3JENUdWWDgvLzRSWmpLWXRYV3VZT09ZUllMSVNVMzBWbFRQc29F?=
 =?utf-8?B?Mk93WDFLeDJKeEMyNmdqbXY3eVdNTDBPZ0NBeUl5WjJWQ3UzczZML2VUdmg3?=
 =?utf-8?B?NGhEZDd0QUZSNHB6RXhNa0JTZlRuTnVkSFI2Q2NCeFJkK1J0NDk3dGE0akNY?=
 =?utf-8?B?SVVseEJoSW1iTWtwNEdtNFZ5V21sanI2dlhUSDFXZzM2NkJ5TjZKUis2RWV3?=
 =?utf-8?B?WSt4R0ljc0RJNjgwT0NJS0dLeVBpRnA5ZWpkUDZnMk1SUGE2Rm54TEtlck5T?=
 =?utf-8?B?YTdqU0tnK09EZXZFeVRGb3FRd09NQS9zM1k4Mjd5UlYyTmEyR1VsVzM4czdi?=
 =?utf-8?B?alFJQ0lvaU4yUEFGN3lkWHdHWlRyTzZPNEpnY3ZPVjlCaEZ3RkIrd1VpT2ha?=
 =?utf-8?B?VGkzV2QzZUVvNGZnUVZObUp6eEtPbkpBODNYNU1yT0k3cENVM3l1WVFQeC8v?=
 =?utf-8?B?dWZBS2Nub21wSUpYUkE5VmlydDFtcUFsRmpQUHErWXUrZk5IeHBTbElJbFl3?=
 =?utf-8?B?a2wzSWo2MjlQUFNWSHoxS2dGWkc5cEhoYVRpc3JvanFFWGxWUU9heXl0dUxH?=
 =?utf-8?B?TWF2WHpTdjZKSjhYVXA5dm9UMnZqRTE0b0hJNWNlVTZVeC9nc0pucS9pelk5?=
 =?utf-8?B?RUhIK1Z2cUcySGorYXdVUFpBN0pLdW14NVhWVXJwNlhvZG5nL2FFK3I0ZUJh?=
 =?utf-8?Q?slcwrdzgW8gUX7p1e1NQTG5zh4mFprDvBxW9eJkwfmv22?=
X-MS-Exchange-AntiSpam-MessageData-1: T6fXwJ/GiwORRA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5ec844-f511-4b73-e640-08de8e39e53f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:54:04.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QapB3wcYCLRXeKMTVrGF6w81m7uzNFWt+zFBfW3poFVLPIi4tI0g8FFc9TvV7mzp7ILBRyrEWYeCHKknVU51lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8413-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99AC2357ABD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tegra264, each PWM instance has two registers (per channel, of which
there is one). Update the pwm_readl/pwm_writel helper functions to
take channel (as struct pwm_device *) and offset separately.

Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 759b98b97b6e..cf54f75d92a5 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -57,6 +57,8 @@
 #define PWM_SCALE_WIDTH	13
 #define PWM_SCALE_SHIFT	0
 
+#define PWM_CSR_0	0
+
 struct tegra_pwm_soc {
 	unsigned int num_channels;
 };
@@ -78,14 +80,18 @@ static inline struct tegra_pwm_chip *to_tegra_pwm_chip(struct pwm_chip *chip)
 	return pwmchip_get_drvdata(chip);
 }
 
-static inline u32 pwm_readl(struct tegra_pwm_chip *pc, unsigned int offset)
+static inline u32 pwm_readl(struct pwm_device *dev, unsigned int offset)
 {
-	return readl(pc->regs + (offset << 4));
+	struct tegra_pwm_chip *chip = to_tegra_pwm_chip(dev->chip);
+
+	return readl(chip->regs + (dev->hwpwm * 16) + offset);
 }
 
-static inline void pwm_writel(struct tegra_pwm_chip *pc, unsigned int offset, u32 value)
+static inline void pwm_writel(struct pwm_device *dev, unsigned int offset, u32 value)
 {
-	writel(value, pc->regs + (offset << 4));
+	struct tegra_pwm_chip *chip = to_tegra_pwm_chip(dev->chip);
+
+	writel(value, chip->regs + (dev->hwpwm * 16) + offset);
 }
 
 static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -194,7 +200,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	} else
 		val |= PWM_ENABLE;
 
-	pwm_writel(pc, pwm->hwpwm, val);
+	pwm_writel(pwm, PWM_CSR_0, val);
 
 	/*
 	 * If the PWM is not enabled, turn the clock off again to save power.
@@ -207,7 +213,6 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	int rc = 0;
 	u32 val;
 
@@ -215,21 +220,20 @@ static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (rc)
 		return rc;
 
-	val = pwm_readl(pc, pwm->hwpwm);
+	val = pwm_readl(pwm, PWM_CSR_0);
 	val |= PWM_ENABLE;
-	pwm_writel(pc, pwm->hwpwm, val);
+	pwm_writel(pwm, PWM_CSR_0, val);
 
 	return 0;
 }
 
 static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	u32 val;
 
-	val = pwm_readl(pc, pwm->hwpwm);
+	val = pwm_readl(pwm, PWM_CSR_0);
 	val &= ~PWM_ENABLE;
-	pwm_writel(pc, pwm->hwpwm, val);
+	pwm_writel(pwm, PWM_CSR_0, val);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 }

-- 
2.53.0


